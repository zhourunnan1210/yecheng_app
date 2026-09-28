<template>
	<view class="wrap">
		<u-toast ref="uToast" />
		<u-form :model="model" :rules="rules" ref="uForm">
			<view class="title">
				填写企业信息
			</view>
			<u-line />
			<u-form-item label-width="120" label-position="top" label="公司名称" prop="financialInstitutionName">
				<u-input border placeholder="请输入公司名称" v-model="model.financialInstitutionName" type="text"></u-input>
			</u-form-item>
			<u-form-item label-position="top" label="法人" prop="legalPersonName">
				<u-input border type="text" v-model="model.legalPersonName" placeholder="请输入法人"></u-input>
			</u-form-item>
			<u-form-item label="企业类型" prop="type" label-width="120" label-position="top">
				<u-input border :select-open="typeShow" placeholder="请选择企业类型" v-model="model.type" type="select" @click="typeShow = true"></u-input>
			</u-form-item>
			<u-form-item label-position="top" label="经营范围" prop="businessScope">
				<u-input border type="text" v-model="model.businessScope" placeholder="请输入经营范围"></u-input>
			</u-form-item>
			<u-form-item label-position="top" label="社会信用统一代码" prop="socialCreditCode">
				<u-input border type="text" v-model="model.socialCreditCode" placeholder="请输入社会信用统一代码"></u-input>
			</u-form-item>
			<u-form-item label="请上传企业信用等级证书" prop="financialInstitutionImage" label-width="400">
				<u-upload width="160" height="160" action="#" :auto-upload="false" :file-list="fileList" @on-list-change="onListChange" max-count="1"></u-upload>
			</u-form-item>
			<u-form-item label-position="top" label="简介" prop="briefIntroduction">
				<u-input border type="textarea" v-model="model.briefIntroduction" placeholder="请输入公司简介"></u-input>
			</u-form-item>
			<u-form-item label-position="top" label="成立时间" prop="establishmentDay" label-width="150">
				<u-input border type="select" :select-open="establishmentDay" v-model="model.establishmentDay" placeholder="请选择成立时间" @click="establishmentDay= true"></u-input>
			</u-form-item>
			<u-form-item label-position="top" label="经营期限" prop="timeLimit" label-width="150">
				<u-input border type="select" :select-open="timeLimit" v-model="model.timeLimit" placeholder="请选择经营期限" @click="timeLimit = true"></u-input>
			</u-form-item>
			<u-form-item label-position="top" label="公司网站" prop="websites">
				<u-input border type="text" v-model="model.websites" placeholder="请输入公司网站"></u-input>
			</u-form-item>
			<u-form-item label-position="top" label="公司邮箱" prop="email">
				<u-input border type="text" v-model="model.email" placeholder="请输入公司邮箱"></u-input>
			</u-form-item>
			<u-form-item label-position="top" label="注册资本" prop="registeredCapital">
				<u-input border type="text" v-model="model.registeredCapital" placeholder="请输入注册资本"></u-input>
			</u-form-item>
			<u-form-item label-position="top" label="地区" prop="briefAddress" label-width="150">
				<u-input border type="select" :select-open="briefAddress" v-model="model.briefAddress" placeholder="请选择地区" @click="briefAddress = true"></u-input>
			</u-form-item>
			<u-form-item label-position="top" label="详细地址" prop="detailedAddress">
				<u-input border type="text" v-model="model.detailedAddress" placeholder="请输入详细地址"></u-input>
			</u-form-item>
			<u-form-item label-position="top" label="固定电话" prop="fixedLineTelephone">
				<u-input border type="text" v-model="model.fixedLineTelephone" placeholder="请输入固定电话"></u-input>
			</u-form-item>
			<u-form-item label-position="top" label="登记机关" prop="registrationAuthority">
				<u-input border type="text" v-model="model.registrationAuthority" placeholder="请输入登记机关"></u-input>
			</u-form-item>
			<u-form-item label-position="top" label="核准日期" prop="sanctionDay" label-width="150">
				<u-input border type="select" :select-open="sanctionDay" v-model="model.sanctionDay" placeholder="请选择核准日期" @click="sanctionDay= true"></u-input>
			</u-form-item>
		</u-form>
		<view class="u-margin-30"></view>
		<u-button @click="submit" type="primary" :ripple="true">提交</u-button>
		<u-select :list="typeList" mode="single-column" v-model="typeShow" @confirm="typeCallback"></u-select>
		<u-picker mode="time" v-model="establishmentDay" @confirm="establishmentDayConfirm"></u-picker>
		<u-picker mode="time" v-model="timeLimit" @confirm="timeLimitConfirm"></u-picker>
		<u-picker mode="region" v-model="briefAddress" @confirm="briefAddressConfirm"></u-picker>
		<u-picker mode="time" v-model="sanctionDay" @confirm="sanctionDayConfirm"></u-picker>
	</view>
</template>

