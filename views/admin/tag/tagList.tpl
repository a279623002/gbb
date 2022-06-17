{{template "admin/common/header.tpl" .}}
<style>
    .x-admin-sm .layui-icon {
        font-size: 26px;
    }
</style>

<body>
    <meta name="_xsrf" content="{{.xsrf_token}}">

    <div class="layui-fluid">
        <div class="layui-row layui-col-space15">
            <div class="layui-col-md12">
                <div class="layui-card">
                    <div class="layui-card-body ">
                        <form class="layui-form layui-col-space5">

                            <div class="layui-inline layui-show-xs-block">
                                <input type="text" name="name" placeholder="搜索标题" value="" autocomplete="off"
                                    class="layui-input">
                            </div>
                            <div class="layui-inline layui-show-xs-block">
                                <button class="layui-btn" lay-submit="" lay-filter="sreach"><i
                                        class="layui-icon"></i></button>
                            </div>
                        </form>
                    </div>
                    {{if ne .admin.Status 1}}
                         <script>
                            $(function() {
                                $('.power').attr('onclick', null).click(function() {
                                     layer.msg('无权限');
                                });

                            })
                         </script>
                    {{end}}
                    <div class="layui-card-header">
                        <button class="layui-btn power" onclick="xadmin.open('添加标签',{{urlfor "TagController.TagEdit"}},500,200)"><i
                                class="layui-icon"></i>添加标签</button>
                    </div>
                    <div class="layui-card-body ">
                        <table class="layui-table layui-form">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>名称</th>
                                    <th>添加时间</th>
                                    <!-- <th>状态</th> -->
                                    <th>操作</th>
                            </thead>
                            <tbody>
                            {{range $index, $elem := .Items}}
                                <tr>
                                    <td>{{$elem.TagId}}</td>
                                    <td>{{$elem.Name}}</td>
                                    <td>{{convertTime $elem.Addtime}}</td>
                                    <!-- <td class="td-status">
                                        <span class="layui-btn layui-btn-normal layui-btn-mini"></span>
                                    </td> -->
                                    <td class="td-manage">
                                        <a class="power" onclick="xadmin.open('修改标签',{{urlfor "TagController.TagEdit" "tagId" $elem.TagId}},500,200)"
                                            name="修改标签" href="javascript:;">
                                            <i class="layui-icon">&#xe631;</i>
                                        </a>
                                        <a class="power" name="删除" onclick="tagDel(this,{{$elem.TagId}})" href="javascript:;">
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

        /*标签-删除*/
        function tagDel(obj, id) {
            layer.confirm('确认要删除吗？', function (index) {
                //发异步删除数据
                $.ajax({
                    url: {{urlfor "TagController.TagDel"}},
                    type: 'post',
                    dataType: 'json',
                    data: { tagId: id },
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
    </script>
</body>

</html>