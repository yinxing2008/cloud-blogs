//厦门大学计算机专业 | 前华为工程师
//专注《零基础学编程系列》  http://lblbc.cn/blog
//包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
//公众号：蓝不蓝编程
<template>
    <view class="page-wrapper">
        <view class="info-container" v-for="(item, bindex) in dataList" :key="item.k">
            <view class="info-row">
                <view class="name" @tap="gotoEditBlog" :data-id="item.id">{{ item.title }}</view>
				<view class="btn" @tap="delBlog" :data-id="item.id">删除</view>
            </view>
        </view>
        <view class="bottom-wrapper">
			<image class="add-img" src="/static/images//add.png" @tap="gotoAddBlog"></image>
        </view>
    </view>
</template>

<script>
import { queryBlogs, delBlog } from '@/common/api'
export default {
    data() {
        return {
            dataList: []
        };
    },
    onShow: function () {
        this.queryData();
    },
    methods: {
        queryData() {
			queryBlogs().then(resp => {
				if (!resp.data.code) {
					this.dataList = resp.data.data
				}
			})
        },

        gotoAddBlog() {
            uni.navigateTo({
                url: '/pages/blog-add'
            });
        },

        gotoEditBlog(e) {
            let blogId = e.currentTarget.dataset['id'];
            uni.navigateTo({
                url: '/pages/blog-edit?id=' + blogId
            });
        },

        delBlog(e) {
            let blogId = e.currentTarget.dataset['id'];
			delBlog(blogId).then(resp => {
				if (!resp.data.code) {
					 this.queryData();
				}
			})
        }
    }
};
</script>
<style>
page {
    background-color: #f4f4f4;
}

.page-wrapper {
    margin: 0;
    font-size: 28rpx;
    line-height: 1.5;
    color: #333;
    overflow-x: hidden;
    -webkit-overflow-scrolling: touch;
    -webkit-tap-highlight-color: transparent;
}

.info-container {
    background-color: #fff;
    border-radius: 10rpx;
    margin-top: 2rpx;
    padding-left: 20rpx;
    padding-right: 20rpx;
    padding-top: 20rpx;
    padding-bottom: 20rpx;
}

.info-row {
    display: flex;
    flex-direction: row;
}
.name {
    font-size: 30rpx;
	flex: 1;
}

.btn {
    border-radius: 10rpx;
    border: 1rpx solid #565f66;
    margin-left: 20rpx;
    padding-left: 10rpx;
    padding-right: 10rpx;
    font-size: 30rpx;
}

.bottom-wrapper {
    position: fixed;
    bottom: 0;
    width: 100%;
	text-align: end;
}
.add-img {
    width: 80rpx;
	height: 80rpx;
	margin-bottom: 30rpx;
	margin-right: 30rpx;
}
</style>
