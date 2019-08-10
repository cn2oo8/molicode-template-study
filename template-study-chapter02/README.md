# chapter01 数据模型和常用写法

## 前言
针对大家可能不知道模板开发中数据怎么取值，我在这里给大家详细的介绍一下。顺便把一些我们在写模板的时候会用到的代码片段粘贴一部分。因为目前主要用的是数据库表模型，所以也主要介绍一下tableModel的数据结构。

这个工程是空的，没有示例代码，请查看readme文档信息即可。

## tableModel数据结构

tableModel 包含tableDefine属性，同时存储业务字段信息，字段信息，排序等信息；

tableDefine 用于存储和数据库一致的信息；

tableDefine.columns 为数据库所有的列 list;



### tableModel的json数据格式如下（精简版本）：

```javascript
{
  "tableDefine": {
    "dbTableName": "ac_project",
    "id": "AcProject",
    "cnname": "项目",
    "varDomainName": "acProject",
    "columns": [
      {
        "canBeNull": false,
        "cnname": "id",
        "columnName": "id",
        "columnType": "INT",
        "comment": "id",
        "dataName": "id",
        "isPK": true,
        "jspTag": "TEXT",
        "length": 10,
        "readonly": false
      },
      {
        "canBeNull": true,
        "cnname": "名称",
        "columnName": "name",
        "columnType": "VARCHAR",
        "comment": "名称",
        "dataName": "name",
        "isPK": false,
        "jspTag": "TEXT",
        "length": 50,
        "readonly": false
      },
      {
        "canBeNull": true,
        "cnname": "类型",
        "columnName": "type",
        "columnType": "INT",
        "comment": "类型:1.本地，2.仓库",
        "dataName": "type",
        "dictName": "acProject_type_DICT",
        "isPK": false,
        "jspTag": "SELECT",
        "length": 10,
        "readonly": false
      }
    ],
    "pkColumn": {
      "canBeNull": false,
      "cnname": "id",
      "columnName": "id",
      "columnType": "INT",
      "comment": "id",
      "dataName": "id",
      "isPK": true,
      "jspTag": "TEXT",
      "length": 10,
      "readonly": false
    }
  },
  "bizFieldsMap": {
    "allColumn": "id,name,type,created,modified",
    "addList": "id,name,type",
    "updateList": "id,name,type,created,modified",
    "queryList": "id,name,type,created,modified",
    "viewList": "id,name,type,created,modified",
    "searchKey": "id,name,type",
    "createTime": "created",
    "updateTime": "modified"
  },
  "dictMap": {
    "acProject_type_DICT": {
      "id": "acProject_type_DICT",
      "name": "type字段的字典项",
      "optionList": [
        {
          "name": "本地",
          "value": "1"
        },
        {
          "name": "仓库",
          "value": "2"
        }
      ]
    }
  }
}
```



### tableModel主体信息的属性结构

```
tableModel(表模型)
	|
  |___tableDefine(表信息)
  |     |
  |     |____id(类名), cnname(中文名称), varDomainName(变量名称), dbTableName(表名)
  |			|
  |			|____columns 列列表信息；
  |						|
  |						|__columnName(数据库列名),dataName(字段名称), columnType(数据库字段类型)
  |						|__length(长度)，comment(备注), isPK(是否主键), jspTag(展示类型)
  |						|__canBeNull(是否可为空)，dictName(字典项名称)，readonly(是否只读)
  |
  |___ bizFieldMap(业务字段map)
  |				|
  |				|__allColumn(全部列名称列表，逗号分隔)
  |				|__addList(新增列名称列表，逗号分隔)
  |				|__updateList (修改列名称列表，逗号分隔)
  |				|__queryList (查询列名称列表，逗号分隔)
  |				|__viewList (查看列名称列表，逗号分隔)
  |				|__createTime (创建时间列名称)
  |				|__updateTime (修改时间列名称)
  |
  |__dictMap(字典项map，略)
  
```





## 内置的工具类

### pubUtils

Key: PubUtils, 指向: com.shareyi.molicode.common.utils.PubUtils

方法列表及说明

