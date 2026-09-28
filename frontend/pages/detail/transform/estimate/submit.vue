<template>
	<view class="content">
		<image :src="imgsrc" class="img"></image>
		<view class="mes">您的申请已成功提交，审核完毕后</br>请在<text @click="jump">我的申请</text>查看完整评估报告</view>
	</view>
</template>

<script>
export default {
	data() {
		return {
			imgsrc:'/static/submit.png'
		}
	},
	methods:{
		jump() {
			uni.navigateTo({
				url:'/pages/detail/transform/estimate/estimate'
			})
		}
	}
}
</script>

<style lang="scss" scoped>
.content {
	.img {
		width: 200rpx;
		height: 200rpx;
		margin-left: 260rpx;
	}
	.mes {
		margin: 20rpx 100rpx;
		font-size: 35rpx;
		text {
			color: blue;
		}
	}
}
</style>