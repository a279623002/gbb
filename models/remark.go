package models

type Remark struct {
	RemarkId int    `orm:"column(remark_id);auto"`
	LogId    int    `orm:"column(log_id)"`
	Name     string `orm:"column(name);size(100)"`
	Email    string `orm:"column(email);size(100)"`
	Content  string `orm:"column(content);"`
	Addtime  int    `orm:"column(addtime)"`
	Status   int8   `orm:"column(status)"`
}
