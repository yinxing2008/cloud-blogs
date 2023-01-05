import { createApp } from 'vue';
import App from './App.vue';
import router from './router';
import { vuexStore, piniaStore } from './store';

// 移动端适配
import 'lib-flexible/flexible.js';

import ElementPlus from 'element-plus'
import 'element-plus/dist/index.css'

//全局公共组件
import components from './plugins/components.js';
import * as ElementPlusIconsVue from '@element-plus/icons-vue'
const app = createApp(App)
app.use(vuexStore).use(piniaStore).use(router).use(ElementPlus).use(components).mount('#app');


for (const [key, component] of Object.entries(ElementPlusIconsVue)) {
    app.component(key, component)
  }