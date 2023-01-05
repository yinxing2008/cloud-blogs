/**
 * 厦门大学计算机专业 | 前华为工程师
 * 专注《零基础学编程系列》  http://lblbc.cn/blog
 * 包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
 * 公众号：蓝不蓝编程
 */
import router from '@ohos.router';
import { httpRequestGet } from '../../common/utils/HttpUtil'

@Entry
@Component
struct BlogList {
  @State blogList: Array<any> = [];

  onPageShow() {
    this.queryData();
  }

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        Text('蓝不蓝博客')
          .width('100%')
          .fontSize(25)
          .fontColor("#FFFFFF")
          .backgroundColor("#418DF9")
          .padding({ left: 20, top: 20, bottom: 20 })
        List() {
          ForEach(this.blogList, item => {
            ListItem() {
              Text(item.title).fontSize(22).fontColor("#333333")
            }
            .align(Alignment.Start)
            .width('100%')
            .backgroundColor("#FFFFFF")
            .padding({ left: 20, right: 20, top: 15, bottom: 15 })
            .margin({ top: 1 })
            .onClick(() => {
              router.push({ url: "pages/EditBlog", params: { blogId: item.id } })
            })
          }, item => item.id)
        }
      }.width('100%').height('100%')

      Image($r("app.media.add"))
        .width(100)
        .height(100)
        .padding(20)
        .margin({ bottom: 20, right: 10 })
        .onClick(() => {
          router.push({ url: "pages/AddBlog" })
        })
    }.backgroundColor("#EFEFEF").width('100%').height('100%')
  }

  private async queryData() {
    var url = "blog/blogs"
    var data = await httpRequestGet(url)
    this.blogList = data.data
  }
}