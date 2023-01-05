/**
 * 厦门大学计算机专业 | 前华为工程师
 * 专注《零基础学编程系列》  http://lblbc.cn/blog
 * 包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
 * 公众号：蓝不蓝编程
 */
import prompt from '@ohos.prompt';
import router from '@ohos.router';
import { User } from '../../data/UserDataStore';
import { httpRequestPost } from '../../common/utils/HttpUtil';

@Entry
@Component
struct Login {
  @State name: string = 'lblbc'
  @State password: string = '1'

  build() {
    Row() {
      Column() {
        Text('蓝不蓝博客')
          .width('100%')
          .fontSize(23)
          .margin({ bottom: 50 })
          .textAlign(TextAlign.Center)
        TextInput({
          placeholder: "请输入用户名",
          text: this.name
        })
        TextInput({
          placeholder: "请输入密码",
          text: this.password
        }).type(InputType.Password).margin({ top: 20 })
        Row() {
          Button("登录").margin(10).onClick(() => {
            this.login()
          }).width(100)
          Button("注册").margin(10).onClick(() => {
            this.register()
          }).width(100)
        }.margin(20)
      }.margin({ left: 20, right: 20 })
    }.alignItems(VerticalAlign.Center)
    .height('100%')
  }

  private async login() {
    var url = "user/login"
    this.process(url)
  }

  private async register() {
    var url = "user/register"
    this.process(url)
  }

  private async process(url: string) {
    var params = {
      name: this.name,
      password: this.password,
    }
    var data = await httpRequestPost(url, params)
    var user = User.get()
    if (data.code == 0) {
      user.setToken(data.data.token)
      user.save()
      router.push({ url: "pages/BlogList" })
    } else {
      prompt.showToast({ message: data.msg })
    }
  }
}