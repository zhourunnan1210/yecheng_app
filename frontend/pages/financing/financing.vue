<template>
 <view class="mainbox">

	<view class="imagebox">
			<u-swiper class="swiper"
						:list="list1"
						@change="change"
						@click="click"
				></u-swiper>
				
	</view>
	
		<view class="grid">
		  <u-grid :col="4">
		   <u-grid-item @click="clickitem" index="/auth/business/business">
			<image src="../../static/font/qiyezhuce.png" class="icon"></image>
			<view class="grid-text">企业注册</view>
		   </u-grid-item>
		   <u-grid-item @click="clickitem" index="/add/financingProduct/financingProduct">
				<image src="../../static/font/chanpinfabu.png" class="icon"></image>
				<view class="grid-text">产品发布</view>
		   </u-grid-item>
		  <u-grid-item @click="clickitem" index="/add/financing/financing">
			<image src="../../static/font/woyaotourongzi.png" class="icon"></image>
			<view class="grid-text">投融资意向</view>
		   </u-grid-item>
		   <u-grid-item @click="clickitem" index="/finance/cridit inquiry">
		   			<image src="../../static/font/qiyexinyongchaxun.png" class="icon"></image>
		   			<view class="grid-text">企业信用查询</view>
		    </u-grid-item>
		  </u-grid>
		  <u-grid :col="4">
		   <u-grid-item @click="clickitem" index="/finance/financingFirm">
		   				<image src="../../static/font/shenhe.png" class="icon"></image>
		   				<view class="grid-text">投融资审核</view>
					</u-grid-item>
		   <u-grid-item @click="clickitem" index="/finance/financingProduct">
				<image src="../../static/font/touzichanpin.png" class="icon"></image>
				<view class="grid-text">金融产品</view>
		   </u-grid-item>
				<u-grid-item @click="clickitem" index="/finance/finance">
							<image src="../../static/font/tourongzi.png" class="icon"></image>
							<view class="grid-text">投融资需求</view>
		   </u-grid-item>
		   <u-grid-item @click="clickitem" index="/finance/project inquiry">
		   			<image src="../../static/font/xiangmuchaxun.png" class="icon"></image>
		   			<view class="grid-text">项目申请</view>
		    </u-grid-item>
		  </u-grid>
		</view>
	<view class="box">
		<view class="header">
			<text class="title">成功融资项目</text>
			<text class="subTitle">部分成功案例展示</text>
			<text class="subTitle1" @click="jumpTorong">更多</text>
		</view>
		<view class="main" >
			<view class="item">
				<u-row>
					<u-col span="6" v-for="(item,i) in TAlist" @click="getTAlistDesc(item.projectId)">
						<view class="iconbox">
							<img :src="item.projectImage" mode="aspectFit" style="width: 200rpx; height: 140rpx;"></img>
						</view>
						<view class="detail">{{item.projectName}}</view>
					</u-col>
					
				</u-row>
				
				
			</view>
		</view>
	</view>
	<view class="box">
		<view class="header">
			<text class="title">成功投资项目</text>
			<text class="subTitle">部分成功案例展示</text>
			<text class="subTitle1" @click="jumpTotou">更多</text>
		</view>
		<view class="main" >
			<view class="item">
				<u-row>
					<u-col span="6" v-for="(item,i) in TBlist" @click="getTBlistDesc(item.projectId)">
					<view class="iconbox">
						<img :src="item.projectImage" mode="aspectFit" style="width: 200rpx; height: 140rpx;"></img>
					</view>
					<view class="detail">{{item.projectName}}</view>
					</u-col>
					
				</u-row>
				
				
			</view>
		</view>
		
	</view>
	<u-tabbar :list="tabbar" active-color="#1296db" height="110"></u-tabbar>
 </view>
