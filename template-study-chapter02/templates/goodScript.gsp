<%

    /**
     * 表相关信息
     */
    %>
        -----------表信息： start --------------
        表名：${tableDefine.dbTableName}    class名称：${tableDefine.id}
        中文名称：${tableDefine.cnname}    变量名称：${tableDefine.varDomainName}
        -----------表信息： end --------------
    <%


    /**
     * 第一个脚本示例：遍历column列表, 并打印列信息
     */
    println """数据库表： ${tableDefine.dbTableName}"""
    tableDefine.columns.each { column ->
        println """---------- 列信息打印 start -------"""

        print """dataName: ${column.dataName} \t , columnName: ${column.columnName} """
        println """\tcolumnType: ${column.columnType} \t , length: ${column.length} """

        // 获取Java类型
        def dataType = tableNameUtil.getDataType(column.columnType)
        print """java类型: ${dataType} """


        /**
         * 字段是否在 addList里面
         */
        def isColumnInAddList = tableModel.isInList('addList', column.columnName);

        /**
         * 字段是否在 searchKey里面
         */
        def isColumnInSearchKey = tableModel.isInList('searchKey', column.columnName);

        print """isColumnInAddList: ${isColumnInAddList} \t isColumnInSearchKey: ${isColumnInSearchKey}"""


        println """---------- 列信息打印 end -------"""
    }


    /**
     * 获取新增列表名称，并遍历获取columnVo
     *
     * addList，updateList，queryList ，viewList ，createTime，updateTime 等列表也类似；
     * 打印列信息
     */
    //新增字段列表
    List<String> addList = tableModel.getColumnNameList('addList');
    //遍历新增字段名称列表
    addList.each { addColumnName ->
        // 通过列名称 获取columnVo对象
        def column = tableDefine.getColumnByColumnName(addColumnName);
        println """dataName: ${column.dataName} \t , columnName: ${column.columnName} """
    }


    /**
     * 获取单个的主键
     */
    def pkColumn = tableDefine.getPkColumn();
    println """pkInfo dataName: ${pkColumn.dataName} \t , columnName: ${pkColumn.columnName} """


    /**
     * 如果为复合主键,可以获取列表
     */
    def pkColumnList = tableDefine.getPkColumns();
    pkColumnList.each { pkColumnVo ->
        println """pkList dataName: ${pkColumn.dataName} \t , columnName: ${pkColumn.columnName} """

    }
%>