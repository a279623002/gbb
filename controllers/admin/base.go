package controllers

import (
	"html/template"
	"gbb/models"

	"github.com/astaxie/beego"
)

type baseController struct {
	beego.Controller
}

func (this *baseController) Prepare() {
	admin := this.GetSession("admin")
	_, method := this.GetControllerAndAction()
	this.Data["xsrfdata"] = template.HTML(this.XSRFFormHTML())
	this.Data["xsrf_token"] = this.XSRFToken()
	if admin != nil {
		if method == "Login" {
			this.Ctx.WriteString("<script>window.location.href='/admin/';</script>")
		}
		this.Data["admin"] = admin.(models.Admin)

	} else {
		if method != "Login" {
			this.Ctx.WriteString("<script>window.location.href='/admin/login';</script>")
		}
	}

}
