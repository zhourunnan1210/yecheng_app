<template>
	<!-- 宫格组件 -->
	<view class="icon-box">
		<u-grid :col="4">
			<u-grid-item @click="clickitem2" index="/question/questionList/questionList">
				<image src="../../static/font/yijianfabu.png" class="icon"></image>
				<view class="grid-text">有事必应</view>
			</u-grid-item>
			<u-grid-item @click="clickitem2" index="/detail/authHiTech/authHiTech">
				<image src="../../static/font/rending.png" class="icon"></image>
				<view class="grid-text">高企认定</view>
			</u-grid-item>
			<u-grid-item @click="clickitem2" index="/detail/rewordHitech/rewordHitech">
				<image src="../../static/font/jiangli.png" class="icon"></image>
				<view class="grid-text">高企奖励</view>
			</u-grid-item>

			<u-grid-item @click="clickitem2" index="/dataStatistics/dataStatistics">
				<image src="../../static/font/tongji.png" class="icon"></image>
				<view class="grid-text">高企统计</view>
			</u-grid-item>
		</u-grid>
		<u-grid :col="4">
			<u-grid-item @click="clickitem" index="/policy/policy">
				<image src="../../static/font/zhengceshang.png" class="icon"></image>
				<view class="grid-text">政策服务</view>
			</u-grid-item>
			<u-grid-item @click="clickitem2" index="/detail/technology/technology">
				<image src="../../static/font/keji.png" class="icon"></image>
				<view class="grid-text">成果服务</view>
			</u-grid-item>
			<u-grid-item @click="clickitem2" index="/detail/financing/financing">
				<image src="../../static/font/jinrong.png" class="icon"></image>
				<view class="grid-text">科技金融</view>
			</u-grid-item>
			<u-grid-item @click="clickitem2" index="/detail/service/service">
				<image src="../../static/font/xiangmu.png" class="icon"></image>
				<view class="grid-text">科技项目</view>
			</u-grid-item>
		</u-grid>
		<u-grid :col="4">
			<u-grid-item @click="clickitem2" index="/financing/financing">
				<image src="../../static/font/rongzishouyetu.png" class="icon"></image>
				<view class="grid-text">企业投融资</view>
			</u-grid-item>
			<u-grid-item @click="clickitem2" index="/talent/talentindext">
				<image src="../../static/font/cencai.png" class="icon"></image>
				<view class="grid-text">人才供需平台</view>
			</u-grid-item>
			<u-grid-item @click="clickitem2" index="/detail/transform/transform">
				<image src="../../static/font/transform.png" class="icon"></image>
				<view class="grid-text">成果转化</view>
			</u-grid-item>
		</u-grid>
	</view>
</template>

<script>
	export default {
		methods: {
			clickitem(index) {				
				uni.switchTab({
					url: "/pages" + index,
				});
			},
			clickitem2(index) {
				uni.navigateTo({
					url: "/pages" + index,
				});
			},
		}
	}
</script>

<style lang="scss" scoped>
	.grid-text {
		font-size: 28rpx;
		margin-top: 4rpx;
		color: $u-type-info;
	}
	.icon {
	  height: 65rpx;
	  width: 65rpx;
	}
</style>