<script>
	export default {
		data() {
			let that = this;
			return {
				model:{
					financialInstitutionName:'',
					  briefAddress:'',
					  briefIntroduction:'' ,
					  businessScope:'' ,
					  detailedAddress: '',
					  email:'' ,
					  establishmentDay:'',
					  financialInstitutionId: 0,
					  financialInstitutionImage:'' ,
					  fixedLineTelephone:'' ,
					  legalPersonId: 0,
					  legalPersonName: '',
					  registeredCapital: '',
					  registrationAuthority: '',
					  result:'',
					  sanctionDay: '',
					  socialCreditCode: '',
					  timeLimit: '',
					  websites:'',
					  // image:''
					
				},
				fileList: [],
				tempFilePath: '',
				// action: this.BASE_URL + '/upload/stega',
				rules: {
					name: [{
						required: true,
						message: '请输入公司名称',
						trigger: 'blur'
					}],
					legalPersonName: [{
						required: true,
						message: '请输入法人姓名',
						trigger: 'blur',
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
						],
						
							establishmentDay: [{
								required: true,
								message: '请选择成立时间',
								trigger: 'change'
							}, ],
							timeLimit: [{
								required: true,
								message: '请选择经营期限',
								trigger: 'change'
							}, ],
							businessScope: [{
									required: true,
									message: '请填写经营范围'
								},
								{
									min: 5,
									message: '描述不能少于5个字',
									trigger: 'change',
								}
							],
							briefIntroduction: [{
									required: true,
									message: '请填写公司简历'
								},
								{
									min: 5,
									message: '描述不能少于5个字',
									trigger: 'change',
								}
							],
						
							fixedLineTelephone: [{
									required: true,
									message: '请输入固定电话',
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
							sanctionDay: [{
									required: true,
									message: '请输入核准日期',
									trigger: ['change', 'blur'],
								}
							],
					
				},
				typeList: [
					{
						label: '有效期高企',
						value:1
					},
					{
						label: '培育库入库企业',
						value:2
					},
					{
						label:'当年申报企业',
						value:3
					}
				],
				typeShow:false,
				establishmentDay: false,
				timeLimit: false,
				briefAddress: false,
				sanctionDay: false,
			}
		},
		methods: {
			typeCallback(e) {
				this.model.type= '';
				e.map((val, index) => {
					this.model.type += this.model.type == '' ? val.label : '-' + val.label;
				})
			},
			sanctionDayConfirm(e) {
				// console.log(e)
				this.model.sanctionDay = e.year + '-' + e.month + '-' + e.day;
			},
			timeLimitConfirm(e) {
				// console.log(e)
				this.model.timeLimit= e.year + '-' + e.month + '-' + e.day;
			},
			// 选择地区回调
			briefAddressConfirm(e) {
				this.model.briefAddress = e.province.label + '-' + e.city.label + '-' + e.area.label;
			},
			establishmentDayConfirm(e) {
				// console.log(e)
				this.model.establishmentDay = e.year + '-' + e.month + '-' + e.day;
			},
			onLoad() {
				
			},
			onListChange(lists) {
				this.fileList = lists;
				if (lists.length > 0 && lists[0].url) {
					this.tempFilePath = lists[0].url;
				} else {
					this.tempFilePath = '';
				}
			},
			
			onReady() {
				this.$refs.uForm.setRules(this.rules);
			},
			submit() {
				this.$refs.uForm.validate(valid => {
					if (valid) {
						if (!this.tempFilePath) {
							this.$refs.uToast.show({
								title: '请上传企业信用等级证书',
								type: 'warning'
							});
							return;
						}
						console.log('验证通过');
						uni.uploadFile({
							url: this.BASE_URL + '/financialInstitution/request',
							filePath: this.tempFilePath,
							name: 'multipartFile',
							formData: {
								'briefAddress': this.model.briefAddress || '',
								'briefIntroduction': this.model.briefIntroduction || '',
								'businessScope': this.model.businessScope || '',
								'detailedAddress': this.model.detailedAddress || '',
								'email': this.model.email || '',
								'financialInstitutionName': this.model.financialInstitutionName || '',
								'establishmentDay': this.model.establishmentDay ? this.model.establishmentDay + ' 00:00:00' : '',
								'financialInstitutionId': '0',
								'fixedLineTelephone': this.model.fixedLineTelephone || '',
								'legalPersonName': this.model.legalPersonName || '',
								'registeredCapital': this.model.registeredCapital || '',
								'registrationAuthority': this.model.registrationAuthority || '',
								'sanctionDay': this.model.sanctionDay ? this.model.sanctionDay + ' 00:00:00' : '',
								'unifiedSocialCreditCode': this.model.socialCreditCode || '',
								'timeLimit': this.model.timeLimit ? this.model.timeLimit + ' 00:00:00' : '',
								'website': this.model.websites || ''
							},
							success: (uploadRes) => {
								console.log(uploadRes);
								const res = JSON.parse(uploadRes.data);
								if (res.code == 200 || res.code == 0) {
									this.$refs.uToast.show({
										title: '已提交审核',
										type: 'success',
										back: 'true'
									});
								} else {
									this.$refs.uToast.show({
										title: res.msg || res.message || '提交失败',
										type: 'error'
									});
								}
							},
							fail: (err) => {
								console.log(err);
								this.$refs.uToast.show({
									title: '提交失败',
									type: 'error'
								});
							}
						});
					} else {
						console.log('验证失败');
					}
				});
			}
		}
	};
</script>

<style>
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
