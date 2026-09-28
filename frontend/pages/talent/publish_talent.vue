<template>
	<view class="wrap">
		<u-toast ref="uToast" />
		<u-form :model="model" :rules="rules" ref="uForm">
			<view class="title">
				个人信息
			</view>
			<u-line />
			<u-form-item label-width="120" label-position="top" label="姓名" prop="name">
				<u-input border placeholder="请输入姓名" v-model="model.name" type="text"></u-input>
			</u-form-item>
			<u-form-item label-width="120" label-position="top" label="年龄" prop="age">
				<u-input border placeholder="请输入年龄" v-model="model.age" type="text"></u-input>
			</u-form-item>
			<u-form-item label="性别" prop="gender" label-width="150">
				<u-radio-group @change="radioGroupChange">
					<u-radio shape="circle" v-for="(item, index) in genderList" :key="index"
						:name="item.name">{{ item.name }}</u-radio>
				</u-radio-group>
			</u-form-item>
			<u-form-item label="学历" prop="degree" label-width="150">
				<u-radio-group @change="radioGroupChange2">
					<u-radio shape="circle" v-for="(item, index) in degreeList" :key="index"
						:name="item.name">{{ item.name }}</u-radio>
				</u-radio-group>
			</u-form-item>
			<u-form-item label-width="120" label-position="top" label="毕业院校" prop="school">
				<view @click="showSchoolPicker">{{schoolData}}</view>
				<schoolPicker themeColor="#000" ref="schoolPicker" @onConfirm="onConfirm">
				</schoolPicker>
			</u-form-item>
			<u-form-item label="上传头像" prop="image" label-width="200">
				<u-upload width="160" height="160" :action="action" :file-list="fileList" @on-success="afterUpload"
					max-count="1"></u-upload>
			</u-form-item>
			<view class="title" style="margin-top: 30rpx;">
				求职信息
			</view>
			<u-line />
			<u-form-item label-width="120" label-position="top" label="期望职业" prop="profession">
				<u-input border placeholder="" v-model="model.profession" type="text"></u-input>
			</u-form-item>
			<u-form-item label-width="120" label-position="top" label="期望薪资" prop="salaryMax">
				<view style="padding-left: 20rpx;"></view>
				<u-input placeholder="" border v-model="model.salaryMin" type="number"></u-input>
				<view style="font-size: 50rpx;padding-left:20rpx;padding-right: 20rpx; ;">k —— </view>
				<u-input placeholder="" border v-model="model.salaryMax" type="number"></u-input>
				<view style="font-size: 50rpx;padding-left:20rpx;padding-right: 20rpx; ;"> k</view>
			</u-form-item>
			<u-form-item label-position="top" label="专业技能" prop="skill">
				<u-input type="textarea" border placeholder="请填写专业技能" v-model="model.skill" />
			</u-form-item>
			<u-form-item label-position="top" label="性格品质" prop="quality">
				<u-input type="textarea" border placeholder="请描述个人性格品质" v-model="model.quality" />
			</u-form-item>
			<view class="title" style="margin-top: 30rpx;">
				联系方式
			</view>
			<u-line />
			<u-form-item label="手机号码" prop="phone" label-width="150" label-position="top">
				<u-input border placeholder="请输入手机号" v-model="model.phone" type="number"></u-input>
			</u-form-item>
			<u-form-item label="邮箱" prop="email" label-width="150" label-position="top">
				<u-input border placeholder="请输入联系人邮箱" v-model="model.email" type="text"></u-input>
			</u-form-item>


		</u-form>
		<view class="u-margin-30"></view>
		<u-button @click="submit" type="primary" :ripple="true">发布</u-button>
		<u-select :list="StateArray" mode="single-column" v-model="StateShow" @confirm="actionSheetCallback"></u-select>
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
				schoolData: '请选择学校',
				model: {
					userId: '',
					name: "",
					age: "",
					gender: "",
					degree: "",
					school: "",
					image: "",
					jobStatus: "",
					salaryMin: "",
					salaryMax: "",
					profession: "",
					skill: "",
					quality: "",
					phone: "",
					email: "",
				},
				rules: {
					image: [{
						required: true,
						message: '请上传头像'
					}],
					SalaryMax: [{
							required: true,
							message: '请填写个人技能'
						},
						{
							min: 10,
							message: '描述不能少于10个字',
							trigger: 'blur',
						}
					],
					skill: [{
							required: true,
							message: '请填写个人技能'
						},
						{
							min: 10,
							message: '描述不能少于10个字',
							trigger: 'change',
						}
					],
					quality: [{
							required: true,
							message: '请填写性格品质'
						},
						{
							min: 10,
							message: '描述不能少于10个字',
							trigger: 'change',
						}
					],
					name: [{
							require: true,
							errorMessage: '请填写姓名',
							trigger: 'change',
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
					age: [{
							require: true,
							errorMessage: '请输入年龄',
							trigger: ['change', 'blur'],
						},
						{
							validator: (rule, value, callback) => {
								if (value < 18 || value > 60) {
									return false
								} else return true;
							},
							message: '年龄应该在18到60岁内',
							// 触发器可以同时用blur和change，二者之间用英文逗号隔开
							trigger: ['change', 'blur'],
						},
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
					profession: [{
							require: true,
							message: '请填写期望职业',
						},
						{
							max: 20,
							message: '选的职业太多啦',
							trigger: 'blur',
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
				fileList: [],
				action: this.BASE_URL + '/upload/single',
				jobStatus: '', //就职状态
				genderList: [

					{
						name: '男',
						checked: true,
						disabled: false
					},
					{
						name: '女',
						checked: false,
						disabled: false
					},
				],
				degreeList: [

					{
						name: '大专',
						checked: false,
						disabled: false,
					},
					{
						name: '本科',
						checked: true,
						disabled: false,
					},
					{
						name: '硕士',
						checked: false,
						disabled: false,
					},
					{
						name: '博士',
						checked: false,
						disabled: false,
					},
				],
				list: [{
						name: '企业推荐'
					},
					{
						name: '简历发布'
					},
				],
				StateShow: false,
				StateArray: [{
					label: '已离职',
					value: '0',
				}, {
					label: '未离职',
					value: '1',
				}, {
					label: '正在办理离职',
					value: '2',
				}],
				StateIndex: 0,
				index: 0,
				jobtime: "全职",
				current: 0,
				swiperCurrent: 0,
				dx: 0,
				searchValue: '123123',
				inputcontent: '', //输入内容
				TalentList: '',
				degree2: '全部',
				publishTime2: '全部',
				optionsDegree: [{
						label: "全部",
						value: "全部",
					},
					{
						label: "大专",
						value: "4",
					},
					{
						label: "本科",
						value: "3",
					},
					{
						label: "硕士",
						value: "2",
					},
					{
						label: "博士",
						value: "1",
					}
				],
				optionsPublishTime: [{
						label: "全部",
						value: "全部",
					},
					{
						label: "一个月内",
						value: "一个月内",
					},
					{
						label: "三个月内",
						value: "三个月内",
					},
					{
						label: "六个月内",
						value: "六个月内",
					},
					{
						label: "一年内",
						value: "一年内",
					},
				],
				swiperheight: 500, // 默认给了个高度，具体数值随意
			}
		},
		onLoad() {
			// this.getTalentList()
			uni.getSystemInfo({
				success: (res) => {
					// 这个减100，看个人需求可以不要，这里我需要和底部隔开一定距离，变相来讲就是让这个swiper少一点高度，你想想我这个操作
					let height = res.windowHeight - uni.upx2px(100)
					console.log(height);
					this.swiperheight = height;
				}
			})
		},
		onReady() {
			this.$refs.uForm.setRules(this.rules);
		},
		methods: {
			/**
			 * 打开学校选择器
			 */
			showSchoolPicker: function() {
				this.$refs.schoolPicker.show()
			},
			/**
			 * 确认学校选择
			 */
			onConfirm(e) {
				const school = e.label.split("-")[2];
				if (school === '暂未收录') {
					return;
				} else {
					this.schoolData = school;
					this.model.school = school;
				}
			},

			afterUpload(data, index, lists, name) {
				this.model.image = data.data.url
			},

			actionSheetCallback(e) {
				this.jobStatus = '';
				e.map((val, index) => {
					this.jobStatus += this.jobStatus == '' ? val.label : '-' + val.label
					this.model.jobStatus += this.model.jobStatus == '' ? val.value : '-' + val.value
				})
			},
			submit() {
				this.model.userId = this.$store.state.userInfo.uid
				// this.model.businessId = this.$store.state.userInfo.gid
				this.$refs.uForm.validate(async valid => {
					if (valid) {
						console.log('验证通过');
						const res = await this.$myRequest({
							url: '/talentSupply/publish',
							method: 'POST',
							header: {
								'content-type': 'application/json'
							},
							data: {
								"userId": this.model.userId,
								"address": "1",
								"age": this.model.age,
								"name": this.model.name,
								"degree": this.model.degree,
								"email": this.model.email,
								"experience": "1",
								"gender": "1",
								"image": this.model.image,
								"job": "领军人才",
								"jobNature": "1",
								"jobStatus": this.model.jobStatus,
								"phone": this.model.phone,
								"position": "1",
								"profession": this.model.profession,
								"quality": this.model.quality,
								"salaryMax": this.model.salaryMax,
								"salaryMin": this.model.salaryMin,
								"school": this.model.school,
								// "schoolCheck":"1",
								"skill": this.model.skill,
								"resumeUrl": "",
								"status": "0"
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
							if (res.data.msg == '' || res.data.msg == null) {
								res.data.msg = res.data.message
							}
							this.$refs.uToast.show({
								title: res.data.msg,
								type: 'error',
								back: 'false'
							})
						}
					}
				});
			},

			async search(fresh) {
				this.condition = fresh.value
				const res = await this.$myRequest({
					url: '/talentneed/listByCondition',
					method: 'POST',
					header: {
						'content-type': 'application/json'
					},
					data: {
						"condition": this.condition,
					}
				});
				this.TalentList = res.data.data
			},
			change1(index) {
				if (index == '全部') {
					this.degree2 = '全部'
				} else {

					this.degree2 = index
				}
				this.getTalentList()
			},
			change2(index) {
				if (index == '全部') {
					this.publishTime2 = '全部'
				} else {

					this.publishTime2 = index
				}
				this.getTalentList()
			},
			/* 点击进入企业详情页 */
			getTalent(talentNeedId) {
				console.log(talentNeedId)
				uni.navigateTo({
					url: "../businessIndex/businessInside/businessInside?talentNeedId=" + talentNeedId
				});
			},
			/*企业列表*/
			async getTalentList() {
				const res = await this.$myRequest({
					url: '/talentneed/listByDurationDegree',
					method: 'POST',
					header: {
						'content-type': 'application/json'
					},
					data: {
						"degree": this.degree2, //0，1,2,
						"duration": this.publishTime2 //
					},
				});
				this.TalentList = res.data.data
			},
			//选择器
			bindPickerChange1: function(e) {
				this.StateIndex = e.detail.value;
			},
			bindPickerChange2: function(e) {
				this.index = e.detail.value;
			},
			// tab栏切换
			tebchange(index) {
				this.swiperCurrent = index;

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
			radioGroupChange(n) {
				if (n == '男') {
					this.model.gender = 1
				} else if (n == '女') {
					this.model.gender = 2
				}
				console.log('groupChange', n);
			},
			radioGroupChange2(n) {
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

		},
	}
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