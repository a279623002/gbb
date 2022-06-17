
{{template "admin/common/header.tpl" .}}
    <body>
        <div class="layui-fluid">
            <div class="layui-row layui-col-space15">
                <div class="layui-col-md12">
                    <div class="layui-card">
                        <div class="layui-card-body ">
                            <blockquote class="layui-elem-quote">欢迎管理员：
                                <span class="x-red">{{.admin.Name}}</span>！当前时间:{{date .T "Y-m-d H:i:s"}}
                            </blockquote>
                        </div>
                    </div>
                </div>
                
                <div class="layui-col-md12">
                    <div class="layui-card">
                        <div class="layui-card-header">系统信息</div>
                        <div class="layui-card-body ">
                            <table class="layui-table">
                                <tbody>
                                    <tr>
                                        <th>系统版本</th>
                                        <td>1.0.0</td></tr>
                                    <tr>
                                        <th>操作系统</th>
                                        <td>linux</td></tr>
                                    <tr>
                                        <th>运行环境</th>
                                        <td>goland</td></tr>
                                    <tr>
                                        <th>系统框架</th>
                                        <td>beego</td></tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                
                <div class="layui-col-md12">
                    <div class="layui-card">
                        <div class="layui-card-header">开发团队</div>
                        <div class="layui-card-body ">
                            <table class="layui-table">
                                <tbody>
                                    <tr>
                                        <th>版权所有</th>
                                        <td>siro
                                            <a href="http://siro.zerogod.cn/" target="_blank">访问</a></td>
                                    </tr>
                                    <tr>
                                        <th>开发者</th>
                                        <td>siro(970979353@qq.com)</td></tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                
                <style id="welcome_style"></style>
            </div>
        </div>
        </div>
    </body>
</html>