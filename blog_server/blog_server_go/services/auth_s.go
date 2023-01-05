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
	"golang.org/x/crypto/bcrypt"
	"lblbc.cn/blog/dto"
	"lblbc.cn/blog/entity"
	"lblbc.cn/blog/repository"
)

type LoginService interface {
	VerifyUser(name string, password string) interface{}
	Register(user dto.RegisterDTORequest) entity.User
	FindByName(name string) entity.User
	IsUserExists(name string) bool
}

type authService struct {
	userRepository repository.UserRepository
}

func NewAuthService(userRepository repository.UserRepository) LoginService {
	return &authService{userRepository: userRepository}
}

func (s *authService) VerifyUser(name string, password string) interface{} {
	res := s.userRepository.VerifyUser(name, password)
	if v, ok := res.(entity.User); ok {
		comparedPassword := comparePassword(v.Password, []byte(password))

		if v.Name == name && comparedPassword {
			return res
		}
		return false
	}
	return false
}

func (s *authService) Register(user dto.RegisterDTORequest) entity.User {
	userToCreate := entity.User{}
	err := smapping.FillStruct(&userToCreate, smapping.MapFields(&user))
	if err != nil {
		log.Fatalf("Failed map %v", err)
	}

	res := s.userRepository.InsertUser(userToCreate)
	return res
}

func (s *authService) FindByName(name string) entity.User {
	return s.userRepository.FindByName(name)
}

func (s *authService) IsUserExists(name string) bool {
	res := s.userRepository.IsUserExists(name)
	return !(res.Error == nil)
}

func comparePassword(hashedPwd string, plainPassword []byte) bool {

	byteHash := []byte(hashedPwd)

	err := bcrypt.CompareHashAndPassword(byteHash, plainPassword)
	if err != nil {
		log.Println(err)
		return false
	}
	return true

}
