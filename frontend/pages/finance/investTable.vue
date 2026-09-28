<template>
	<view class="wrap">
		<u-toast ref="uToast" />
		<u-form :model="model" :rules="rules" ref="uForm">
			<view class="title">
				填写投资项目申请
			</view>
			<u-line />
			<u-form-item label-width="120" label-position="top" label="项目名称" prop="projectName">
				<!-- <u-input border placeholder="请输入项目名称" v-model="model.projectName" type="text"></u-input> -->
				<u-input border placeholder="请输入项目名称" v-model="investing.companyName" type="text" disabled></u-input>
			</u-form-item>
			<u-form-item label-width="120" label-position="top" label="投资需求id" prop="investingNeedId">
				<u-input border placeholder="请输入投资需求id" v-model="investing.investNeedId" type="text" disabled></u-input>
			</u-form-item>
			
			<u-form-item label-position="top" label="项目开始时间" prop="startDate" label-width="150">
				<u-input border type="select" :select-open="startDate" v-model="model.startDate" placeholder="请选择项目开始时间" @click="startDate= true"></u-input>
			</u-form-item>
			<u-form-item label-position="top" label="项目结束时间" prop="endDate" label-width="150">
				<u-input border type="select" :select-open="endDate" v-model="model.endDate" placeholder="请选择项目结束时间" @click="endDate = true"></u-input>
			</u-form-item>
			<u-form-item label-position="top" label="项目进度描述" prop="progressDescription">
				<u-input type="textarea" border placeholder="请填写项目进度描述" v-model="model.progressDescription" />
			</u-form-item>
			<u-form-item label-position="top" label="项目备注" prop="notes">
				<u-input type="textarea" border placeholder="请填写项目备注" v-model="model.notes" />
			</u-form-item>
			<u-form-item label="项目图片" prop="projectImage" label-width="200">
				<u-upload width="160" height="160" :action="action" :file-list="fileList" @on-success="afterUpload" max-count="1"></u-upload>
			</u-form-item>
			<view class="title" style="margin-top: 30rpx;">
				联系人信息
			</view>
			<u-line />
			<u-form-item label-width="120" label="姓名" prop="contactName" label-position="top">
				<u-input border placeholder="请输入联系人姓名" v-model="model.contactName" type="text"></u-input>
			</u-form-item>
			<u-form-item label="手机号码" prop="contactPhone" label-width="150" label-position="top">
				<u-input border placeholder="请输入手机号" v-model="model.contactPhone" type="number"></u-input>
			</u-form-item>
			
		</u-form>
		<view class="u-margin-30"></view>
		<u-button @click="submit" type="primary" :ripple="true">提交</u-button>
		<u-picker mode="time" v-model="startDate" @confirm="startDateConfirm"></u-picker>
		<u-picker mode="time" v-model="endDate" @confirm="endDateConfirm"></u-picker>
		
	</view>
</template>

<script>
	export default {
		data() {
			let that = this;
			return {
				investing:'',
				action: this.BASE_URL + '/upload/single',
				model: {
					projectName: '',
					contactName: '',
					contactPhone: '',
					progressDescription: '',
					investingNeedId: '',
					
					startDate: '',
					endDate: '',
					contactName: '',
					projectImage: '',
					notes:''
					
				},
				rules: {
					projectName: [{
						required: true,
						message: '请输入项目名称',
						trigger: 'blur'
					}],
					// investingNeedId: [{
					// 	required: true,
					// 	message: '请输入投资需求id',
					// 	trigger: 'blur'
					// }],
					startDate: [{
						required: true,
						message: '请选择开始时间',
						trigger: 'change'
					}, ],
					endDate: [{
						required: true,
						message: '请选择结束时间',
						trigger: 'change'
					}, ],
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

					progressDescription: [{
							required: true,
							message: '请填写项目进度描述'
						},
						{
							min: 5,
							message: '描述不能少于5个字',
							trigger: 'change',
						}
					],
					
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
					]
		
			},
				startDate: false,
				endDate: false,
				}
		},
		onLoad: async function(options) { //option为object类型，会序列化上个页面传递的参数
			console.log(options.item)
			let item = options.item
			console.log(item)
			const res = await this.$myRequest({
				url: '/investingneed/get/' + item,
				// data: {
				// 	policyId: item
				// },
				header: {
					'content-type': 'application/x-www-form-urlencoded'
				}
			});
			console.log(res)
			this.investing = res.data.data
		},
		computed: {

		},
		onReady() {
			this.$refs.uForm.setRules(this.rules);
		},
		methods: {
			afterUpload(data, index, lists, name) {
				this.model.projectImage = data.data.url
			},
			typeCallback(e) {
				this.model.type= '';
				e.map((val, index) => {
					this.model.type += this.model.type == '' ? val.label : '-' + val.label;
				})
			},
			startDateConfirm(e) {
				// console.log(e)
				this.model.startDate = e.year + '-' + e.month + '-' + e.day;
			},
			endDateConfirm(e) {
				// console.log(e)
				this.model.endDate= e.year + '-' + e.month + '-' + e.day;
			},

			submit() {
				// this.model.financialInstitutionId = this.$store.state.userInfo.gid
				console.log(this.model)
				 this.$refs.uForm.validate(async valid =>  {
					 if (valid)  {
						console.log('验证通过');
						const res = await this.$myRequest({
							url:'/investFinancialProj/publish',
							method: 'POST',
							header: {
								'content-type': 'application/json'
							},
							 data:{
							  "projectName":this.model.projectName,
							  "contactName":this.model.contactName,
							  "contactPhone":this.model.contactPhone,
							  "progressDescription":this.model.progressDescription,
							  "investingNeedId":this.model.investingNeedId,
							  
							  "startDate":this.model.startDate+" 00:00:00",
							  "endDate":this.model.endDate+" 00:00:00",
							  "projectImage":this.model.projectImage,
							  "notes":this.model.notes
							 
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
