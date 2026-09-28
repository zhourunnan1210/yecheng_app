<script>
	import {
		mapstate,
		mapMutations
	} from 'vuex';
	export default {
		onLaunch: function() {
			
		},
		onShow: function() {
			this.loginByToken()
		},
		onHide: function() {
			console.log('App Hide')
		},
		methods:{
			...mapMutations(['login']),
			async loginByToken() {
				try {
					// 使用Promise方式获取token
					const token = await new Promise((resolve, reject) => {
						uni.getStorage({
							key: 'token',
							success: function (res) {
								resolve(res.data);
							},
							fail: function (err) {
								resolve(null);
							}
						});
					});
					
					if (!token) {
						console.log('未找到token，用户未登录');
						return;
					}
					
					const res = await this.$myRequest({
						url: '/user/token/login',
						method: 'POST',
						header: {
							'content-type': 'application/x-www-form-urlencoded'
						},
						data: {
							"token": token
						}
					});
					
					if (res.data.code == 0 && res.data.data != null) {
						console.log('Token登录成功:', res.data.data);
						this.login(res.data.data);
					} else {
						console.log('Token登录失败或数据为空');
					}
				} catch (error) {
					console.error('Token登录过程中发生错误:', error);
				}
			}
		}
	}
</script>

<style lang="scss">
	/* 注意要写在第一行，同时给style标签加入lang="scss"属性 */
	@import "uview-ui/index.scss";
	// .page{
	// 	width: 100%;
	// 	height: 100%;
	// 	background-color: #f0f0f0;
	// 	position: absolute;
	// }
</style>
