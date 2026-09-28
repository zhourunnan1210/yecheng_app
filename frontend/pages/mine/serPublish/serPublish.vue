<template>
	<view>
			
		<view class="box" v-for="(item,i) in SPList" @click="getSPDesc(item.serviceProductId)">
			<u-row>
				<u-col span="4">
					<view class="iconbox">
		
						<img :src="item.image"></img>
		
					</view>
				</u-col>
				<u-col span="8">
					<view class="textbox">{{item.title}}
					</view>
					<view class="notebox u-line-2">服务类型：{{item.serviceType}}</view>
					<view class="notebox u-line-2">发布时间：{{item.publishTime}}</view>
				
				</u-col>
			</u-row>
		
		</view>
		
	</view>
</template>

<script>
	export default {
		data() {
			return {

				gid: 1,
				type: '',
				SPList:[],
			}
		},
		methods: {
			
			
			//获取服务产品列表
			async getSPList() {
				const res = await this.$myRequest({
					url: '/serviceproduct/getlist/' + this.gid,
					method: 'GET',
				});
				// console.log(res)
				this.SPList = res.data.data
				for(let i=0;i<this.SPList.length;i++) {
					let image = this.SPList[i].image.split(';')[0]
					this.SPList[i].image = image
				}
			},
			
			// tab栏切换
			tebchange(index) {
				this.swiperCurrent = index;
				
			},
			
			transition({
				detail: {
					dx
				}
			}) {
				this.$refs.tabs.setDx(dx);
			},
			animationfinish({
				detail: {
					current
				}
			}) {
				this.$refs.tabs.setFinishCurrent(current);
				this.swiperCurrent = current;
				this.current = current;
			},
			getSPDesc(item) {
				uni.navigateTo({
					url: '/pages/detail/service/servicePro/servicePro?item=' + item
				});
			
			}
		},
		onLoad(options) {
			// this.gid = this.$store.state.userInfo.gid
			this.type = this.$store.state.userInfo.type
			this.getSPList()
		},
		
	}
</script>

<style lang="scss" scoped>
	.box {
		border-bottom: 1px solid;
		border-color: #e6e6e6;
		height: 200rpx;
		background: #FFFFFF;
	
	
		.iconbox img {
			margin-left: 40rpx;
			margin-top: 28rpx;
			width: 80px;
			height: 80px;
	
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
