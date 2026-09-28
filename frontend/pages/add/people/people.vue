<template>
	<view class="wrap">
		<u-toast ref="uToast" />
		<u-form :model="model" :rules="rules" ref="uForm">
			<view class="title">
				岗位信息
			</view>
			<u-line />
			<u-form-item label-position="top" label="职位" prop="businessPosition">
				<u-input type="text" border placeholder="请填写职位" v-model="model.businessPosition"/>
			</u-form-item>
			
			<u-form-item label-position="top" label="学历要求" prop="education">
				<u-input border type="select" :select-open="actionSheetShow" v-model="model.education" placeholder="请选择学历要求" @click="actionSheetShow = true"></u-input>
			</u-form-item>
			<u-form-item label-width="120" label-position="top" label="工作内容" prop="job">
				<u-input border placeholder="请输入工作内容" v-model="model.job" type="textarea" maxlength="1000"></u-input>
			</u-form-item>
			<u-form-item label-position="top" label="任职要求" prop="demand">
				<u-input type="textarea" border placeholder="请填写任职要求" v-model="model.demand" maxlength="1000" />
			</u-form-item>
			
			<u-form-item label-position="top" label="工作地区" prop="location" label-width="150">
				<u-input border type="select" :select-open="pickerShow" v-model="model.location" placeholder="请选择地区" @click="pickerShow = true"></u-input>
			</u-form-item>
			<u-form-item label-position="top" label="详细地址" prop="businessAddress">
				<u-input type="textarea" border placeholder="请填写详细地址" v-model="model.businessAddress" />
			</u-form-item>
			<u-form-item label="上传图片" prop="image" label-width="200">
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


		</u-form>
		<view class="u-margin-30"></view>
		<u-button @click="submit" type="primary" :ripple="true">提交</u-button>
		<u-select :list="actionSheetList" mode="single-column" v-model="actionSheetShow" @confirm="actionSheetCallback"></u-select>
		<u-picker mode="region" v-model="pickerShow" @confirm="locationConfirm"></u-picker>
	</view>
</template>

<script>
	export default {
		data() {
			let that = this;
			return {
				model: {
					job: '',
					education: '',
					demand: '',
					businessPosition: '',
					location: '',
					phone: '',
					email: '',
					name: '',
					image: '',
					businessAddress: '',
					businessId:''
				},
				rules: {
					job: [{
						required: true,
						message: '请输入招聘岗位',
						trigger: 'blur'
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
					education: [{
						required: true,
						message: '请选择学历要求',
						trigger: 'change'
					}, ],
					businessPosition: [{
							required: true,
							message: '请填写职位描述'
						},
						{
							min: 5,
							message: '描述不能少于5个字',
							trigger: 'change',
						}
					],
					businessAddress: [{
						required: true,
						message: '请填写详细地址'
					}],
					demand: [{
							required: true,
							message: '请填写任职要求'
						},
						{
							min: 5,
							message: '要求不能少于5个字',
							trigger: 'change',
						}
					],
					location: [{
						required: true,
						message: '请选择地区',
						trigger: 'change',
					}],
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
				actionSheetList: [{
						value: '无学历要求',
						label: '无学历要求'
					},
					{
						label: '初中及以下',
						value: '初中及以下',
					},
					{
						label: '高中/中技/中专',
						value: '高中/中技/中专'
					},
					{
						label: '大专',
						value: '大专'
					},
					{
						label: '本科',
						value: '本科'
					},
					{
						label: '硕士',
						value: '硕士'
					},
					{
						label: '博士',
						value: '博士'
					},
				],
				fileList:[],
				actionSheetShow: false,
				pickerShow: false
			};
		},
		onLoad() {

		},
		computed: {

		},
		onReady() {
			this.$refs.uForm.setRules(this.rules);
		},
		methods: {
			afterUpload(data, index, lists, name) {
				this.model.image = data.data.url
			},
			// 点击actionSheet回调
			actionSheetCallback(e) {
				console.log(e)
				this.model.education = '';
				e.map((val, index) => {
					this.model.education += this.model.education == '' ? val.label : '-' + val.label;
				})
			},

			// 选择地区回调
			locationConfirm(e) {
				this.model.location = e.province.label + '-' + e.city.label + '-' + e.area.label;
			},
			submit() {
				// this.model.businessId = this.$store.state.userInfo.gid
				this.$refs.uForm.validate(async valid => {
					if (valid) {
						console.log('验证通过');
						console.log(JSON.stringify(this.model))
						const res = await this.$myRequest({
							url: '/talentneed/publish',
							method: 'POST',
							header: {
								'content-type': 'application/json'
							},
							data: this.model
						});
						console.log(res)
						if (res.data.code == 0){
							this.$refs.uToast.show({
								title: '发布成功',
								type: 'success',
								back:'true'
							})
						} 
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
