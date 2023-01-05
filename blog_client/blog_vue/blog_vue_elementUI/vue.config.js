// 基础路径 注意发布之前要先修改这里
// let baseUrl = './'
module.exports = {
    publicPath: './', // 根据你的实际情况更改这里
    lintOnSave: true,
    productionSourceMap: false,

    chainWebpack: (config) => {

        const entry = config.entry('app')
        entry
            .add('babel-polyfill')
            .end()
        entry
            .add('classlist-polyfill')
            .end()
    },
    devServer: {
        // 端口配置
        port: 8090,
        // 反向代理配置
        proxy: {
            '/api': {
                target: 'http://127.0.0.1:18003/',
                changeOrigin: true, //改变源 如果接口跨域，需要进行这个参数配置
                pathRewrite: {
                    '^/api': ''
                }
            },
            '/v-web': {
                target: 'http://127.0.0.1:8778/',
                changeOrigin: true, //改变源 如果接口跨域，需要进行这个参数配置
                pathRewrite: {
                    '^/v-web': ''
                }
            },
        }
    }
}
