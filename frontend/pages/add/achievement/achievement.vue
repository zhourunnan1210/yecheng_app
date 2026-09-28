<template>
	<view class="wrap">
		<u-toast ref="uToast" />
		<u-form :model="model" :rules="rules" ref="uForm">
			<view class="title">
				科技成果
			</view>
			<u-line />
			<u-form-item label-width="120" label-position="top" label="名称" prop="title">
				<u-input border placeholder="请输入发布成果名称" v-model="model.title" type="text"></u-input>
			</u-form-item>

			<u-form-item label-position="top" label="行业领域" prop="field">
				<u-input border type="select" :select-open="fieldShow" v-model="model.field" placeholder="请选择行业领域" @click="fieldShow = true"></u-input>
			</u-form-item>
			<u-form-item  label="成果分类" prop="category" label-width="150">
				<u-radio-group v-model="radio" @change="radioGroupChange" >
					<u-radio shape="circle" v-for="(item, index) in radioList" :key="index" :name="item.name">{{ item.name }}</u-radio>
				</u-radio-group>
			</u-form-item>
			<u-form-item label-position="top" label="成果描述" prop="description">
				<u-input type="textarea" border placeholder="请填写成果描述" v-model="model.description" />
			</u-form-item>
			<u-form-item label-width="120" label-position="top" label="网站" prop="website">
				<u-input border placeholder="请输入网站" v-model="model.website" type="text"></u-input>
			</u-form-item>
			<u-form-item  label="上传成果介绍图片" prop="image" label-width="130">
				<u-upload width="160" height="160" :action="action" :file-list="fileList" @on-success="afterUpload" max-count="5"></u-upload>
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
			<u-form-item label-position="top" label="联系人地址" prop="address">
				<u-input type="textarea" border placeholder="请填写详细地址" v-model="model.address" />
			</u-form-item>
			<u-form-item label-position="top" label="联系人单位" prop="position">
				<u-input type="textarea" border placeholder="请填写单位名称" v-model="model.position" />
			</u-form-item>


		</u-form>
		<view class="u-margin-30"></view>
		<u-button @click="submit" type="primary" :ripple="true">提交</u-button>
		<u-select :list="fieldList" mode="single-column" v-model="fieldShow" @confirm="fieldCallback"></u-select>
	</view>
</template>

<script>
	export default {
		data() {
			let that = this;
			return {
				model: {
					title: '',
					phone: '',
					email: '',
					name: '',
					image: '',
					address: '',
					publisherId:'',
					publisherType:'',
					position:'',
					field:'',
					category: '其他',
					description:'',
					"website": ''
				},
				fileList:[],
				action: this.BASE_URL + '/upload/single',
				rules: {
					title: [{
						required: true,
						message: '请输入科技成果名称',
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
							message: '请选择成果分类',
							trigger: 'change',
						}
					],
					field: [
						{
							required: true,
							message: '请选择行业领域',
							trigger: 'change',
						}
					],
					description: [
						{
							required: true,
							message: '请填写成果描述',
							trigger: 'change',
						}
					],
					website: [
						{
							required: true,
							message: '请填写网站',
							trigger: 'change',
						}
					]

				},

				fieldList: [
				],
				radioList: [
					{
						name: '其他',
						checked: true,
						disabled: false
					},
					{
						name: '产品',
						checked: true,
						disabled: false
					},
					{
						name: '科研',
						checked: true,
						disabled: false
					},
					{
						name: '项目',
						checked: true,
						disabled: false
					}
				],
				radio: '其他',
				fieldShow: false
			};
		},
		computed: {

		},
		onLoad() {
			this.getField()
		},
		onReady() {
			this.$refs.uForm.setRules(this.rules);
		},
		methods: {
			afterUpload(data, index, lists, name) {
				let str = this.model.image
				let newstr = str == '' ? data.data.url : ';'+data.data.url
				this.model.image = str + newstr
				// console.log(this.model.image)
			},
			async getField() {
				const res = await this.$myRequest({
					url: "/professionfieldindex/getlist"
				})
				for (let i = 0; i < res.data.data.length; i++) {
					let obj = res.data.data[i]
					let temp = {}
					temp.label = obj.name
					temp.value = obj.id
					this.fieldList[i] = temp
				}
			},
			// radio选择发生变化
			radioGroupChange(e) {
				this.model.category = e;
			},

		
			fieldCallback(e) {
				this.model.field = '';
				e.map((val, index) => {
					this.model.field += this.model.field == '' ? val.label : '-' + val.label;
				})
			},

			submit() {
				// this.model.publisherId = this.$store.state.userInfo.gid
				this.model.publisherType = this.$store.state.userInfo.type
				this.$refs.uForm.validate(async valid => {
					if (valid) {
						console.log(JSON.stringify(this.model))
						const res = await this.$myRequest({
							url: '/technologyAchievement/publish',
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
