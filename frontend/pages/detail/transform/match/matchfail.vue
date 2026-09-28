<template>
	<view class="container">
		<u-empty
		        mode="search"
				class="empty"
				marginTop="150"
		>
		</u-empty>
		<view class="text">前往<text class="search" @click="jump">校企共研</text></view>
	</view>
</template>

<script>
export default {
	data() {
		
	},
	methods:{
		jump() {
			uni.navigateTo({
				url: '/pages/detail/transform/research/research'
			})
		}
	}
}
</script>

<style lang="scss" scoped>
.container {
	.text {
		text-align: center;
		.search {
			color: blue;
		}
	}
}
</style>
