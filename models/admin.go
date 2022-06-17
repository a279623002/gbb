package models

type Admin struct {
	AdminId   int    `orm:"column(admin_id);auto"`
	Name      string `orm:"column(name);size(20)"`
	Password  string `orm:"column(password)"`
	LoginTime int    `orm:"column(login_time)"`
	Addtime   int    `orm:"column(addtime)"`
	LoginIp   string `orm:"column(login_ip)"`
	Status    int8   `orm:"column(status)"`
}
