{{template "admin/common/header.tpl" .}}

<body>

    <div class="layui-fluid">
        <div class="layui-row">
            <form method="post" class="layui-form">
                {{ .xsrfdata }}
                <input type="hidden" name="logId" value="{{.detail.LogId}}">


                <div class="layui-form-item">
                    <label class="layui-form-label">标签</label>
                    <div class="layui-input-block">
                        {{$lid := .detail.TagId}}
                        {{range $index, $elem := .tagList}}
                        <input type="radio" name="tagId" value="{{$elem.TagId}}" title="{{$elem.Name}}"
                            {{if compare $elem.TagId $lid}} checked{{end}}>
                        <div class="layui-unselect layui-form-radio"><i class="layui-anim layui-icon"></i>
                            <div>{{$elem.Name}}</div>
                        </div>
                        {{end}}


                    </div>
                </div>

                <div class="layui-form-item">
                    <label for="L_title" class="layui-form-label">标题</label>
                    <div class="layui-input-inline">
                        <input type="text" id="L_title" name="title" required="" value="{{.detail.Title}}" class="layui-input"></div>
                </div>

           
                <script id="editor" name="content" style="min-height: 500px; width: 90%; margin: 0 auto;"></script>
                <!-- 配置文件 -->
                <script type="text/javascript" src="/static/ueditor/ueditor.config.js"></script>
                <!-- 编辑器源码文件 -->
                <script type="text/javascript" src="/static/ueditor/ueditor.all.js"></script>
                <!-- 实例化编辑器 -->
                <script type="text/javascript">
                    var ue = UE.getEditor('editor');
                    ue.ready(function() {
                        //设置编辑器的内容
                        {{if ne .detail.Content ""}} 
                            ue.setContent({{.detail.Content}});
                        {{end}}
                    });
                </script>


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
                    $.ajax({
                        url: {{ urlfor "LogController.LogEdit" }},
                        type: 'post',
                        dataType: 'json',
                        data: data.field,
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