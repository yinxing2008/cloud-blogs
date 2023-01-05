/**
 * 厦门大学计算机专业 | 前华为工程师
 * 专注《零基础学编程系列》  http://lblbc.cn/blog
 * 包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
 * 公众号：蓝不蓝编程
 */
export class Blog {
  private id: number;
  private title: string = '';
  private content: string = '';

  public getId() {
    return this.id
  }

  public setId(id: number) {
    this.id = id
  }

  public getTitle() {
    return this.title
  }

  public setTitle(title: string) {
    this.title = title
  }

  public getContent() {
    return this.content
  }

  public setContent(content: string) {
    this.content = content
  }
}