<template>
	<view class="mainclass">

    <u-grid :col="1">
			<u-grid-item>
				<u-image width="150px" height="150px" :src="DataInside.image"></u-image>
			</u-grid-item>
		</u-grid>

		<u-row>
			{{DataInside.name}}
		</u-row>
		<u-row>
			<u-col span="12">
				<view class="title">
					求职意向
				</view>
				<u-col span="12">
					<view class="text">学历：
						<text class="u-main-color">
							{{degreelist[DataInside.degree]}}
						</text>
					</view>
				</u-col>
				<u-col span="12">
					<view class="text">期望职业：
						<text class="u-main-color">
							{{DataInside.profession}}
						</text>
					</view>
				</u-col>
				<u-col span="12">
					<view class="text">期望薪资：
						<text class="u-main-color">
							{{DataInside.salaryMin}}k-{{DataInside.salaryMax}}k
						</text>
					</view>
				</u-col>
        <u-col span="12">
        	<view class="text">毕业院校：
        		<text class="u-main-color">
        			{{DataInside.school}}
        		</text>
        	</view>
        </u-col>
			</u-col>
		</u-row>
		<u-row>
			<u-col span="12">
				<view class="title">
					联系方式
				</view>
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
			</u-col>
		</u-row>
    <u-row>
      <view class="title">
      	个人经历
      </view>
    	<u-col span="12">
    		<view class="text">专业技能：
    			<text class="u-main-color">
    				{{DataInside.skill}}
    			</text>
    		</view>
    	</u-col>
      <u-col span="12">
      	<view class="text">专业技能：
      		<text class="u-main-color">
      			{{DataInside.quality}}
      		</text>
      	</view>
      </u-col>
    </u-row>
		<view class="u-margin-30"></view>
			<u-button @click="submit" type="primary" :ripple="true">同意面试</u-button>
		</view>
	</view>


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
				url: '/talentSupply/getById/'+ id,
				header: {
					'content-type': 'application/x-www-form-urlencoded'
				}
			});
			console.log(res.data.data)
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
