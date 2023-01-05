package entity

/*
厦门大学计算机专业 | 前华为工程师
专注《零基础学编程系列》  http://lblbc.cn/blog
包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
公众号：蓝不蓝编程
*/
type Blog struct {
	ID      uint64 `gorm:"primary_key;auto_increment" json:"id"`
	Title   string `gorm:"type:varchar(255)" json:"title"`
	Content string `gorm:"type:varchar(255)" json:"content"`
	UserID  uint64 `gorm:"not_null" json:"-"`
	// Create a foreign key to user table with json tag user for json marshalling
	User *User `gorm:"foreignkey:UserID;references:ID;constraint:onUpdate:CASCADE,onDelete:CASCADE" json:"-"`
}

func (Blog) TableName() string {
	return "blog"
}