```java
  /**
     * 获取随机的Long
     *
     * @return 随机Long
     */
    public static Long getRandomLong();

    /**
     * 生成UUID
     *
     * @return 无-的，且大写32位的UUID
     */
    public static String getUUID();

    /**
     * 获取当前年月日
     *
     * @return yyyy-MM-dd
     */
    public static String getDate();

    /**
     * 获取年月日和时间
     *
     * @return yyyy-MM-dd HH:mm:ss
     */
    public static String getDateTime();

    /**
     * 获取当前的时间戳
     *
     * @return 时间戳
     */
    public static long getTime();

    /**
     * List转换为String,用逗号间隔
     * 如： col1,col2,col3
     *
     * @param list 字符串list
     * @return 逗号分隔的字符串
     */
    public static String listToStr(List<String> list);

    /**
     * String转换为List,用逗号间隔
     * 将 col1,col2,col3 以逗号分隔为list的元素
     *
     * @param str 原始字符串
     * @return 拆分后的List
     */
    public static List<String> stringToList(String str);

    /**
     * 包名转路径
     * 如：com.jd.xxx 转换为： com/jd/xxx
     *
     * @param str 包名
     * @return 路径地址
     */
    public static String packageToPath(String str);

    /**
     * 路径转换为包名
     * 如： com/jd/xxx 转换为：com.jd.xxx
     *
     * @param str 路径地址
     * @return 包名路径
     */
    public static String pathToPackage(String str) ;

    /**
     * 如果字符串不为空，将字符串拼接到分隔符后面
     * 否则返回空串
     * 如：("path","/") --&gt;  /path
     *
     * @param str 原始串
     * @param sep 分隔符
     * @return 转换后的字符串
     */
    public static String addStrBeforeSeparator(String str, String sep);

    /**
     * 如果字符串不为空，将字符串拼接到分隔符后面
     * 否则返回空串
     * 如：("path","/") --&gt;  /path
     *
     * @param str 原始串
     * @param sep 分隔符
     * @return 转换后的字符串
     */
    public static String addStrAfterSeparator(String str, String sep);


    /**
     * 将列名，按id,name,total_money格式拼接在一起，主要用户SQL拼接
     *
     * @param columns 列List
     * @return 类似 id,name,total_money
     */
    public static String joinColumnNames(List<ColumnVo> columns);
    

```



### TableNameUtil

Key: tableNameUtil, 指向: com.shareyi.molicode.common.utils.TableNameUtil

方法列表及说明

```java
 /**
     * 首字符大写，为空返回空
     * 示例： userName-&gt;UserName  常用于获取类名
     *
     * @param str 要转换的字符串
     * @return 首字符大写
     */
    public String upperFirst(String str);

    /**
     * 首字符小写，为空返回空
     * 示例： UserName  -&gt; userName 常用于类名转实例名
     *
     * @param str 要转换的字符串
     * @return 首字符小写
     */
    public static String lowerCaseFirst(String str);

    /**
     * 数据库字段名称转换为属性名称 MY_OLD-&gt; myOld
     *
     * @param dbNames 数据库字段名称
     * @return 属性名称
     */
    public String convertToBeanNames(String dbNames);

    /**
     * 转换为数据库字段名称 myOld --&gt; MY_OLD
     *
     * @param dbNames 属性名称
     * @return 数据库字段名称
     */
    public String convertToDbNames(String dbNames);

    /**
     * 将字符串按大写字母拆分为List元素
     * 如： userName -&gt; [user, name]
     *
     * @param src
     * @return
     */
    public List<String> splitByUppercase(String src) ;

    /**
     * 根据数据库类型获取java数据类型
     * <p>
     * 如 VARCHAR -&gt; String
     *
     * @param dbType 数据库数据类型
     * @return 数据类型
     */
    public String getDataType(String dbType);

    /**
     * 根java数据类型获取数据库类型
     * <p>
     * 如 String -&gt; VARCHAR
     *
     * @param dataType 数据类型
     * @return 数据库类型
     */
    public String transToColumnType(String dataType);

    /**
     * 根据数据库类型获取java数据类型 z全包名，  如java.lang.Integer
     *
     * @param dbType 数据库数据类型
     * @return 数据类型
     */
    public String getFullDataType(String dbType);

    /**
     * 根据数据库类型获取Tag
     *
     * @param dbType 数据库数据类型
     * @return 数据类型
     */
    public String getJspTag(String dbType) ;

    /**
     * 获取排序字段
     *
     * @param tableModel
     * @return 排序string
     */
    public String getOrderString(TableModelVo tableModel);

    /**
     * 获取列的测试数据
     *
     * @param column
     * @return
     */
    public String genTestDataQuote(ColumnVo column, Map<String, DictVo> dictMap) ;

    /**
     * 通过字典项生成数据
     *
     * @param data
     * @param column
     * @param dictMap
     * @return 字典项数据
     */
    public static String genTestDataWithDict(String data, ColumnVo column, Map<String, DictVo> dictMap);

    /**
     * 将输入值用双引号包裹起来
     *
     * @param value
     * @return "value"
     */
    public static String wrapWithQuote(String value) ;
```

