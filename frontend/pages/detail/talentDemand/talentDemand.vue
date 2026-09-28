<template>
	<view class="box">
		<button class="Button" @click="click1">人才端</button>
		<button class="Button" @click="click2">企业端</button>
		<button class="Button" @click="click3">高校端</button>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				
			}
		},
		methods: {
			click1(){		 
				uni.navigateTo({
					url: "/pages/detail/talentDemand/talentIndex/talentIndex",
				});
			},
			click2(){
				uni.navigateTo({
					url: "/pages/detail/talentDemand/businessIndex/businessIndex",
				});
			},
			click3(){
				uni.navigateTo({
					url: "/pages/detail/talentDemand/schoolIndex/schoolIndex",
				});
			}
		}
	}
</script>

<style>
	.box{
		padding: 300rpx 200rpx;
		
	}
	.Button{
		margin: 50rpx;
		display: flex;
		width: 300rpx;
		height: 100rpx;
		padding: 50rpx 50rpx;
		justify-content: center;
		align-items:center;
		background-color: #34b5f0;
	}

</style>
