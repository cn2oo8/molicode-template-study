<%
    //获取Java源码属性列表，并进行属性复制
    data.fieldList.each { it ->
        def upperFistName = tableNameUtil.upperFirst(it.dataName)
        println """     dest.set${upperFistName}(src.get${upperFistName}());"""
    }
%>

