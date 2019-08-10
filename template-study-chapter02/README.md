# chapter01 数据模型和常用写法

## 前言
针对大家可能不知道模板开发中数据怎么取值，我在这里给大家详细的介绍一下。顺便把一些我们在写模板的时候会用到的代码片段粘贴一部分。因为目前主要用的是数据库表模型，所以也主要介绍一下tableModel的数据结构。

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



