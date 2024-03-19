<template>
  <div class="common-layout">
    <el-container>
      <div>
        <p>{{ currentDate }}</p>
      </div>
      <el-header class="header">
        <div id="app" class="button-container">
          <el-button @click="changePage('TodayCheckin')">今日打卡</el-button>
          <el-button @click="changePage('Tally')">数据统计</el-button>
        </div>
      </el-header>
      <el-main>
        <component :is="currentComponent"></component>
      </el-main>
    </el-container>
  </div>
</template>

<script>
import { ref } from 'vue';
import Tally from './pages/Tally.vue'; // 假设你有一个名为 PageOne 的组件  
import TodayCheckin from './pages/TodayCheckin.vue'; // 假设你有一个名为 PageTwo 的组件  
import { formattedDate } from './util/time';

export default {
  components: {
    Tally,
    TodayCheckin
  },
  setup() {
    const currentComponent = ref('TodayCheckin'); // 默认显示页面一  

    const changePage = (pageName) => {
      currentComponent.value = pageName;
    };

    const currentDate = ref(formattedDate(new Date()));

    return {
      currentComponent,
      changePage,
      currentDate
    };
  }
};  
</script>

<style>
/* 自定义样式 */
/* #app {  
  display: flex;  
  flex-direction: column;  
  align-items: center;  
  justify-content: center;  
  height: 100vh;  
} */

.hearder {
  background-color: pink;
  padding: 0;
  text-align: center;
  position: fixed;
  height: 100px;
}

.button-container {
  display: flex;
  justify-content: center;
  /* 水平居中按钮 */
  align-items: stretch;
  /* 垂直居中按钮 */
  margin-bottom: 2px;
  /* 与下面的组件内容保持一些间距 */
}

el-button {
  margin-bottom: 20px;
}
</style>