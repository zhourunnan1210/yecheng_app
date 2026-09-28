<template>

	<view class="content">
		<view class="search">
			<u-search placeholder="请输入投资项目名称" v-model="keyword" shape="square" :show-action="false"></u-search>
		</view>
		<view class="Button">
			<u-button @click="inquiry()" type="primary" :ripple="true" size="medium">查询</u-button>
		</view>
		<view class="result">
			<view class="box" v-for="(item,i) in TAList" @click="getTBlistDesc(item.investNeedId)">
				<u-row>
					<u-col span="4">
						<u-image width="100px" height="100px" :src="checkImage(item.investImag)"></u-image>
					</u-col>
					<u-col span="8">
						<view class="textbox1 u-line-1">{{item.companyName}}
						</view>
						<view class="text">联系人：
							<text class="u-main-color">
								{{item.contactName}}
							</text>
						</view>
						<view class="text">联系人电话：
							<text class="u-main-color">
								{{item.contactPhone}}
							</text>
						</view>
					</u-col>
				</u-row>

			</view>

		</view>
	</view>
</template>

<script>
	import { needDefaultImage, isStaleOssUrl } from '../../utils/imageUrl.js'
	export default {
		data() {
			return {
				DEFAULT_IMAGE: '/static/defaultImage/1.png',
				keyword: '',
				TAList: []
			}
		},
		onLoad() {
			this.allquiry()
		},
		methods: {
			async allquiry() {
				const res = await this.$myRequest({
					url: '/investingneed/getList/',
					method: 'GET',
					header: {
						'content-type': 'application/json'
					},
					data: {}
				});
				console.log(res, '111111')
				if (res.data.data.length == 0) {
					return uni.showToast({
						title: '无投资项目',
						icon: 'none'
					})
				}
				this.TAList = res.data.data
			},
			async getTBlistDesc(item) {
				uni.navigateTo({
					url: '/pages/finance/investTable?item=' + JSON.stringify(item),
				});
			
			},
			async inquiry() {
				const res = await this.$myRequest({
					url: '/investingneed/getListByCompanyName/' + this.keyword,
					method: 'POST',
					header: {
						'content-type': 'application/json'
					},
					data: {}
				});
				console.log(res, '111111')
				if (res.data.data.length == 0) {
					// console.log(666666)
					return uni.showToast({
						title: '未查询到该投资',
						icon: 'none'
					})
				}
				this.TAList = res.data.data;
			}
			,
			checkImage(url) {
				if (needDefaultImage(url)
					|| url.trim() === '') {
					return this.DEFAULT_IMAGE
				}
				return url
			}
		},
	}	
		
</script>

<style>
	.content {

		margin-top: 100rpx;

	}

	.search {

		margin-top: 50rpx;
		margin-left: 15rpx;
		margin-right: 15rpx;


	}

	.Button {
		margin-left: 300rpx;
		margin-top: 30rpx;
	}

	.box {}

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
</style>