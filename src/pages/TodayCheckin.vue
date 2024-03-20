<template>
    <div>
        <el-input v-model="name" style="width: 320px" placeholder="请输入学生姓名" />
        <el-button type="primary" @click="addStudent">添加</el-button>
    </div>
    <div>
        <el-table :data="students" border style="width: 100%">
            <!-- <el-table-column prop="id" label="ID" width="180" /> -->
            <el-table-column prop="name" label="姓名" width="180" />
            <el-table-column prop="state" label="打卡" width="100">
                <template #default="scope">
                    <el-button type="success" :disabled='scope.row.state != 0'
                        @click="check(scope.row, 1)">✅</el-button>
                </template>
            </el-table-column>
            <el-table-column label="操作" width="100">
                <template #default="scope">
                    <el-popconfirm title="Are you sure to delete this student?" @confirm="deleteStudent(scope.row.id)">
                        <template #reference>
                        <el-button type="danger">删除</el-button>
                    </template>
                    </el-popconfirm>
                </template>
            </el-table-column>
        </el-table>
    </div>
</template>

<script>
import axios from 'axios'
import { ElMessage } from 'element-plus'
export default {
    data() {
        return {
            name: '',
            students: [],
            isDisabled: true
        }
    },
    mounted() {
        this.getStudents()
    },
    methods: {
        deleteStudent(id) {
            axios.delete('/api/student/' + id).then(res => {
                this.getStudents()
            })
            ElMessage.success('删除成功！')
        },
        addStudent() {
            axios.post('/api/student', {
                name: this.name
            }).then(res => {
                this.getStudents()
            })
        },
        getStudents() {
            axios.get('/api/student').then(res => {
                this.students = res.data.result
            })
        },
        check(student, state) {
            console.log(state)
            console.log(new Date())
            axios.post('/api/checkin', {
                state: state,
                studentId: student.id,
                checkinDate: new Date().toISOString()
            }).then(res => {
                this.getStudents()
            })
        }
    }
}
</script>