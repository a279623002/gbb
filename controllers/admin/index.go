package controllers

import (
	"fmt"
	"gbb/models"
	"gbb/util"
	"strings"
	"time"

	"github.com/astaxie/beego/orm"
)

type IndexController struct {
	baseController
}

func (this *IndexController) Index() {
	this.TplName = "admin/index/index.tpl"
}

func (this *IndexController) Main() {
	this.Data["T"] = time.Now()
	this.TplName = "admin/index/main.tpl"
}

func (this *IndexController) Login() {
	if this.Ctx.Request.Method == "POST" {
		name := this.GetString("name")
		password := util.Md5(this.GetString("password"))
		admin := models.Admin{Name: name}

		o := orm.NewOrm()
		o.Using("default") // 默认使用 default，你可以指定为其他数据库

		err := o.Read(&admin, "Name")

		if admin.AdminId < 1 {
			msg := util.Msg{false, "账号不存在"}
			this.Data["json"] = &msg
			this.ServeJSON()
			return
		}

		if password != strings.Trim(admin.Password, " ") {
			msg := util.Msg{false, "密码错误"}
			this.Data["json"] = &msg
			this.ServeJSON()
			return
		}

		if err == orm.ErrNoRows {
			fmt.Println("查询不到")
		} else if err == orm.ErrMissPK {
			fmt.Println("找不到主键")
		} else {
			msg := util.Msg{true, "登录成功"}

			// 更新状态
			req := this.Ctx.Request
			admin.LoginIp = req.RemoteAddr
			admin.LoginTime = int(time.Now().Unix())
			admin.Password = password

			if _, err := o.Update(&admin); err == nil {
				fmt.Println("更新成功")
				this.SetSession("admin", admin)
			}

			this.Data["json"] = &msg
			this.ServeJSON()
			return
		}

	}

	this.TplName = "admin/index/login.tpl"
}

func (this *IndexController) Logout() {
	this.DelSession("admin")
	this.Ctx.WriteString("<script>window.location.href='/admin/login';</script>")
	return
}
