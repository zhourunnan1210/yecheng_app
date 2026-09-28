<template>
	<view class="wrap">
		<u-toast ref="uToast" />
		<u-form :model="model" :rules="rules" ref="uForm">
			<view class="title">
				最新政策
			</view>
			<u-line />
			<u-form-item label-width="120" label-position="top" label="标题" prop="title">
				<u-input border placeholder="请输入标题" v-model="model.title" type="text"></u-input>
			</u-form-item>
			<u-form-item label-width="120" label-position="top" label="文号" prop="number">
				<u-input border placeholder="请输入文号" v-model="model.number" type="text"></u-input>
			</u-form-item>
			<u-form-item label-position="top" label="类别" prop="category">
				<u-input border type="select" :select-open="categoryShow" v-model="model.category" placeholder="请选择类别" @click="categoryShow = true"></u-input>
			</u-form-item>
			<u-form-item label="上传照片" prop="image" label-width="200">
				<u-upload width="160" height="160" :action="action" :file-list="fileList" @on-success="afterUpload" max-count="5"></u-upload>
			</u-form-item>
			<u-form-item label="上传附件" prop="addition" label-width="200">
				<u-upload width="160" height="160" :action="actionfile" :file-list="List" @on-success="afterUploadfile" max-count="1" upload-text="选择文件" ></u-upload>
			</u-form-item>
			<u-form-item label-width="120" label-position="top" label="链接(可选)" prop="link">
				<u-input border placeholder="请输入链接" v-model="model.link" type="text"></u-input>
			</u-form-item>
			<u-form-item label-position="top" label="内容" prop="content">
				<u-input type="textarea" border placeholder="请填写内容" v-model="model.content" maxlength="5000" />
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
					"number": "",
					"category": "",
					 "addition": "",
					"image": "",
					"link": "",
					"content": "",
					"departmentId": 1

				},
				action: this.BASE_URL + '/upload/single',
				actionfile: this.BASE_URL + '/upload/single',
				rules: {
					title: [{
						required: true,
						message: '请输入标题',
						trigger: 'blur'
					}],
					number: [{
						required: true,
						message: '请输入文号',
						trigger: 'blur'
					}],
					category: [{
						required: true,
						message: '请选择分类',
						trigger: 'blur'
					}]
				},
				categoryList: [],
				fileList: [],
				list:[],
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
			afterUpload(data, index, lists, name) {
				let str = this.model.image
				let newstr = str == '' ? data.data.url : ';' + data.data.url
				this.model.image = str + newstr
				// console.log(this.model.image)
			},
			afterUploadfile(data, index, lists, name) {
				this.model.addition = data.data.url
				console.log(this.model.addition)
			},
			categoryCallback(e) {
				this.model.category = '';
				e.map((val, index) => {
					this.model.category += this.model.category == '' ? val.label : '-' + val.label;
				})
			},
			submit() {
				// this.model.departmentId = this.$store.state.userInfo.gid
				this.$refs.uForm.validate(async valid => {
					if (valid) {
						console.log('验证通过');
						console.log(JSON.stringify(this.model))
						const res = await this.$myRequest({
							url: '/policy/publish',
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
