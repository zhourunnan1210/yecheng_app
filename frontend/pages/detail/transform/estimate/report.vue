<template>
	<view class="container">
		<view class="title">成果评估报告</view>
		<view class="main">
			<view class="name">成果名称：<text>高油酸花生规模化种植</text></view>
			<view class="result">评估结果：<text>通过</text></view>
			<view class="way">评估方式：人工评审</view>
			<view class="starttime">委托日期：2020.11.5</view>
			<view class="endtime">完成日期：2021.1.2</view>
		</view>
	</view>
</template>

<script>
</script>

<style lang="scss" scoped>
.container {
	.title {
		height: 100rpx;
		line-height: 100rpx;
		font-size: 43rpx;
		text-align: center;
	}
	.main {
		font-size: 35rpx;
		padding: 0 100rpx;
		.name,.result,.way,.starttime,.endtime {
			height: 70rpx;
			line-height: 70rpx;
		}
	}
}
</style>
