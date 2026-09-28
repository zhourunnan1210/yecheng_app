<template>
	<view v-if="showQuality" class="quality-indicator">
		<view class="quality-header">
			<text class="quality-title">推荐质量</text>
			<text class="quality-score">{{ avgScore }}</text>
		</view>
		<view class="quality-stats">
			<text class="stat-item">总数: {{ total }}</text>
			<text class="stat-item">有分数: {{ withScore }}</text>
			<text class="stat-item">匹配率: {{ matchRate }}%</text>
		</view>
		<view class="quality-distribution">
			<view v-for="(count, range) in scoreDistribution" :key="range" class="distribution-bar">
				<text class="range-label">{{ range }}</text>
				<view class="bar-container">
					<view class="bar" :style="{ width: getBarWidth(count) }"></view>
				</view>
				<text class="count-label">{{ count }}</text>
			</view>
		</view>
	</view>
</template>

<script>
	import { getRecommendationStats } from '@/utils/recommendation.js'
	
	export default {
		name: 'RecommendationQuality',
		props: {
			recommendations: {
				type: Array,
				default: () => []
			},
			showQuality: {
				type: Boolean,
				default: true
			}
		},
		computed: {
			stats() {
				return getRecommendationStats(this.recommendations);
			},
			total() {
				return this.stats.total;
			},
			withScore() {
				return this.stats.withScore;
			},
			avgScore() {
				return this.stats.avgScore;
			},
			matchRate() {
				return this.total > 0 ? Math.round((this.withScore / this.total) * 100) : 0;
			},
			scoreDistribution() {
				return this.stats.scoreDistribution;
			}
		},
		methods: {
			getBarWidth(count) {
				const maxCount = Math.max(...Object.values(this.scoreDistribution));
				return maxCount > 0 ? `${(count / maxCount) * 100}%` : '0%';
			}
		}
	}
</script>

<style scoped lang="scss">
	.quality-indicator {
		background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
		border-radius: 12rpx;
		padding: 20rpx;
		margin: 20rpx;
		color: white;
	}
	
	.quality-header {
		display: flex;
		justify-content: space-between;
		align-items: center;
		margin-bottom: 20rpx;
	}
	
	.quality-title {
		font-size: 28rpx;
		font-weight: bold;
	}
	
	.quality-score {
		font-size: 32rpx;
		font-weight: bold;
		background: rgba(255, 255, 255, 0.2);
		padding: 8rpx 16rpx;
		border-radius: 20rpx;
	}
	
	.quality-stats {
		display: flex;
		justify-content: space-around;
		margin-bottom: 20rpx;
	}
	
	.stat-item {
		font-size: 24rpx;
		opacity: 0.9;
	}
	
	.quality-distribution {
		background: rgba(255, 255, 255, 0.1);
		border-radius: 8rpx;
		padding: 16rpx;
	}
	
	.distribution-bar {
		display: flex;
		align-items: center;
		margin-bottom: 12rpx;
	}
	
	.range-label {
		width: 120rpx;
		font-size: 22rpx;
		opacity: 0.8;
	}
	
	.bar-container {
		flex: 1;
		height: 20rpx;
		background: rgba(255, 255, 255, 0.2);
		border-radius: 10rpx;
		margin: 0 16rpx;
		overflow: hidden;
	}
	
	.bar {
		height: 100%;
		background: linear-gradient(90deg, #4CAF50, #8BC34A);
		border-radius: 10rpx;
		transition: width 0.3s ease;
	}
	
	.count-label {
		width: 60rpx;
		text-align: right;
		font-size: 22rpx;
		opacity: 0.8;
	}
</style> 