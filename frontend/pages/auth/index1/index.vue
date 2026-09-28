<template>
	<view class="page">
		<view class="container" style="margin-top: 15upx;">
			<navigator url="../service/service">
			<view class="shape container1">
				<image class="icon" src="../../../static/templateHL.png"></image>	
				<view class="container2">
					<text style="font-weight: 700">实名认证服务机构</text>
					<text style="font-size: 12px">融入创新创业，对接技术成果，政策兑现申请。</text>
				</view>
				<view>
					<text style="color: #4CD964;">去认证</text>
					<text>></text>
				</view>
			</view>
			</navigator>
			<navigator url="../company/company">
			<view class="shape container1">
				<image class="icon item" src="../../../static/templateHL.png"></image>	
				<view class="container2">
					<text style="font-weight: 700">实名认证企业</text>
					<text style="font-size: 12px">发布服务信息，对接优质客户，推动创新创业。</text>
				</view>
				<view>
					<text style="color: #F0AD4E;">去认证</text>
					<text>></text>
				</view>
			</view>
			</navigator>
			<navigator url="../technology/technology">
			<view class="shape container1">
				<image class="icon" src="../../../static/templateHL.png"></image>	
				<view class="container2">
					<text style="font-weight: 700">实名认证科技主管部门</text>
					<text style="font-size: 12px">发布技术供需，申请政策补助，对接优势资源。</text>
				</view>
				<view>
					<text style="color: #0000FF;">去认证</text>
					<text>></text>
				</view>
			</view>
			</navigator>
			<navigator url="../finance/finance">
			<view class="shape container1">
				<image class="icon" src="../../../static/templateHL.png"></image>	
				<view class="container2">
					<text style="font-weight: 700">实名认证金融机构</text>
					<text style="font-size: 12px">发布服务信息，对接优质客户，推动创新创业。</text>
				</view>
				<view>
					<text style="color: #007AFF;">去认证</text>
					<text>></text>
				</view>
			</view>
			</navigator>
			<navigator url="../colleges/colleges">
			<view class="shape container1">
				<image class="icon" src="../../../static/templateHL.png"></image>	
				<view class="container2">
					<text style="font-weight: 700">实名认证高校</text>
					<text style="font-size: 12px">发布科技成果，对接企业资源，促进成果转化。</text>
				</view>
				<view>
					<text style="color: #00cccc;">去认证</text>
					<text>></text>
				</view>
			</view>
			</navigator>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				
			}
		},
		methods: {
			
		}
	}
</script>

<style>
	.container{
		height: 690upx ;
		display: flex;
		justify-content: space-between;
		flex-direction: column;
	}
	.container1{
		display:flex;
		align-items:center;
		justify-content:space-around;
	}
	.container2{
		height: 120upx;
		display: flex;
		justify-content: space-around;
		flex-direction: column;
	}
	.shape{
		height: 120upx;
		background-color:#FFFFFF;
	}
	
	.icon {
		width: 12vw;
		height: 12vw;
	}
</style>
