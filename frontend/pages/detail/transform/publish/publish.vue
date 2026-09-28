<template>
	<view class="content">
		<u-navbar :autoback="true" title="我要发布">
			<view
			    class="u-nav-slot"
			    slot="right"
			>
				<view @click="jumpToMyPublish">我的发布</view>
			</view>
		</u-navbar>
			<view class="u-tabs-box">
				<u-tabs-swiper activeColor="#1296db" ref="tabs" :list="list" :current="current" @change="tebchange"
					:is-scroll="false" swiperWidth="750" inactive-color="#000000"></u-tabs-swiper>
			</view>
			<swiper class="swiper-box" :current="swiperCurrent" @transition="transition" @animationfinish="animationfinish" style="height: 100vh;">
				<!-- 成果发布 -->
				<swiper-item class="swiper-item" style="height: 100%;width: 100%;">
					<scroll-view style="height: 100vh;" scroll-y="true" >
						<view class="basicInfo">
							<view class="title">基本信息</view>
							<u-form
								labelPosition="left"
								labelAlign="left"
								:model="techModel"
								:rules="techRules" 
								ref="uForm1"
							>
								<u-form-item
										labelWidth="180"
										:label-style="{'font-size':'35rpx'}"
										label="单位名称:"
										prop="name"
								>
									<u-input
											placeholder-style="font-size:34rpx;"
											v-model="techModel.name"
									></u-input>
								</u-form-item>
								<u-form-item
										label="单位电话:"
										borderBottom
										labelWidth="180"
										:label-style="{'font-size':'35rpx'}"
										prop="businessTel"
								>
									<u-input
											placeholder-style="font-size:34rpx;"
											v-model="techModel.businessTel"
											placeholder="例: 010-12345678912"
									></u-input>
								</u-form-item>
								<u-form-item
										label="联系人:"
										borderBottom
										labelWidth="180"
										:label-style="{'font-size':'35rpx'}"
										prop="person"
								>
									<u-input
											placeholder-style="font-size:34rpx;"
											v-model="techModel.person"
									></u-input>
								</u-form-item>
								<u-form-item
										label="联系人电话:"
										borderBottom
										labelWidth="190"
										:label-style="{'font-size':'35rpx'}"
										prop="personTel"
								>
									<u-input
											placeholder-style="font-size:34rpx;"
											v-model="techModel.personTel"
									></u-input>
								</u-form-item>
								<u-form-item
										label="联系人邮箱:"
										borderBottom
										labelWidth="190"
										:label-style="{'font-size':'35rpx'}"
										prop="email"
								>
									<u-input
											placeholder-style="font-size:34rpx;"
											v-model="techModel.email"
									></u-input>
								</u-form-item>
								<u-form-item
										label="单位地址:"
										labelWidth="180"
										:label-style="{'font-size':'35rpx'}"
										prop="address"
								>
									<u-input
											placeholder-style="font-size:34rpx;"
											v-model="techModel.address"
									></u-input>
								</u-form-item>
