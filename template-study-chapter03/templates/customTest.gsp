<%
    /**
     * 测试自定义工具类；
     * 直接传入参数，调用工具类方法
     */
    println customTool.sayHello('模板页面', "Hello world")

    /**
     * 测试自定义数据；
     * 直接打印出数据；
     */
    println "自定义数据 key: myData01，value:" + customData['myData01'];
    println "自定义数据 key: helloInfo，value:" + customData['helloInfo'];

%>