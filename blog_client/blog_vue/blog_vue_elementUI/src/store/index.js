import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

export default new Vuex.Store({

    state: {
        userToken: '',
    },

    mutations: {
        setUserToken(userToken) {
            this.state.userToken = userToken
        },
    },

    getters: {
        getUserToken: state => state.userToken,
    },

    actions: {
        //这个部分我暂时用不上
    },

    modules: {
        //这里是我自己理解的是为了给全局变量分组，所以需要写提前声明其他store文件，然后引入这里
    }
})

