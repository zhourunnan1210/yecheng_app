<template>
	<view class="content">
		<view class="imgbox">
			<img :src="imgsrc" alt="">
		</view>
		<view class="main">
			<view class="title">实验室简介</view>
			<view class="descript">{{description}}</view>
		</view>
		<u-button class="button">立即咨询</u-button>
	</view>
</template>

<script>
export default {
	data() {
		return {
			imgsrc: 'static/lab.png',
			description: '南海海洋资源利用国家重点实验室（State Key Laboratory of Marine Resource Utilization in South China Sea）是我国第一个针对南海海洋资源进行开发利用和保护研究的国家重点实验室。实验室以推动国家海洋资源利用为己任，聚焦南海海域，开发南海资源，服务国家战略。'
		}
	}
}
</script>

<style lang="scss" scoped>
.content {
	.imgbox {
		padding: 20rpx 60rpx;
		img {
			width: 100%;
			height: 100%;
		}
	}
	.main {
		padding: 10rpx 60rpx;
		.title {
			padding-bottom: 15rpx;
			font-size: 40rpx;
			border-bottom: 1rpx solid #ccc;
		}
		.descript {
			text-indent: 2em;
			padding-top: 15rpx;
			font-size: 30rpx;
		}
	}
	.button {
		background-color: #f4f4f5;
		font-size: 35rpx;
		width: 300rpx;
		margin: 40rpx auto;
	}
}
</style>
