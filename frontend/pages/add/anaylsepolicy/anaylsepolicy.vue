<template>
	<view class="wrap">
		<u-toast ref="uToast" />
		<u-form :model="model" :rules="rules" ref="uForm">
			<view class="title">
				政策解读
			</view>
			<u-line />
			<u-form-item label-width="120" label-position="top" label="政策解读标题" prop="title">
				<u-input border placeholder="请输入政策解读标题" v-model="model.title" type="text"></u-input>
			</u-form-item>
			<u-form-item label-position="top" label="类别" prop="category">
				<u-input border type="select" :select-open="categoryShow" v-model="model.category" placeholder="请选择类别" @click="categoryShow = true"></u-input>
			</u-form-item>
			<u-form-item label-position="top" label="介绍" prop="introducton">
				<u-input type="textarea" border placeholder="请填写内容介绍" v-model="model.introduction" maxlength="500" />
			</u-form-item>
			<u-form-item label="上传照片" prop="video" label-width="200">
				<u-upload width="160" height="160" :action="action" :file-list="fileList" @on-success="afterUpload" max-count="5"></u-upload>
			</u-form-item>
			<u-form-item label-width="120" label-position="top" label="链接" prop="link">
				<u-input border placeholder="请输入链接" v-model="model.link" type="text"></u-input>
			</u-form-item>

		</u-form>
		<view class="u-margin-30"></view>
		<u-button @click="submit" type="primary" :ripple="true">提交</u-button>
		<u-select :list="categoryList" mode="single-column" v-model="categoryShow" @confirm="categoryCallback"></u-select>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				model: {
					"title": "",
					"category": "",
					"introduction": "",
					"link": "",
					"departmentId": "",
					"video": ""

				},
				action: this.BASE_URL + '/upload/single',
				rules: {
					title: [{
						required: true,
						message: '请输入标题',
						trigger: 'blur'
					}],
					category: [{
						required: true,
						message: '请选择分类',
						trigger: 'blur'
					}],
					introduction: [{
							required: true,
							message: '请填写简介',
							trigger: 'blur'
						},
						{
							max: 500,
							message: '不能超过500字',
							trigger: ['change', 'blur'],
						}
					]
				},
				fileList: [],
				categoryList: [],
				categoryShow: false,
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
			categoryCallback(e) {
				this.model.category = '';
				e.map((val, index) => {
					this.model.category += this.model.category == '' ? val.label : '-' + val.label;
				})
			},
			afterUpload(data, index, lists, name) {
				this.model.video = data.data.url
			}, 
			async getField() {
				const res = await this.$myRequest({
					url: "/policycategoryindex/getlist"
				})
				for (let i = 0; i < res.data.data.length; i++) {
					let obj = res.data.data[i]
					let temp = {}
					temp.label = obj.name
					temp.value = obj.id
					this.categoryList[i] = temp
				}
			},
			submit() {

				// this.model.departmentId = this.$store.state.userInfo.gid
				this.$refs.uForm.validate(async valid => {
					if (valid) {
						console.log('验证通过');
						console.log(JSON.stringify(this.model))
						const res = await this.$myRequest({
							url: '/policyanalyse/publish',
							method: 'POST',
							header: {
								'content-type': 'application/json'
							},
							data: this.model
						});
						if (res.data.code == 0) {
							this.$refs.uToast.show({
								title: '发布成功',
								type: 'success',
								back: 'true'
							})
						}
					} else {
						console.log('验证失败');
					}
				});
			}
		}
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
