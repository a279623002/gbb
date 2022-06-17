{{template "admin/common/header.tpl" .}}
<body class="login-bg">
    
    <div class="login layui-anim layui-anim-up">
        <div class="message">Siro-后台管理</div>
        <div id="darkbannerwrap"></div>
        
        <form method="post" class="layui-form" >
            {{ .xsrfdata }}
            <input name="name" placeholder="用户名"  type="text" lay-verify="required" class="layui-input" >
            <hr class="hr15">
            <input name="password" lay-verify="required" placeholder="密码"  type="password" class="layui-input">
            <hr class="hr15">
            <input value="登录" lay-submit lay-filter="login" style="width:100%;" type="submit">
            <hr class="hr20" >
        </form>
    </div>

    <script>
        $(function() {
            layui.use('form', function(){
              var form = layui.form;
              form.on('submit(login)', function(data){
            	  $.ajax({
	  					url: {{urlfor "IndexController.Login"}},
	  					type: 'post',
	  					dataType: 'json',
	  					data: data.field,
	  					success: function (result) {
	                     if(result.state) {
	                    	 layer.msg(result.msg, {
	                    		  icon: 1,
	                    		  time: 2000
	                    	 }, function(){
	                    			window.location.href = {{urlfor "IndexController.Index"}};
	                    	 }); 
	                     } else {
	                    	 layer.msg(result.msg);
	                     }
		  				}
	  				});
            	  return false;
              });
            });
        })
    </script>
</body>
</html>