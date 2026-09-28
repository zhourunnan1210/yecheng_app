<template>
	<view class="mainclass">

<u-grid :col="1">
			<u-grid-item>
				<u-image width="550px" height="150px" :src="DataInside.image"></u-image>
			</u-grid-item>
		</u-grid>
    
		<u-row>
			{{DataInside.businessInfoEntity.name}}
		</u-row>
		<u-row>
			<u-col span="12">
				<view class="title">
					能力需求
				</view>
				<text decode class="u-content-color u-m-r-20 u-m-l-20 u-m-t-80 u-font-28 textbox">{{DataInside.demand}}
				</text>
			</u-col>
		</u-row>
		<u-row>
			<u-col span="12">
				<view class="title">
					工作职责
				</view>
				<text decode class="u-content-color u-m-r-20 u-m-l-20 u-m-t-80 u-font-28 textbox u-m-b-30">{{DataInside.job}}
				</text>
			</u-col>
		</u-row>
    <u-row>
      <view class="title">
      	公司信息
      </view>
    	<u-col span="12">
    		<view class="text">网址：
    			<text class="u-main-color">
    				{{DataInside.netAddress}}
    			</text>
    		</view>
    	</u-col>
    	<u-col span="12">
    		<view class="text">联系电话：
    			<text class="u-main-color">
    				{{DataInside.phone}}
    			</text>
    		</view>
    	</u-col>
      <u-col span="12">
      	<view class="text">邮箱：
      		<text class="u-main-color">
      			{{DataInside.email}}
      		</text>
      	</view>
      </u-col>
    </u-row>
		<que-button @clicked="clicked()"></que-button>
	</view>


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
			console.log('岗位表序号',id)
			const res = await this.$myRequest({
				url: '/talentNeed/get/'+ id,
				header: {
					'content-type': 'application/x-www-form-urlencoded'
				}
			});
			this.DataInside = res.data.data
		}
		}
</script>

<style scoped lang="scss">
	.mainclass {
		background-color: #F2F2F2;
		height: 100%;
		padding-bottom: 54px;
	}

	.u-row {
		margin-top: 20rpx;
		background: #FFFFFF;
		font-size: 18px;
		padding: 20px;
		color: #000000;
		letter-spacing: 2px;

	}

	.text {
		font-size: 14px;
		color: #949494;
		line-height: 2;

	}

	.title {
		font-size: 28rpx;
		position: relative;
		line-height: 1;
		padding-left: 20rpx;
		font-weight: 900;
		margin-bottom: 20px;
		color: $uni-color-title;

		&:before {
			width: 4px;
			height: 16px;
			border-radius: 100rpx;
			background-color: $uni-color-primary;
			content: '';
			position: absolute;
			left: 1rpx;
			top: -1px;
		}
	}
</style>
