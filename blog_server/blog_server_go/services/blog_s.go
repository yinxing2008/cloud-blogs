package services

/*
厦门大学计算机专业 | 前华为工程师
专注《零基础学编程系列》  http://lblbc.cn/blog
包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
公众号：蓝不蓝编程
*/
import (
	"log"

	"github.com/mashingan/smapping"
	"lblbc.cn/blog/dto"
	"lblbc.cn/blog/entity"
	"lblbc.cn/blog/repository"
)

type BlogService interface {
	AddBlog(b dto.BlogCreateDTORequest) entity.Blog
	ModifyBlog(b dto.BlogUpdateDTORequest) entity.Blog
	DeleteBlog(b entity.Blog)
	QueryById(blogId uint64) entity.Blog
	QueryBlogs() []entity.Blog
}

type blogService struct {
	blogRepository repository.BlogRepository
}

func NewBookService(bookRepo repository.BlogRepository) BlogService {
	return &blogService{blogRepository: bookRepo}
}

func (s *blogService) QueryById(blogId uint64) entity.Blog {
	return s.blogRepository.QueryByID(blogId)
}

func (s *blogService) QueryBlogs() []entity.Blog {
	return s.blogRepository.QueryBlogs()
}

func (s *blogService) AddBlog(b dto.BlogCreateDTORequest) entity.Blog {
	blog := entity.Blog{}
	err := smapping.FillStruct(&blog, smapping.MapFields(&b))
	if err != nil {
		log.Fatalf("Failed to map fields %v: ", err)
	}
	result := s.blogRepository.AddBlog(blog)
	return result
}

func (s *blogService) ModifyBlog(b dto.BlogUpdateDTORequest) entity.Blog {
	blog := entity.Blog{}
	err := smapping.FillStruct(&blog, smapping.MapFields(&b))
	if err != nil {
		log.Fatalf("Failed to map fields %v: ", err)
	}
	result := s.blogRepository.ModifyBlog(blog)
	return result
}

func (s *blogService) DeleteBlog(b entity.Blog) {
	s.blogRepository.DeleteBlog(b) // delete book
}
