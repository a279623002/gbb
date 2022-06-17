{{template "admin/common/header.tpl" .}}

<body> 
    <div class="layui-fluid">
        <div class="layui-row layui-col-space15">
            <div class="layui-col-md12">
                <div class="layui-card">
                    <form method="post" class="layui-form" id="taskForm" enctype="multipart/form-data">
                        {{ .xsrfdata }}
                        <div class="layui-card-body" style="padding: 15px;">
                            <form class="layui-form" action="" lay-filter="component-form-group">
                                <div class="layui-form-item">
                                    <label class="layui-form-label">logo:</label>
                                    <div class="layui-input-block">
                                        <input type="radio" name="logo" value="1" title="黑" {{if eq .detail.Logo 1}}checked{{end}}>
                                        <div class="layui-unselect layui-form-radio"><i
                                                class="layui-anim layui-icon"></i>
                                            <div>黑</div>
                                        </div>
                                        <input type="radio" name="logo" value="2" title="白" {{if eq .detail.Logo 2}}checked{{end}} >
                                        <div class="layui-unselect layui-form-radio"><i
                                                class="layui-anim layui-icon"></i>
                                            <div>白</div>
                                        </div>
                                    </div>
                                </div>
                                <div class="layui-form-item">
                                    <label class="layui-form-label">主题:</label>
                                    <div class="layui-input-block">
                                        <input type="radio" name="theme" value="1" title="默认" {{if eq .detail.Theme 1}}checked{{end}} >
                                        <div class="layui-unselect layui-form-radio"><i
                                                class="layui-anim layui-icon"></i>
                                            <div>默认</div>
                                        </div>
                                        <input type="radio" name="theme" value="2" title="简约" {{if eq .detail.Theme 2}}checked{{end}} >
                                        <div class="layui-unselect layui-form-radio"><i
                                                class="layui-anim layui-icon"></i>
                                            <div>简约</div>
                                        </div>
                                        <input type="radio" name="theme" value="3" title="少年" {{if eq .detail.Theme 3}}checked{{end}} >
                                        <div class="layui-unselect layui-form-radio layui-form-radioed"><i
                                                class="layui-anim layui-icon layui-anim-scaleSpring"></i>
                                            <div>少年</div>
                                        </div>
                                        <input type="radio" name="theme" value="4" title="少女" {{if eq .detail.Theme 4}}checked{{end}} >
                                        <div class="layui-unselect layui-form-radio"><i
                                                class="layui-anim layui-icon"></i>
                                            <div>少女</div>
                                        </div>
                                    </div>
                                </div>
                                <div class="layui-form-item">
                                    <label class="layui-form-label">空间</label>
                                    <div class="layui-input-inline">
                                        <input type="text" id="name" name="name" value="{{.detail.Name}}" required=""
                                            lay-verify="name" autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                                <div class="layui-form-item">
                                    <label class="layui-form-label">简介</label>
                                    <div class="layui-input-inline">
                                        <input type="text" id="tip" name="tip" value="{{.detail.Tip}}" required=""
                                            lay-verify="tip" autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                                <div class="layui-form-item">
                                    <label class="layui-form-label">git</label>
                                    <div class="layui-input-inline">
                                        <input type="text" id="git" name="git" value="{{.detail.Git}}" required=""
                                            lay-verify="url" autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                                <div class="layui-form-item">
                                    <label class="layui-form-label">sina</label>
                                    <div class="layui-input-inline">
                                        <input type="text" id="sina" name="sina" value="{{.detail.Sina}}" required=""
                                            lay-verify="url" autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                                <div class="layui-form-item">
                                    <label class="layui-form-label">qq-email</label>
                                    <div class="layui-input-inline">
                                        <input type="text" id="qq" name="qq" value="{{.detail.QQ}}" required=""
                                            lay-verify="qq" autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                                <div class="layui-form-item">
                                    <label class="layui-form-label">版权</label>
                                    <div class="layui-input-inline">
                                        <input type="text" id="copyright" name="copyright" value="{{.detail.Copyright}}" required=""
                                            lay-verify="copyright" autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                                <div class="layui-form-item">
                                    <label class="layui-form-label">头像</label>
                                    <div class="layui-input-inline">
                                        <input type="file" name="headimg" accept="image/*" />
                                    </div>
                                   {{if ne .detail.Headimg ""}}
                                        <div class="layui-input-inline">
                                            <div class="layui-upload-list" style="margin:0;">
                                                <img src="/{{.detail.Headimg}}"
                                                    class="layui-upload-img" style="width: 150px;">
                                            </div>
                                        </div>
                                   {{end}}
                                   
                                 
                                </div>
                                <div class="layui-form-item">
                                    <label class="layui-form-label">背景</label>
                                    <div class="layui-input-inline">
                                        <input type="file" name="banner" accept="image/*" />
                                    </div>
                                    {{if ne .detail.Banner ""}}
                                        <div class="layui-input-inline">
                                            <div class="layui-upload-list" style="margin:0;">
                                                <img src="/{{.detail.Banner}}"
                                                    class="layui-upload-img" style="width: 150px;">
                                            </div>
                                        </div>
                                   {{end}}
                                </div>
                                <div class="layui-form-item">
                                    <label for="" class="layui-form-label"></label>
                                    <button class="layui-btn" lay-filter="save" lay-submit="">保存</button>
                                </div>
                            </form>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    </div>

    <script>
        $(function () {
            layui.use('form', function () {
                var form = layui.form;
                form.verify({
                    name: [/(.+){1,12}$/, '空间名1到20位'],
                    tip: [/(.+)+$/, '简介至少1位'],
                    copyright: [/(.+)+$/, '版权至少1位'],
                    qq: [/[\w!#$%&'*+/=?^_`{|}~-]+(?:\.[\w!#$%&'*+/=?^_`{|}~-]+)*@(?:[\w](?:[\w-]*[\w])?\.)+[\w](?:[\w-]*[\w])?/, '请输入正确的qq邮箱'],
                });
                form.on('submit(save)', function (data) {
                    var formData = new FormData(document.getElementById("taskForm"));
                    $.ajax({
                        url: {{urlfor "SystemController.SystemEdit"}},
                        type: 'post',
                        dataType: 'json',
                        data: formData,
                        async: false,
                        cache: false,
                        contentType: false,
                        processData: false,
                        success: function (result) {
                            if (result.state) {
                                layer.msg(result.msg, {
                                    icon: 6,
                                    time: 2000
                                }, function () {
                                    xadmin.close();
                                    xadmin.father_reload();
                                });
                            } else {
                                layer.msg(result.msg);
                            }
                        }
	  				});
                return false;
            });

        });

        });
    </script>
</body>

</html>