<%
    def columns=tableDefine.columns;
%>
package com.shareyi.study.springcloud.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * ${tableDefine.cnname}测试
 *
 * @author ${config.author}
 * @date ${config.date}
 */
@Getter
@Setter
@ToString
public class ${tableDefine.id} {

<%
     columns.each{ column ->
         %>
    /**
     * ${column.cnname}
     */
    private String ${column.dataName};
<%
     }
%>

}
