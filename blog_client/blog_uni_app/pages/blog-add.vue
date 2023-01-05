//厦门大学计算机专业 | 前华为工程师
//专注《零基础学编程系列》  http://lblbc.cn/blog
//包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
//公众号：蓝不蓝编程
<template>
    <view class="page-wrapper">
        <form @submit="onSubmit">
            <scroll-view :scroll-y="true">
                <view class="info-container">
                    <view class="common-info-row">
                        <input class="common-input" name="title" placeholder="请输入标题" />
                    </view>
                    <view class="split"></view>
                    <view class="common-info-row">
                        <textarea class="common-input" name="content" placeholder="请输入正文" ></textarea>
                    </view>
                </view>
            </scroll-view>
            <view class="bottom-wrapper">
                <button class="bottom-btn" form-type="submit">保存</button>
            </view>
        </form>
    </view>
</template>

<script>
import { addBlog } from '@/common/api'
export default {
    data() {
        return {
            title: '',
            content: '',
        };
    },
    onLoad: function (option) {},
    methods: {
        onSubmit(e) {
            var params = {
                title: e.detail.value.title,
                content: e.detail.value.content,
            };
			addBlog(params).then(resp => {
				if (!resp.data.code) {
					uni.navigateBack();
				}
			})
        },
    }
};
</script>
<style>
page {
    background-color: #f4f4f4;
}

.page-wrapper {
    margin: 0;
    font-size: 32rpx;
    line-height: 1.5;
    color: #333;
    overflow-x: hidden;
    -webkit-overflow-scrolling: touch;
    -webkit-tap-highlight-color: transparent;
    min-height: 2000rpx;
}
.split {
    background-color: #e0e3ea;
    height: 1rpx;
    margin: 20rpx 10rpx;
}
.info-container {
    background-color: #fff;
    border-radius: 10rpx;
    margin-top: 40rpx;
    margin-left: 20rpx;
    margin-right: 20rpx;
    padding-left: 20rpx;
    padding-right: 20rpx;
    padding-top: 20rpx;
    padding-bottom: 20rpx;
}
.common-info-row {
    display: flex;
    flex-direction: row;
    margin-top: 20rpx;
    margin-bottom: 20rpx;
    align-items: center;
}
.common-input {
    margin-left: 20rpx;
}
.bottom-wrapper {
    position: fixed;
    bottom: 0;
    width: 100%;
}
.bottom-btn {
    font-size: 30rpx;
    color: #fff;
    margin: 50rpx 50rpx;
    background-color: #418DF9;
    border-radius: 2rem;
}
</style>
