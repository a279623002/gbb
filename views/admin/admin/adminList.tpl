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
                  
                   
                         <div class="layui-card-header">
                            <button class="layui-btn power" onclick="xadmin.open('添加管理员',{{urlfor "AdminController.AdminAdd"}},600,400)"><i
                                class="layui-icon"></i>添加管理员</button>
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
                    
                    
                  
                   
                    <div class="layui-card-body ">
                        <table class="layui-table layui-form">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>登录名</th>
                                    <th>登陆时间</th>
                                    <th>注册时间</th>
                                    <th>登陆IP</th>
                                    <th>状态</th>
                                    <th>操作</th>
                            </thead>
                            <tbody>
                            {{range $index, $elem := .Items}}
                                  <tr>
                                    <td>{{$elem.AdminId}}</td>
                                    <td>{{$elem.Name}}</td>
                                    <td>{{convertTime $elem.LoginTime}}</td>
                                    <td>{{convertTime $elem.Addtime}}</td>
                                    <td>{{$elem.LoginIp}}</td>
                                    <td class="td-status">
                                        {{if eq $elem.Status 1}}
                                            <span class="layui-btn layui-btn-warm layui-btn-mini">超级管理员</span>
                                        {{else}}
                                            <span class="layui-btn layui-btn-normal layui-btn-mini">普通管理员</span>
                                        {{end}}

                                    </td>
                                    <td class="td-manage">
                                      
                                        <a class="power" onclick="xadmin.open('修改密码',{{urlfor "AdminController.AdminPassEdit" "adminId" $elem.AdminId}}, 600,400)"
                                            title="修改密码" href="javascript:;">
                                            <i class="layui-icon">&#xe631;</i>
                                        </a>
                                        <a class="power" name="删除" onclick="adminDel(this,{{$elem.AdminId}})" href="javascript:;">
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
        function adminDel(obj, id) {
            layer.confirm('确认要删除吗？', function (index) {
                //发异步删除数据
                $.ajax({
                    url: {{urlfor "AdminController.AdminDel"}},
                    type: 'post',
                    dataType: 'json',
                    data: { adminId: id },
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