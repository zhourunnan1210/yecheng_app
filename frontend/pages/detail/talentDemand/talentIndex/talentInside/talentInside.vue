<template>
	<view class="resume" tyle="background-color: #ffffff">
		<!-- <view v-for="(item,index) in DataInside"> -->
			<view class="resumephoto">
				<view class="photo">
					<image :src="DataInside.image" lazy-load ></image>
				</view>	
			</view>
			<view class="resumename">{{DataInside.name}}</view>
			<view class="self">
				<view class="self_list">{{DataInside.age}}岁</view>
				<view class="self_list">{{DataInside.job}}</view>
				<view class="self_list">{{JobState[DataInside.jobStatus]}}</view>
			</view>
			<view class="resumelist">
				<view class="title" >求职意向
				<view style="width: 100%;height: 5rpx; background-color: #000000;"></view>
					<view class="titie_list">就业状态:  {{State[DataInside.jobStatus]}}</view>
					<view class="titie_list">学历:  {{degreelist[DataInside.degree]}}</view>
					<view class="titie_list">期望职业:   {{DataInside.profession}}</view>
					<view class="titie_list">期望薪资:   {{DataInside.salaryMin}}k-{{DataInside.salaryMax}}k</view>
					<view class="titie_list">毕业院校:   {{DataInside.school}}</view>
				</view>
				
				
				<view class="title" style="padding-bottom: 30rpx;">联系方式
				<view style="width: 100%;height: 5rpx; background-color: #000000;"></view>
					<view class="titie_list">手机号码:{{DataInside.phone}}</view>
					<view class="titie_list">邮箱:{{DataInside.email}}</view>
				</view>				
				
				<view class="title">个人经历
				<view style="width: 100%;height: 5rpx; background-color: #000000;"></view>
					<view class="titie_list" style="padding-bottom: 30rpx;">专业技能: {{DataInside.skill}}</view>
					<view class="titie_list">性格品质:{{DataInside.quality}}</view>
				</view>
				

		</view>
	
		<view class="Buttonflex" >
<!-- 			<button class="Button" ><uni-icons class="icons"  type="phone" ></uni-icons>电话</button>
			<button class="Button" ><uni-icons class="icons" type="pulldown"></uni-icons>下载</button>
			<button class="Button" ><uni-icons class="icons" type="star"></uni-icons>收藏</button> -->
		</view>
	</view >	
</template>

<script>
	export default {
		data() {
			return {
				name:"李四",
				age:"20",
				education:"本科",
				jobtime:"全职",
				DataInside:'',
				State:['已离职','未离职','正在办理离职'],
				JobState:['全职','兼职','实习'],
				degreelist: ['','专科','本科','硕士','博士'],
			}
		},

		onLoad: async function(options) { //option为object类型，会序列化上个页面传递的参数
			var arr = [];
			 for (let i in options){
			      arr.push(options[i])
			    }
		
			const id = arr[0];  
			const res = await this.$myRequest({
				url: '/talentsupply/get/'+ id,
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
