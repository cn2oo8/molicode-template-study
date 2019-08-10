/**
  * 这是一个自定义的工具处理文件， 加载顺序01；
  */
<%
    /**
     * 声明一个sayHello的闭包，类似js的function；
     */
    def sayHello = { userName, helloMsg ->
            return """${userName} say: ${helloMsg}! """
    }

    /**
     * 将改闭包，设置到customTool map对象之中；
     */
    customTool['sayHello'] = sayHello;
%>