<template>
	<view class="mainclass">
		<u-toast ref="uToast" />
		<u-row style="padding-top: 5px; padding-left: 10px;">
			<u-col span="12">
				<span class="title" style="display: inline-block;">
					问题描述
				</span>

			</u-col>
			<u-col span="12" style="margin-top: 10px;">
				<span style="font-size: 14px; display: inline-block;">
					{{content}}
				</span>
			</u-col>
		</u-row>
		<u-row style="padding-top: 10px; padding-left: 10px;">
			<u-col span="12">
				<span class="title" style="display: inline-block;">
					联系方式
				</span>
			</u-col>
			<u-col span="12" style="margin-top: 10px;">
				<view class="text">电话：
					<text class="u-main-color">
						{{phone}}
					</text>
				</view>
			</u-col>
			<u-col span="12">
				<view class="text">邮箱：
					<text class="u-main-color">
						{{email}}
					</text>
				</view>
			</u-col>
		</u-row>
		<u-row style="padding-top: 5px; padding-left: 10px;">
			<u-col span="12">
				<span class="title" style="display: inline-block;">
					问题回复
				</span>
			</u-col>
			<u-col span="12" style="margin-top: 10px;">
				<u-form-item label-position="left">
					<u-input maxlength="1000" type="textarea" border placeholder="请填写回复内容" v-model="model.content" />
				</u-form-item>
			</u-col>
			<u-col span="12" style="margin-top: 30px;">
				<u-button @click="submit" type="primary" :ripple="true">提交</u-button>
			</u-col>
		</u-row>


	</view>
</template>

<script>
	import {
		mapState,
		mapMutations
	} from 'vuex';

	export default {
		computed: {
			...mapState({
				type: state => state.userInfo.type,
				isLogin: state => state.isLogin,
			})
		},

		data() {
			return {

				id: '',
				content: '',
				phone: '',
				email: '',
				model: {
					content: '',
					uesrId: '',
					parentId: ''
				},
			}
		},
		methods: {
			async submit() {
				this.model.parentId = this.id;
				const res = await this.$myRequest({
					url: '/consultation/reply',
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
			}
		},
		onLoad() {
			this.id = this.$route.query.id;
			this.content = this.$route.query.content;
			this.phone = this.$route.query.phone;
			this.email = this.$route.query.email;
		},
		watch: {
			'$route'() {
				this.id = this.$route.query.id;
				this.content = this.$route.query.content;
				this.phone = this.$route.query.phone;
				this.email = this.$route.query.email;
			},
			isLogin: function(value) {
				uni.switchTab({
					url: '../mine/mine'
				})
			}
		}
	}
</script>

<style scoped lang="scss">
	.mainclass {
		background-color: #F2F2F2;
		height: 100%;
	}

	.u-row {
		margin-top: 20rpx;
		background: #FFFFFF;
		font-size: 18px;
		padding: 20px;
		color: #000000;
		letter-spacing: 2px;

	}

	.text {
		font-size: 14px;
		color: #949494;
		line-height: 2;

	}

	.title {
		font-size: 28rpx;
		position: relative;
		line-height: 1;
		padding-left: 20rpx;
		font-weight: 900;
		margin-bottom: 20px;
		color: $uni-color-title;

		&:before {
			width: 4px;
			height: 16px;
			border-radius: 100rpx;
			background-color: $uni-color-primary;
			content: '';
			position: absolute;
			left: 1rpx;
			top: -1px;
		}
	}
</style>
