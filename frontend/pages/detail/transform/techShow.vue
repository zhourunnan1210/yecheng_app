<template>
	<view class="content">
		<view class="icons">
			<view class="icon-box" v-for="(item,index) in iconList" :key="index">
				<image :src="item.imgsrc" class="icon"></image>
				<view class="name">{{item.name}}</view>
			</view>
		</view>
	</view>
</template>

<script>
export default{
	data(){
		return {
			iconList:[{
				imgsrc: '/static/font/manage.png',
				name: '农业',
			},{
				imgsrc: '/static/font/manage.png',
				name: '互联网+',
			},{
				imgsrc: '/static/font/manage.png',
				name: '生物医药',
			},{
				imgsrc: '/static/font/manage.png',
				name: '新材料',
			},{
				imgsrc: '/static/font/manage.png',
				name: '智能设备',
			},{
				imgsrc: '/static/font/manage.png',
				name: '新能源',
			}]
		}
	}
}
</script>

<style lang="scss" scoped>
.content {
	width: 100vw;
	height: 100vh;
	padding: 20rpx 30rpx;
	background-color: #f3f4f6;
	.icons{
			display: flex;
			height: 200rpx;
			justify-content: center;
			align-items: center;
			flex-wrap: wrap;
			.icon-box{
				flex: 30%;
				height: 200rpx;
				background: -webkit-linear-gradient(left top,  #f3f4f6, lightblue);
				margin: 10rpx 10rpx;
				.icon {
					left: 50%;
					transform: translateX(-50%);
					height: 100rpx;
					width: 100rpx;
					margin-top: 20rpx;
					border-radius: 50rpx;
					background-color: #fff;
				}
				.name{
					font-weight: 550;
					text-align: center;
					padding-top: 10rpx;
				}
			}
		}
}
</style>