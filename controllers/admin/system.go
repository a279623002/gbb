package controllers

import (
	"crypto/md5"
	"fmt"
	"math/rand"
	"os"
	"path"
	"gbb/models"
	"gbb/util"
	"time"

	"github.com/astaxie/beego/orm"
)

type SystemController struct {
	baseController
}

func (this *SystemController) System() {
	detail := models.System{SystemId: 1}

	o := orm.NewOrm()
	o.Using("default") // 默认使用 default，你可以指定为其他数据库

	o.Read(&detail)

	this.Data["detail"] = detail

	this.TplName = "admin/system/system.tpl"
}

func (this *SystemController) SystemEdit() {

	if this.Ctx.Request.Method == "POST" {
		admin := this.GetSession("admin").(models.Admin)
		if admin.Status != 1 {
			msg := util.Msg{false, "普通管理员无权限"}
			this.Data["json"] = &msg
			this.ServeJSON()
			return
		}

		data := models.System{SystemId: 1}

		o := orm.NewOrm()
		o.Using("default") // 默认使用 default，你可以指定为其他数据库

		o.Read(&data)

		logo, _ := this.GetInt("logo")
		if logo > 0 {
			data.Logo = int8(logo)
		}

		theme, _ := this.GetInt("theme")
		if logo > 0 {
			data.Theme = int8(theme)
		}

		name := this.GetString("name")
		if name == "" {
			msg := util.Msg{false, "空间不得为空"}
			this.Data["json"] = &msg
			this.ServeJSON()
			return
		}
		data.Name = name

		tip := this.GetString("tip")
		if tip == "" {
			msg := util.Msg{false, "简介不得为空"}
			this.Data["json"] = &msg
			this.ServeJSON()
			return
		}
		data.Tip = tip

		git := this.GetString("git")
		if git != "" {
			data.Git = git
		}

		sina := this.GetString("sina")
		if sina != "" {
			data.Sina = sina
		}

		qq := this.GetString("qq")
		if qq != "" {
			data.QQ = qq
		}

		copyright := this.GetString("copyright")
		if copyright != "" {
			data.Copyright = copyright
		}

		headimg, _, _ := this.GetFile("headimg")
		if headimg != nil {
			url, err := this.UpFile("headimg")
			if err != "" {
				msg := util.Msg{false, err}
				this.Data["json"] = &msg
				this.ServeJSON()
				return
			}
			data.Headimg = url
		}

		banner, _, _ := this.GetFile("banner")
		if banner != nil {
			url, err := this.UpFile("banner")
			if err != "" {
				msg := util.Msg{false, err}
				this.Data["json"] = &msg
				this.ServeJSON()
				return
			}
			data.Banner = url
		}

		_, err := o.Update(&data)
		if err == nil {
			msg := util.Msg{true, "保存成功"}
			this.Data["json"] = &msg
			this.ServeJSON()
			return
		} else {
			msg := util.Msg{false, "保存失败"}
			this.Data["json"] = &msg
			this.ServeJSON()
			return
		}

	}

}

func (this *SystemController) UpFile(file string) (url string, err string) {

	f, h, _ := this.GetFile(file) //获取上传的文件
	ext := path.Ext(h.Filename)
	//验证后缀名是否符合要求
	var AllowExtMap map[string]bool = map[string]bool{
		".jpg":  true,
		".jpeg": true,
		".png":  true,
	}
	if _, ok := AllowExtMap[ext]; !ok {
		err = "后缀名不符合上传要求"
		return
	}
	//创建目录
	uploadDir := "static/upload/" + time.Now().Format("2006/01/02/")
	err1 := os.MkdirAll(uploadDir, 777)
	if err1 != nil {
		err = fmt.Sprintf("%v", err1)
		return
	}
	//构造文件名称
	rand.Seed(time.Now().UnixNano())
	randNum := fmt.Sprintf("%d", rand.Intn(9999)+1000)
	hashName := md5.Sum([]byte(time.Now().Format("2006_01_02_15_04_05_") + randNum))

	fileName := fmt.Sprintf("%x", hashName) + ext
	//this.Ctx.WriteString(  fileName )

	fpath := uploadDir + fileName
	defer f.Close() //关闭上传的文件，不然的话会出现临时文件不能清除的情况
	err1 = this.SaveToFile(file, fpath)
	if err1 != nil {
		err = fmt.Sprintf("%v", err1)
		return
	}
	return fpath, ""
}
