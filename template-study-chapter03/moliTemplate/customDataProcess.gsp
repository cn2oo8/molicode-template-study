/**
  * 这是一个自定义的数据处理文件，加载顺序02；
  */
<%
    /**
     * 引用在customTool中声明的 打招呼工具；
     */
    def sayHello = customTool['sayHello']

    /**
     * 将经过处理的数据设置到：customData map对象中；
     * 即可全局上下文直接获取；
     */
    customData['myData01'] = "my first custom data value";
    customData['helloInfo'] = sayHello("David", "welcome to moliCode!");

%>