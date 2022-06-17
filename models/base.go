package models

import (
	"github.com/astaxie/beego/orm"
	_ "github.com/go-sql-driver/mysql"
)

func init() {
	orm.RegisterDriver("mysql", orm.DRMySQL)

	orm.RegisterDataBase("default", "mysql", "root:shiro2796@/gbb?charset=utf8")
	// 需要在init中注册定义的model
	orm.RegisterModelWithPrefix("b_", new(Admin), new(Tag), new(Log), new(Remark), new(System))
}
