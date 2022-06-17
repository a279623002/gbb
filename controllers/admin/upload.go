package controllers

import (
	"crypto/md5"
	"encoding/json"
	"fmt"
	"io"
	"io/ioutil"
	"math/rand"
	"os"
	"regexp"
	"strings"
	"time"
)

type UploadController struct {
	baseController
}

func (this *UploadController) Prepare() {
	this.EnableXSRF = false
}

// 上传图片
func (this *UploadController) Upload() {

	err := this.Ctx.Request.ParseForm()
	if err != nil {
		fmt.Fprintf(this.Ctx.ResponseWriter, "解析参数失败: %v", err)
		return
	}
	op := this.Ctx.Request.Form.Get("action")
	switch op {
	case "config":
		file, err := os.Open("static/ueditor/go/config.json")
		if err != nil {
			fmt.Fprintf(this.Ctx.ResponseWriter, "打开文件错误 : %v", err)
			return
		}
		defer file.Close()
		fd, err := ioutil.ReadAll(file)
		if err != nil {
			fmt.Fprintf(this.Ctx.ResponseWriter, "读取文件失败 : %v", err)
			return
		}

		src := string(fd)
		re, _ := regexp.Compile(`\/\*[\S\s]+?\*\/`) // 匹配里面的注释
		src = re.ReplaceAllString(src, "")
		tt := []byte(src)
		var r interface{}
		err = json.Unmarshal(tt, &r) //这个byte要解码
		if err != nil {
			fmt.Fprintf(this.Ctx.ResponseWriter, "json decode failed %v", err)
			return
		}

		tt, err = json.Marshal(r)
		if err != nil {
			fmt.Fprintf(this.Ctx.ResponseWriter, "json encode failed $v", err)
			return
		}
		fmt.Fprint(this.Ctx.ResponseWriter, string(tt))

	// 上传图片的功能
	case "uploadimage":
		err := this.Ctx.Request.ParseForm()
		if err != nil {
			fmt.Fprintf(this.Ctx.ResponseWriter, "uploadimage parseform fail : %v", err)
			return
		}
		fmt.Println("打印所有的请求 : ", this.Ctx.Request.PostForm)
		fmt.Println("打印 upfile :", this.Ctx.Request.PostForm.Get("upfile"))
		// 开始上传
		// 文件路径
		file, h, err := this.Ctx.Request.FormFile("upfile")
		defer file.Close()
		if err != nil {
			fmt.Printf("%v\n", err)
			return
		}
		fmt.Println("file header: ", h, "\n detail-filename: ", h.Filename, " ;\n fileHeader:", h.Header)
		// 文件路径
		filePath := "/root/go/src/gbb/static/upload/" + time.Now().Format("20060102")
		err = os.MkdirAll(filePath, 0777)
		if err != nil {
			fmt.Printf("%v\n", err)
			return
		}
		// 文件名
		//构造文件名称
		rand.Seed(time.Now().UnixNano())
		randNum := fmt.Sprintf("%d", rand.Intn(9999)+1000)
		hashName := md5.Sum([]byte(time.Now().Format("2006_01_02_15_04_05_") + randNum))

		fileName := filePath + "/" + fmt.Sprintf("%x", hashName) + ".jpg"
		f, err := os.OpenFile(fileName, os.O_WRONLY|os.O_CREATE|os.O_TRUNC, 0666)
		if err != nil {
			fmt.Printf("%v\n", err)
			return
		}
		defer f.Close()
		io.Copy(f, file)
		ret_json := map[string]interface{}{
			"state":    "SUCCESS",
			"url":      strings.Replace(fileName, "/root/go/src/gbb", "", 1),
			"title":    h.Filename,
			"original": h.Filename,
			"type":     h.Header.Get("Content-Type"),
		}
		json, _ := json.Marshal(ret_json)
		fmt.Fprintf(this.Ctx.ResponseWriter, string(json))

	default:
		fmt.Fprint(this.Ctx.ResponseWriter, `{"msg":"请求地址错误"}`)
	}
}
