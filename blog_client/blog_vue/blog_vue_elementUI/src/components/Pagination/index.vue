 <!--
 * 厦门大学计算机专业 | 前华为工程师
 * 专注《零基础学编程系列》  http://lblbc.cn/blog
 * 包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
 * 公众号：蓝不蓝编程
 -->
<template>
    <div :class="{'hidden':hidden}" class="pagination-container">
        <el-pagination
                :background="background"
                :current-page.sync="currentPage"
                :page-size.sync="pageSize"
                :layout="layout"
                :page-sizes="pageSizes"
                :total="total"
                v-bind="$attrs"
                @size-change="handleSizeChange"
                @current-change="handleCurrentChange"
        />
    </div>
</template>

<script>
    import {scrollTo} from '../../utils/scroll-to'

    export default {
        name: 'Pagination',
        props: {
            total: {
                required: true,
                type: Number
            },
            page: {
                type: Number,
                default: 1
            },
            limit: {
                type: Number,
                default: 20
            },
            pageSizes: {
                type: Array,
                default() {
                    return [10, 20, 30, 50]
                }
            },
            layout: {
                type: String,
                default: 'total, sizes, prev, pager, next, jumper'
            },
            background: {
                type: Boolean,
                default: true
            },
            autoScroll: {
                type: Boolean,
                default: true
            },
            hidden: {
                type: Boolean,
                default: false
            }
        },
        computed: {
            currentPage: {
                get() {
                    return this.page
                },
                set(val) {
                    this.$emit('update:page', val)
                }
            },
            pageSize: {
                get() {
                    return this.limit
                },
                set(val) {
                    this.$emit('update:limit', val)
                }
            }
        },
        methods: {
            handleSizeChange(val) {
                debugger
                this.$emit('pagination', {page: this.currentPage, limit: val})
                if (this.autoScroll) {
                    scrollTo(0, 800)
                }
            },
            handleCurrentChange(val) {
                this.$emit('pagination', {page: val, limit: this.pageSize})
                if (this.autoScroll) {
                    scrollTo(0, 800)
                }
            }
        }
    }
</script>

<style scoped>
    .pagination-container {
        background: #fff;
        padding: 32px 16px;
        margin-left: 15px;
    }

    .pagination-container.hidden {
        display: none;
    }
</style>
