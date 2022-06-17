package controllers

import (
	"gbb/models"
	"gbb/util"
	"time"

	"github.com/astaxie/beego/orm"
)

type IndexController struct {
	baseController
}

func (this *IndexController) Index() {
	o := orm.NewOrm()
	o.Using("default") // 默认使用 default，你可以指定为其他数据库

	pno, _ := this.GetInt("page") //获取当前请求页

	var Items []models.Log
	conditions := "order by log_id desc"

	var po util.PageOptions
	po.ParamName = "page"
	po.TableName = "b_log"        //指定分页的表名
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

	// 转换需要展示的标签id
	var List []models.LogT
	for _, v := range Items {
		// 只返回 Id 和 Title
		var tag models.Tag
		o.QueryTable("b_tag").Filter("tag_id", v.TagId).One(&tag, "Name")
		List = append(List, models.LogT{
			LogId:   v.LogId,
			TagName: tag.Name,
			Title:   v.Title,
			Content: v.Content,
			Click:   v.Click,
			Addtime: v.Addtime,
			Status:  v.Status,
		})
	}

	this.Data["pagerhtml"] = pagerhtml2
	this.Data["totalItem"] = totalItem
	this.Data["PageSize"] = po.PageSize
	this.Data["totalPage"] = totalPage
	this.Data["List"] = List

	this.TplName = "home/index/index.tpl"
}

func (this *IndexController) Log() {
	logId, _ := this.GetInt("logId")
	if logId < 1 {
		this.Ctx.WriteString("<script>alert('参数错误');window.location.href='/';</script>")
		return
	}
	// 增加点击数
	log := models.Log{LogId: logId}
	o := orm.NewOrm()
	o.Using("default")
	o.Read(&log)

	log.Click += 1
	o.Update(&log)

	var tag models.Tag
	o.QueryTable("b_tag").Filter("tag_id", log.TagId).One(&tag, "Name")
	detail := models.LogT{
		LogId:   log.LogId,
		TagName: tag.Name,
		Title:   log.Title,
		Content: log.Content,
		Click:   log.Click,
		Addtime: log.Addtime,
		Status:  log.Status,
	}

	this.Data["detail"] = detail
	this.TplName = "home/index/log.tpl"
}

func (this *IndexController) Remark() {
	if this.Ctx.Request.Method == "POST" {
		logId, _ := this.GetInt("logId")

		if logId < 1 {
			msg := util.Msg{false, "参数错误"}
			this.Data["json"] = &msg
			this.ServeJSON()
			return
		}
		name := this.GetString("name")

		if name == "" {
			msg := util.Msg{false, "姓名不得为空"}
			this.Data["json"] = &msg
			this.ServeJSON()
			return
		}
		email := this.GetString("email")

		if email == "" {
			msg := util.Msg{false, "邮箱不得为空"}
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

		o := orm.NewOrm()
		o.Using("default")
		data := models.Remark{
			LogId:   logId,
			Name:    name,
			Email:   email,
			Content: content,
			Addtime: int(time.Now().Unix()),
			Status:  1,
		}

		_, err := o.Insert(&data)
		if err != nil {
			msg := util.Msg{false, "评论失败"}
			this.Data["json"] = &msg
			this.ServeJSON()
			return
		} else {
			msg := util.Msg{true, "评论成功"}
			this.Data["json"] = &msg
			this.ServeJSON()
			return
		}
	}
}
