<%
    println "用户名称\t省份ID"
    data.each {
        item ->
            println item.userName + "\t" + item.address.provinceId;
    }
%>