<template>
	<view class="wrap">
		<u-toast ref="uToast" />
		<u-form :model="model" :rules="rules" ref="uForm">
			<view class="title">
				产品信息
			</view>
			<u-line />
			<u-form-item label-width="120" label-position="top" label="金融产品" prop="title">
				<u-input border placeholder="请输入金融产品名称" v-model="model.title" type="text"></u-input>
			</u-form-item>
			<u-form-item label-position="top" label="贷款额度" prop="loanMoney">
				<u-input border type="select" :select-open="actionSheetShow" v-model="model.loanMoney" placeholder="请选择贷款额度" @click="actionSheetShow = true"></u-input>
			</u-form-item>
			<u-form-item label-position="top" label="贷款期限" prop="loanDeadline">
				<u-input border type="select" :select-open="actionSheetShow2" v-model="model.loanDeadline" placeholder="请选择贷款期限"
				 @click="actionSheetShow2 = true"></u-input>
			</u-form-item>
			<u-form-item label="利率范围" prop="rate" label-width="150">
				<u-radio-group v-model="radio" @change="radioGroupChange">
					<u-radio shape="circle" v-for="(item, index) in radioList" :key="index" :name="item.name">{{ item.name }}</u-radio>
				</u-radio-group>
			</u-form-item>
			<u-form-item label-position="top" label="担保方式" prop="ensureMethod">
				<u-input border type="select" :select-open="fieldShow" v-model="model.ensureMethod" placeholder="请选择担保方式" @click="fieldShow = true"></u-input>
			</u-form-item>
			<u-form-item label-position="top" label="产品描述" prop="description">
				<u-input type="textarea" border placeholder="请填写产品描述" v-model="model.description" />
			</u-form-item>
			<u-form-item label-position="top" label="申请条件" prop="applyCondition">
				<u-input type="textarea" border placeholder="请填写申请条件" v-model="model.applyCondition" />
			</u-form-item>

			<u-form-item label="产品图片" prop="image" label-width="200">
				<u-upload width="160" height="160" :action="action" :file-list="fileList" @on-success="afterUpload" max-count="1"></u-upload>
			</u-form-item>
			<view class="title" style="margin-top: 30rpx;">
				联系人信息
			</view>
			<u-line />
			<u-form-item label-width="120" label="姓名" prop="contactName" label-position="top">
				<u-input border placeholder="请输入联系人姓名" v-model="model.contactName" type="text"></u-input>
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
		<u-select :list="actionSheetList2" mode="single-column" v-model="actionSheetShow2" @confirm="actionSheetCallback2"></u-select>
		<u-select :list="fieldList" mode="single-column" v-model="fieldShow" @confirm="fieldCallback"></u-select>
	</view>
</template>

<script>
	export default {
		data() {
			let that = this;
			return {
				fileList:[],
				action: this.BASE_URL + '/upload/single',
				model: {
					title: '',
					loanMoney: '',
					loanDeadline: '',
					description: '',
					applyCondition: '',
					phone: '',
					email: '',
					contactName: '',
					image: '',
					financialInstitutionId: '',
					ensureMethod: '',
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
					contactName: [{
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

					loanMoney: [{
						required: true,
						message: '请选择贷款额度',
						trigger: 'change'
					}, ],
					loanDeadline: [{
						required: true,
						message: '请选择贷款期限',
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
					applyCondition: [{
							required: true,
							message: '请填写申请条件'
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
			this.getMoney(),
				this.getField(),
				this.getTime()
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
				this.model.loanMoney = '';
				e.map((val, index) => {
					this.model.loanMoney += this.model.loanMoney == '' ? val.label : '-' + val.label;
				})
			},
			actionSheetCallback2(e) {
				this.model.loanDeadline = '';
				e.map((val, index) => {
					this.model.loanDeadline += this.model.loanDeadline == '' ? val.label : '-' + val.label;
				})
			},
			fieldCallback(e) {
				this.model.ensureMethod = '';
				e.map((val, index) => {
					this.model.ensureMethod += this.model.ensureMethod == '' ? val.label : '-' + val.label;
				})
			},
			radioGroupChange(e) {
				this.model.rate = e;
			},
			//获取担保方式列表
			async getField() {
				const res = await this.$myRequest({
					url: "/ensuremethodindex/getlist"
				})
				for (let i = 0; i < res.data.data.length; i++) {
					let obj = res.data.data[i]
					let temp = {}
					temp.label = obj.name
					temp.value = obj.id
					this.fieldList[i] = temp
				}
			},
			//获取投资额度列表
			async getMoney() {
				const res = await this.$myRequest({
					url: "/ensuremoneyindex/getlist"
				})
				for (let i = 0; i < res.data.data.length; i++) {
					let obj = res.data.data[i]
					let temp = {}
					temp.label = obj.name
					temp.value = obj.id
					this.actionSheetList[i] = temp
				}
			},
			//获取贷款期限列表
			async getTime() {
				const res = await this.$myRequest({
					url: "/loandeadlineindex/getlist"
				})
				for (let i = 0; i < res.data.data.length; i++) {
					let obj = res.data.data[i]
					let temp = {}
					temp.label = obj.name
					temp.value = obj.id
					this.actionSheetList2[i] = temp
				}
			},

			submit() {
				// this.model.financialInstitutionId = this.$store.state.userInfo.gid
				console.log(this.model)
				 this.$refs.uForm.validate(async valid =>  {
					 if (valid)  {
						console.log('验证通过');
						const res = await this.$myRequest({
							url: '/financialproduct/publish',
							method: 'POST',
							header: {
								'content-type': 'application/json'
							},
							 data:{
							  "address":this.model.address,
							  "applyCondition": this.model.applyCondition,
							  "contactName":this.model.contactName,
							  "description": this.model.description,
							  "email": this.model.email,
							  "ensureMethod": this.model.ensureMethod,
							  "financialInstitutionId": 0,
							  "image": this.model.image,
							  "loanDeadline": this.model.loanDeadline,
							  "loanMoney": this.model.loanMoney,
							  "phone": this.model.phone,
							  "position":this.model.position,
							  "rate": this.model.rate,
							  "title": this.model.title,
							  }
						});
						console.log(res)
						if (res.data.code == 0) {
						this.$refs.uToast.show({
											title: '已提交审核',
											type: 'success',
											back:'true'
										})
						}

					}
					else {
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
