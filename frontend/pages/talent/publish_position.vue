<template>
	<view class="wrap">
		<u-toast ref="uToast" />
		<u-form :model="model" :rules="rules" ref="uForm">
			<view class="title">
				企业信息
			</view>
			<u-line />
			<u-form-item label-width="120" label-position="top" label="企业名称" prop="businessname">
				<u-input border placeholder="请输入企业名称" v-model="model.businessname" type="text"></u-input>
			</u-form-item>
			<u-form-item label="联系电话" prop="phone" label-width="150" label-position="top">
				<u-input border placeholder="请输入手机号" v-model="model.phone" type="number"></u-input>
			</u-form-item>
			<u-form-item label="邮箱" prop="email" label-width="150" label-position="top">
				<u-input border placeholder="请输入联系人邮箱" v-model="model.email" type="text"></u-input>
			</u-form-item>
			<u-form-item label-width="120" label-position="top" label="详细地址" prop="businessaddress">
				<u-input border placeholder="请输入详细地址" v-model="model.businessaddress" type="text"></u-input>
			</u-form-item>
			<u-form-item label-width="120" label-position="top" label="公司网址" prop="businessweb">
				<u-input border placeholder="请输入公司网址" v-model="model.businessweb" type="text"></u-input>
			</u-form-item>
			<u-form-item label-width="120" label-position="top" label="企业特点">
				<u-input border placeholder="请输入标签1" v-model="model.title1" type="text"></u-input>
				<u-input border placeholder="请输入标签2" v-model="model.title2" type="text"></u-input>
				<u-input border placeholder="请输入标签3" v-model="model.title3" type="text"></u-input>
			</u-form-item>
			<u-form-item label="上传公司头像" prop="image" label-width="200">
				<u-upload width="160" height="160" :action="action" :file-list="fileList" @on-success="afterUpload"
					max-count="1"></u-upload>
			</u-form-item>
			<view class="title" style="margin-top: 30rpx;">
				招聘详情
			</view>
			<u-line />
			<u-form-item label-width="120" label-position="top" label="招聘岗位" prop="position">
				<u-input border placeholder="请输入招聘岗位" v-model="model.position" type="text"></u-input>
			</u-form-item>
			<u-form-item label="学历" prop="degree" label-width="150">
				<u-radio-group @change="radioGroupChange">
					<u-radio shape="circle" v-for="(item, index) in radioList1" :key="index"
						:name="item.name">{{ item.name }}</u-radio>
				</u-radio-group>
			</u-form-item>
			<u-form-item label-width="120" label-position="top" label="起步薪资" prop="salaryMax">
				<u-input placeholder="" border v-model="model.salaryMin" type="number"></u-input>
				<view style="font-size: 50rpx;padding-left:20rpx;padding-right: 20rpx; ;">k——</view>
				<u-input placeholder="" border v-model="model.salaryMax" type="number"></u-input>
				<view style="font-size: 50rpx;padding-left:20rpx;padding-right: 20rpx; ;"> k</view>
			</u-form-item>
			<u-form-item label-position="top" label="能力需求" prop="need">
				<u-input type="textarea" border placeholder="请填写能力需求" v-model="model.need" />
			</u-form-item>
			<u-form-item label-position="top" label="工作职责" prop="duty">
				<u-input type="textarea" border placeholder="请填写工作职责" v-model="model.duty" />
			</u-form-item>


		</u-form>
		<view class="u-margin-30"></view>
		<u-button @click="submit" type="primary" :ripple="true">提交</u-button>
		<u-select :list="actionSheetList" mode="single-column" v-model="actionSheetShow"
			@confirm="actionSheetCallback"></u-select>
		<u-select :list="actionSheetList2" mode="single-column" v-model="actionSheetShow2"
			@confirm="actionSheetCallback2"></u-select>
		<u-select :list="fieldList" mode="single-column" v-model="fieldShow" @confirm="fieldCallback"></u-select>
	</view>
</template>

