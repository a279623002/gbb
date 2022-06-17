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
                            <div class="layui-inline">
                                <div class="layui-input-inline">
                                    <select name="tag_id" lay-search="">
                                  
                                        <option value="">所有分类</option>
                                        {{range $index, $elem := .tagList}}
                                        <option value="{{$elem.TagId}}">{{$elem.Name}}</option>
                                        {{end}}
                                      
                                    </select>
                                </div>
                            </div>
                            <div class="layui-inline layui-show-xs-block">
                                <input type="text" name="title" placeholder="搜索标题" value="" autocomplete="off"
                                    class="layui-input">
                            </div>
                            <div class="layui-inline layui-show-xs-block">
                                <button class="layui-btn" lay-submit="" lay-filter="sreach"><i
                                        class="layui-icon"></i></button>
                            </div>
                        </form>
                    </div>
                    <div class="layui-card-header">
                        <button class="layui-btn power" onclick="xadmin.open('添加日志',{{urlfor "LogController.LogEdit"}},1200,800)"><i
                                class="layui-icon"></i>添加日志</button>
                    </div>
                  
                    {{if ne .admin.Status 1}}
                         <script>
                            $(function() {
                              /*
                                $('.power').attr('onclick', null).click(function() {
                                     layer.msg('无权限');
                                });
                                */

                            })
                         </script>
                    {{end}}
                    
                    <div class="layui-card-body ">
                        <table class="layui-table layui-form">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>标签</th>
                                    <th>标题</th>
                                    <th>添加时间</th>
                                    <th>评论数</th>
                                    <th>操作</th>
                            </thead>
                            <tbody>
                             {{range $index, $elem := .List}}
                                <tr>
                                    <td>{{$elem.LogId}}</td>
                                    <td>{{$elem.TagName}}</td>
                                    <td>{{$elem.Title}}</td>
                                    <td>{{convertTime $elem.Addtime}}</td>
                                    <td class="td-status">
                                        <span class="layui-btn layui-btn-normal layui-btn-mini">{{$elem.RemarkAll}}</span>
                                         {{if gt $elem.Remark 0}}
                                        <span
                                            class="layui-btn layui-btn layui-btn-danger layui-btn-mini">+{{$elem.Remark}}</span>
                                        {{end}}
                                    </td>
                                    <td class="td-manage">

                                        <a onclick="xadmin.open('评论列表',{{urlfor "LogController.RemarkList" "logId" $elem.LogId}},1200,800)"
                                            title="评论列表" href="javascript:;">
                                            <i class="layui-icon">&#xe611;</i>
                                        </a>
                                        <a class="power" onclick="xadmin.open('修改日志',{{urlfor "LogController.LogEdit" "logId" $elem.LogId}},1200,800)"
                                            title="修改日志" href="javascript:;">
                                            <i class="layui-icon">&#xe631;</i>
                                        </a>
                                        <a class="power" title="删除" onclick="logDel(this,{{$elem.LogId}})" href="javascript:;">
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

        /*日志-删除*/
        function logDel(obj, id) {
            layer.confirm('确认要删除吗？', function (index) {
                //发异步删除数据
                $.ajax({
                    url: {{urlfor "LogController.LogDel"}},
                    type: 'post',
                    dataType: 'json',
                    data: { logId: id },
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