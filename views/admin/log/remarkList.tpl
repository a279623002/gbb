{{template "admin/common/header.tpl" .}}
<style>
    .x-admin-sm .layui-icon {
        font-size: 26px;
    }
</style>

<body>
    <meta name="_xsrf" content="{{.xsrf_token}}">
    {{if ne .admin.Status 1}}
            <script>
            $(function() {
                $('.power').attr('onclick', null).click(function() {
                        layer.msg('无权限');
                });

            })
            </script>
    {{end}}
    <div class="layui-fluid">
        <div class="layui-row layui-col-space15">
            <div class="layui-col-md12">
                <div class="layui-card">
                    <div class="layui-card-body ">
                        <table class="layui-table layui-form">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>姓名</th>
                                    <th>邮箱</th>
                                    <th>内容</th>
                                    <th>添加时间</th>
                                    <th>状态</th>
                                    <th>操作</th>
                            </thead>
                            <tbody>
                               {{range $index, $elem := .Items}}
                                <tr>
                                    <td>{{$elem.RemarkId}}</td>
                                    <td>{{$elem.Name}}</td>
                                    <td>{{$elem.Email}}</td>
                                    <td class="taskContent">{{$elem.Content}}</td>
                                    <td>{{convertTime $elem.Addtime}}</td>
                                    <td class="td-status">
                                           {{if eq $elem.Status 1}}
                                            <span class="layui-btn layui-btn layui-btn-danger layui-btn-mini">未读</span>
                                            {{else}}
                                            <span class="layui-btn layui-btn-normal layui-btn-mini">已读</span>
                                            {{end}}
                                     
                                    </td>
                                    <td class="td-manage">
                                        <a class="power" title="删除" onclick="remarkDel(this,{{$elem.RemarkId}})"
                                            href="javascript:;">
                                            <i class="layui-icon"></i>
                                        </a>
                                    </td>
                                </tr>
                                {{end}}
                            </tbody>
                        </table>
                    </div>
                    <div class="layui-card-body ">
                        <div class="page">
                           {{.pagerhtml}}
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script>
        layui.use(['laydate', 'form']);

        /*评论-删除*/
        function remarkDel(obj, id) {
            layer.confirm('确认要删除吗？', function (index) {
                //发异步删除数据
                $.ajax({
                    url: {{urlfor "LogController.RemarkDel"}},
                    type: 'post',
                    dataType: 'json',
                    data: { remarkId: id },
                    headers: {
                         'X-Xsrftoken': $('meta[name="_xsrf"]').attr('content')
                    },
                    success: function (result) {
                        if (result.state) {
                            $(obj).parents("tr").remove();
                            layer.msg(result.msg, { icon: 1, time: 1000 });
                        } else {
                            layer.msg(result.msg);
                        }
                    }
                });

            });
        }

        //查看结果

        function replace_em(str) {

            str = str.replace(/\</g, '&lt;');

            str = str.replace(/\>/g, '&gt;');

            str = str.replace(/\n/g, '<br/>');

            str = str.replace(/\[em_([0-9]*)\]/g, '<img src="/static/home/js/images/$1.gif" border="0" />');

            return str;

        }

        $(function() {
            $('.taskContent').each(function() {
                $(this).html(replace_em($(this).html()));
            })
        })
    </script>
</body>

</html>