<script>
	import schoolPicker from '@/components/sugar-schoolPicker/schoolPicker/schoolPicker.vue';
	export default {
		components: {
			schoolPicker
		},
		data() {
			let that = this;
			return {
				fileList: [],
				action: this.BASE_URL + '/upload/single',
				model: {
					userId: '',
					businessname: "",
					businessaddress: "",
					degree: "",
					businessweb: "",
					title1: "",
					title2: "",
					title3: "",
					salaryMin: "",
					salaryMax: "",
					position: "",
					phone: "",
					email: "",
					need: "",
					image: "",
					duty: ""
				},
				rules: {
					businessname: [{
						required: true,
						message: '请输入企业名称',
						trigger: 'blur'
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
					businessaddress: [{
						required: true,
						message: '请输入详细地址',
						trigger: 'blur',
					}],
					businessweb: [{
							required: true,
							message: '请输入公司网址',
							trigger: 'blur',
						},
						// {
						// 	// 此为同步验证，可以直接返回true或者false，如果是异步验证，稍微不同，见下方说明
						// 	validator: (rule, value, callback) => {
						// 		// 调用uView自带的js验证规则，详见：https://www.uviewui.com/js/test.html
						// 		return this.$u.test.url(value);
						// 	},
						// 	message: '内容必须为正确网址',
						// 	// 触发器可以同时用blur和change，二者之间用英文逗号隔开
						// 	trigger: ['change', 'blur'],
						// },
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
					image: [{
						required: true,
						message: '请上传头像',
						trigger: 'blur'
					}],
					position: [{
						required: true,
						message: '请输入岗位',
						trigger: 'blur'
					}],
					salaryMax: [{
							require: true,
							errorMessage: '请输入工资范围',
							trigger: ['change', 'blur'],
						},
						{
							validator: (rule, value, callback) => {
								if (value < this.model.salaryMin) {
									return false
								} else return true;
							},
							message: '最高工资不能低于最低工资',
							// 触发器可以同时用blur和change，二者之间用英文逗号隔开
							trigger: ['blur'],
						},
					],
					need: [{
						required: true,
						message: '请填写能力需求',
						trigger: 'blur'
					}],
					duty: [{
						required: true,
						message: '请填写工作职责',
						trigger: 'blur'
					}],
				},
				fileList: [],
				action: this.BASE_URL + '/upload/single',
				actionSheetList: [],
				actionSheetList2: [],
				radioList1: [{
						name: '大专',
						checked: false,
						disabled: false
					},
					{
						name: '本科',
						checked: false,
						disabled: false
					},
					{
						name: '硕士',
						checked: false,
						disabled: false
					},
					{
						name: '博士',
						checked: false,
						disabled: false
					},

				],
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
			radioGroupChange(n) {
				if (n == '大专') {
					this.model.degree = 4
				} else if (n == '本科') {
					this.model.degree = 3
				} else if (n == '硕士') {
					this.model.degree = 2
				} else if (n == '博士') {
					this.model.degree = 1
				}
				console.log('groupChange2', n);
			},

			submit() {
				this.model.userId = this.$store.state.userInfo.uid
				// this.model.financialInstitutionId = this.$store.state.userInfo.gid
				console.log(this.model)
				this.$refs.uForm.validate(async valid => {
					if (valid) {
						console.log('验证通过');
						console.log(this.model);
						const res = await this.$myRequest({
							url: '/talentNeed/publish',
							method: 'POST',
							header: {
								'content-type': 'application/json'
							},
							data: {
								"userId": this.model.userId,
								"businessName": this.model.businessname,
								"contactName": "1",
								"location": "1",
								"phone": this.model.phone,
								"businessEmail": this.model.email,
								"contactEmail": this.model.email,
								"businessAddress": this.model.businessaddress,
								"website": this.model.businessweb,
								"title1": this.model.title1,
								"title2": this.model.title2,
								"title3": this.model.title3,
								"image": this.model.image,
								"businessPosition": this.model.position,
								"degree": this.model.degree,
								"salaryMax": this.model.salaryMax,
								"salaryMin": this.model.salaryMin,
								"demand": this.model.need,
								"job": this.model.duty,
							}
						});
						console.log(res)
						if (res.data.code == 0) {
							this.$refs.uToast.show({
								title: '发布成功',
								type: 'success',
								back: 'true'
							})
						} else {
							this.$refs.uToast.show({
								title: res.data.msg,
								type: 'error',
								back: 'false'
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