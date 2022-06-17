package controllers

import (
	"fmt"
	"gbb/models"
	"gbb/util"
	"strings"
	"time"

	"github.com/astaxie/beego/orm"
)

type AdminController struct {
	baseController
}

// 获取管理员信息
func (this *AdminController) GetAdminByID(adminId int) models.Admin {
	admin := models.Admin{AdminId: adminId}

	o := orm.NewOrm()
	o.Using("default") // 默认使用 default，你可以指定为其他数据库

	o.Read(&admin)
	return admin
}

func (this *AdminController) AdminList() {

	// o.Using("default") // 默认使用 default，你可以指定为其他数据库

	// var list []*models.Admin
	// num, _ := o.QueryTable("b_admin").All(&list)
	// page := util.PageUtil(int(num), 1, 1, list)
	// this.Data["list"] = page.List
	// this.Data["page"] = page
	pno, _ := this.GetInt("page") //获取当前请求页
	var Items []models.Admin
	conditions := " order by admin_id asc"
	var po util.PageOptions
	po.ParamName = "page"
	po.TableName = "b_admin"      //指定分页的表名
	po.EnableFirstLastLink = true //是否显示首页尾页 默认false
	po.EnablePreNexLink = true    //是否显示上一页下一页 默认为false
	po.Conditions = conditions    // 传递分页条件 默认全表
	po.Currentpage = int(pno)     //传递当前页数,默认为1
	po.PageSize = 7               //页面大小  默认为20

	//返回分页信息,
	//第一个:为返回的当前页面数据集合,ResultSet类型
	//第二个:生成的分页链接
	//第三个:返回总记录数
	//第四个:返回总页数
	totalItem, totalPage, rs, pagerhtml2 := util.GetPagerLinks(&po, this.Ctx)
	rs.QueryRows(&Items) //把当前页面的数据序列化进一个切片内
	this.Data["pagerhtml"] = pagerhtml2
	this.Data["totalItem"] = totalItem
	this.Data["PageSize"] = po.PageSize
	this.Data["totalPage"] = totalPage
	this.Data["Items"] = Items
	this.TplName = "admin/admin/adminList.tpl"
}

func (this *AdminController) AdminPassEdit() {
	id, _ := this.GetInt("adminId")

	detail := this.GetAdminByID(id)

	if this.Ctx.Request.Method == "POST" {
		admin := this.GetSession("admin").(models.Admin)
		if admin.Status != 1 {
			msg := util.Msg{false, "普通管理员无权限"}
			this.Data["json"] = &msg
			this.ServeJSON()
			return
		}

		o := orm.NewOrm()
		o.Using("default") // 默认使用 default，你可以指定为其他数据库

		adminId, _ := this.GetInt("adminId")
		password := this.GetString("password")
		newpass := this.GetString("newpass")
		repass := this.GetString("repass")

		if adminId < 1 {
			msg := util.Msg{false, "参数错误"}
			this.Data["json"] = &msg
			this.ServeJSON()
			return
		}

		if password == "" {
			msg := util.Msg{false, "旧密码不得为空"}
			this.Data["json"] = &msg
			this.ServeJSON()
			return
		}

		if newpass == "" {
			msg := util.Msg{false, "新密码不得为空"}
			this.Data["json"] = &msg
			this.ServeJSON()
			return
		}

		if newpass != repass {
			msg := util.Msg{false, "密码不一致"}
			this.Data["json"] = &msg
			this.ServeJSON()
			return
		}

		data := this.GetAdminByID(adminId)

		if util.Md5(password) != strings.Trim(data.Password, " ") {

			msg := util.Msg{false, "密码错误"}
			this.Data["json"] = &msg
			this.ServeJSON()
			return
		}

		data.Password = util.Md5(newpass)

		_, err := o.Update(&data)
		if err == nil {

			msg := util.Msg{true, "修改成功"}
			this.Data["json"] = &msg
			this.ServeJSON()
			return
		} else {
			msg := util.Msg{false, "修改失败"}
			this.Data["json"] = &msg
			this.ServeJSON()
			return
		}

	}
	this.Data["detail"] = detail
	this.TplName = "admin/admin/adminPassEdit.tpl"
}

func (this *AdminController) AdminAdd() {
	if this.Ctx.Request.Method == "POST" {
		admin := this.GetSession("admin").(models.Admin)
		if admin.Status != 1 {
			msg := util.Msg{false, "普通管理员无权限"}
			this.Data["json"] = &msg
			this.ServeJSON()
			return
		}

		name := this.GetString("name")
		password := this.GetString("password")
		repass := this.GetString("repass")

		if name == "" {
			msg := util.Msg{false, "用户名不得为空"}
			this.Data["json"] = &msg
			this.ServeJSON()
			return
		}

		if password == "" {
			msg := util.Msg{false, "密码不得为空"}
			this.Data["json"] = &msg
			this.ServeJSON()
			return
		}

		if password != repass {
			msg := util.Msg{false, "密码不一致"}
			this.Data["json"] = &msg
			this.ServeJSON()
			return
		}

		o := orm.NewOrm()
		o.Using("default") // 默认使用 default，你可以指定为其他数据库
		data := models.Admin{Name: name}

		err := o.Read(&data, "Name")
		if err != nil {
			fmt.Println(err)
		}

		if data.AdminId > 0 {
			msg := util.Msg{false, "用户名已存在"}
			this.Data["json"] = &msg
			this.ServeJSON()
			return
		}

		data.Password = util.Md5(password)
		data.Addtime = int(time.Now().Unix())
		data.Status = 2

		_, err = o.Insert(&data)
		if err == nil {
			msg := util.Msg{true, "添加成功"}
			this.Data["json"] = &msg
			this.ServeJSON()
			return
		} else {
			msg := util.Msg{false, "添加失败"}
			this.Data["json"] = &msg
			this.ServeJSON()
			return
		}

	}
	this.TplName = "admin/admin/adminAdd.tpl"
}

func (this *AdminController) AdminDel() {
	if this.Ctx.Request.Method == "POST" {
		admin := this.GetSession("admin").(models.Admin)
		if admin.Status != 1 {
			msg := util.Msg{false, "普通管理员无权限"}
			this.Data["json"] = &msg
			this.ServeJSON()
			return
		}

		adminId, _ := this.GetInt("adminId")
		if adminId == 1 {
			msg := util.Msg{false, "超级管理员不能删除"}
			this.Data["json"] = &msg
			this.ServeJSON()
			return
		}
		o := orm.NewOrm()
		if _, err := o.Delete(&models.Admin{AdminId: adminId}); err == nil {
			msg := util.Msg{true, "删除成功"}
			this.Data["json"] = &msg
			this.ServeJSON()
			return
		} else {
			msg := util.Msg{false, "删除失败"}
			this.Data["json"] = &msg
			this.ServeJSON()
			return
		}

	}
}
