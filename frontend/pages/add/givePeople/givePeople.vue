<template>
	<view class="wrap">
		<u-toast ref="uToast" />
		<u-form :model="model" :rules="rules" ref="uForm">
			<view class="title">
				需求信息
			</view>
			<u-line />
			<u-form-item label-width="120" label-position="top" label="姓名" prop="talentName">
				<u-input border placeholder="请输入姓名" v-model="model.talentName" type="text"></u-input>
			</u-form-item>
			<u-form-item label-position="top" label="性别" prop="gender">
				<u-input border type="select" :select-open="genderShow" v-model="model.gender" placeholder="请选择性别" @click="genderShow = true"></u-input>
			</u-form-item>
			<u-form-item label="年龄" prop="age" label-width="150" label-position="top">
				<u-input border placeholder="请输入年龄" v-model="model.age" type="number"></u-input>
			</u-form-item>
			<u-form-item label-position="top" label="毕业时间" prop="graduateDate" label-width="150">
				<u-input border type="select" :select-open="pickerShow" v-model="model.graduateDate" placeholder="请选择毕业时间" @click="pickerShow = true"></u-input>
			</u-form-item>
			<u-form-item label-width="120" label-position="top" label="专业" prop="profession">
				<u-input border placeholder="请输入所学专业" v-model="model.profession" type="text"></u-input>
			</u-form-item>
			
			<u-form-item label-position="top" label="求职意向" prop="job">
				<u-input type="text" border placeholder="请填写求职意向" v-model="model.job" />
			</u-form-item>
			<u-form-item label-width="120" label-position="top" label="专业技能" prop="skill" >
				<u-input type="textarea" border placeholder="请输入具备技能" v-model="model.skill" maxlength="1000"></u-input>
			</u-form-item>
			<u-form-item label-position="top" label="个人经历" prop="experience">
				<u-input type="textarea" border placeholder="请填写个人经历" v-model="model.experience" maxlength="1000"/>
			</u-form-item>
			
			<u-form-item label="上传照片" prop="image" label-width="200">
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
		<u-select :list="genderList" mode="single-column" v-model="genderShow" @confirm="genderCallback"></u-select>
		<u-picker mode="time" v-model="pickerShow" @confirm="graduateDateConfirm"></u-picker>
	</view>
</template>

<script>
	export default {
		data() {

			return {
			
				model: {
					talentName: '',
					job: '',
					phone: '',
					age:'',
					email: '',
					contactName: '',
					image: '',
					address: '',
					schoolId:'',
					position:'',
					profession:'',
					gender:'',
					graduateDate:'',
					skill:'',
					experience:''
				},
				action: this.BASE_URL + '/upload/single',
				rules: {
					talentName: [{
						required: true,
						message: '请输入姓名',
						trigger: 'blur'
					}],
					age: [{
						required: true,
						message: '请输入年龄',
						trigger: 'blur'
					}],
					image: [{
						required: true,
						message: '请上传照片',
						trigger: 'blur'
					}],
					gender: [{
						required: true,
						message: '请输入性别',
						trigger: 'blur'
					}],
					graduateDate: [{
						required: true,
						message: '请输入毕业时间',
						trigger: 'blur'
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
					profession:[
						{
								required: true,
								message: '请输入关键词',
								trigger: 'blur',
							},
							{
								max: 20,
								message: '关键词字数不能超过20字',
								trigger: ['change','blur'],
							}
							
					],
					skill:[
						{
								required: true,
								message: '请输入专业技能',
								trigger: 'blur',
							},
							{
								max: 1000,
								message: '不能超过1000字',
								trigger: ['change','blur'],
							}
							
					],
					experience:
					[
						{
								required: true,
								message: '请输入个人经历',
								trigger: 'blur',
							},
							{
								max: 1000,
								message: '不能超过1000字',
								trigger: ['change','blur'],
							}
							
					],
					money: [{
						required: true,
						message: '请选择投资额度',
						trigger: 'change'
					}, ],
					job: [{
							required: true,
							message: '请填写需求描述'
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

				actionSheetList: [{
						value: '面议',
						label: '面议'
					},
					{
						label: '50万及以下',
						value: '50万及以下',
					},
					{
						label: '50万 ~ 100万',
						value: '50万+'
					},
					{
						label: '100~200万',
						value: '100万+'
					},
					{
						label: '200万及以上',
						value: '200万+'
					}
				],
				genderList: [
					{
						label: '男',
						value:1
					},
					{
						label: '女',
						value:2
					}
				],
				fileList:[],
				actionSheetShow: false,
				fieldShow: false,
				genderShow:false,
				pickerShow: false,
			};
		},
		computed: {

		},
		onLoad() {
			
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
				this.model.money = '';
				e.map((val, index) => {
					this.model.money += this.model.money == '' ? val.label : '-' + val.label;
				})
			},
			fieldCallback(e) {
				this.model.field = '';
				e.map((val, index) => {
					this.model.field += this.model.field == '' ? val.label : '-' + val.label;
				})
			},
			// 点击actionSheet回调
			genderCallback(e) {
				this.model.gender= '';
				e.map((val, index) => {
					this.model.gender += this.model.gender == '' ? val.label : '-' + val.label;
				})
			},
			graduateDateConfirm(e) {
				console.log(e)
				this.model.graduateDate = e.year + '-' + e.month + '-' + e.day;
			},

			submit() {
				// this.model.schoolId = this.$store.state.userInfo.gid
				this.$refs.uForm.validate(async valid => {
					if (valid) {
						console.log('验证通过');
						this.model.gender = this.model.gender == '男'? 1 : 2
						this.model.graduateDate = this.model.graduateDate + ' 00:00:00'
						console.log(JSON.stringify(this.model))
						const res = await this.$myRequest({
							url: '/talentsupply/publish',
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
