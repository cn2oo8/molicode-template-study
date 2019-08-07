<%
    data.each {
        line ->
%>insert into user_info(id,user_name,age,gender,status,created,modified) values(${line.get(0)}, '${line.get(1)}', ${line.get(2)},'${line.get(3)}',1,now(),now);
<%
}
%>

