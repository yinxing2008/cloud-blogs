import Vue from 'vue'
import App from './App.vue'
import router from './router'
// 引入element-ui
import ElementUI from 'element-ui';
import 'element-ui/lib/theme-chalk/index.css';
// import echarts from 'echarts'
import store from './store'
// import '../theme/index.css'


Vue.use(ElementUI)

Vue.config.productionTip = false

// Vue.prototype.$echarts = echarts

new Vue({
  el:"#app",
  router,
  store,
  render: h => h(App),
}).$mount('#app')

