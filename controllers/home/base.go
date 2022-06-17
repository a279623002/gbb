package controllers

import (
	"html/template"
	"gbb/models"

	"github.com/astaxie/beego"
	"github.com/astaxie/beego/orm"
)

type baseController struct {
	beego.Controller
}

func (this *baseController) Prepare() {
	system := models.System{SystemId: 1}

	o := orm.NewOrm()
	o.Using("default") // 默认使用 default，你可以指定为其他数据库

	o.Read(&system)

	this.Data["xsrfdata"] = template.HTML(this.XSRFFormHTML())
	this.Data["xsrf_token"] = this.XSRFToken()

	this.Data["system"] = system

}
