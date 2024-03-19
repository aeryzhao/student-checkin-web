<template>
    <div class="date">
        <el-date-picker v-model="select" type="daterange" unlink-panels range-separator="To"
            start-placeholder="Start date" end-placeholder="End date" :shortcuts="shortcuts" />
        <el-button type="primary" @click="getTallys">查询</el-button>
    </div>
    <div>
        <el-table :data="tallys" style="width: 100%">
            <el-table-column v-for="(column, index) in tableColumns" :key="index" :prop="column.prop"
                :label="column.label" :width="column.width"></el-table-column>
        </el-table>
    </div>
    <!-- <el-button type="primary" @click="refrenceData">刷新</el-button> -->
</template>
<script>
import axios from 'axios'
import { formattedDate } from '../util/time'

export default {
    data() {
        return {
            shortcuts: [
                {
                    text: '最近一周',
                    value: () => {
                        const end = new Date()
                        const start = new Date()
                        start.setTime(start.getTime() - 3600 * 1000 * 24 * 7)
                        return [start, end]
                    },
                },
                {
                    text: '最近一月',
                    value: () => {
                        const end = new Date()
                        const start = new Date()
                        start.setTime(start.getTime() - 3600 * 1000 * 24 * 30)
                        return [start, end]
                    },
                },
                {
                    text: '最近三月',
                    value: () => {
                        const end = new Date()
                        const start = new Date()
                        start.setTime(start.getTime() - 3600 * 1000 * 24 * 90)
                        return [start, end]
                    },
                },
            ],
            select: [],
            tallys: [],
            tableColumns: [
                {
                    prop: 'id',
                    label: 'ID',
                    width: 180
                },
                {
                    prop: 'name',
                    label: '姓名',
                    width: 180
                }
                // 初始列配置  
            ],
            fixedColumns: [
                {
                    prop: 'name',
                    label: '姓名',
                    width: 180
                }
                // 固定列配置  
            ],
            // 动态添加的列配置  
            dynamicColumn: {
                prop: '2024-03-11',
                label: '2024-03-11',
                width: 180
            }
        }
    },
    mounted() {
        this.init()
    },
    methods: {
        init() {
            const end = new Date()
            const start = new Date()
            start.setTime(start.getTime() - 3600 * 1000 * 24 * 7)
            this.select = [start, end]
            this.getTallys()
        },
        getTallys() {
            //console.log(this.select)
            this.tableColumns.splice(0, this.tableColumns.length)
            this.tableColumns.push(...this.fixedColumns)
            var begin = ""
            var end = ""
            if (this.select != '') {
                begin = this.select[0].toLocaleDateString()
                end = this.select[1].toLocaleDateString()
                this.iterateDates(begin, end)
            }
            this.refrenceData()
        },
        async refrenceData() {
            var begin = ""
            var end = ""
            if (this.select != '') {
                begin = this.select[0].toLocaleDateString()
                end = this.select[1].toLocaleDateString()
            }
            await axios.get('/api/tally', { params: { beginDate: begin, endDate: end } }).then(res => {
                this.tallys = res.data.result
            })
            this.tallys.forEach(element => {
                var map = new Map()
                if (element.span != null) {
                    element.span.forEach(s => {
                        map.set(s.date, s.state)
                    });
                }
                const startDate = new Date(begin);
                const endDate = new Date(end);
                let currentDate = new Date(startDate);
                while (currentDate <= endDate) {
                    // console.log(currentDate)
                    let dateOnly = formattedDate(currentDate)
                    console.log(dateOnly); // 输出日期，格式为YYYY-MM-DD
                    element[dateOnly] = map.get(dateOnly) == 1 ? '✅' : '❌'
                    currentDate.setDate(currentDate.getDate() + 1); // 增加一天
                }
            });
            console.log(this.tallys);
        },
        iterateDates(startDateStr, endDateStr) {
            const startDate = new Date(startDateStr);
            const endDate = new Date(endDateStr);

            let currentDate = new Date(startDate);

            while (currentDate <= endDate) {
                // console.log(currentDate)
                var dateOnly = formattedDate(currentDate)
                //console.log(dateOnly); // 输出日期，格式为YYYY-MM-DD
                currentDate.setDate(currentDate.getDate() + 1); // 增加一天
                var d = {
                    prop: dateOnly,
                    label: dateOnly,
                    width: 100
                }
                //console.log(d);
                this.tableColumns.push(d);
            }
            //console.log(this.tableColumns);
        }
    }
}
</script>
<style>
.date {
    margin-top: 20px;
    margin-bottom: 20px;
    display: flex;
    justify-content: center;
    align-items: center;
}
</style>