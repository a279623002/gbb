package controllers

import (
	"gbb/models"
	"gbb/util"
	"time"

	"github.com/astaxie/beego/orm"
)

type LogController struct {
	baseController
}

func (this *LogController) TagList() []*models.Tag {
	o := orm.NewOrm()
	o.Using("default") // 默认使用 default，你可以指定为其他数据库
	//获取tag列表
	var tagList []*models.Tag
	o.QueryTable("b_tag").All(&tagList)
	return tagList
}

func (this *LogController) LogList() {
	//获取tag列表
	tagList := this.TagList()
	o := orm.NewOrm()
	o.Using("default") // 默认使用 default，你可以指定为其他数据库

	pno, _ := this.GetInt("page") //获取当前请求页
	tagId := this.GetString("tag_id")
	title := this.GetString("title")

	var Items []models.Log
	conditions := "order by addtime desc"
	mapWhere := ""
	if tagId != "" {
		mapWhere = "tag_id = " + tagId + " "
	}
	if title != "" {
		if mapWhere != "" {
			mapWhere += "and "
		}
		mapWhere += "title like '%" + title + "%' "
	}
	if mapWhere != "" {
		conditions = " where " + mapWhere + conditions
	}

	var po util.PageOptions
	po.ParamName = "page"
	po.TableName = "b_log"        //指定分页的表名
	po.EnableFirstLastLink = true //是否显示首页尾页 默认false
	po.EnablePreNexLink = true    //是否显示上一页下一页 默认为false
	po.Conditions = conditions    // 传递分页条件 默认全表
	po.Currentpage = int(pno)     //传递当前页数,默认为1
	po.PageSize = 10               //页面大小  默认为20

	//返回分页信息,
	//第一个:为返回的当前页面数据集合,ResultSet类型
	//第二个:生成的分页链接
	//第三个:返回总记录数
	//第四个:返回总页数
	totalItem, totalPage, rs, pagerhtml2 := util.GetPagerLinks(&po, this.Ctx)
	rs.QueryRows(&Items) //把当前页面的数据序列化进一个切片内

	// 转换需要展示的标签id、评论数\未读评论数
	var List []models.LogPn
	for _, v := range Items {
		// 只返回 Id 和 Title
		var tag models.Tag
		o.QueryTable("b_tag").Filter("tag_id", v.TagId).One(&tag, "Name")
		remark, _ := o.QueryTable("b_remark").Filter("log_id", v.LogId).Filter("status", 1).Count()
		remarkAll, _ := o.QueryTable("b_remark").Filter("log_id", v.LogId).Count()
		List = append(List, models.LogPn{
			LogId:     v.LogId,
			TagName:   tag.Name,
			Title:     v.Title,
			Addtime:   v.Addtime,
			RemarkAll: int(remarkAll),
			Remark:    int(remark),
		})
	}
	this.Data["pagerhtml"] = pagerhtml2
	this.Data["totalItem"] = totalItem
	this.Data["PageSize"] = po.PageSize
	this.Data["totalPage"] = totalPage
	this.Data["List"] = List
	this.Data["tagList"] = tagList
	this.TplName = "admin/log/logList.tpl"
}

func (this *LogController) LogDel() {
	if this.Ctx.Request.Method == "POST" {
		admin := this.GetSession("admin").(models.Admin)
		if admin.Status != 1 {
			msg := util.Msg{false, "普通管理员无权限"}
			this.Data["json"] = &msg
			this.ServeJSON()
			return
		}
		logId, _ := this.GetInt("logId")
		o := orm.NewOrm()
		if _, err := o.Delete(&models.Log{LogId: logId}); err == nil {
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

// 获取日志信息
func (this *LogController) GetLogByID(logId int) models.Log {
	log := models.Log{LogId: logId}

	o := orm.NewOrm()
	o.Using("default") // 默认使用 default，你可以指定为其他数据库

	o.Read(&log)
	return log
}

func (this *LogController) LogEdit() {
	//获取tag列表
	tagList := this.TagList()
	id, _ := this.GetInt("logId")

	detail := this.GetLogByID(id)

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

		title := this.GetString("title")

		if title == "" {
			msg := util.Msg{false, "标题不得为空"}
			this.Data["json"] = &msg
			this.ServeJSON()
			return
		}

		tagId, _ := this.GetInt("tagId")

		if tagId < 1 {
			msg := util.Msg{false, "标签不得为空"}
			this.Data["json"] = &msg
			this.ServeJSON()
			return
		}

		content := this.GetString("content")

		if content == "" {
			msg := util.Msg{false, "内容不得为空"}
			this.Data["json"] = &msg
			this.ServeJSON()
			return
		}

		logId, _ := this.GetInt("logId")
		if logId > 0 {
			data := this.GetLogByID(logId)
			data.Content = content
			data.Title = title
			data.TagId = tagId

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
			data := models.Log{
				TagId:   tagId,
				Title:   title,
				Content: content,
				Click:   0,
				Addtime: int(time.Now().Unix()),
				Status:  1,
			}

			_, err := o.Insert(&data)
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
	this.Data["tagList"] = tagList
	this.TplName = "admin/log/logEdit.tpl"
}

func (this *LogController) RemarkList() {
	pno, _ := this.GetInt("page") //获取当前请求页
	logId := this.GetString("logId")

	if logId == "" {
		return
	}

	var Items []models.Remark
	conditions := "where log_id = " + logId + " order by remark_id desc"

	var po util.PageOptions
	po.ParamName = "page"
	po.TableName = "b_remark"     //指定分页的表名
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
	for _, v := range Items {
		this.ReadRemark(v.RemarkId)
	}

	this.Data["pagerhtml"] = pagerhtml2
	this.Data["totalItem"] = totalItem
	this.Data["PageSize"] = po.PageSize
	this.Data["totalPage"] = totalPage
	this.Data["Items"] = Items

	this.TplName = "admin/log/remarkList.tpl"
}

func (this *LogController) RemarkDel() {
	if this.Ctx.Request.Method == "POST" {
		admin := this.GetSession("admin").(models.Admin)
		if admin.Status != 1 {
			msg := util.Msg{false, "普通管理员无权限"}
			this.Data["json"] = &msg
			this.ServeJSON()
			return
		}
		remarkId, _ := this.GetInt("remarkId")
		o := orm.NewOrm()
		if _, err := o.Delete(&models.Remark{RemarkId: remarkId}); err == nil {
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

func (this *LogController) ReadRemark(remarkId int) {
	o := orm.NewOrm()
	o.Using("default") // 默认使用 default，你可以指定为其他数据库
	remark := models.Remark{RemarkId: remarkId}

	o.Read(&remark)

	remark.Status = 2

	o.Update(&remark)

}
