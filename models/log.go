package models

type Log struct {
	LogId   int    `orm:"column(log_id);auto"`
	TagId   int    `orm:"column(tag_id)"`
	Title   string `orm:"column(title);size(100)"`
	Content string `orm:"column(content);"`
	Click   int    `orm:"column(click)"`
	Addtime int    `orm:"column(addtime)"`
	Status  int8   `orm:"column(status)"`
}

type LogPn struct {
	LogId     int    `orm:"column(log_id);auto"`
	TagName   string `orm:"column(tag_name)"`
	Title     string `orm:"column(title);size(100)"`
	Addtime   int    `orm:"column(addtime)"`
	RemarkAll int    `orm:"column(remark)"`
	Remark    int    `orm:"column(remark)"`
}

type LogT struct {
	LogId   int    `orm:"column(log_id);auto"`
	TagName string `orm:"column(tag_name)"`
	Title   string `orm:"column(title);size(100)"`
	Content string `orm:"column(content);"`
	Click   int    `orm:"column(click)"`
	Addtime int    `orm:"column(addtime)"`
	Status  int8   `orm:"column(status)"`
}