<!-- 						</view>
						<view class="techInfo"> -->
							<view class="title">成果信息</view>
								<u-form-item
										label="成果名称:"
										borderBottom
										labelWidth="180"
										:label-style="{'font-size':'35rpx'}"
										prop="title"
								>
									<u-input
											placeholder-style="font-size:34rpx;"
											v-model="techModel.title"
									></u-input>
								</u-form-item>
								<u-form-item
										label="适用领域:"
										borderBottom
										labelWidth="180"
										:label-style="{'font-size':'35rpx'}"
										prop="field"
								>
									<view class="desc">
										{{options[techFieldIndex].name}}
									</view>
									<picker class="picker" mode="selector" :range="options" range-key="name" @change="changeTechFields" :value="index">选择</picker>
								</u-form-item>
								<u-form-item
										label="成果简介:"
										borderBottom
										labelWidth="180"
										:label-style="{'font-size':'35rpx'}"
										prop="descript"
								>
									<u-input
											placeholder-style="font-size:34rpx;"
											v-model="techModel.descript"
											type="textarea"
									></u-input>
								</u-form-item>
								<u-form-item
										label="技术原理:"
										borderBottom
										labelWidth="180"
										:label-style="{'font-size':'35rpx'}"
										prop="principle"
								>
									<u-input
											placeholder-style="font-size:34rpx;"
											v-model="techModel.principle"
											type="textarea"
									></u-input>
								</u-form-item>
								<u-form-item
										label="相关文件:"
										borderBottom
										labelWidth="180"
										:label-style="{'font-size':'35rpx'}"
								>
									<u-upload
											:fileList="fileList"
											name="1"
											multiple
											:maxCount="10"
										></u-upload>
								</u-form-item>
							</u-form>
							<u-button class="submit" @click="submitTech">提交</u-button>
						</view>
					</scroll-view>
				</swiper-item>
				<!-- 需求发布 -->
				<swiper-item class="swiper-item" style="height: 100%;width: 100%;">
					<scroll-view style="height: 100vh;" scroll-y="true" >
						<view class="basicInfo">
							<view class="title">基本信息</view>
							<u-form
								labelPosition="left"
								labelAlign="left"
								:model="needModel"
								:rules="needRules" 
								ref="uForm2"
							>
								<u-form-item
										label="单位名称:"
										labelWidth="180"
										:label-style="{'font-size':'35rpx'}"
										borderBottom
										prop="name"
								>
									<u-input
											placeholder-style="font-size:34rpx;"
											v-model="needModel.name"
									></u-input>
								</u-form-item>
								<u-form-item
										label="单位电话:"
										borderBottom
										labelWidth="180"
										:label-style="{'font-size':'35rpx'}"
										prop="phone"
								>
									<u-input
											placeholder-style="font-size:34rpx;"
											v-model="needModel.phone"
											placeholder="例: 010-12345678912"
									></u-input>
								</u-form-item>
								<u-form-item
										label="单位邮箱:"
										ref="item5"
										labelWidth="180"
										:label-style="{'font-size':'35rpx'}"
										prop="email"
								>
									<u-input
											placeholder-style="font-size:34rpx;"
											v-model="needModel.email"
									></u-input>
								</u-form-item>
<!-- 						</view>
						<view class="techInfo"> -->
							<view class="title">需求详情</view>
								<u-form-item
										label="需求名称:"
										borderBottom
										labelWidth="180"
										:label-style="{'font-size':'35rpx'}"
										prop="title"
								>
									<u-input
											placeholder-style="font-size:34rpx;"
											v-model="needModel.title"
									></u-input>
								</u-form-item>
								<u-form-item
										label="适用领域:"
										borderBottom
										labelWidth="180"
										:label-style="{'font-size':'35rpx'}"
										prop="field"
								>
									<view class="desc">
										{{options[needFieldIndex].name}}
									</view>
									<picker class="picker" mode="selector" :range="options" range-key="name" @change="changeNeedFields" :value="index">选择</picker>
								</u-form-item>
								<u-form-item
										label="需求简介:"
										borderBottom
										labelWidth="180"
										:label-style="{'font-size':'35rpx'}"
										prop="descript"
								>
									<u-input
											placeholder-style="font-size:34rpx;"
											v-model="needModel.descript"
											type="textarea"
									></u-input>
								</u-form-item>
							</u-form>
							<u-button class="submit" @click="submitNeed">提交</u-button>
						</view>
					</scroll-view>
				</swiper-item>
			</swiper>
		
	</view>
</template>

<script>
	import {
		mapState,
		mapMutations
	} from 'vuex';
