<template>
	<view >
		<div class="queBox">
			<!-- <div class="box1">
				<u-rate count="1" v-model="value"></u-rate>
				收藏
			</div> -->
			<div class="box2" @click="clickQue">
				咨询
			</div>
		</div>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				value:1
			}
		},
		methods: {
			clickQue(){
				this.$emit("clicked");
			}
		}
	}
</script>

<style>
.queBox {

	letter-spacing:3px ;
	line-height: 3.5rem;
	font-size: 16px;
	position: fixed;
	bottom: 0;
	border-top: 1px solid #eeefe7;
	background: #ffffff;
	width: 100%;
	height: 3.5rem;
	right: 0px;
	display: flex;
	font-weight: 700;
}
.box1 {
	color: #1296db;
	height: 3.5rem;
	flex-grow: 1;
	text-align: center;
	
}
.box2 {
	flex-grow: 1;
	background-color: #1296db;
	text-align: center;
	color: #FFFFFF;
}

</style>

