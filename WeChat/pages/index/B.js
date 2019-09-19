// B.js

// 在B.js中引用模块A
var multiplyBy2 = require('./moduleA')
var result = multiplyBy2(4)

// 定义局部变量
console.log(localValue) // 触发一个错误 b.js中无法访问 a.js 中定义的变量