package models

type System struct {
	SystemId  int    `orm:"column(system_id);auto"`
	Headimg   string `orm:"column(headimg);size(255)"`
	Name      string `orm:"column(name);size(20)"`
	Tip       string `orm:"column(tip);size(20)"`
	Git       string `orm:"column(git);size(255)"`
	Sina      string `orm:"column(sina);size(255)"`
	QQ        string `orm:"column(qq);size(255)"`
	Banner    string `orm:"column(banner);size(255)"`
	Theme     int8   `orm:"column(theme)"`
	Copyright string `orm:"column(copyright);size(100)"`
	Logo      int8   `orm:"column(logo)"`
}
