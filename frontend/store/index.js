import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

const store = new Vuex.Store({
	state: {
		userInfo: {},
		isLogin: false,
	},

	mutations: {
		login(state, provider) {

			state.isLogin = true
			state.userInfo.token = provider.token
			state.userInfo.uid = provider.uid
			state.userInfo.phone = provider.phone
			state.userInfo.email = provider.email
			// state.userInfo.gid = provider.gid
			state.userInfo.type = provider.type
			switch (provider.type) {
				case 0:
					state.userInfo.authStatus = "未认证"
					break;
				case 1:
					state.userInfo.authStatus = "高新企业"
					break;
				case 2:
					state.userInfo.authStatus = "科技主管部门"
					break;
				case 3:
					state.userInfo.authStatus = "学校"
					break;
				case 4:
					state.userInfo.authStatus = "金融机构"
					break;
				case 5:
					state.userInfo.authStatus = "服务机构"
					break;
				case 6:
					state.userInfo.authStatus = "超级管理员"
					break;
			}

			uni.setStorage({
				key: 'token',
				data: provider.token
			})
			// console.log(state.userInfo)
		},
		logout1(state) {
			state.isLogin = false
			state.userInfo = {}
			uni.removeStorage({
			    key: 'token',
			});
		}
	}
})

export default store
