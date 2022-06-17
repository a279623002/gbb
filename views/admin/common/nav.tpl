<!-- 顶部开始 -->
<div class="container">
    <div class="logo">
        <a href={{urlfor "IndexController.Index"}}>siro后台管理</a></div>
    <div class="left_open">
        <a><i title="展开左侧栏" class="iconfont">&#xe699;</i></a>
    </div>
    <ul class="layui-nav right" lay-filter="">
        <li class="layui-nav-item">
            <a href="javascript:;">{{.admin.Name}}</a>
            <dl class="layui-nav-child">
                <!-- 二级菜单 -->
                <!-- <dd>
                    <a onclick="xadmin.open('个人信息','')">个人信息</a></dd>
                <dd>
                    <a onclick="xadmin.open('切换帐号','')">切换帐号</a></dd> -->
                <dd>
                    <a href={{urlfor "IndexController.Logout"}}>退出</a></dd>
            </dl>
        </li>
        <li class="layui-nav-item to-index">
            <a href="/" target="_blank">前台首页</a></li>
    </ul>
</div>


<div class="left-nav">
    <div id="side-nav">
        <ul id="nav">
            <li>
                <a href="javascript:;">
                    <i class="iconfont left-nav-li" lay-tips="管理员管理">&#xe6b8;</i>
                    <cite>管理员管理</cite>
                    <i class="iconfont nav_right">&#xe697;</i></a>
                <ul class="sub-menu">
                    <li>
                        <a onclick="xadmin.add_tab('管理员列表',{{urlfor "AdminController.AdminList"}})">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>管理员列表</cite>
                        </a>
                    </li>
                </ul>
            </li>
            <li>
                <a href="javascript:;">
                    <i class="iconfont left-nav-li" lay-tips="标签管理">&#xe6b2;</i>
                    <cite>标签管理</cite>
                    <i class="iconfont nav_right">&#xe697;</i></a>
                <ul class="sub-menu">
                    <li>
                        <a onclick="xadmin.add_tab('标签列表',{{urlfor "TagController.TagList"}})">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>标签列表</cite>
                        </a>
                    </li>
                </ul>
            </li>
            <li>
                <a href="javascript:;">
                    <i class="iconfont left-nav-li" lay-tips="日志管理">&#xe6b2;</i>
                    <cite>日志管理</cite>
                    <i class="iconfont nav_right">&#xe697;</i></a>
                <ul class="sub-menu">
                    <li>
                        <a onclick="xadmin.add_tab('日志列表',{{urlfor "LogController.LogList"}})">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>日志列表</cite>
                        </a>
                    </li>
                </ul>
            </li>
            <li>
                <a href="javascript:;">
                    <i class="layui-icon layui-icon-set" lay-tips="系统管理"></i>
                    <cite>系统管理</cite>
                    <i class="iconfont nav_right">&#xe697;</i></a>
                <ul class="sub-menu">
                    <li>
                        <a onclick="xadmin.add_tab('系统设置',{{urlfor "SystemController.System"}})">
                            <i class="iconfont">&#xe6a7;</i>
                            <cite>系统设置</cite>
                        </a>
                    </li>
                </ul>
            </li>
       
        </ul>
    </div>
</div>