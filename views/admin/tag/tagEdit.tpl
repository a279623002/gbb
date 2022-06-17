{{template "admin/common/header.tpl" .}}

<body>

    <div class="layui-fluid">
        <div class="layui-row">
            <form method="post" class="layui-form" id="taskForm" enctype="multipart/form-data">
            {{ .xsrfdata }}
                <input type="hidden" name="tagId" value="{{.detail.TagId}}">
                <div class="layui-form-item">
                    <label for="L_name" class="layui-form-label">名称</label>
                    <div class="layui-input-inline">
                        <input type="text" id="L_name" name="name" required="" value="{{.detail.Name}}" class="layui-input"></div>
                </div>
         

                <div class="layui-form-item">
                    <label for="L_repass" class="layui-form-label"></label>
                    <button class="layui-btn" lay-filter="save" lay-submit="">保存</button></div>
            </form>
        </div>
    </div>
    <script>
        $(function () {
            layui.use('form', function () {
                var form = layui.form;
                form.verify({
                });
                form.on('submit(save)', function (data) {
                    var formData = new FormData(document.getElementById("taskForm"));
                    $.ajax({
                        url: {{urlfor "TagController.TagEdit"}},
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