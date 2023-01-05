 <!--
 * 厦门大学计算机专业 | 前华为工程师
 * 专注《零基础学编程系列》  http://lblbc.cn/blog
 * 包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
 * 公众号：蓝不蓝编程
 -->
<template>
  <div>
    <div class="title">蓝不蓝博客</div>
    <div>
      <van-list finished-text="到底啦">
        <van-cell
          v-for="(item, index) in list"
          :key="index"
          :title="item.title"
          size="large"
          @click="gotoModifyBlog(item.id)"
        />
      </van-list>
    </div>
    <div class="bottom-wrapper">
      <van-icon name="add" class="add-img" size="50" @click="gotoAddBlog" />
    </div>
  </div>
</template>

<script setup lang="ts">
import { onMounted, ref } from 'vue'
import { queryBlogList } from '@/api/api'
import { useRouter } from 'vue-router'

const router = useRouter()
const list = ref([])

const queryData = async () => {
  const result = await queryBlogList()
  list.value = result.data
}

const gotoModifyBlog = async (blogId) => {
  router.push(`/blog/modifyBlog?id=${blogId}`)
}

const gotoAddBlog = async () => {
  router.push('/blog/addBlog')
}

onMounted(() => {
  if (sessionStorage.getItem('token')) {
    queryData()
  } else {
    router.push('/blog/login')
  }
})
</script>

<style scoped>
.title {
  font-size: 30px;
  margin-top: 10px;
  margin-left: 10px;
}
.bottom-wrapper {
  position: fixed;
  bottom: 0;
  right:0;
}
.add-img {
  color: #418df9;
  margin-bottom: 30px;
  margin-right: 30px;
}
</style>