export default {
	
	data() {
		return {
			list: [{
					name: '发布成果'
				},
				{
					name: '发布需求'
				}
			],
			TAList:[],
			showpop: false,
			current: 0,
			swiperCurrent:0,
			fileList: [],
			options:[
				{
					id:0,
					name:'全部'
				},
				{
					id:1,
					name:'互联网+'
				},
				{
					id:2,
					name:'生物医药'
				},
				{
					id:3,
					name:'新一代信息技术'
				},
				{
					id:4,
					name:'高端智能设备'
				},
				{
					id:5,
					name:'新能源'
				},
				{
					id:6,
					name:'新材料'
				},
				{
					id:7,
					name:'高技术服务'
				},
				{
					id:8,
					name:'资源与环境'
				},
				{
					id:9,
					name:'先进制造业'
				}
			],
			techFieldIndex: 0,
			needFieldIndex:0,
			techModel:{
				name: '',
				businessTel: '',
				person: '',
				personTel: '',
				address: '',
				email:'',
				title: '',
				descript: '',
				principle:''
			},
			needModel:{
				name:'',
				phone:'',
				email:'',
				title:'',
				descript:''
			},
			techRules: {
				name: [
					{
						required: true,
						message: '请输入单位名称',
						trigger: 'blur'
					}
				],
				businessTel: [
					{
						required: true,
						message: '请输入单位电话',
						trigger: 'blur'
					}
				],
				person: [
					{
						required: true,
						message: '请输入联系人',
						trigger: 'blur'
					}
				],
				personTel: [
					{
						required: true,
						message: '请输入联系人电话',
						trigger: 'blur'
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
				email: [
					{
						required: true,
						message: '请输入联系人邮箱',
						trigger: 'blur'
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
				address: [
					{
						required: true,
						message: '请输入地址',
						trigger: 'blur'
					}
				],
				title: [
					{
						required: true,
						message: '请输入成果名称',
						trigger: 'blur'
					}
				],
				field: [
					{
						required: true,
						message: '请选择适用领域',
						trigger: 'blur'
					}
				],
				descript: [
					{
						required: true,
						message: '请输入成果简介',
						trigger: 'blur'
					}
				],
				principle: [
					{
						required: true,
						message: '请输入技术原理',
						trigger: 'blur'
					}
				]
			},
			needRules: {
				name: [
					{
						required: true,
						message: '请输入单位名称',
						trigger: 'blur'
					}
				],
				phone: [
					{
						required: true,
						message: '请输入单位电话',
						trigger: 'blur'
					}
				],
				email: [
					{
						required: true,
						message: '请输入单位邮箱',
						trigger: 'blur'
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
				title: [
					{
						required: true,
						message: '请输入需求名称',
						trigger: 'blur'
					}
				],
				field: [
					{
						required: true,
						message: '请选择适用领域',
						trigger: 'blur'
					}
				],
				descript: [
					{
						required: true,
						message: '请输入需求简介',
						trigger: 'blur'
					}
				]
			},
		}
	},
	computed:{
		...mapState({
			type: state => state.userInfo.type,
			isLogin: state => state.isLogin,
		}),
		// 获取到选择的领域
		techField(){
			return this.options[this.techFieldIndex].name
		},
		needField(){
			return this.options[this.needFieldIndex].name
		}
	},
	watch:{
		isLogin: function(value) {
			uni.switchTab({
				url:'../mine/mine'
			})
		}
	},
	onLoad(){	
		if (this.isLogin == false) {
			console.log(this.isLogin)
			uni.redirectTo({
				url:'/pages/user/login/login'
			})
		}
	},
	onReady(){
		this.$refs.uForm1.setRules(this.techRules)
		this.$refs.uForm2.setRules(this.needRules)
	},
	methods: {
		// tab栏切换
		tebchange(index) {
			this.swiperCurrent = index;		
		},
		// 切换动画
		transition({
			detail: {
				dx
			}
		}) {
			this.$refs.tabs.setDx(dx);
		},
		animationfinish({
			detail: {
				current
			}
		}) {
			this.$refs.tabs.setFinishCurrent(current);
			this.swiperCurrent = current;
			this.current = current;
		},
		changeTechFields(e){
			this.techFieldIndex = e.detail.value
		},
		changeNeedFields(e){
			this.needFieldIndex = e.detail.value
		},
		async submitTech() {
			this.$refs.uForm1.validate(async valid =>  {
				if (valid)  {
					console.log('验证通过')
					const uid=localStorage.getItem('user')
					console.log(uid)
					const res = await this.$myRequest({
						url: '/technologyAchievement/publish',
						method: 'POST',
						header: {
							'content-type': 'application/json'
						},
						data: {
							"address": this.techModel.address,
							"category": "string",
							"description": this.techModel.descript,
							"email": this.techModel.email,
							"field": this.techField,
							"image": "",
							"name": this.techModel.name,
							"phone": this.techModel.personTel,
							"position": "",
							"publisherId": uid,
							"publisherType": 1,
							"title": this.techModel.title,
							"website": "http://baidu.com"
						}
					});
					this.jumpToSubmit()
					console.log(this.techModel)
					console.log(this.techField)
				}else console.log('验证失败')
			});
		},
		async submitNeed(){
			this.$refs.uForm2.validate(async valid =>  {
				if (valid)  {
					const uid=localStorage.getItem('user')
					console.log(uid)
					const res = await this.$myRequest({
						url: '/technologyneed/publish',
						method: 'POST',
						header: {
							'content-type': 'application/json'
						},
						data: {
							"businessId": uid,
							"category": "string",
							"contactEmail": this.needModel.email,
							"contactName": this.needModel.name,
							"contactPhone": this.needModel.phone,
							"description": this.needModel.descript,
							"field": this.needField,
							"image": "string",
							"title": this.needModel.title
						}
					});
					console.log(this.needModel)
					console.log(this.needField)
					this.jumpToSubmit()
				}else console.log('验证失败')
			});
			
		},
		jumpToMyPublish() {
			uni.navigateTo({
				url:'/pages/detail/transform/publish/myPublish'
			})
		},
		jumpToSubmit(){
			uni.navigateTo({
				url:'/pages/detail/transform/publish/submit'
			})
		}
	}
}
</script>

<style lang="scss" scoped>
.content {
	padding: 0rpx 30rpx 30rpx 30rpx;
	::v-deep .u-navbar {
		background-color: #1296db!important;
		color: #fff;
	}
	::v-deep .u-iconfont {
		color: #fff!important;
	}
	::v-deep .u-back-wrap{
		padding-left: 7px;
	}
	::v-deep .u-title {
		font-size: 16px!important;
		font-weight: 700!important;
		color: #fff!important;
	}
	.u-nav-slot {
		padding-right: 7px;
		font-size: 15px;
		font-weight: 550;
	}
	.popup {
		width: 70vw;
		.header {
			font-size: 40rpx;
			font-weight: 550;
			padding: 17rpx;
			border-bottom: 3rpx solid #333;
			color: #fff;
			background-color: #1296db!important;
		}
		.item {
			display: flex;
			padding: 15rpx;
			justify-content: space-between;
			align-items: center;
			border-bottom: 1rpx solid #ccc;
			.left {
				.title {
					width: 250rpx;
					font-size: 39rpx;
					overflow: hidden;
					text-overflow: ellipsis;
					white-space: nowrap;
				}
			}
			.status {
				font-size: 35rpx;
				color: red;
			}
		}
	}
	.basicInfo,.techInfo {
		margin-top: 30rpx;
	}
	.title {
		font-size: 45rpx;
		color: #333333;
	}
	.desc {
		font-size: 35rpx;
		width: 400rpx;
	}
	.picker {
		font-size: 35rpx!important;
	}
	.submit {
		width: 300rpx;
		margin: 50rpx 0 0 200rpx;
		font-size:39rpx;
	}
}
</style>
