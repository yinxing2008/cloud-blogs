
# 目标
为编程初学者打造入门学习项目，使用各种主流编程语言来实现。让想学编程的，一个都不落下。
![](https://img-blog.csdnimg.cn/ad1389e112e64cc8bd513d75b8453b46.png)

上述基本涵盖了当前编程开发所有主流语言（我这里说的主流，直白点讲就是互联网公司都在用的）。  
左侧为前端版本：安卓、iOS、鸿蒙、Flutter、Vue、uni-app、微信小程序。  
右侧为服务器端版本：Java、Python、Go、Php、NodeJS
# 看看效果图
![](https://img-blog.csdnimg.cn/1d636de117a54716a70c1ef2ebc21c9e.png)
# 支持特性
1. 注册、登录
2. 博客增删改查
3. 支持mysql数据库
# Python工程截图
![](https://img-blog.csdnimg.cn/d0921f3d1d0b48979b3e18e507dbe2c8.png)

# 接口截图
![](https://img-blog.csdnimg.cn/d5d122919e1242bab080802b1817c88e.png)

# 开发工具
PyCharm
# 开源地址
[https://gitee.com/lblbc/cloud_blogs](https://gitee.com/lblbc/cloud_blogs/tree/master/blog_server/blog_server_python)
![](https://img-blog.csdnimg.cn/f94d417f7c144a0d8b88691e10e10ecb.png)

# 关于
厦门大学计算机专业|华为八年高级工程师   
专注《零基础学编程系列》  http://lblbc.cn/blog  
包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙  
公众号：蓝不蓝编程

# 安装依赖
pip install python-jose
pip install fastapi
pip install python-multipart
pip install sqlalchemy
pip install uvicorn

# 运行
uvicorn main:app --reload --port 8080

# FAQ
如果遇到如下错误：
ModuleNotFoundError: No module named 'pymysql'
就卸载后重新安装pymysql。

卸载：
`pip uninstall pymysql`

重新安装：
`pip install pymysql`

如果是IDE里（非命令行）报错，可以在代码里增加：
``` import pymysql```
然后按照代码提示import该依赖。