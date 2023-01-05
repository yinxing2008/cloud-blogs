import axios from 'axios';

axios.defaults.headers.post['Content-Type'] = 'application/json';
axios.defaults.timeout = 60000;
axios.defaults.withCredentials = false;

axios.interceptors.request.use(
    config => {
        if (sessionStorage.getItem("user_token")) {  // 判断是否存在token，如果存在的话，则每个http header都加上token
            config.headers.Authorization =  sessionStorage.getItem("user_token")
        }
        return config
    },
    err => {
        return Promise.reject(err)
    })
axios.interceptors.response.use(
    response => {
        return response
    },
    error => { //默认除了2XX之外的都是错误的，就会走这里
        if(error.response){
            switch(error.response.status){
                case 401:
                    // Message.error({
                    //     message: 'Token失效，请重新登陆'
                    // })
                    sessionStorage.removeItem('user_token') //可能是token过期，清除它
                    this.$router.replace({ //跳转到登录页面
                        path: '/Login'
                    })
                    break;
                case 404:
                    this.$router.replace({ //跳转到登录页面
                        path: '/404'
                    })
                    break;
                case 500:
                    // Message.error({
                    //     message: '服务器错误'
                    // })
                    break;
            }
        }else{
            this.$router.replace({ //跳转到登录页面
                path: '/404'
            })
        }
        return Promise.reject(error.response)
    })

export default axios
