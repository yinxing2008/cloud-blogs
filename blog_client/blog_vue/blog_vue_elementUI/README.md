# web

1. 编译
```
yarn install
```

2. 运行
```
yarn serve
```
3. 发布
```
yarn build
```
4.
登录：
http://localhost:8090/#/blog/login

# FAQ
1. 遇到错误`error:0308010C:digital envelope routines::unsupported`
解决方法：`export NODE_OPTIONS=--openssl-legacy-provider`