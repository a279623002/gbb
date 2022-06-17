package routers

import (
	admin "gbb/controllers/admin"
	home "gbb/controllers/home"

	"github.com/astaxie/beego"
)

func init() {
	// 后台
	beego.Router("/admin/", &admin.IndexController{}, "*:Index")
	// 上传文件
	beego.Router("/admin/upload", &admin.UploadController{}, "*:Upload")

	// 登录、首页
	beego.Router("/admin/main", &admin.IndexController{}, "*:Main")
	beego.Router("/admin/login", &admin.IndexController{}, "*:Login")
	beego.Router("/admin/logout", &admin.IndexController{}, "*:Logout")

	// 管理员
	beego.Router("/admin/adminList", &admin.AdminController{}, "*:AdminList")
	beego.Router("/admin/adminPassEdit", &admin.AdminController{}, "*:AdminPassEdit")
	beego.Router("/admin/adminAdd", &admin.AdminController{}, "*:AdminAdd")
	beego.Router("/admin/adminDel", &admin.AdminController{}, "*:AdminDel")

	// 标签
	beego.Router("/admin/tagList", &admin.TagController{}, "*:TagList")
	beego.Router("/admin/tagDel", &admin.TagController{}, "*:TagDel")
	beego.Router("/admin/tagEdit", &admin.TagController{}, "*:TagEdit")

	// 日志
	beego.Router("/admin/logList", &admin.LogController{}, "*:LogList")
	beego.Router("/admin/logDel", &admin.LogController{}, "*:LogDel")
	beego.Router("/admin/logEdit", &admin.LogController{}, "*:LogEdit")

	// 日志评论列表
	beego.Router("/admin/remarkList", &admin.LogController{}, "*:RemarkList")
	beego.Router("/admin/remarkDel", &admin.LogController{}, "*:RemarkDel")

	// 系统
	beego.Router("/admin/system", &admin.SystemController{}, "*:System")
	beego.Router("/admin/systemEdit", &admin.SystemController{}, "*:SystemEdit")

	// 前台
	beego.Router("/", &home.IndexController{}, "*:Index")
	beego.Router("/log", &home.IndexController{}, "*:Log")
	beego.Router("/remark", &home.IndexController{}, "*:Remark")
}
