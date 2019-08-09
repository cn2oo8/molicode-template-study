<%
    def columns=tableDefine.columns;
%>
package ${config.basePackage};

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * ${tableDefine.cnname}测试
 *
 * @author ${config.author}
 * @date ${config.nowDate}
 */
@Getter
@Setter
@ToString
public class ${tableDefine.id} {

<%
     columns.each{ column ->
         def dataType =tableNameUtil.getDataType(column.columnType)
         %>
    /**
     * ${column.cnname}
     */
    private ${dataType} ${column.dataName};
<%
     }
%>

}
