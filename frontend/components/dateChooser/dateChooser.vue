<template>
	<view>
		<view class="uni-padding-wrap">
			<view class="uni-title" @tap="date">
				日期：{{nian}}年{{yue}}月{{ri}}日
			</view>
		</view>

		<uni-popup ref="wenzi" type="bottom" :maskClick=false>
			
			<view class="date-select">
				<view style="display: flex;height: 150upx;justify-content: space-around;
				flex-direction: row; align-items: center;">
					<view class="btn-left" @tap="concel">
						取消
					</view>
					<view class="btn-right" @tap="confirm">
						确定
					</view>
				</view>
				<picker-view class="picker-view" v-if="visible" :indicator-style="indicatorStyle" :value="value" @change="bindChange">
					<picker-view-column>
						<view class="item" v-for="(item,index) in years" :key="index">{{item}}年</view>
					</picker-view-column>
					<picker-view-column>
						<view class="item" v-for="(item,index) in months" :key="index">{{item}}月</view>
					</picker-view-column>
					<picker-view-column>
						<view class="item" v-for="(item,index) in days" :key="index">{{item}}日</view>
					</picker-view-column>
				</picker-view>
			</view>

		</uni-popup>


	</view>
</template>

<script>
	import uniPopup from '../../components/uni-popup/uni-popup.vue'
	export default {
		data() {
			const date = new Date()
			const years = []
			const year = date.getFullYear()
			const months = []
			const month = date.getMonth() + 1
			const days = []
			const day = date.getDate()

			for (let i = 2020; i <= date.getFullYear(); i++) {
				years.push(i)
			}

			for (let i = 1; i <= 12; i++) {
				months.push(i)
			}

			for (let i = 1; i <= 31; i++) {
				days.push(i)
			}
			return {
				title: 'picker-view',
				years,
				year,
				months,
				month,
				days,
				day,
				value: [0, month - 1, day - 1],
				/**
				 * 解决动态设置indicator-style不生效的问题
				 */
				visible: true,
				indicatorStyle: `height: ${Math.round(uni.getSystemInfoSync().screenWidth/(750/100))}px;`,
				nian:'',
				yue:'',
				ri:''
			}
		},
		methods: {
			bindChange(e) {
				let a;
				let y;
				console.log(e);
				let val = e.detail.value;
				y = this.years[val[0]];
				a = this.months[val[1]];
				this.day = this.days[val[2]];
				this.month = a;
				this.year = y;
				this.days = [];
				if (a||y) {
					if (a == 1 || a == 3 || a == 5 || a == 7 || a == 8 || a == 10 || a == 12) {
						for (let i = 1; i <= 31; i++) {
							this.days.push(i)
						}
					} else if (a == 4 || a == 6 || a == 11 || a == 9) {
						for (let i = 1; i <= 30; i++) {
							this.days.push(i)
						}
						
					} else if (a == 2) {
						if (this.year % 4 == 0 && (this.year % 100 != 0 || this.year % 400 == 0)) {
							for (let i = 1; i <= 29; i++) {
								this.days.push(i)
							}
						} else {
							for (let i = 1; i <= 28; i++) {
								this.days.push(i)
							}
						}
					}
				
				}
			},
			date(e) {
				console.log(e);
				this.$refs.wenzi.open();
				console.log();
			},
			concel(){
				this.$refs.wenzi.close();
			},
			confirm(){
				this.nian =this.year;
				this.yue = this.month;
				this.ri=this.day;
				this.$refs.wenzi.close();
			}
		}
	}
</script>

<style scoped lang="scss">
	// picker-view {
	// 	position: absolute;
	// 	width: 100%;
	// 	height: 500upx;
	// 	bottom: 20upx;
	// }

	

	.date-select {
		width: 100%;
		height: 700upx;
		border-top-left-radius: 40upx;
		border-top-right-radius: 40upx;
		background-color: #FFFFFF;
		position: relative;
		.picker-view {
			background-color: #EEEEEE;
			position: absolute;
			width: 100%;
			height: 500upx;
			bottom: 20upx;
			.item {
				line-height: 100rpx;
				font-size: 34upx;
				text-align: center;
			}
		}
		
				.btn-left,.btn-right{
					color: #FFFFFF;
					width: 150upx;
					height: 90upx;
					line-height: 90upx;
					text-align: center;
					// border: 1upx solid #BEBEBE;
					border-radius: 15upx;
				}
				.btn-left{
					background-color: #BEBEBE;
				}
				.btn-right{
					background-color: #1cb419;
				}

	}
	
</style>
