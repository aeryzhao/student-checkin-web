import { createApp } from 'vue'
import ElementPlus from 'element-plus'
import 'element-plus/dist/index.css'
import './style.css'
import App from './App.vue'
import axios from 'axios'
import VueAxios from 'vue-axios'

createApp(App).use(ElementPlus, axios, VueAxios).mount('#app')
