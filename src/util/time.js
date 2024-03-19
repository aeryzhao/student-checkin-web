function formattedDate(date) {
    //const date = new Date(); // 创建一个Date对象，表示当前日期和时间  
    const year = date.getFullYear(); // 获取年份  
    const month = (1 + date.getMonth()).toString().padStart(2, '0'); // 获取月份（注意要加1，因为getMonth返回的月份是从0开始的），并格式化为两位数字  
    const day = date.getDate().toString().padStart(2, '0'); // 获取日期，并格式化为两位数字  
    return `${year}-${month}-${day}`; // 返回格式为"YYYY-MM-DD"的字符串  
}
export { formattedDate };