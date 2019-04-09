<%
    def sumAge = 0;
    data.each {
        item ->
            sumAge += item.age;
    }
    println "sumAge=" + sumAge;
%>