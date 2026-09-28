import Vue from 'vue'
import App from './App'
import uView from "uview-ui"
import store from './store'
import {myRequest} from './utils/api.js'
import BASE_URL from './utils/api.js'



Vue.prototype.BASE_URL = BASE_URL
Vue.prototype.$myRequest = myRequest
Vue.prototype.$store = store

Vue.use(uView);

Vue.config.productionTip = false

App.mpType = 'app'

const app = new Vue({
    ...App,
	
	store
})
app.$mount()
