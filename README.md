# 机票管理系统

基于SSM框架的机票管理系统，包含用户端和管理员端。

## 技术栈

### 后端
- Spring Framework 4.3.18.RELEASE
- Spring MVC 4.3.18.RELEASE
- MyBatis 3.4.6
- MySQL 5.7
- Druid 1.1.10

### 前端
- AngularJS 1.x
- Bootstrap 5.x
- jQuery 2.x

### 开发工具
- Maven 3.x
- Tomcat 11
- JDK 1.8

## 项目结构

```
airport_management_system/
├── pom.xml                          # 父工程POM
├── database/
│   └── flyticket.sql               # 数据库脚本
├── flyTicket-pojo/                 # 实体类模块
├── flyTicket-dao/                  # 数据访问模块
├── flyTicket-manage-service/       # 后台业务逻辑模块
├── flyTicket-manage-web/           # 后台Web应用
└── flyTicket-portal-web/           # 前台Web应用
```

## 部署步骤

### 1. 数据库配置

1. 创建MySQL数据库：
```sql
CREATE DATABASE flyticket CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

2. 执行数据库脚本：
```bash
mysql -u root -p flyticket < database/flyticket.sql
```

3. 修改数据库连接配置：
   - `flyTicket-manage-web/src/main/resources/jdbc.properties`
   - `flyTicket-portal-web/src/main/resources/jdbc.properties`

```properties
jdbc.driver=com.mysql.jdbc.Driver
jdbc.url=jdbc:mysql://localhost:3306/flyticket?useUnicode=true&characterEncoding=utf8
jdbc.username=root
jdbc.password=your_password
```

### 2. 编译项目

在项目根目录执行：
```bash
mvn clean install
```

### 3. 部署到Tomcat

#### 方式一：直接部署WAR包

1. 将以下WAR包复制到Tomcat的webapps目录：
   - `flyTicket-manage-web/target/flyTicket-manage-web.war`
   - `flyTicket-portal-web/target/flyTicket-portal-web.war`

2. 启动Tomcat：
```bash
cd /path/to/tomcat/bin
./startup.sh  # Linux/Mac
startup.bat   # Windows
```

#### 方式二：使用Maven插件部署

1. 在`flyTicket-manage-web/pom.xml`中添加Tomcat插件：
```xml
<plugin>
    <groupId>org.apache.tomcat.maven</groupId>
    <artifactId>tomcat7-maven-plugin</artifactId>
    <version>2.2</version>
    <configuration>
        <port>8080</port>
        <path>/flyTicket-manage-web</path>
    </configuration>
</plugin>
```

2. 运行：
```bash
cd flyTicket-manage-web
mvn tomcat7:run
```

### 4. 访问系统

#### 前台用户系统
- 首页：http://localhost:8080/flyTicket-portal-web/portal/index
- 登录：http://localhost:8080/flyTicket-portal-web/portal/toLogin
- 注册：http://localhost:8080/flyTicket-portal-web/portal/toRegister

#### 后台管理系统
- 登录：http://localhost:8080/flyTicket-manage-web/admin/toLogin
- 默认管理员账号：admin / admin123

## 功能模块

### 前台用户系统
- 用户注册/登录
- 航班查询（按出发地、目的地、日期）
- 航班预订
- 订单支付（模拟支付）
- 订单管理

### 后台管理系统
- 管理员登录
- 航班管理（增删改查）
- 用户管理
- 订单管理

## 注意事项

1. 确保MySQL服务已启动
2. 确保Tomcat版本为11或更高
3. 确保JDK版本为1.8
4. 数据库连接信息需要根据实际情况修改
5. 首次运行前需要执行数据库脚本

## 常见问题

### 1. 数据库连接失败
检查`jdbc.properties`中的数据库连接信息是否正确。

### 2. 端口被占用
修改Tomcat的`server.xml`中的端口配置，或修改Maven插件中的port配置。

### 3. 页面404
检查WAR包是否正确部署到Tomcat的webapps目录。

### 4. 中文乱码
确保数据库字符集为utf8mb4，JSP页面编码为UTF-8。

## 开发说明

### 添加新功能

1. 在`flyTicket-pojo`中添加实体类
2. 在`flyTicket-dao`中添加Mapper接口和XML
3. 在`flyTicket-manage-service`中添加Service接口和实现
4. 在`flyTicket-manage-web`或`flyTicket-portal-web`中添加Controller
5. 创建对应的JSP页面和JS控制器

### 代码规范

- 遵循阿里巴巴Java开发规范
- 使用驼峰命名法
- 添加必要的注释
- 异常处理要完善

## 许可证

MIT License
