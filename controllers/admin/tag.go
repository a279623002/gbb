package controllers

import (
	"fmt"
	"gbb/models"
	"gbb/util"
	"time"

	"github.com/astaxie/beego/orm"
)

type TagController struct {
	baseController
}

func (this *TagController) TagList() {
	pno, _ := this.GetInt("page")  //获取当前请求页
	name := this.GetString("name") //获取当前请求页

	var Items []models.Tag
	conditions := "order by tag_id asc"
	if name != "" {
		conditions = "where name like '%" + name + "%' order by tag_id asc"
	}
	var po util.PageOptions
	po.ParamName = "page"
	po.TableName = "b_tag"        //指定分页的表名
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
	this.TplName = "admin/tag/tagList.tpl"
}

func (this *TagController) TagDel() {
	if this.Ctx.Request.Method == "POST" {
		admin := this.GetSession("admin").(models.Admin)
		if admin.Status != 1 {
			msg := util.Msg{false, "普通管理员无权限"}
			this.Data["json"] = &msg
			this.ServeJSON()
			return
		}
		tagId, _ := this.GetInt("tagId")
		o := orm.NewOrm()
		if _, err := o.Delete(&models.Tag{TagId: tagId}); err == nil {
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

// 获取标签信息
func (this *TagController) GetTagByID(tagId int) models.Tag {
	tag := models.Tag{TagId: tagId}

	o := orm.NewOrm()
	o.Using("default") // 默认使用 default，你可以指定为其他数据库

	o.Read(&tag)
	return tag
}

func (this *TagController) TagEdit() {
	id, _ := this.GetInt("tagId")

	detail := this.GetTagByID(id)

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

		name := this.GetString("name")

		if name == "" {
			msg := util.Msg{false, "标题不得为空"}
			this.Data["json"] = &msg
			this.ServeJSON()
			return
		}

		data := models.Tag{Name: name}

		err := o.Read(&data, "Name")
		if err != nil {
			fmt.Println(err)
		}

		if data.TagId > 0 {
			msg := util.Msg{false, "标签已存在"}
			this.Data["json"] = &msg
			this.ServeJSON()
			return
		}

		tagId, _ := this.GetInt("tagId")
		if tagId > 0 {
			data.TagId = tagId
			data.Name = name

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
		} else {
			data.TagId = tagId
			data.Name = name
			data.Addtime = int(time.Now().Unix())
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

	}
	this.Data["detail"] = detail
	this.TplName = "admin/tag/tagEdit.tpl"
}
