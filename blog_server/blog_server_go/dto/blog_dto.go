package dto

/*
厦门大学计算机专业 | 前华为工程师
专注《零基础学编程系列》  http://lblbc.cn/blog
包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
公众号：蓝不蓝编程
*/
type BlogUpdateDTORequest struct {
	ID      uint64 `json:"id" form:"id"`
	Title   string `json:"title" form:"title" binding:"required"`
	Content string `json:"content" form:"content" binding:"required"`
	UserID  uint64 `json:"user_id,omnitempty" form:"user_id,omitempty"`
}

type BlogCreateDTORequest struct {
	Title   string `json:"title" form:"title" binding:"required"`
	Content string `json:"content" form:"content" binding:"required"`
	UserID  uint64 `json:"user_id,omnitempty" form:"user_id,omitempty"`
}
