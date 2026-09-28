<template>
	<view class="wrap">
		<view class="u-tabs-box">
			<u-tabs-swiper activeColor="#1296db" ref="tabs" :list="list" :current="current" @change="tebchange"
				:is-scroll="false" swiperWidth="750" inactive-color="#000000"></u-tabs-swiper>
		</view>
			<swiper class="swiper-box" :current="swiperCurrent" @transition="transition"
				@animationfinish="animationfinish" style="height: 100vh;">
				<swiper-item class="swiper-item" style="height: 100%;width: 100%;">
					<scroll-view scroll-y style="height: 100%;width: 100%;" @scrolltolower="reachBottom">
					<u-toast ref="uToast1" />
						<u-form :model="model" :rules="rules" ref="uForm">
							<view class="title">融资需求</view>
							<u-line />
							<u-form-item label-width="120" label-position="top" label="项目名称" prop="title">
							<u-input border placeholder="请输入待融资项目名称" v-model="model.title" type="text"></u-input>
							</u-form-item>
							<u-form-item label-position="top" label="融资规模" prop="financingMoney">
							<u-input border type="select" :select-open="actionSheetShow" v-model="model.financingMoney" placeholder="请选择融资规模" @click="actionSheetShow = true"></u-input>
							</u-form-item>
							<u-form-item label-width="120" label-position="top" label="融资方式" prop="financingMethod">
							<u-input border placeholder="请输入融资方式" v-model="model.financingMethod" type="text"></u-input>
							</u-form-item>
							<u-form-item label-position="top" label="行业领域" prop="field">
							<u-input border type="select" :select-open="fieldShow" v-model="model.field" placeholder="请选择行业领域" @click="fieldShow = true"></u-input>
							</u-form-item>
							<u-form-item label-position="top" label="融资阶段" prop="financingPhase" label-width="150">
							<u-radio-group v-model="radio" @change="radioGroupChange" >
							<u-radio shape="circle" v-for="(item, index) in radioList" :key="index" :name="item.name">{{ item.name }}</u-radio>
							</u-radio-group>
							</u-form-item>
							<u-form-item label-position="top" label="融资介绍" prop="financingIntroduction">
							<u-input type="textarea" border placeholder="请填写融资介绍" v-model="model.financingIntroduction" />
							</u-form-item>
							<u-form-item label-position="top" label="项目描述" prop="projectDescription">
							<u-input type="textarea" border placeholder="请填写项目描述" v-model="model.projectDescription" />
							</u-form-item>
							<u-form-item  label="上传项目详情图片" prop="projectImage" label-width="130">
							<u-upload width="160" height="160" :action="action" :file-list="fileList" @on-success="afterUpload" max-count="5"></u-upload>
							</u-form-item>
							<u-form-item label-position="top" label="团队介绍" prop="teamIntroduction">
							<u-input type="textarea" border placeholder="请填写团队介绍" v-model="model.teamIntroduction" />
							</u-form-item>
			
							<view class="title" style="margin-top: 30rpx;">联系人信息</view>
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
							<u-form-item label-position="top" label="联系人地址" prop="address">
							<u-input type="textarea" border placeholder="请填写详细地址" v-model="model.address" />
							</u-form-item>
							<u-form-item label-position="top" label="联系人单位" prop="position">
							<u-input type="textarea" border placeholder="请填写单位名称" v-model="model.position" />
							</u-form-item>
						</u-form>
						<view class="u-margin-30"></view>
						<u-button @click="submit" type="primary" :ripple="true">提交</u-button>
						<u-select :list="actionSheetList" mode="single-column" v-model="actionSheetShow" @confirm="actionSheetCallback"></u-select>
						<u-select :list="fieldList" mode="single-column" v-model="fieldShow" @confirm="fieldCallback"></u-select>
					</scroll-view>
				</swiper-item>
				<swiper-item class="swiper-item" style="height: 100%;width: 100%;">
					<scroll-view scroll-y style="height: 100%;width: 100%;" @scrolltolower="reachBottom">
					<u-toast ref="uToast" />
						<u-form :model="model" :rules="rules" ref="uForm1">
							<view class="title">投资需求</view>
							<u-line />
							<u-form-item label-width="120" label-position="top" label="公司名称" prop="companyName">
							<u-input border placeholder="请输入您的公司名称" v-model="model.companyName" type="text"></u-input>
							</u-form-item>
							<u-form-item label-position="top" label="投资金额" prop="investingMoney">
							<u-input border type="select" :select-open="actionSheetShow" v-model="model.investingMoney" placeholder="请选择投资金额" @click="actionSheetShow = true"></u-input>
							</u-form-item>
							<u-form-item label-width="120" label-position="top" label="投资方式" prop="investWay">
							<u-input border placeholder="请输入投资方式" v-model="model.investWay" type="text"></u-input>
							</u-form-item>
							<u-form-item label-position="top" label="行业领域" prop="industryField">
							<u-input border type="select" :select-open="fieldShow" v-model="model.industryField" placeholder="请选择行业领域" @click="fieldShow = true"></u-input>
							</u-form-item>
							<u-form-item label-position="top" label="投资类型" prop="investType">
							<u-input border type="select" :select-open="TypeShow" v-model="model.investType" placeholder="请选择投资类型" @click="TypeShow = true"></u-input>
							</u-form-item>
							<u-form-item label-position="top" label="投资说明" prop="investDescription">
							<u-input type="textarea" border placeholder="请填写投资说明" v-model="model.investDescription" />
							</u-form-item>
							<u-form-item label-position="top" label="成功案例" prop="successCase">
							<u-input type="textarea" border placeholder="请填写成功案例" v-model="model.successCase" />
							</u-form-item>
							<u-form-item  label="上传投资需求图片" prop="investImag" label-width="130">
							<u-upload width="160" height="160" :action="action" :file-list="fileList" @on-success="afterUpload" max-count="5"></u-upload>
							</u-form-item>
							<u-form-item label-position="top" label="公司介绍" prop="companyIntroduction">
							<u-input type="textarea" border placeholder="请填写公司介绍" v-model="model.companyIntroduction" />
							</u-form-item>
							
							<view class="title" style="margin-top: 30rpx;">联系人信息</view>
							<u-line />
							<u-form-item label-width="120" label="姓名" prop="contactName" label-position="top">
							<u-input border placeholder="请输入联系人姓名" v-model="model.contactName" type="text"></u-input>
							</u-form-item>
							<u-form-item label="联系人电话" prop="contactPhone" label-width="150" label-position="top">
							<u-input border placeholder="请输入联系人电话" v-model="model.contactPhone" type="number"></u-input>
							</u-form-item>
							<u-form-item label="邮箱" prop="contactEmail" label-width="150" label-position="top">
							<u-input border placeholder="请输入联系人邮箱" v-model="model.contactEmail" type="text"></u-input>
							</u-form-item>
							<!-- <u-form-item label-position="top" label="联系人地址" prop="address">
							<u-input type="textarea" border placeholder="请填写详细地址" v-model="model.address" />
							</u-form-item>
							<u-form-item label-position="top" label="联系人单位" prop="position">
							<u-input type="textarea" border placeholder="请填写单位名称" v-model="model.position" />
							</u-form-item> -->
						</u-form>
						<view class="u-margin-30"></view>
						<u-button @click="submit1" type="primary" :ripple="true">提交</u-button>
						<u-select :list="actionSheetList" mode="single-column" v-model="actionSheetShow" @confirm="actionSheetCallback1"></u-select>
						<u-select :list="fieldList" mode="single-column" v-model="fieldShow" @confirm="fieldCallback1"></u-select>
						<u-select :list="TypeList" mode="single-column" v-model="TypeShow" @confirm="TypeCallback"></u-select>
					</scroll-view>
				</swiper-item>
			</swiper>
	</view>
