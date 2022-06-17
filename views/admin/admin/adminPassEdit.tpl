{{template "admin/common/header.tpl" .}}
    <body>
        <div class="layui-fluid">
            <div class="layui-row">
                <form method="post" class="layui-form">
                     {{ .xsrfdata }}
                     <input type="hidden" name="adminId" value="{{.detail.AdminId}}">
                    <div class="layui-form-item">
                        <label for="L_uname" class="layui-form-label">账号</label>
                        <div class="layui-input-inline">
                            <input type="text" id="L_name" value="{{.detail.Name}}" disabled class="layui-input"></div>
                    </div>
                    <div class="layui-form-item">
                        <label for="L_password" class="layui-form-label">
                            <span class="x-red">*</span>旧密码</label>
                        <div class="layui-input-inline">
                            <input type="password" id="L_password" name="password" required="" lay-verify="password" autocomplete="off" class="layui-input"></div>
                    </div>
                    <div class="layui-form-item">
                        <label for="L_newpass" class="layui-form-label">
                            <span class="x-red">*</span>新密码</label>
                        <div class="layui-input-inline">
                            <input type="password" id="L_newpass" name="newpass" required="" lay-verify="newpass" autocomplete="off" class="layui-input"></div>
                        <div class="layui-form-mid layui-word-aux">6到16个字符</div></div>
                    <div class="layui-form-item">
                        <label for="L_repass" class="layui-form-label">
                            <span class="x-red">*</span>确认密码</label>
                        <div class="layui-input-inline">
                            <input type="password" id="L_repass" name="repass" required="" lay-verify="repass" autocomplete="off" class="layui-input"></div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label"></label>
                        <button class="layui-btn" lay-filter="save" lay-submit="">保存</button></div>
                </form>
            </div>
        </div>
        <script>
        $(function() {
            layui.use('form', function(){
              var form = layui.form;
              form.verify({
            	  password: [/(.+){3,12}$/, '旧密码必须6到12位'],
            	  newpass: [/(.+){6,12}$/, '新密码必须6到12位'],
            	  repass: function(value) {
                      if ($('#L_newpass').val() != $('#L_repass').val()) {
                          return '两次密码不一致';
                      }
                  }
              });
              form.on('submit(save)', function(data){
            	  $.ajax({
	  					url: {{urlfor "AdminController.AdminPassEdit"}},
	  					type: 'post',
	  					dataType: 'json',
	  					data: data.field,
	  					success: function (result) {
	                     if(result.state) {
	                    	 layer.msg(result.msg, {
	                    		  icon: 6,
	                    		  time: 2000
	                    	 }, function(){
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