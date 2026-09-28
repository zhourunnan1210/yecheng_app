<template>
	<view class="content">
		<view class="imgbox">
			<img :src="imgsrc" alt="">
		</view>
		<view class="main">
			<u-input 
				class="input" 
				v-model="info1" 
				height="90" 
				border="surround"
				placeholder="请输入需求描述"
				placeholder-style="font-size:34rpx;" 
				clearable></u-input>
			<u-input 
				class="input" 
				v-model="info2" 
				height="90" 
				border="surround"
				placeholder="请输入需求类型"
				placeholder-style="font-size:34rpx;" 
				clearable></u-input>
			<!-- <u-input
				class="input" 
				v-model="info2" 
				height="90" 
				border="surround"
				placeholder="请输入验证码"
				placeholder-style="font-size:34rpx;" 
				clearable>
			</u-input> -->
			<u-button class="button">快速匹配</u-button>
		</view>
	</view>
</template>

<script>
export default {
	data() {
		return {
			imgsrc: 'static/pic1.png',
			info1: '',
			info2: ''
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
	.input {
		background-color: #f3f4f6;
		border-radius: 10rpx;
		margin: 30rpx 60rpx;
		font-size: 35rpx!important;
	}
	.button {
		background-color: #f4f4f5;
		font-size: 35rpx;
		width: 300rpx;
		margin: 40rpx auto;
	}
}
</style>
