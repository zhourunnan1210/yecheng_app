<template>
	<view class="mainclass">
		<u-grid :col="1">
			<u-grid-item>
				<u-image width="150px" height="150px" :src="checkImage(financing.projectImage)"></u-image>
			</u-grid-item>
		</u-grid>
		<!-- <u-swiper :list="imgList" mode="number" height=350></u-swiper> -->
		<u-row>
			{{financing.title}}
		</u-row>
		<u-row>
			<u-col span="12">
				<view class="text u-flex-nowrap">发布时间：
					<text class="u-main-color">
						{{$u.timeFormat(financing.publishTime, 'yyyy-mm-dd')}}

					</text>
				</view>
			</u-col>
			<u-col span="12">
				<view class="text">融资方式：
					<text class="u-main-color">
						{{financing.financingMethod}}
					</text>
				</view>
			</u-col>
			<u-col span="12">
				<view class="text">融资阶段：
					<text class="u-main-color">
						{{financing.financingPhase}}
					</text>
				</view>
			</u-col>

		</u-row>
		<u-row>
			<u-col span="12">
				<view class="text">行业领域：
					<text class="u-main-color">
						{{financing.field}}
					</text>
				</view>
			</u-col>
		</u-row>
		<!-- <u-row>
			<u-col span="12" >
				<view class="text u-flex-nowrap" >项目进度：
					<text class="u-main-color">
						{{financing.investType}}
					</text>
				</view>
			</u-col>
			
		</u-row> -->
		<u-row>
			<u-col span="12">
				<view class="text">联系人：
					<text class="u-main-color">
						{{contact.name}}
					</text>
				</view>
			</u-col>
			<u-col span="12">
				<view class="text">联系电话：
					<text class="u-main-color">
						{{contact.phone}}
					</text>
				</view>
			</u-col>
		</u-row>
		<u-row>
			<u-col span="12">
				<view class="title">
					项目介绍
				</view>
				<text decode class="u-content-color u-m-r-20 u-m-l-20 u-m-t-80 u-font-28 textbox">{{financing.projectDescription}}
				</text>
			</u-col>
		</u-row>
		<u-row>
			<u-col span="12">
				<view class="title">
					需求描述
				</view>
				<text decode class="u-content-color u-m-r-20 u-m-l-20 u-m-t-80 u-font-28 textbox u-m-b-30">{{financing.financingIntroduction}}
				</text>
			</u-col>
		</u-row>
		<u-row>
			<u-col span="12">
				<view class="title">
					团队介绍
				</view>
				<text decode class="u-content-color u-m-r-20 u-m-l-20 u-m-t-80 u-font-28 textbox u-m-b-30">{{financing.teamIntroduction}}
				</text>
			</u-col>
		</u-row>
		<!-- <que-button @clicked="clicked()"></que-button> --><!-- 点击咨询 -->
	</view>


</template>

<script>
	import { needDefaultImage, isStaleOssUrl } from '../../../../utils/imageUrl.js'
	import queButton from '../../../../components/queButton/queButton.vue'
	export default {
		components: {
			queButton
		},
		data() {
			return {
				DEFAULT_IMAGE: '/static/defaultImage/1.png',
				financing: "",
				imgList: [],
				contact: ''
			}
		},
		methods: {
			checkImage(url) {
				if (needDefaultImage(url)
					|| url.trim() === '') {
					return this.DEFAULT_IMAGE
				}
				return url
			},
			clicked(item) {
				uni.navigateTo({
					url: '../../../question/question'
				});
			}
		},
		onLoad: async function(options) { //option为object类型，会序列化上个页面传递的参数
			console.log(options.item)
			let item = options.item
			// console.log(item)
			const res = await this.$myRequest({
				url: '/financingneed/get/' + item,
				// data: {
				// 	policyId: item
				// },
				header: {
					'content-type': 'application/x-www-form-urlencoded'
				}
			});
			// console.log(res)
			this.financing = res.data.data
			if (this.financing) {
				// this.imgList = this.financing.projectImage.split(';')
				// console.log(this.imgList)
				let item = this.financing.contactId
				console.log("111s")
				const res = await this.$myRequest({
					url: '/contact/info/' + item,
					/* data: {
						policyId: item
					}, */
					header: {
						'content-type': 'application/x-www-form-urlencoded'
					}
				});
				console.log(res)
				this.contact = res.data.contact
			}


		}
	}
</script>

<style scoped lang="scss">
	.mainclass {
		background-color: #F2F2F2;
		height: 100%;
		padding-bottom: 54px;
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