</template>

<script>
	export default {
		data() {
			
			let that = this;
			return {
				fileList:[],
				
				TypeList:[],
				action: this.BASE_URL + '/upload/single',
				model: {
					title: '',
					financingMoney: '',
					financingIntroduction: '',
					phone: '',
					email: '',
					name: '',
					projectImage: '',
					address: '',
					businessId:'',
					position:'',
					financingMethod:'',
					field:'',
					financingPhase: '其他',
					projectDescription:'',
					teamIntroduction:'',
					auditFlag: 0,
					 companyIntroduction: '',
					  companyName: '',
					  contactAddress: '',
					  contactCompany: '',
					  contactEmail: '',
					  contactName: '',
					  contactPhone: '',
					  // financialInstitutionId: 0,
					  // id: 0,
					  industryField: '',
					  investDescription: '',
					  investImag: '',
					  investType: '',
					  investWay: '',
					  investingMoney:'',
					  projProposal: '',
					  successCase:'',
					
				},
				current: 0,
				swiperCurrent: 0,
				tabsHeight: 0,
				dx: 0,
				tabbar: [],
				list: [{
						name: '我要融资'
					},
					{
						name: '我要投资'
					},
					
				],
				rules: {
					title: [{
						required: true,
						message: '请输入融资项目名称',
						trigger: 'blur'
					}],
					
					field: [{
						required: true,
						message: '请输入行业领域',
						trigger: 'blur'
					}],
					
					projectDescription: [{
						required: true,
						message: '请输入项目描述',
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
						
					],
					financingMethod:[
						{
								required: true,
								message: '请输入融资方式',
								trigger: 'blur',
							}
							
					],
					financingMoney: [{
						required: true,
						message: '请选择融资规模',
						trigger: 'change'
					}],
					financingIntroduction: [{
							required: true,
							message: '请填写融资项目介绍'
						},
						{
							min: 5,
							message: '介绍不能少于5个字',
							trigger: 'change',
						}
					],
					teamIntroduction: [{
							required: true,
							message: '请填写团队介绍'
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
					// financingPhase: [
					// 	{
					// 		required: true,
					// 		message: '请选择融资阶段',
					// 		trigger: 'change',
					// 	}
					// ],
					companyName: [{
							required: true,
							message: '请输入公司名称',
							trigger: 'blur'
					}],
					industryField: [{
							required: true,
							message: '请输入行业领域',
							trigger: 'blur'
					}],
					investWay: [{
							required: true,
							message: '请输入投资方式',
							trigger: 'blur'
					}],
					investDescription: [{
							required: true,
							message: '请输入投资描述说明',
							trigger: 'blur',
					
					}],
					contactPhone: [{
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
					contactEmail: [{
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
				
					successCase: [{
							required: true,
							message: '请输入成功案例',
							trigger: 'blur'
					}]
			},

				actionSheetList: [{
						value: '100万及以下',
						label: '100万及以下'
					},
					{
						label: '101万-200万',
					    value: '101万-200万',
					},
					{
						label: '201万-300万',
					    value: '201万-300万',
					},
					{
						label: '301万-500万',
					    value: '301万-500万',
					},
					{
						label: '501万-1000万',
					    value: '501万-1000万',
					},
					
					{
						label: '1001万及以上',
					    value: '1001万及以上',
					},
					
					{
						label: '其他金额',
					    value: '其他金额',
					},
				],
				fieldList: [{
						value: '电子信息技术领域',
						label: '电子信息技术领域'
					},
					{
						label: '生物与新医药技术领域',
						value: '生物与新医药技术领域',
					},
					{
						label: '航空航天技术领域',
						value: '航空航天技术领域'
					},
					{
						label: '新材料技术领域',
						value: '新材料技术领域'
					},
					{
						label: '高技术服务业领域',
						value: '高技术服务业领域'
					},
					{
						label: '新能源及节能技术领域',
						value: '新能源及节能技术领域'
					},
					{
						label: '资源与环境技术领域',
						value: '资源与环境技术领域'
					},
					{
						label: '先进制造与自动化领域',
						value: '先进制造与自动化领域'
					},
					{
						label: '其他',
						value: '其他'
					}
				],
				radioList: [
					{
						name: '其他',
						checked: true,
						disabled: false
					},
					{
						name: 'A~B轮',
						checked: false,
						disabled: false
					},
					{
						name: 'C轮及以上',
						checked: false,
						disabled: false
					}
				],
				TypeList: [
				     {
				      value: '保险投资',
				      label: '保险投资'
				     },
				     {
				      value: '债权投资',
				      label: '债权投资'
				     },
				     {
				      value: '股权投资',
				      label: '股权投资'
				     },
				     {
				      value: '天使投资',
				      label: '天使投资'
				     },
				     {
				      value: '风险投资',
				      label: '风险投资'
				     },
				     
				    ],
				radio: '其他',
				actionSheetShow: false,
				fieldShow: false,
				TypeShow:false,
			};
		},
		onLoad() {
			// this.getField()
		},
		computed: {

		},
		onReady() {
			this.$refs.uForm.setRules(this.rules);
			this.$refs.uForm1.setRules(this.rules);
		},
		methods: {
			
			reachBottom() {
				// 此tab为空数据
				if (this.current != 2) {
					this.loadStatus.splice(this.current, 1, "loading")
					setTimeout(() => {}, 1200);
				}
			},
			
			// tab栏切换
			tebchange(index) {
				this.swiperCurrent = index;
			
			},
			
			afterUpload(data, index, lists, name) {
				let str = this.model.projectImage
				let newstr = str == '' ? data.data.url : ';'+data.data.url
				this.model.projectImage = str + newstr
				// console.log(this.model.image)
			},
			
			radioGroupChange(e) {
				this.model.financingPhase = e;
			},

			// 点击actionSheet回调
			actionSheetCallback(e) {
				this.model.financingMoney = '';
				e.map((val, index) => {
					this.model.financingMoney += this.model.financingMoney == '' ? val.label : '-' + val.label;
				})
			},
			actionSheetCallback1(e) {
				this.model.investingMoney = '';
				e.map((val, index) => {
					this.model.investingMoney += this.model.investingMoney == '' ? val.label : '-' + val.label;
				})
			},
			fieldCallback(e) {
				this.model.field = '';
				e.map((val, index) => {
					this.model.field += this.model.field == '' ? val.label : '-' + val.label;
				})
			},
			fieldCallback1(e) {
				this.model.industryField = '';
				e.map((val, index) => {
					this.model.industryField += this.model.industryField == '' ? val.label : '-' + val.label;
				})
			},
			TypeCallback(e) {
				this.model.investType = '';
				e.map((val, index) => {
					this.model.investType += this.model.investType == '' ? val.label : '-' + val.label;
				})
			},
			
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
			submit() {
				// this.model.businessId = this.$store.state.userInfo.gid
				console.log(111)
				this.$refs.uForm.validate(async valid => {
					if (valid) {
						// console.log(JSON.stringify(this.model))
						const res = await this.$myRequest({
							url: '/financingneed/publish',
							method: 'POST',
							header: {
								'content-type': 'application/json'
							},
							data:{
								  "address": this.model.address,
								  "businessId": 0,
								  "email": this.model.email,
								  "field": this.model.field,
								  "financingIntroduction": this.model.financingIntroduction,
								  "financingMethod": this.model.financingMethod,
								  "financingMoney":this.model.financingMoney,
								  "financingPhase": this.model.financingPhase,
								  "name": this.model.name,
								  "phone":this.model.phone,
								  "position":this.model.position,
								  "projectDescription":this.model.projectDescription,
								  "projectImage":this.action,
								  "teamIntroduction": this.model.teamIntroduction,
								  "title": this.model.title
							} 
						});
						console.log(res,'222222q')
						if (res.data.code == 0){
							console.log(666666)
							this.$refs.uToast1.show({
								title: '已提交审核',
								type: 'success',
								back:'true'
							})
							
						}
					} else {
						console.log('验证失败');
					}
				})
				
			},
			submit1() {
				// this.model.businessId = this.$store.state.userInfo.gid
				console.log(222)
				this.$refs.uForm1.validate(async valid => {
					if (valid) {
						// console.log(JSON.stringify(this.model))
						const res = await this.$myRequest({
							url: '/investingneed/publish',
							method: 'POST',
							header: {
								'content-type': 'application/json'
							},
							data:{
								    "companyIntroduction":this.model.companyIntroduction,
								    "companyName": this.model.companyName,
								    // "contactAddress": this.model.contactAddress,
							     //    "contactCompany": this.model.contactCompany,
								    "contactEmail": this.model.contactEmail,
								    "contactName": this.model.contactName,
								    "contactPhone": this.model.contactPhone,
								    // "financialInstitutionId": 0,
								    // "id": 0,
								    "industryField": this.model.industryField,
								    "investDescription": this.model.investDescription,
								    "investImag": this.action,
								    "investType": this.model.investType,
								     "investWay": this.model.investWay,
								     "investingMoney":this.model.investingMoney,
								    // "projProposal": this.model.projProposal,
								    // "reading": 0,
								    "releaseTime": this.model.releaseTime,
								    "successCase":this.model.successCase,
							} 
						});
						if (res.data.code == 0){
							console.log(12345)
							this.$refs.uToast.show({
								title: '已提交审核',
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
		padding: 10rpx;
	}
	.swiper-box {
		flex: 1;
	}
	
	.swiper-item {
		height: 100%;
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
