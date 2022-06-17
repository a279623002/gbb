package main

import (
	_ "gbb/routers"
	"time"

	"github.com/astaxie/beego"
	_ "github.com/astaxie/beego/orm"
)

func main() {
	beego.EnableXSRF = true
	beego.XSRFKEY = "61oETzKXQAGaYdkL5gEmGeJJFuYh7EQnp2XdTP1o"
	beego.XSRFExpire = 3600  //过期时间，默认1小时

	templateFunc() //添加模板函数要在beego.Run前执行
	//orm.Debug = true
	beego.Run()
}

//建议将需要添加的模板函数统一放入一个方法中统一管理
func templateFunc() {
	beego.AddFuncMap("convertTime", func(int_time int) string {
		return time.Unix(int64(int_time), 0).Format("2006-01-02 15:04")
	})
}
