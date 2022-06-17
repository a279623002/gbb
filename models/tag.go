package models

type Tag struct {
	TagId   int    `orm:"column(tag_id);auto"`
	Name    string `orm:"column(name);size(20)"`
	Addtime int    `orm:"column(addtime)"`
	Status  int8   `orm:"column(status)"`
}
