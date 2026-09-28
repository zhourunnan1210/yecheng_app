<template>
	<view class="content">
		<image :src="imgsrc" class="img"></image>
		<view class="mes">您的申请已成功提交管理员审核，</br>请在<text @click="jumpToMyPublish">我的发布</text>查看发布状态</view>
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
		jumpToMyPublish() {
			uni.navigateTo({
				url:'/pages/detail/transform/publish/myPublish'
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