<template>
	<!-- 发布问题 -->
	<view class="wrap">
		<u-toast ref="uToast" />
		<u-form :model="model" :rules="rules" ref="uForm">
			<view class="title">
				咨询内容
			</view>
			<u-line />
			<u-form-item label-position="top" label="咨询分类" prop="category">
				<u-select :list="fieldList" mode="single-column" v-model="fieldShow" @confirm="fieldCallback"></u-select>
				<u-input border type="select" :select-open="fieldShow" v-model="model.category" placeholder="请选择问题类型" @click="fieldShow = true"></u-input>
			</u-form-item>
			<u-form-item label-position="top" label="问题描述" prop="content">
				<u-input type="textarea" border placeholder="请填写问题描述" v-model="model.content" />
			</u-form-item>
			<view class="title" style="margin-top: 30rpx;">
				联系人信息
			</view>
			<u-line />	
			<u-form-item label="手机号码" prop="phone" label-width="150" label-position="top">
				<u-input border placeholder="请输入手机号" v-model="model.phone" type="number"></u-input>
			</u-form-item>
			<u-form-item label="邮箱" prop="email" label-width="150" label-position="top">
				<u-input border placeholder="请输入联系人邮箱" v-model="model.email" type="text"></u-input>
			</u-form-item>
		</u-form>
		<view class="u-margin-30"></view>
		<u-button @click="submit" type="primary" :ripple="true">提交</u-button>	
	</view>
</template>
<script>
	import {
		mapState,
		mapMutations
	} from 'vuex';
	export default {
	
		computed:{
			...mapState({
				type: state => state.userInfo.type,
				isLogin: state => state.isLogin,
			})
		},
		watch:{
			isLogin: function(value) {
				uni.switchTab({
					url:'../mine/mine'
				})
			}
		},
		data() {
			return {
				model: {
					phone: '',
					email: '',
					userId:'',
					category: '',
					content:''
				},
				fieldList:[],
				rules: {
					phone: [{
							required: true,
							message: '请输入手机号',
							trigger: ['change', 'blur'],
						},
						{
							validator: (rule, value, callback) => {
								// 调用uView自带的js验证规则，详见：https://www.uviewui.com/js/test.html
								return this.$u.test.mobile(value);
							},
							message: '手机号码不正确',
							// 触发器可以同时用blur和change，二者之间用英文逗号隔开
							trigger: ['change', 'blur'],
						}
					],
					email: [{
							required: true,
							message: '请输入邮箱',
							trigger: ['change', 'blur'],
						},
						{
							validator: (rule, value, callback) => {
								// 调用uView自带的js验证规则，详见：https://www.uviewui.com/js/test.html
								return this.$u.test.email(value);
							},
							message: '邮箱地址不正确',
							// 触发器可以同时用blur和change，二者之间用英文逗号隔开
							trigger: ['change', 'blur'],
						}
					],
					category: [
						{
							required: true,
							message: '请选择咨询分类',
							trigger: 'change',
						}
					],
		
					content: [
						{
							required: true,
							message: '请填写问题描述',
							trigger: 'change',
						}
					],
				},
				fieldShow: false
			};
		},
	
		async onLoad() {
			if (this.isLogin == false) {
				uni.redirectTo({
					url:'../user/login/login'
				})
				return
			}
			// 尝试从store获取手机号和邮箱
			let phone = this.$store.state.userInfo.phone
			let email = this.$store.state.userInfo.email
			// 如果store中没有，调用token登录接口刷新用户信息
			if (!phone || !email) {
				try {
					const token = uni.getStorageSync('token')
					if (token) {
						const res = await this.$myRequest({
							url: '/user/token/login',
							method: 'POST',
							header: {
								'content-type': 'application/x-www-form-urlencoded'
							},
							data: { token: token }
						})
						if (res.data.code == 0 && res.data.data) {
							this.login(res.data.data)
							phone = res.data.data.phone
							email = res.data.data.email
						}
					}
				} catch (e) {
					console.log('获取用户信息失败', e)
				}
			}
			this.model.phone = phone || ''
			this.model.email = email || ''
		},
		onReady() {
			this.$refs.uForm.setRules(this.rules);
			this.getField();
		},
		methods: {
			...mapMutations(['login']),
			/* 获取分类索引 */
			async getField() {
				const res = await this.$myRequest({
					url: "/list",
					method:'POST',
					data:{
						indexName:'咨询索引'
					},
					header:{
						'content-type':'application/x-www-form-urlencoded'
					}
				})
				const data = res.data.data[0].keys;
				
				data.forEach((item,index) => {
					const option = {label:item,value:index + 2}
					this.fieldList.push(option)
				})
				
				this.fieldList.unshift({label:'全部',value:1})
				
			},
			
			fieldCallback(e) {
				//console.log(e)
				this.model.category = '';
				e.map((val, index) => {
					this.model.category += this.model.category == '' ? val.label : '-' + val.label;
				})
				
			},

			submit() {
				this.model.userId = this.$store.state.userInfo.uid
				console.log(this.model.userId)
				this.$refs.uForm.validate(async valid => {
					if (valid) {
						console.log(JSON.stringify(this.model))
						const res = await this.$myRequest({
							url: '/consultation/publish',
							method: 'POST',
							header: {
								'content-type': 'application/json'
							},
							data: this.model
						});
						if (res.data.code == 0){
							this.$refs.uToast.show({
								title: '发布成功',
								type: 'success',
								back:'true'
							})
							
						}
					} else {
						console.log('验证失败');
					}
				});
				
			}



		}
	};
</script>

<style scoped lang="scss">
	.wrap {
		padding: 30rpx;
	}



	.title {
		font-size: 30rpx;
		position: relative;
		line-height: 1;
		padding-left: 28rpx;
		font-weight: 900;
		margin: 20rpx 0;
		color: $uni-color-title;

		&:before {
			width: 4px;
			height: 17px;
			border-radius: 100rpx;
			background-color: $uni-color-primary;
			content: '';
			position: absolute;
			left: 6rpx;
			top: -1px;
		}
	}
</style>
