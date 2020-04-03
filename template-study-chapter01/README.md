# chapter01 模板开发基础篇

## 章节说明
第一章节讲解模板开发的基本流程和方式；

### 视屏教程
* 优酷：[https://v.youku.com/v_show/id_XNDMwNzU1NzY0MA==.html](https://v.youku.com/v_show/id_XNDMwNzU1NzY0MA==.html)
* 西瓜视屏（无广告）: [https://www.ixigua.com/i6723194026742252040/](https://www.ixigua.com/i6723194026742252040/)；

## 模板资源存储
我们所有的模板资源，建议托管到git仓库里面，方便大家发布和更新资源。如果是公开的可以推送到public仓库，如果公司内部私有的可以推送到私有仓库。

一个git仓库可以只存储一个模板集合，也可以存储多个：

* 存储单个的工程实例：https://gitee.com/molicode_repo/molicode-template-elementui

* 存储多个的工程实例：https://gitee.com/molicode_repo/autocode-template-example


多个的git仓库如下图所示，每个子文件下存储一个模板集合，每个子文件夹下面都有一个autoCode.xml 模板描述文件：
<img src="../images/multi_template.png" width="600"/>


## 模板文件夹说明

autoCode.xml  描述整个模板的信息；

```xml
<?xml version="1.0" encoding="UTF-8" ?>
<autoMake
        xmlns="http://molicode_repo.gitee.io/molicode_doc/schema/autoCode"
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xsi:schemaLocation="http://molicode_repo.gitee.io/molicode_doc/schema/autoCode http://molicode_repo.gitee.io/molicode_doc/schema/autoCode/autoCode-1.0.xsd">

    <moliCodeVersion>1.0.0</moliCodeVersion>

    <mavenInfo>
        <modelVersion>4.0.0</modelVersion>
        <groupId>com.shareyi.molicode</groupId>
        <version>1.0-SNAPSHOT</version>
        <artifactId>template-study-chapter01</artifactId>
        <name>moliCode模板开发学习章节01</name>
        <description>
            moliCode模板开发学习章节01
        </description>
        <developers>
            <developer>
                <name>david</name>
                <email>zsb1987@foxmail.com</email>
                <organization>www.shareyi.com</organization>
                <organizationUrl>www.shareyi.com</organizationUrl>
            </developer>
        </developers>
    </mavenInfo>

    <properties>
        <!-- 代码片段配置文件，将部分公用的代码抽取出来放置到此处 -->
        <property key="snippet.template.path">config/molicode/snippetTemplate.xml</property>
        <!-- 用户自定义的配置文件，配置的值以文本方式直接可以在：extendConf.get("") 到-->
        <property key="extend.text.config">config/molicode/extendConfig.xml</property>
        <!-- 页面依赖资源配置文件（可支持requirejs和 普通引入）-->
        <property key="pagerequire.map.config">config/molicode/requireConfig.xml</property>
        <!-- 数据库类型到java类型映射-->
        <property key="dbtype.javatype.map.config">config/molicode/db2javaTypeMap.xml</property>
        <!-- 数据库类型到页面类型映射-->
        <property key="dbtype.columntag.map.config">config/molicode/dbType2ColumnTagMap.xml</property>

    </properties>

    <templates>

        <template id="javaBean" name="javaBean"
                  destFile="/${config.artifactId}-domain/src/main/java/${PubUtils.packageToPath(config.basePackage)}/domain/${PubUtils.packageToPath(config.category)}/${tableDefine.id}.java" templateFile="templates/java/bean.gsp" engine="groovy">
            <desc>基于lombok的java bean</desc>
            <acceptDataModel>tableModel</acceptDataModel>
        </template>


        <template id="mybatisDaoIntf" name="mybatis dao接口"
                  destFile="/${config.artifactId}-dao/src/main/java/${PubUtils.packageToPath(config.basePackage)}/dao/${PubUtils.packageToPath(config.category)}/${tableDefine.id}Dao.java"
                  templateFile="templates/java/daoIntf.gsp" engine="groovy">
            <desc>适配mybatis的dao接口</desc>
            <acceptDataModel>tableModel</acceptDataModel>
        </template>


        <template id="controller" name="controller"
                  destFile="/${config.artifactId}-web/src/main/java/${PubUtils.packageToPath(config.basePackage)}/controller/${PubUtils.packageToPath(config.category)}/${tableDefine.id}Controller.java"
                  templateFile="templates/java/controller.gsp" engine="groovy">
            <desc>springMvc controller</desc>
            <acceptDataModel>tableModel</acceptDataModel>
        </template>

    </templates>
</autoMake>
```

模板engine属性目前支持： groovy（默认）、velocity 、xlsx

后期可扩展：freemarker, thymeleaf等；

请访问以下地址，查看帮助文档：http://molicode_repo.gitee.io/molicode_doc//template/



## 模板中可直接使用的数据和工具


### 内置预处理数据结构
* key: data  指向：前台输入按数据模型处理后的结果； 说明：原始数据；

* key: config 指向：com.shareyi.molicode.common.vo.code.ConfigVo  说明：来自于【项目配置】-->【业务代码设置】；

  ![业务代码配置](https://oscimg.oschina.net/oscnet/8696651dca4ebf30c0ffceb2a36c3672f3e.jpg)

* key: tableModel 指向：com.shareyi.molicode.common.vo.code.TableModelVo  说明：来自于数据库表模型，可以参考安装目录下：tableModel文件夹生成的json数据结构取值；

  **配置界面：**

  

  <img src="https://oscimg.oschina.net/oscnet/5fff381248561826a926cd16c7c177cb23a.jpg" width="600">

  **tableModel的一般json如下：**

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

  

* key: tableDefine 指向：com.shareyi.molicode.common.vo.code.TableDefineVo  说明：来自于数据库表模型 , 和tableModel.tableDefine 同为一个对象，可以参考安装目录下：tableModel文件夹生成的tableDefine数据结构取值；



### 本工程提供的工具类

* key: tableNameUtil  指向：com.shareyi.molicode.common.utils.TableNameUtil； 说明：参考api文档；
* key: PubUtils 指向：com.shareyi.molicode.common.utils.PubUtils  说明：参考api文档；
* key: snippetTemplateUtil, dictUtil  指向：com.shareyi.molicode.common.utils.SnippetTemplateUtil  说明：模板片段工具类，用于字典项转换等处理；

 api文档地址：[http://molicode_repo.gitee.io/molicode_doc/](http://molicode_repo.gitee.io/molicode_doc/)

### 第三方工具类

* key: StringUtils   指向：org.apache.commons.lang3.StringUtils   说明：参考apache-commons 相关API说明；
  
* key: CollectionUtils  指向：org.apache.commons.collections4.CollectionUtils 说明：参考apache-commons 相关API说明；
  
*  key: JSON  指向：com.alibaba.fastjson.JSON 说明：参考fastjson相关API说明；


### 预留扩展的插槽
*  key: customTool   类型：HashMap  说明：可以通过groovy脚本，在customTool中设置自定义工具类，然后即可在其他地方通过： customTool['myTool'](paramter) 进行参数调用；

*   key: customData   类型：HashMap  说明：可以通过groovy脚本，在customData中设置自定义数据，然后即可在其他地方通过： customTool['customData'] 获取到该数据；

*  key: jsonConfig   类型：JsonObject 说明：数据来自项目的json扩展配置信息；  通过jsonConfig['myKey'] 可以取到jsonConfig中的值；



### 具体属性说明

参考以下API说明：

http://molicode_repo.gitee.io/molicode_doc/api/