</template>
<script>
	import global from '../../store/global.js';
	import {
		mapState,
		mapMutations
	} from 'vuex';
	export default {
		computed:{
			...mapState({
				type: state => state.userInfo.type,
				isLogin: state => state.isLogin,
			})
		},
		watch:{
			isLogin: function(value) {
				uni.switchTab({
					url:'../mine/mine'
				})
			}
		},
		data() {
			return{
				
				list1: [
				                    // 'https://cdn.uviewui.com/uview/swiper/swiper1.png',
				                    // 'https://cdn.uviewui.com/uview/swiper/swiper2.png',
				                    // 'https://cdn.uviewui.com/uview/swiper/swiper3.png',
									"/static/pic3.png",
									 "/static/pic1.png",
									 "/static/pic2.png",
									
				                ],
				questionList:[],
				tabbar: [],
				TAlist: [],
				TBlist: [],
				
			
			}
			
			
		},
		onLoad() {
			if (this.isLogin == false) {
				// uni.showToast({
				// 	icon:'error',
				// 	title: '请先登录',
				// });
				// setTimeout(() => {
				// uni.hideToast();
				// //关闭提示后跳转
				// uni.redirectTo({
				// 	url:'../user/login/login'
				// })
				// }, 1500)
				uni.redirectTo({
					url:'../user/login/login'
				})
			}
			this.tabbar = global.tabbar
			this.getTAlist()
			this.getTBlist()
		},
		methods: {
			async getTAlist() {
			
				const res = await this.$myRequest({
					url: '/investFinancialProj/getSuccessList4',
					method: 'POST',
					header: {
						'content-type': 'application/json'
					},
					data: {
						// "duration": this.publishTime,
						// "field": this.field,
						// "financingMoney": this.financingMoney
						
					}
				});
				console.log(res.data,'565656')
				this.TAlist = res.data.data
				// this.TAlist.forEach(item => {
				// 	if (!item.image) {
				// 		item.image = this.DEFAULT_IMAGE
				// 	}
				// })
				
					
			},
			async getTBlist() {
			
				const res = await this.$myRequest({
					url: '/investFinancialProj/getSuccessList2',
					method: 'POST',
					header: {
						'content-type': 'application/json'
					},
					data: {
						// "duration": this.publishTime,
						// "field": this.field,
						// "financingMoney": this.financingMoney
						
					}
				});
				console.log(res.data,'111111')
				this.TBlist = res.data.data
				// this.TBlist.forEach(item => {
				// 	if (!item.image) {
				// 		item.image = this.DEFAULT_IMAGE
				// 	}
				// })
				
					
			},
			async getTAlistDesc(item) {
				uni.navigateTo({
					url:  '/pages/detail/financing/financingNeed/financingNeed?item=' + JSON.stringify(item),
				});
			
			},
			async getTBlistDesc(item) {
				uni.navigateTo({
					url:   '/pages/detail/financing/financingInst/financingInst?item=' + JSON.stringify(item),
				});
			
			},
			clickitem(index) {		
				//在这里对角色的type进行判断
				//并限制其能进入的页面
				if(	index=="/add/financingProduct/financingProduct" || 
					index=="/add/financing/financing" ||
					index=="/finance/financingFirm" ||
					index=="/finance/project inquiry"
				){
					//产品发布 投融资意向 投融资审核 投融资申请
					if(this.type == 1 || this.type == 4 || this.type == 6){
						uni.navigateTo({
							url: "/pages" + index,
						
						});
					}else{
						uni.showToast({
							icon:"error",
							title:"您没有权限！"
						})
					}
				}else{
					uni.navigateTo({
						url: "/pages" + index,
					
					});
				}
			},
			jumpTorong() {
				uni.navigateTo({
					url: '/pages/detail/financing/successrongzi'
				});
			},
			jumpTotou() {
				uni.navigateTo({
					url: '/pages/detail/financing/successtouzi'
				});
			},
		}
	}
</script>
<style lang="scss" scoped>
	
	.mainbox{
		height: 100%;
		background-color: #E9E9EB;
		padding: 20rpx,30rpx;
			.grid{
				// margin-bottom: 20rpx;
				// padding-bottom: 10rpx;
				margin-top: 25rpx;
				margin: 15rpx;
			}
			.swiper{
				padding: 20rpx;
			}
			
			.grid-text {
				font-size: 28rpx;
				margin-top: 4rpx;
				// color: $u-type-info;
				color:$uni-color-title;
			}
			
			.icon {
			  height: 65rpx;
			  width: 65rpx;
			}
			.title{
				font-size:38rpx ;
			}
			// .box {
				
			// 	height: 84%;
			// }
			
			.imagebox{
				// background-color: #999999;
				width: 100%;
				height: 300rpx;
			}
			
			.content{
				font-size: 15rpx;
				color: #ADAFB3;
			}
			.box {
				margin-top: 30rpx;
				margin-left:15rpx;
				margin-right: 15rpx;
				background-color: #fff;
				border-radius: 15rpx;
				.header {
					height: 80rpx;
					line-height: 80rpx;
					border-bottom: 1rpx solid #ccc;
					.title {
						margin-left: 20rpx;
						font-size: 32rpx;
					}
					.subTitle {
						font-size: 30rpx;
						color: #c4c6c9;
						margin-left: 20rpx;
					}
					.subTitle1 {
						font-size: 30rpx;
						color: #c4c6c9;
						margin-left: 120rpx;
					}
					
				}
				.main {
					.item {
						height: auto;
						margin-top: 20rpx;
						padding: 20rpx;
						border-bottom: 2rpx solid #f3f4f6;
						.iconbox {
							text-align: center;
							margin-bottom: 16rpx;
						}
						.detail {
							text-align: center;
							font-size: 26rpx;
							color: #333;
							line-height: 1.4;
							word-break: break-all;
						}
						.descript {
							height: 60rpx;
						}
					}
					// .item:last-child {
					// 	border: none;
					// }
				}
			}
	
	
	// .message-box{
	// 	padding-bottom: 10rpx;
	// }
	
	
}	
	
</style>