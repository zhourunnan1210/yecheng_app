<template>
	<view class="content">
		<view class="box" v-for="(item,i) in PList" @click="getPDesc(item.parkId)">
			<u-row>
				<u-col span="4">
					<view class="iconbox">
						<image :src="item.avatar" lazy-load> </image>
						<!-- 	<u-lazy-load  :image="item.avatar" height="100"></u-lazy-load> -->
					</view>
				</u-col>
				<u-col span="8">
					<view class="textbox">{{item.parkName}}
					</view>
					<view class="notebox u-line-1">联系电话：{{item.parkPhone}}</view>
					<view class="notebox u-line-1">园区官网：{{item.parkWebsite}}</view>
				</u-col>
			</u-row>
		</view>
		<u-tabbar :list="tabbar" active-color="#1296db" height="110"></u-tabbar>

	</view>
</template>

<script>
	import global from '../../store/global.js';
	export default {
		data() {
			return {
				tabbar: [],
				PList: [],
			};
		},
		onLoad() {
			this.tabbar = global.tabbar;
			this.getParkList();
		},
		methods: {
			async getParkList() {
				try {
					const res = await this.$myRequest({
						url: "/park/getlist"
					})
					if (res.data.code == 0) {
						this.PList = res.data.data
					}
					console.log(res)
				} catch (e) {
					console.error('获取园区列表失败:', e)
				}
			},
			getPDesc(item) {
				uni.navigateTo({
					url: './parkDesc/parkDesc?item=' + item,
				});
			}
		}
	}
</script>

<style lang="scss" scoped>
	.box {
		border-bottom: 1px solid;
		border-color: #e6e6e6;
		height: 200rpx;
		background: #FFFFFF;


		.iconbox image {
			margin-left: 40rpx;
			margin-top: 19rpx;
			width: 80px;
			height: 80px;
			border-radius: 10px;

		}


		.textbox {
			margin: 0 10rpx 5rpx 10rpx;
			padding: 10rpx 10rpx 5rpx 10rpx;
			font-weight: 500;
			color: #000000;
			line-height: 1.2;
			font-size: 28rpx;
		}

		.notebox {

			padding: 0 20rpx;
			font-size: 12px;
			color: #949494;
			line-height: 1.5;
		}
	}
</style>
