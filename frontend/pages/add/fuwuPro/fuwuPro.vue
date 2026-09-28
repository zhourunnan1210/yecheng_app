<template>
	<view class="wrap">
		<u-toast ref="uToast" />
		<u-form :model="model" :rules="rules" ref="uForm">
			<view class="title">
				产品信息
			</view>
			<u-line />
			<u-form-item label-width="120" label-position="top" label="产品名称" prop="title">
				<u-input border placeholder="请输入服务产品名称" v-model="model.title" type="text"></u-input>
			</u-form-item>
			<u-form-item label-position="top" label="产品类型" prop="serviceType">
				<u-input border type="select" :select-open="actionSheetShow" v-model="model.serviceType" placeholder="请选择服务产品类型"
				 @click="actionSheetShow = true"></u-input>
			</u-form-item>
			<u-form-item label-position="top" label="产品描述" prop="description">
				<u-input type="textarea" border placeholder="请填写产品描述" v-model="model.description" />
			</u-form-item>
			<u-form-item label="详情图片" prop="image" label-width="200">
				<u-upload width="160" height="160" :action="action" :file-list="fileList" @on-success="afterUpload" max-count="1"></u-upload>
			</u-form-item>
			<view class="title" style="margin-top: 30rpx;">
				联系人信息
			</view>
			<u-line />
			<u-form-item label-width="120" label="姓名" prop="name" label-position="top">
				<u-input border placeholder="请输入联系人姓名" v-model="model.name" type="text"></u-input>
			</u-form-item>
			<u-form-item label="手机号码" prop="phone" label-width="150" label-position="top">
				<u-input border placeholder="请输入手机号" v-model="model.phone" type="number"></u-input>
			</u-form-item>
			<u-form-item label="邮箱" prop="email" label-width="150" label-position="top">
				<u-input border placeholder="请输入联系人邮箱" v-model="model.email" type="text"></u-input>
			</u-form-item>
			<u-form-item label-position="top" label="联系人地址(选填)" prop="address">
				<u-input type="textarea" border placeholder="请填写详细地址" v-model="model.address" />
			</u-form-item>
			<u-form-item label-position="top" label="联系人单位(选填)" prop="position">
				<u-input type="textarea" border placeholder="请填写单位名称" v-model="model.position" />
			</u-form-item>


		</u-form>
		<view class="u-margin-30"></view>
		<u-button @click="submit" type="primary" :ripple="true">提交</u-button>
		<u-select :list="actionSheetList" mode="single-column" v-model="actionSheetShow" @confirm="actionSheetCallback"></u-select>
	</view>
</template>

<script>
	export default {
		data() {
			let that = this;
			return {
				model: {
					title: '',
					serviceType: '',
					description: '',
					phone: '',
					email: '',
					name: '',
					image: '',
					address: '',
					serviceInstitutionId: '',
					position: '',
					rate: '4%以下'
				},
				rules: {
					title: [{
						required: true,
						message: '请输入产品名称',
						trigger: 'blur'
					}],
					rate: [{
						required: true,
						message: '请选择利率范围',
						trigger: 'change',
					}],
					name: [{
							required: true,
							message: '请输入联系人姓名',
							trigger: 'blur',
						},
						{
							// 此为同步验证，可以直接返回true或者false，如果是异步验证，稍微不同，见下方说明
							validator: (rule, value, callback) => {
								// 调用uView自带的js验证规则，详见：https://www.uviewui.com/js/test.html
								return this.$u.test.chinese(value);
							},
							message: '姓名必须为中文',
							// 触发器可以同时用blur和change，二者之间用英文逗号隔开
							trigger: ['change', 'blur'],
						},
						// 异步验证，用途：比如用户注册时输入完账号，后端检查账号是否已存在
						// {
						// 	trigger: ['blur'],
						// 	// 异步验证需要通过调用callback()，并且在里面抛出new Error()
						// 	// 抛出的内容为需要提示的信息，和其他方式的message属性的提示一样
						// 	asyncValidator: (rule, value, callback) => {
						// 		this.$u.post('/ebapi/public_api/index').then(res => {
						// 			// 如果验证出错，需要在callback()抛出new Error('错误提示信息')
						// 			if(res.error) {
						// 				callback(new Error('姓名重复'));
						// 			} else {
						// 				// 如果没有错误，也要执行callback()回调
						// 				callback();
						// 			}
						// 		})
						// 	},
						// }
					],

					serviceType: [{
						required: true,
						message: '请选择服务类型',
						trigger: 'change'
					}, ],

					description: [{
							required: true,
							message: '请填写产品描述'
						},
						{
							min: 5,
							message: '描述不能少于5个字',
							trigger: 'change',
						}
					],

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


				},
				action: this.BASE_URL + '/upload/single',
				fileList: [],
				actionSheetList: [],
				actionSheetList2: [],
				radioList: [

					{
						name: '4%以下',
						checked: true,
						disabled: false
					},
					{
						name: '4%~6%',
						checked: false,
						disabled: false
					},
					{
						name: '6%以上',
						checked: false,
						disabled: false
					}
				],
				radio: '4%以下',
				fieldList: [],
				actionSheetShow: false,
				actionSheetShow2: false,
				fieldShow: false
			};
		},
		onLoad() {
			this.getMoney()
		},
		computed: {

		},
		onReady() {
			this.$refs.uForm.setRules(this.rules);
		},
		methods: {

			// 点击actionSheet回调
			actionSheetCallback(e) {
				this.model.serviceType = '';
				e.map((val, index) => {
					this.model.serviceType += this.model.serviceType == '' ? val.label : '-' + val.label;
				})
			},


			radioGroupChange(e) {
				this.model.rate = e;
			},

			//获取产品类型列表
			async getMoney() {
				const res = await this.$myRequest({
					url: "/servicetypeindex/getlist"
				})
				for (let i = 0; i < res.data.data.length; i++) {
					let obj = res.data.data[i]
					let temp = {}
					temp.label = obj.name
					temp.value = obj.id
					this.actionSheetList[i] = temp
				}
			},

			submit() {
				// this.model.businessId = this.$store.state.userInfo.gid
				this.$refs.uForm.validate(async valid =>  {
					 if (valid)  {
						console.log('验证通过');
						const res = await this.$myRequest({
							url: '/serviceproduct/publish',
							method: 'POST',
							header: {
								'content-type': 'application/json'
							},
							data: this.model
						});
						console.log(res)
						if (res.data.code == 0) {
						this.$refs.uToast.show({
											title: '发布成功',
											type: 'success',
											back:'true'
										})
						}
				
					}
				});

			},
			afterUpload(data, index, lists, name) {
				this.model.image = data.data.url
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
