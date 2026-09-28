<template>
	<view class="resume" style="background-color: #ffffff">
		
		<view class="resumephoto">
			<view class="photo">
				<image :src="DataInside.image" lazy-load ></image>
			</view>	
		</view>
		
		<view class="resumename">{{DataInside.companyId}}</view>
		
		<view class="self">
			<view class="self_list">{{DataInside.title1}}</view>
			<view class="self_list">{{DataInside.title2}}</view>
			<view class="self_list">{{DataInside.title3}}</view>
		</view>
		
		<view class="resumelist">
			<view class="title" >能力需求
			
			<view style="width: 100%;height: 5rpx; background-color: #000000;"></view>
				<view class="titie_list"> {{DataInside.demand}}</view>
			</view>
				
			
			<view class="title" >工作职责
			<view style="width: 100%;height: 5rpx; background-color: #000000;"></view>
			<view class="titie_list">{{DataInside.job}}</view>
			</view>
			
			
			<view class="title" style="padding-bottom: 80rpx;">公司信息
			<view style="width: 100%;height: 5rpx; background-color: #000000;"></view>
				<view class="titie_list">网址:{{DataInside.netAddress}}</view>
				<view class="titie_list">联系电话:{{DataInside.phone}}</view>
				<view class="titie_list">邮箱:{{DataInside.email}}</view>	
			</view>
		</view>
	
		<view class="Buttonflex" >
		<!-- 	<button class="Button" ><uni-icons class="icons"  type="phone" ></uni-icons>电话</button>
			<button class="Button" ><uni-icons class="icons" type="star"></uni-icons>收藏</button> -->
		</view>

	</view >	
</template>

<script>
	export default {
		data() {
			return {
				name:"海天考研",
				education:"本科",
				jobtime:"全职",
				SelfList:["百强企业","凝聚力强","五险一金"],
				DataInside:'',
			}
		},

		onLoad:  async function(options) { //option为object类型，会序列化上个页面传递的参数
			var arr = [];
			 for (let i in options){
			      arr.push(options[i])
			    }
		
			const id = arr[0];  
			const res = await this.$myRequest({
				url: '/talentneed/get/'+ id,
				header: {
					'content-type': 'application/x-www-form-urlencoded'
				}
			});
			this.DataInside = res.data.data
		}
		}
</script>

<style scoped lang="scss">
	.resumephoto{
		width: 100%;
		height: 100%;
		display: flex;
		justify-content: center;	
		.photo image{
			width: 80px;
			height: 80px;
			border-radius: 100%;
			padding: 10px;
			align-items: center;
			background-color: #ffe9ea;
			}

	}
	.resumename{
		display: flex;
		justify-content: center;
		font-size:40rpx ;
		font-weight:400rpx;
	}
	.self{
		display: flex;
		height: auto;
		width: auto;
		justify-content: center;
		.self_list{
			padding:5rpx 10rpx;
			background-color: #e5e572;
			font-size: 30rpx;
			margin: 20rpx;
		}
	}
	.resumelist{
		font-size: 35rpx;
		font-weight: bold;
		padding :9rpx 0rpx;
		.title{
			color: #007AFF;
			padding:15rpx 10rpx;
			background-color: #ffffff;
			margin-top: 10rpx;
		}
		.titie_list{
			background-color: #ffffff;
			font-size: 30rpx;
			padding: 5rpx 30rpx;
			color: #000000;
		}
	}
	.Buttonflex{
		display: flex;
		align-items: center;
		bottom:0; 	
		position:fixed absolute;
		justify-content: center;

		.Button{
			background-color: #aaffff;
			width:200rpx;
			height:auto;
			.icons{
				size: 90rpx;
			}
		}
	}
</style>
