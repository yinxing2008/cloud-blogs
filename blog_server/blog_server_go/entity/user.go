package entity

/*
厦门大学计算机专业 | 前华为工程师
专注《零基础学编程系列》  http://lblbc.cn/blog
包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
公众号：蓝不蓝编程
*/
type User struct {
	ID       uint64  `gorm:"primary_key;auto_increment" json:"id"` // Primary key, auto-increment id with json tag id for json marshalling
	Name     string  `gorm:"type:varchar(255)" json:"name"`        // Data type varchar with json tag name for json marshalling
	Password string  `gorm:"->;<-;not null" json:"-"`              // TablesPassword field with json tag password for json marshalling
	Token    string  `gorm:"-" json:"token,omitempty"`             // Token field with json tag token for json marshalling
	Blogs    *[]Blog `json:"blogs,omitempty"`
}

func (User) TableName() string {
	return "sys_user"
}
