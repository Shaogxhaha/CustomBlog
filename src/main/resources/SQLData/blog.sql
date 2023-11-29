/*
SQLyog Ultimate v12.09 (64 bit)
MySQL - 5.5.40 : Database - blog
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`blog` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `blog`;

/*Table structure for table `hibernate_sequence` */

DROP TABLE IF EXISTS `hibernate_sequence`;

CREATE TABLE `hibernate_sequence` (
  `next_val` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `hibernate_sequence` */

insert  into `hibernate_sequence`(`next_val`) values (1);

/*Table structure for table `t_blog` */

DROP TABLE IF EXISTS `t_blog`;

CREATE TABLE `t_blog` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `content` longtext,
  `description` longtext,
  `create_time` varchar(255) DEFAULT NULL,
  `first_picture` varchar(255) DEFAULT NULL,
  `flag` varchar(255) DEFAULT NULL,
  `published` bit(1) NOT NULL,
  `recommend` bit(1) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `update_time` varchar(255) DEFAULT NULL,
  `views` int(11) DEFAULT NULL,
  `type_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `FK292449gwg5yf7ocdlmswv9w4j` (`type_id`),
  KEY `FK8ky5rrsxh01nkhctmo7d48p82` (`user_id`),
  CONSTRAINT `FK292449gwg5yf7ocdlmswv9w4j` FOREIGN KEY (`type_id`) REFERENCES `t_type` (`id`),
  CONSTRAINT `FK8ky5rrsxh01nkhctmo7d48p82` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;

/*Data for the table `t_blog` */

insert  into `t_blog`(`id`,`content`,`description`,`create_time`,`first_picture`,`flag`,`published`,`recommend`,`title`,`update_time`,`views`,`type_id`,`user_id`) values (12,'# 类加载器\r\n\r\nClassLoader：是负责加载类的对象\r\n\r\njava运行时具有以下内置加载器\r\n\r\n* Bootstrap class loader：它是虚拟机的内置加载类，通常为null,并且没有父null；\r\n* Platform class loader：平台类加载器可以看到所有平台类，平台类包括由平台类加载器或其祖先定义的java se平台API，其实现类和JDK特定的运行时类；\r\n* System class loader:它也被成为应用程序类加载器，与平台类加载器不同，系统类加载器通常用于定义应用程序类路径，模块路径和JDK特定工具上的类；\r\n* 类加载器的继承关系；System的父加载器为Platfrom，而Platfrom的父类记载器为Bootstrap；\r\n 、\r\n​	\r\n\r\n```java\r\nClassLoader.getSystemClassLoader();//返回用于委派的系统类加载器；\r\ngetParent();//返回父类委派器；\r\n```\r\n\r\n\r\n\r\n# 反射:框架设计的灵魂\r\n\r\n* 框架：半成品软件，可以在框架的基础上进行软件开发，简化编码\r\n* 发射：将类的各个组成部分封装为其他对象，这就是反射机制；\r\n\r\n# 获取Class对象的方法\r\n\r\n把class文件加载到内存当中去\r\n\r\n* ```java\r\n  Class.forName(\"全类名\"):将字节码文件加载进内存，返回class对象//多用于配置文件，将类名定义在配置文件中，读取文件，加载类//灵活性特别高\r\n  ```\r\n\r\n* ```java\r\n  类名.class:通过类名的属性class获取//多用于参数的传递\r\n  ```\r\n\r\n* ```java\r\n  对象.getClass():getClass()方法在object类中定义着//多用于对象的获取字节码的方式\r\n  ```\r\n\r\n# class对象功能\r\n\r\n## 获取功能\r\n\r\n### 1.获取成员变量们\r\n\r\n```java\r\nonly public:\r\n字节码文件名.getFields();//获取所有public修饰的成员变量存储到Field数组中；数组记得用增强for遍历，否则就输出地址；\r\n字节码文件名.getField(\"成员变量名\");//获取指定名称的public修饰的成员变量\r\nall:\r\n字节码文件名.getDeclaredFiels();//获取所有成员变量存储到Field数组中；没有访问修饰符限制；\r\n字节码文件名.getDeclaredField();//获取指定名称的成员变量，这里需要手动暴力反射，不然也会有限制； 成员变量.setAccessible(true);\r\n```\r\n\r\n1.1 Field:成员变量\r\n\r\n```java\r\n1.设置值\r\n  成员变量名.set();\r\n2.得到值\r\n   成员变量名.get();\r\n```\r\n\r\n```java\r\n范例\r\n     Class<Student> studentClass = Student.class;\r\n        Field name = studentClass.getDeclaredField(\"name\");\r\n        name.setAccessible(true);\r\n        Constructor<Student> constructor = studentClass.getConstructor();\r\n        Object student = constructor.newInstance();\r\n        name.set(student,\"林青霞\");\r\n        System.out.println(student);\r\n```\r\n\r\n\r\n\r\n### 2.获取构造方法们\r\n\r\n```java\r\nonly public:\r\n字节码文件名.getConstructors();//获取所有构造方法存储到数组中去，输出记得遍历；\r\n字节码文件名.getConstructor(构造方法的参数类型.class);//获取构造方法；\r\nall:\r\n字节码文件名.getDeclaredConstructors();\r\n字节码文件名.getDeclaredConstructor(构造方法的参数类型.class);//功能同上，就是没有访问修饰符限制； 记得setAccessible(true);\r\n```\r\n\r\n2.2 constructor：构造方法\r\n\r\n```java\r\n构造方法创建对象:\r\n得到构造器的名称的变量.newInstance(\"对象赋值\");\r\n空参创建对象：\r\n字节码文件名.newInstance();\r\n```\r\n\r\n### 3.获取成员方法们\r\n\r\n```java\r\nonly public:\r\ngetmethods();//获取所有方法包括父类；\r\ngetmethod(指定方法名，方法参数类型.class);\r\nall:\r\ngetDeclaredmethods();\r\ngetDeclaredmethod();//setAccessible(true);\r\n```\r\n\r\n3.3 执行方法\r\n\r\n```java\r\ngetmethod对象.invoke(对象类)；\r\ngetName()//得到方法名\r\n```\r\n\r\n\r\n\r\n### 4.获取类名\r\n\r\n```java\r\n字节码文件名.getName();\r\n```\r\n\r\n# 反射特有性质\r\n\r\n通过字节码文件可以越过泛型检查，获取原始方法的类型\r\n\r\n```java\r\n ArrayList<Integer> al=new ArrayList<>();\r\n        Class<? extends ArrayList> aClass = al.getClass();\r\n        Method add = aClass.getDeclaredMethod(\"add\",Object.class);\r\n        add.invoke(al,\"Hello\");\r\n        System.out.println(al);\r\n```\r\n\r\n# 反射创建任意对象\r\n\r\n```java\r\n范例：\r\nProperties pr=new Properties();                       //把文件写入集合，获取键值对\r\n        FileReader fr=new FileReader(\"D:\\\\project\\\\day05-code\\\\class.txt\");\r\n        pr.load(fr);\r\n        fr.close();\r\n        String className = pr.getProperty(\"className\");       //通过properties特性，获取类名方法名\r\n        String method = pr.getProperty(\"method\");\r\n        Class<?> aClass = Class.forName(className);           //创建字节码文件，通过字节码文件引用创建构造器\r\n        Constructor<?> constructor = aClass.getConstructor();\r\n        Object s = constructor.newInstance();                 //通过class文件调用方法\r\n        Method method1 = aClass.getMethod(method);\r\n        method1.invoke(s);\r\n```\r\n\r\n# 注解\r\n\r\nJDK1.5以后的新特性\r\n\r\n## JDK中预定义的一些注解\r\n\r\n```java\r\n@Override：检测被该注解标注的方法是否继承自父类；\r\n@Deprecated:该注解标准的内容，表示已过时\r\n@SuppressWarnings：压制警告\r\n```\r\n\r\n## 自定义注解\r\n\r\n* 格式\r\n\r\n```java\r\n元注解\r\npublic @interface 注解名称{}\r\n\r\n```\r\n\r\n* 本质：注解本质上就是一个接口，该接口默认继承Annotation接口\r\n* 属性：接口中可以定义的成员方法；\r\n\r\n\r\n','框架的根源','2022-12-18','https://tse1-mm.cn.bing.net/th/id/OIP-C.P3NSGTdAYdyqy5zJpb5QXQHaEo?pid=ImgDet&rs=1','原创','','','反射','2023-02-20',19,1,1),(23,'# Tomcat(Web服务器)\r\n\r\n# web服务器概念\r\n\r\n## 服务器：安装了服务器软件的计算机\r\n\r\n## 服务器软件：接收用户的请求，处理请求，做出响应\r\n\r\n## web服务器软件：接收用户的请求，处理请求，做出响应。\r\n\r\n- ​	在web服务器软件中，可以部署web项目，让用户通过浏览器来访问这些项目	\r\n- ​	web容器\r\n\r\n## 常见的java相关的web服务器软件：\r\n\r\n* webLogic：oracle公司，大型的JavaEE服务器，支持所有的JavaEE规范，收费的。\r\n* webSphere：IBM公司，大型的JavaEE服务器，支持所有的JavaEE规范，收费的。\r\n* JBOSS：JBOSS公司的，大型的JavaEE服务器，支持所有的JavaEE规范，收费的。\r\n* Tomcat：Apache基金组织，中小型的JavaEE服务器，仅仅支持少量的JavaEE规范servlet/jsp。开源的，免费的。\r\n\r\n## 软件架构\r\n\r\n1. c/s：客户端/服务器端\r\n2. B/S:浏览器端/服务器端\r\n\r\n## 资源分类\r\n\r\n<img src=\"C:\\Users\\邵高祥\\Desktop\\java图片\\动态资源静态资源.PNG\" style=\"zoom:80%;\" />\r\n\r\n静态资源：一般客户端发送请求到web[服务器](https://www.baidu.com/s?wd=服务器&tn=24004469_oem_dg&rsv_dl=gh_pl_sl_csd)，web服务器从内存在取到相应的文件，返回给客户端，客户端解析并渲染显示出来。\r\n\r\n> 所有用户访问后，得到的结果是一样的，成为静态资源，静态资源可以被浏览器自动解析    如html，css，javascript\r\n\r\n动态资源：一般客户端请求的动态资源，先将请求交于web容器，web容器连接数据库，数据库处理数据之后，将内容交给web服务器，web服务器返回给客户端解析渲染处理。\r\n\r\n> 每个用户访问相同资源后，得到的结果可能就不一样，成为动态资源，动态资源被访问后，需要先转换为静态资源，再返回给浏览器 如Servlet/jsp......\r\n\r\n静态资源和动态资源的区别\r\n\r\n- 静态资源一般都是设计好的html页面，而动态资源依靠设计好的程序来实现按照需求的动态响应；\r\n- 静态资源的交互性差，动态资源可以根据需求自由实现；\r\n- 在服务器的运行状态不同，静态资源不需要与数据库参于程序处理，动态可能需要多个数据库的参与运算。\r\n\r\n## 网络通信三要素\r\n\r\n1. IP:电子设备(计算机)在网络中的唯一标识\r\n2. 端口：应用程序在计算机中的唯一标识(0~65536)\r\n3. 传输协议:规定了数据传输的规则	\r\n   - tcp:安全协议，三次握手，速度稍慢\r\n   - upd：不安全协议，速度快					\r\n\r\n# 启动\r\n\r\n1. bin/startup.bat ,双击运行该文件即可\r\n2. 访问：浏览器输入：http://localhost:8080 回车访问自己\r\n    http://别人的ip:8080 访问别人\r\n\r\n关于启动报错\r\n\r\n1.黑窗口一闪而过\r\n\r\n​	原因：没有正确配置JAVA_HOME环境变量\r\n\r\n2.启动后窗口内报错\r\n\r\n​	暴力：找到端口号，并杀死该进程\r\n\r\n​				cmd中netstat -ano找到端口号和PID，在任务管理器中通过PID杀死该进程\r\n\r\n​	温柔：修改自身的端口号\r\n\r\n​				conf/server.xml中修改\r\n\r\n​				一般会将tomcat默认端口号修改为80，80端口号是http协议中的默认端口号，好处是在访问时，不用输入端口号\r\n\r\n# 关闭\r\n\r\n1. 正常关闭\r\n\r\n   bin/shutdown.bat\r\n\r\n   窗口中ctrl+c\r\n\r\n2. 强制关闭\r\n\r\n   右上角关闭按钮；\r\n\r\n# 项目部署的三种方式\r\n\r\n1.直接将项目放到webapps目录下即可。\r\n\r\n​		/hello：项目的访问路径-->虚拟目录\r\n\r\n​		简化部署：将项目打成一个war包，再将war包放置到webapps目录下。\r\n\r\n​							war包会自动解压缩\r\n\r\n2.配置conf/server.xml文件    (不推荐，容易报错)\r\n		在<Host>标签体中配置\r\n		<Context docBase=\"D:\\hello\" path=\"/hehe\" />\r\n\r\n​		docBase:项目存放的路径\r\n\r\n​		path：虚拟目录\r\n\r\n3.在conf\\Catalina\\localhost创建任意名称的xml文件。在文件中编写\r\n		<Context docBase=\"D:\\hello\" />\r\n\r\n​		虚拟目录：xml文件的名称\r\n\r\n# 静态项目和动态项目：\r\n\r\n 目录结构\r\n		java动态项目的目录结构：\r\n					-- 项目的根目录\r\n						-- WEB-INF目录：\r\n							-- web.xml：web项目的核心配置文件\r\n							-- classes目录：放置字节码文件的目录\r\n							-- lib目录：放置依赖的jar包','基础概念','2022-12-20','https://i.postimg.cc/sxBkHmhK/tomcat.jpg','原创','','','tomcat','2022-12-20',13,1,1),(24,'# 计算机网络\r\n## 概念及功能\r\n### 概念\r\n计算机网络：是一个将分散的，具有独立功能的计算机系统，通过通信设备与线路连接起来，由功能完善的软件实现资源共享和信息传递的系统；\r\n计算机网络是互连的，自治的计算机集合\r\n- 互连：通过通信链路互联互通\r\n- 自治：无主从关系\r\n###功能\r\n1. 数据通信\r\n2. 资源共享：同一个计算机网络上的其他计算机可使用某台计算机的计算机资源行为，可共享硬件（如网络打印机），软件，数据\r\n### 组成部分\r\n1. 软件\r\n2. 硬件\r\n3. 协议：一系列规则和约定的集合','计网概念及功能','2022-12-21','https://i.postimg.cc/sxBkHmhK/tomcat.jpg','原创','','','计网基本概念','2022-12-21',5,33,1),(25,'# 概念\r\nredis是一款高性能的NOSQL系列的非关系型数据库  \r\nRedis是用C语言开发的一个开源的高性能键值对（key-value）数据库\r\n1. 键值型\r\n2. 单线程，每个命令具备原子性\r\n3. 低延迟，速度快（基于内存，IO复用，良好的编码）\r\n4. 支持数据持久化（定期持久）\r\n5. 支持主从集群，分片集群\r\n6. 支持多语言客户端\r\n\r\n# 数据结构\r\nredis存储的是：key,value格式的数据，其中key都是字符串，value有5种不同的数据结构\r\nvalue的数据结构：\r\n1. 字符串类型 string \r\n2. 哈希类型 hash ： map格式  \r\n3. 列表类型 list ： linkedlist格式。支持重复元素\r\n4. 集合类型 set  ： 不允许重复元素\r\n5. 有序集合类型 sortedset：不允许重复元素，且元素有顺序\r\n\r\n# 通用命令\r\n- keys：查看符合模板的所有key，不建议再生产环境设备上使用\r\n- del：删除一个指定的key\r\n- exists：判断key是否存在\r\n- expire：给一个key设置有效期，有效期到期时该key会被自动删除\r\n- ttl：查看一个key的剩余有效期\r\n通过 help [command] 可以查看一个命令的具体用法','基本概念与命令操作','2022-12-31','https://i.postimg.cc/sxBkHmhK/tomcat.jpg','原创','','','Redis入门','2023-02-20',14,27,1),(26,'# 一、线性回归模型概述\r\n\r\n线性回归是利用函数对一个或多个自变量和因变量之间关系进行建模的一种回归分析。**简单来说，就是试图找到自变量与因变量之间的关系。**\r\n\r\n![](https://blog-1306153177.cos.ap-beijing.myqcloud.com/202302220829782.png)\r\n\r\n# 二、线性回归案例：房价预测\r\n\r\n## 1、案例分析\r\n\r\n> 问题：现在要预测140平方的房屋的价格，应该怎么做呢？\r\n>\r\n> 答案：当然是建立于一个预测模型，根据输入的特征，输出预测值（房价）。\r\n>\r\n> 进一步：使用线性回归模型如何呢？\r\n\r\n采用线性方程$f(x)=mx+b$来拟合房价走势。其中，x为房屋的面积，f(x)为模型输出的预测价格。\r\n\r\n```python\r\nimport itertools\r\nimport numpy as np\r\ndata = np.array([[80,200],\r\n             [95,230],\r\n             [104,245],\r\n             [112,247],\r\n             [125,259],\r\n             [135,262]])\r\n\r\n#输出的所有组合保存在列表 com_lists中。\r\ncom_lists = list(itertools.combinations(data, 2))\r\n```\r\n\r\n**对于预测模型 ，发现和获得参数m和b的过程称为模型训练。**\r\n\r\n```python\r\n# 定义容器列表ms和bs，分别存放不同组合获得的参数 m 和 b。\r\nms = []\r\nbs = []\r\n\r\nfor comlist in com_lists:\r\n    x1, y1 = comlist[0]\r\n    x2, y2 = comlist[1]\r\n    # 因为有下列等式成立\r\n    # y1 = m * x1 + b\r\n    # y2 = m * x2 + b\r\n    #所以\r\n    m = (y2 - y1) / (x2 - x1)\r\n    b = y1 - m * x1  # or b = y2 - m * x2\r\n    ms.append(m)\r\n    bs.append(b)\r\n\r\nm,b = np.mean(ms),np.mean(bs)\r\nprint(ms, bs)	\r\nprint(m,b)\r\n```\r\n\r\n> 模型的参数m和b使用ms和bs的均值靠谱吗？\r\n>\r\n> 依据什么来判断？\r\n\r\n一般情况下，评估模型，通常采用**均方误差**来进行评估。\r\n\r\n## 2、均方误差\r\n\r\n均方误差（mean-square error，MSE）是反映估计量与被估计量之间差异程度的一种度量。均方误差是衡量数据偏离真实值的距离，是差值的平方和的平均数。\r\n\r\n![](https://blog-1306153177.cos.ap-beijing.myqcloud.com/202302221036207.png)\r\n\r\n评估预测模型的好坏（m和b参数值是否合适），就是模型 $f(x)=mx+b$ 这个预测模型得到的预测结果f(x)与标记值y 接近的程度。\r\n\r\n通常，MSE公式前面的1/*N* 保留和去掉关系不大，也可以将上面的公式简化为：\r\n\r\n![](https://blog-1306153177.cos.ap-beijing.myqcloud.com/202302221037899.png)\r\n\r\n```python\r\n#计算均方误差\r\nlosses = []\r\nfor x,y in data:\r\n    predict =  m * x + b\r\n    loss = (y -  predict)**2\r\n    losses.append(loss)\r\n\r\nprint(losses)\r\nprint(np.mean(losses))\r\n```\r\n\r\n## 3、梯度下降算法\r\n\r\n**梯度：**梯度是一个**矢量**，在其方向上的**方向导数**最大，也就是函数在该点处沿着梯度的方向变化最快，变化率最大。\r\n\r\n> 当函数y=*f*（x）的自变量x在一点x0上产生一个增量Δx时，函数输出值的增量Δy与自变量增量Δx的比值，在Δx趋于0时的极限a如果存在，a即为在x0处的导数，记作发或d*f*(x0)/dx。\r\n>\r\n> 导数的**本质**是通过极限的概念对函数进行局部的线性逼近（目标时获得极值）。\r\n>\r\n> ![](https://blog-1306153177.cos.ap-beijing.myqcloud.com/202302221041955.gif)\r\n\r\n在机器学习中**逐步逼近**、**迭代求解**最优化时，经常会使用到梯度，沿着**梯度**向量的**方向**是函数增加的最快，容易找最大值。反过来，沿着梯度向量**相反**的地方，梯度减少的最快，容易找到最小值。\r\n\r\n循着这样的思路，获得**理想预测模型**的目标是使得损失函数（代价函数）更小，而获取极小值，可以采用梯度下降方法。\r\n\r\n**梯度下降方法**：通过计算梯度，一步步迭代求解，不断寻找损失函数的极小值点，以获得最佳的*f*(x)。\r\n\r\n![](https://blog-1306153177.cos.ap-beijing.myqcloud.com/202302221046712.png)\r\n\r\n## 4、梯度下降算法的实现\r\n\r\n1、首先，确定模型函数和损失函数（f(x)=mx+b,  loss=MSE）\r\n\r\n![](https://blog-1306153177.cos.ap-beijing.myqcloud.com/202302221051964.png)\r\n\r\n2、设定模型参数**初始值**和算法**终止条件**（例如：m，b，lr，epoch）\r\n\r\n3、开始迭代\r\n\r\n4、计算损失函数的梯度（参数的偏导数）\r\n\r\n![](https://blog-1306153177.cos.ap-beijing.myqcloud.com/202302221052346.png)\r\n\r\n5、步长乘以梯度，得到当前位置下降的距离，更新参数\r\n\r\n![](https://blog-1306153177.cos.ap-beijing.myqcloud.com/202302221052201.png)\r\n\r\n6、判断**迭代过程**是否终止（例如循环迭代次数满足），继续则跳转到3，否则退出。\r\n\r\n```python\r\n# 实现梯度下降的算法\r\n# 预测模型： f(x) = mx+b ，用于预测房屋的真实价格\r\n\r\nimport numpy as np\r\nimport matplotlib.pyplot as plt\r\ndata = np.array([[80,200],\r\n                 [95,230],\r\n                 [104,245],\r\n                 [112,247],\r\n                 [125,259],\r\n                 [135,262]])\r\n\r\n# 求解f(x) = mx + b  ，其中（x，y）来自data，y为标记数据\r\n# 目标：y 与 f(x)之间的差距尽量小\r\n\r\n# 初始化参数\r\nm = 1\r\nb = 1\r\nlr = 0.00001\r\n\r\n#   梯度下降的函数\r\ndef gradientdecent(m, b, data, lr):  # 当前的m，b和数据data，学习率lr\r\n\r\n    loss, mpd, bpd = 0, 0, 0  # loss 为均方误差，mpd为m的偏导数，\r\n                              # bpd为b的偏导数\r\n    for xi, yi in data:\r\n        loss += (m * xi + b - yi) ** 2     # 计算mse\r\n        bpd += (m * xi + b - yi) * 2       # 计算loss/b偏导数\r\n        mpd += (m * xi + b - yi) * 2 * xi  # 计算loss/m偏导数\r\n    \r\n    # 更新m,b\r\n    N = len(data)\r\n    loss = loss / N\r\n    mpd = mpd / N\r\n    bpd = bpd / N\r\n    m = m - mpd * lr\r\n    b = b - bpd * lr\r\n    return loss, m, b\r\n\r\n# 训练过程，循环一定的次数，或者符合某种条件后结束\r\nfor epoch in range(3000000):\r\n    mse,m,b = gradientdecent(m,b,data,lr)\r\n    if epoch%100000 == 0:\r\n        print(f\"loss={mse:.4f},m={m:.4f},b={b:.4f}\")\r\n```\r\n\r\n结果是：loss=42.8698，虽然相比之前手工得到的f(x)=mx+b模型的loss=70.89变小了不少，但是仍然无法接近0。这是因为，**线性模型无法有效拟合现实世界中真实曲线的变化趋势**。\r\n\r\n# 三、利用PyTorch进行梯度计算\r\n\r\n## 1、梯度的自动计算\r\n\r\n在多元函数中，某点的梯为偏导数（由每个自变量所对应的偏导数所组成的向量）。如损失函数的$J(θ, x) =fθ(x) - y$ ，且$θ = [θ_1,θ_2,...,... ,θ_k]$。 \r\n\r\n对于线性回归模型 $f_θ(x) = mx + b$， 其中$θ_1=m$和$θ_2=b$。$f_θ(x)$的计算过程就是前向传播。\r\n\r\n使用梯度下降方法确定模型 $fθ(x)$ 中的参数 $θ$ ，以及参数 $θ$ 的更新都是在向后传播的过程中完成的。 \r\n\r\n> PyTorch 如何识别这些需要计算梯度的参数？\r\n>\r\n> 无需为所有张量计算梯度！\r\n\r\n将 模型参数张量 $θ$ 的 requires_grad属性设置为True，在前向传播过程中，将会在该张量的整个传播链条上，生成计算梯度的函数，并预留保存梯度的存储空间\r\n\r\n```python\r\nimport torch\r\n\r\n# 对四个张量自动赋值，并设置某个张量（例如 m1）需要计算偏导数（需要后向传播）\r\nm1 = torch.randn(1, requires_grad=True)\r\nm2 = torch.randn(1, requires_grad=False)\r\nb1 = torch.randn(1)\r\nb2 = torch.randn(1)\r\n\r\n\r\ndef forward1(x):\r\n    global m1, b1\r\n    return m1 * x + b1\r\n\r\n\r\ndef forward2(x):\r\n    global m2, b2\r\n    return m2 * x + b2\r\n\r\n\r\ndata = [[2, 5]]  # m=2 b=1 最佳\r\nx = data[0][0]\r\ny = data[0][1]\r\n\r\n# 1.前向传播,构建了计算图\r\npredict1 = forward1(x)\r\npredict2 = forward2(x)\r\n\r\n# 构造损失（代价）函数\r\nloss1 = (y - predict1) ** 2\r\nloss2 = (y - predict2) ** 2\r\n\r\n# 2.向后传播\r\nloss1.backward()\r\n# loss2.backward()  # why?\r\n\r\n# 查看计算图中是否保留了计算梯度的函数\r\nprint(loss1.grad_fn)  # 有\r\nprint(loss2.grad_fn)  # 无\r\n\r\n# 向后传播发生后， 查看模型参数 m1和m2 是否记录了梯度值\r\nprint(m1.grad)  # 已记录\r\nprint(m2.grad)  # loss2 无法进行向后传播，无记录\r\n\r\n# 手工计算m1的偏导值 mpd1，并与 m1.grad 比较\r\nmpd1 = 2 * (y - (m1 * x + b1)) * (-1 * x)\r\nprint(mpd1 == m1.grad)\r\n```\r\n\r\n![](https://blog-1306153177.cos.ap-beijing.myqcloud.com/202302230957592.png)\r\n\r\n## 2、多层神经网络的梯度计算\r\n\r\n为了完成更复杂的回归或分类任务，模型的构建会更加复杂（嵌套层次更多，方法嵌套调用）。\r\n\r\n对于复杂函数，一个子方法的输出，是另一个子方法的输入。\r\n\r\n对应到神经网络模型，一个子方法就是神经网络中的一层。上一层中神经元的输出，是下一层神经元的输入。\r\n\r\n![](https://docimg5.docs.qq.com/image/VM3DTpZux08S44hE7VcU0w.png?w=405&h=73)\r\n\r\n**前向传播** forward：\r\n\r\n$y=f(x)$ 、$z=g(y)$\r\n\r\n**向后传播** backward：\r\n\r\n1、要得到 x 的梯度![](https://blog-1306153177.cos.ap-beijing.myqcloud.com/202302231000259.svg) \r\n\r\n2、先从![](https://blog-1306153177.cos.ap-beijing.myqcloud.com/202302231000279.svg) 开始\r\n\r\n3、然后![](https://blog-1306153177.cos.ap-beijing.myqcloud.com/202302231000621.svg)  \r\n\r\n4、最后![](https://blog-1306153177.cos.ap-beijing.myqcloud.com/202302231001428.svg)\r\n\r\n```python\r\n# 多层神经网络计算梯度案例\r\n\r\n# x中的特征数据批量定义，batch=3\r\nx = torch.randn(3, requires_grad=True)  # x=[x1,x2,x3]\r\n\r\n# 第二层定义\r\ny = x + 2\r\n\r\n# 输出层定义\r\nz = 3 * y ** 2  # z=3y2\r\n\r\n# 建立J函数，可向后传播（此处J=z.mean(),该函数无实际意义）\r\nz = z.mean()  # z=(z1+z2+z3)/3  只有标量可以向后传播\r\n\r\n# 可以打印并观察x,y,z， 计算梯度的传播链条已经建立\r\n\r\n# 向后传播, 调用链条中的梯度计算函数（求偏导）\r\nz.backward()\r\n\r\n# 打印（在向后传播过程中，自动计算得到的） x 的梯度值\r\nprint(x.grad)\r\n# 注意，从z开始向后传播， 手工推导可知：dJ/dx= dz/dx = 2*(x+2)\r\nprint(2 * (x + 2))  \r\n# 比较下，手工计算和自动梯度下降方法得到的值是否相同\r\n```\r\n\r\n> 很多时候，y 与 z 无需计算梯度。\r\n>\r\n> 因此，当确定不会调用Tensor.backward()时，禁用梯度计算将减少原本需要张量在requires_grad=True时的计算的内存消耗。\r\n\r\n在`with torch.no_grad()`的作用域中，所有的张量都不进行梯度计算。\r\n\r\n```python\r\n# a要求计算梯度，则吧需要预留资源（偏导函数、梯度占用空间等）\r\na = torch.randn(2, 2, requires_grad=True)\r\nb = (a ** 2)\r\nprint(b.grad_fn)\r\nprint(b.requires_grad)\r\n\r\n# with作用域设置为no_grad，前向传播才不会为其保留偏导传播链\r\nwith torch.no_grad():\r\n    c = (a ** 2)\r\nprint(c.grad_fn)\r\nprint(c.requires_grad)\r\n```\r\n\r\n## 3、梯度清空\r\n\r\n在PyTorch中，求解张量的梯度的方法是`torch.autograd.backward`，多次运行该函数，会将计算得到的梯度累加起来。\r\n\r\n```python\r\nimport torch\r\n\r\n# 首先定义张量（需要计算梯度）\r\nx = torch.ones(4, requires_grad=True)\r\n\r\n# 将x作为输入，分别建立两个 复合函数 y 和 z\r\n# 1.第一个复合函数\r\ny = (2 * x + 1).sum()  # 问题：为什么要sum()???\r\n# 2.第二个复合函数\r\nz = (2 * x).sum()\r\n\r\n# 调用 y 和 z 的向后传播（自动计算梯度）#不是J的向后传播都是耍流氓！\r\ny.backward()\r\nprint(\"dy/dx偏导数:\", x.grad)\r\nz.backward()\r\nprint(\"dz/dx偏导数:\", x.grad)\r\n```\r\n\r\n![](https://blog-1306153177.cos.ap-beijing.myqcloud.com/202302231006230.png)\r\n\r\n**根据上面的结果，可知如果对张量y和z分别求x的梯度，关于x的偏导会累加到 x.grad 中。**\r\n\r\n**为了避免累加，通常计算梯度后，先清空梯度，再进行其他张量的梯度计算。PyTorch中，使用 grad.zero_() 清空梯度。**\r\n\r\n```python\r\nimport torch\r\n\r\nx = torch.ones(4, requires_grad=True)\r\ny = (2 * x + 1).sum()\r\nz = (2 * x).sum()\r\n\r\ny.backward()\r\nprint(\"第一次偏导:\", x.grad)\r\n\r\nx.grad.zero_()\r\nz.backward()\r\nprint(\"第二次偏导:\",x.grad)\r\n```\r\n\r\n![](https://blog-1306153177.cos.ap-beijing.myqcloud.com/202302231010727.png)\r\n\r\n神经网络模型在训练时，需要循环迭代来更新参数。\r\n\r\n如果求出的梯度，一直叠加，就会导致结果没有意义。因此需要对张量的偏导进行清空。\r\n\r\n此外，优化器也提供了类似清空梯度的函数：zero_grad()。\r\n\r\n```python\r\noptimizer = torch.optim.SGD([x], lr=0.1)\r\n# 更新参数，自动调用向后传播，并自动更新模型的参数\r\noptimizer.step()     \r\noptimizer.zero_grad()\r\nprint(optimizer)\r\n```\r\n\r\n## 4、正向和向后传播的函数定义\r\n\r\n**神经网络本质上是一个非常复杂且有大量参数的复合函数（函数链条）。**\r\n\r\n### 1）前向传播\r\n\r\n在PyTorch中，前向传播就是通过函数的定义来构建计算图（传播链条），形成神经网络的基本框架，并得到神经网络的输出（预测值）。\r\n\r\n例如，$y = (a+b)*(b+c)$。PyTorch 利用 forward函数的定义，实现了“计算图”的构建。\r\n\r\n![](https://blog-1306153177.cos.ap-beijing.myqcloud.com/202302232159596.png)\r\n\r\n### 2）向后传播\r\n\r\n根据计算图，在向后传播过程，通过计算参数 w 的梯度，并不断迭代更新参数 w，目标是使 J（代价）函数获得最小值。\r\n\r\n![](https://blog-1306153177.cos.ap-beijing.myqcloud.com/202302232200129.png)\r\n\r\n> 前向传播算法定义神经网络（计算图），初始参数为随机数(一次性)\r\n>\r\n> 向后传播算法优化迭代更新模型的参数值（多次），获得最优模型\r\n\r\n### 3）前向传播函数的定义\r\n\r\n以线性回归模型 $f(x)=mx+b$，其中 b=0为例。该函数的输入数据为x, 参数为w, 评估模型使用loss=MSE。\r\n\r\n```python\r\nimport torch\r\n# 定义测试数据\r\nx = torch.tensor(1.)   # 输入特征\r\ny = torch.tensor(2.)   # 标记值\r\nw = torch.tensor(1.,requires_grad=True)    # 模型参数值，随机赋值1\r\n\r\n# 正向传播 : f(x) = wx     \r\n# 模型的定义，根据 x，y 值可知参数 w = 2\r\ndef forward(x,w):   \r\n    # 计算预测值 pred，并返回\r\n    pred = w*x\r\n    return pred\r\n\r\n# 调用正向传播 \r\npredict = forward(x,w)\r\nprint(predict)\r\n```\r\n\r\n> 初始值可以是任意值\r\n\r\n### 4）向后传播函数的定义\r\n\r\n实践中，预测模型的最佳参数不会这样容易得知。\r\n\r\n通常需要多次迭代（训练），使用梯度下降方法计算模型参数的梯度，并更新模型参数，使损失函数取值最小，因此在向后传播过程中，模型参数将会不断逼近最优值，直到终止训练。\r\n\r\n在本例中，模型参数 w 开始时被随机赋值为 1。在向后传播过程中，模型参数 w 将从 1 迭代更新为（接近） 2 ，该过程就是模型的训练过程。\r\n\r\n![](https://blog-1306153177.cos.ap-beijing.myqcloud.com/202302232202778.png)\r\n\r\n在PyTorch中，如果**计算**损失函数的计算结果为张量 **loss**（维度为0的张量），则调用 **loss.backward()**向后传播，PyTorch将自动为模型参数计算梯度值。\r\n\r\n```python\r\n# 预测模型：f(x)=wx\r\n# 输入特征数据、标记值：x，y （可观察）\r\n# 模型参数：w（赋随机值1）\r\n# 预测值已得到： predict = forward(x,w)\r\n\r\nloss = (predict - y)**2    #  MSE = (预测值 - 真实值)的平方\r\nloss.backward()print(\"此时,loss关于w的偏导值:\", w.grad)\r\n```\r\n\r\n## 5、模型训练的问题与优化\r\n\r\n训练模型的过程，就是不断迭代，在**向后传播**过程中，不断采用梯度下降方法计算模型参数的梯度方向，并沿着该方向不断迭代，以修正模型的参数，**目标是**使得**损失函数**结果为最小，这个过程就是寻找最优参数值的过程。\r\n\r\n![](https://blog-1306153177.cos.ap-beijing.myqcloud.com/202302232203690.png)\r\n\r\n模型训练过程包括以下步骤：\r\n\r\n1. 正向传播\r\n2. 计算损失\r\n3. 向后传播\r\n4. 更新参数\r\n5. 清空梯度\r\n\r\n```python\r\nimport torch\r\n\r\n# 模型为： f(x)=wx     \r\n# 定义测试数据（与之前的数据不同，为成批数据，batch=4）可pycharm调试观察\r\nX = torch.tensor([1,2,3,4],dtype=torch.float32)\r\nY = torch.tensor([2,4,6,8],dtype=torch.float32)\r\nW = torch.tensor(0,dtype=torch.float32,requires_grad=True)\r\n# 1.正向传播\r\ndef forward(w,x):   #构建计算图\r\n    return x*w\r\n\r\n# 2.计算损失\r\ndef lossFunction(y_pred,y):           #确定损失函数\r\n    return ((y_pred - y)**2).mean()   #成批计算，从X和Y的定义也可以看出\r\n\r\n# 模型训练过程\r\nlearning_rate = 0.01\r\nfor epoch in range(100):     # epoch为训练的次数\r\n    # 1.正向传播\r\n    pred = forward(W, X)\r\n    # 2.计算损失\r\n    loss = lossFunction(pred, Y)\r\n    # 3.向后传播\r\n    loss.backward()\r\n    # 4.更新参数\r\n    W.data = W.data - learning_rate * W.grad\r\n    # 5.清空梯度\r\n    W.grad.zero_()\r\n\r\n    if epoch%10 == 0:\r\n        print(f\"loss={loss.item()},w={W.item()}\")\r\n\r\n```\r\n\r\n## 6、使用PyTorch进行模型训练\r\n\r\n### 1）PyTorch中的常用损失函数\r\n\r\n**（1）均方差损失函数（MSELoss）**\r\n\r\n计算预测值（Predict） 和标记值 （Label） 之差的均方差。\r\n\r\ntorch.nn.MSELoss()\r\n\r\n**（2） 交叉熵损失 （CrossEntropyLoss）**\r\n\r\n在多分类任务中，交叉熵描述了预测分类和标记间不同概率分布的差异。\r\n\r\ntorch.nn.CrossEntropyLoss()\r\n\r\n**（3） 二进制交叉熵损失（BCELoss）**\r\n\r\n二分类任务时的交叉熵计算函数。\r\n\r\ntorch.nn.BCELoss()\r\n\r\n```python\r\nimport torch \r\nimport torch.nn as nn\r\n\r\n# 初始化数据集\r\nX = torch.tensor([1,2,3,4],dtype=torch.float32)\r\nY = torch.tensor([2,4,6,8],dtype=torch.float32)\r\nw = torch.tensor(0.0, dtype=torch.float32, requires_grad=True)\r\n\r\ndef forward(x):\r\n    return w*x\r\n\r\n# 测试代码\r\npre = forward(X)\r\nprint(pre)\r\n\r\n# 均方差计算预测值和真实值之间的距离\r\nloss = torch.nn.MSELoss()\r\n\r\n# 计算此时的损失\r\ny_pre = forward(X)\r\nl = loss(y_pre,Y)\r\nprint(f\"此时的损失:{l}\")\r\n```\r\n\r\n### 2）优化器\r\n\r\n优化器的目标就是：根据损失函数，找到更新参数的最优方法或路径。\r\n\r\n随机梯度下降法（stochastic gradient descent，SGD）\r\n\r\n```python\r\noptimizer = torch.optim.SGD([W], lr=learning_rate)	#定义\r\n# 第一个参数张量 [W] 为模型中要更新的参数\r\n# 第二个lr 为学习率（步长）\r\n\r\noptimizer.step()       # 根据参数梯度，对模型中的参数进行更新。\r\noptimizer.zero_grad()  # 清空模型参数梯度，防止累计情况发生\r\n```\r\n\r\n优化器可一次性对所有模型参数变量进行更新，免去手动更新参数的繁琐（Impossible Mission不可能完成的任务）。 \r\n\r\n```python\r\nimport torch\r\nimport torch.nn as nn\r\n\r\n# 初始化数据集\r\nX = torch.tensor([1,2,3,4],dtype=torch.float32)\r\nY = torch.tensor([2,4,6,8],dtype=torch.float32)\r\nw = torch.tensor(0.0, dtype=torch.float32, requires_grad=True)\r\n\r\ndef forward(x):\r\n    return w*x\r\n\r\n# 均方差计算预测值和真实值之间的距离\r\nloss = torch.nn.MSELoss()\r\n\r\n# 首先，定义损失函数和优化器\r\nlearning_rate = 0.01\r\nn_iters = 100\r\nloss = nn.MSELoss()\r\noptimizer = torch.optim.SGD([w], lr=learning_rate)\r\nprint(optimizer)\r\n#  然后, 根据正向传播结果, 更新梯度,进而更新权重值\r\n#  开始模型训练\r\nfor epoch in range(n_iters):\r\n    # 1.正向传播\r\n    y_pre = forward(X)\r\n    # 2.计算损失\r\n    l = loss(Y, y_pre)\r\n    # 3.向后传播（计算梯度）\r\n    l.backward()\r\n    # 4.更新权重,即向梯度反方向走一步，由优化器完成\r\n    optimizer.step()\r\n    # 5.清空梯度，由优化器完成\r\n    optimizer.zero_grad()\r\n\r\n    if epoch % 10 == 0:\r\n        print(f\"epoch:{epoch}, w={w},loss={l:.8f}\")\r\n```\r\n\r\n### 3）模型定义\r\n\r\n基于Pytorch，构建神经网络，并进行训练的代码步骤如下（特征数据X，标记数据Y）\r\n\r\n1. 定义模型（确定模型对象与模型参数，构建计算图（传播链））\r\n2. 定义损失（代价）函数loss\r\n3. 定义优化器optimizer,利用其优化模型参数\r\n4. 通过model(X) 调用forward，前向传播\r\n5. 利用loss(Y, y_pre)计算模型的损失\r\n6. 利用loss.backward() 向后传播，计算模型参数的梯度\r\n7. 利用optimizer.step() 更新模型参数的权重\r\n8. 利用optimizer.zero_grad() 清空模型参数的梯度\r\n9. 重复4-8的操作，进行训练直到达到预定结束条件\r\n\r\n使用PyTorch可以极大的简化我们编程的难度。\r\n\r\n通常只需要改变模型、损失函数和优化器的定义形式，就能快速搭建神经网络模型，进行训练以解决不同的深度学习问题。\r\n\r\n# 四、利用PyTorch定义神经网络模型类\r\n\r\n在PyTorch中，自定义神经网络类，通常继承于nn.Module类，并对子类的构造函数（init）和前向传播函数（forward）进行重新实现。\r\n\r\n## 1、利用sklearn生成模拟数据\r\n\r\n```python\r\nimport numpy as np \r\nfrom sklearn import datasets\r\nimport matplotlib.pyplot as plt\r\n\r\nX_numpy,Y_numpy = datasets.make_regression(\r\n    n_samples=100,\r\n    n_features=1,\r\n    noise=20,\r\n    random_state=12\r\n)\r\n\r\nplt.plot(X_numpy,Y_numpy,\"ro\")  # 红色圆点\r\nplt.show()\r\n\r\n```\r\n\r\n![](https://blog-1306153177.cos.ap-beijing.myqcloud.com/202302232208435.png)\r\n\r\n将数据集转成PyTorch使用的张量形式。\r\n\r\n```python\r\nimport torch \r\n# 将numpy 的数据类型转成tensor\r\nX = torch.from_numpy(X_numpy.astype(np.float32))\r\nY = torch.from_numpy(Y_numpy.astype(np.float32))\r\n\r\nprint(X.shape,Y.shape)\r\n# 对Y进行格式统一\r\nY = Y.view(100,1)\r\n# 模型训练\r\nprint(X.shape,Y.shape)\r\n```\r\n\r\n## 2、 神经网络类的定义\r\n\r\n```python\r\n 线性函数模型的定义和训练：\r\n# 1. 定义模型（包括正向传播方法forward）\r\nn_samples,in_features = X.shape\r\nn_labels, out_features = Y.shape\r\n\r\n# 搭建自己的神经网络,并创建模型对象\r\nclass MyModel(torch.nn.Module):\r\n    # 初始化函数的定义，定义神经网络和参数\r\n    def __init__(self, in_features_len, out_features_len):\r\n        super(MyModel, self).__init__()\r\n        # 构建线性层\r\n        self.linear = torch.nn.Linear(\r\n                           in_features_len, \r\n                           out_features_len\r\n        )\r\n\r\n    # 向前传播，构建计算图\r\n    def forward(self, x):\r\n        \"\"\"重写了父类的forward函数，正向传播\"\"\"\r\n        out = self.linear(x)\r\n        return out\r\n\r\nmodel = MyModel(in_features,out_features)\r\n\r\n# 2.定义损失（代价）函数loss\r\nlossF = torch.nn.MSELoss()\r\n\r\n# 3. 定义优化器optimizer,利用其管理模型参数\r\noptimizer = torch.optim.SGD(model.parameters(),lr=0.1)\r\nprint(list(model.parameters()))\r\n\r\n# 模型训练\r\nn_iters = 100\r\nfor epoch in range(n_iters):\r\n       # 4. 通过model(X) 调用forward，进行前向传播\r\n       pred = model(X)\r\n       # 5. 利用loss(Y, y_pre)计算模型的损失\r\n       l = lossF(Y,pred)\r\n       #6. 利用loss.backward() 进行向后传播，计算模型的梯度\r\n       l.backward()\r\n       # 7. 利用optimizer.step() 更新权重\r\n       optimizer.step()\r\n       # 8. 利用optimizer.zero_grad() 清空梯度\r\n       optimizer.zero_grad()\r\n       # 打印结果\r\n       if epoch%10 == 0:\r\n           w,b = model.parameters()\r\n           # print(f\"epoch:{epoch},w={w[0][0].item()}\")\r\n           print(f\"loss={l.item():.8f},w={w.item():.4f},\r\n                                                 b = {b.item()}\")\r\n\r\nwith torch.no_grad():\r\n    predicted = model(X).numpy()\r\n\r\nplt.plot(X_numpy,Y_numpy,\"ro\")\r\nplt.plot(X_numpy,predicted,\"b\")\r\nplt.show()\r\n```\r\n\r\n![](https://blog-1306153177.cos.ap-beijing.myqcloud.com/202302232212656.png)','计网概念及功能','2023-03-02','https://tse1-mm.cn.bing.net/th/id/OIP-C.P3NSGTdAYdyqy5zJpb5QXQHaEo?pid=ImgDet&rs=1','转载','','','线性回归模型','2023-03-02',32,25,1),(27,'123412341234123423141asdkfjaklsdfjaklsdfasdfasdfasdfasdfasdfasd','123','2023-03-03','https://tse1-mm.cn.bing.net/th/id/OIP-C.P3NSGTdAYdyqy5zJpb5QXQHaEo?pid=ImgDet&rs=1','转载','','','送了康','2023-03-03',9,1,1),(28,'# cmp\r\n\r\n```c++\r\nbool \r\n```\r\n\r\n\r\n\r\n# STL\r\n\r\n## vector\r\n\r\n定义\r\n\r\n``` c++\r\nvector <int> a;\r\nvector <int> a(10,1); //初始化vector长度为10,且每个数为3\r\nvector <int> a[10];	  //初始化一个vector数组，有10个vector\r\n```\r\n\r\n方法\r\n\r\n```c++\r\nsize(); 				//元素个数\r\nempty();				//是否为空\r\nclear();				//清空vector\r\nfront()/back(); 		//返回首/尾\r\npush_back()/pop_back();	//放入/删除尾\r\nbegin()/end();			//首/尾元素\r\n```\r\n\r\n遍历方式\r\n\r\n```c++\r\nfor(auto x : a) cout << x << endl;\r\nfor(int i = 0; i < a.size(); i ++) cout << a[i] << endl;\r\nfor(auto i = a.begin(); i != a.end(); i ++ ) cout << *i << endl;\r\n```\r\n\r\n## 二元组pair\r\n\r\n定义\r\n\r\n```c++\r\npair<int, string>p; //类型可以自定义\r\npair<int, pair<int, string>>p; //嵌套\r\np = {1,\"sgx\"}\r\n```\r\n\r\n方法\r\n\r\n```C++\r\nfirst; //第一个元素\r\nsecond;//第二个元素\r\n```\r\n\r\n## string\r\n\r\n定义\r\n\r\n```c++\r\nstring a = \"sgx\";\r\n```\r\n\r\n操作\r\n\r\n```c++\r\na += \"def\";\r\na += \"c\";\r\na[i]; //可以直接操作某个字符\r\n```\r\n\r\n方法\r\n\r\n```c++\r\nsubstr();\r\n例如：substr(1,2); //从下标1开始截取两个,如果超过字符串长度，则截取到末尾\r\n     substr(1);	  //从下标1截取到末尾\r\nc_str(); \r\n例如：printf(\"%s\",a.c_str());\r\nsize()/length();\r\n```\r\n\r\n## queue\r\n\r\n定义\r\n\r\n```c++\r\nqueue<int> q;\r\nq = queue<int>();\r\n```\r\n\r\n\r\n\r\n方法\r\n\r\n```c++\r\npush(); 	//向对头插入一个元素\r\nfront();	//返回对头元素\r\nback(); 	//返回队尾元素\r\npop();  	//弹出对头元素\r\nsize();\r\nempty();\r\n```\r\n\r\n## priority_queue\r\n\r\n优先队列，默认是大根堆\r\n\r\n定义\r\n\r\n```c++\r\npriority_queue<int> heap;							 //大根堆\r\npriority_queue<int, vector<int>, greater<int>> heap; //小根堆\r\n```\r\n\r\n方法\r\n\r\n```c++\r\npush(); //插入一个元素\r\ntop();  //返回堆元素\r\npop();  //返回堆顶元素\r\n```\r\n\r\n## stack\r\n\r\n定义\r\n\r\n```c++\r\nstack<int> stack;  \r\n```\r\n\r\n方法\r\n\r\n```c++\r\npush(); //向栈顶加入一个元素\r\ntop(); 	//返回栈顶元素\r\npop();	//弹出栈顶元素\r\nsize();\r\nempty();\r\n```\r\n\r\n## deque\r\n\r\n双端队列\r\n\r\n方法\r\n\r\n```c++\r\nsize();\r\nempty();\r\nclear();\r\nfront()/back();\r\npush_back()/pop_bakc();\r\npush_front()/pop_front();\r\nbegin()/end();\r\n```\r\n\r\n## set/multiset\r\n\r\n自动排序，set不允许插入相同的值，multiset不会\r\n\r\n方法\r\n\r\n```c++\r\ninsert(); //插入一个数\r\nfind();   //查找一个数\r\ncount();  //返回一个某一个数得个数\r\nerase();\r\n	(1)输入是一个数，删除所有这个数\r\n    (2)输入是一个迭代器，删除这个迭代器\r\nlower_bound()/upper_bound()\r\n     lower_bound(x):返回大于等于x的最小的数的迭代器\r\n     upper_bound(x):返回大于x的最小的数组的迭代器\r\nsize();\r\nempty();\r\nclear();\r\nbegin()/end() ++ , --\r\n```\r\n\r\n## map/multimap\r\n\r\n定义\r\n\r\n```c++\r\nmap<String,int> map;\r\n```\r\n\r\n使用\r\n\r\n```c++\r\nmap[\"sgx\"] = 1;\r\ncout << map[\"sgx\"] << endl;\r\n```\r\n\r\n方法\r\n\r\n```c++\r\ninsert(); //插入的pair\r\nerase();  //输入的参数是pair或者迭代器\r\nfind();\r\n[];\r\nlower_bound()/upper_bound();\r\nsize();\r\nempty();\r\nclear();\r\nbegin()/end() ++ , --\r\n```\r\n\r\n判断key是否为空\r\n\r\n1. find：如果key存在，则find返回key对应的迭代器，如果key不存在，则find返回尾后迭代器 .end()。可以参考下面的示例来判断key值是否存在\r\n\r\n```c++\r\nif (mymap.find(key) == mymap.end())\r\n   cout << \"没有这个key\" << endl;\r\n```\r\n\r\n2. cout函数：count函数用于统计key值在map中出现的次数，map的key不允许重复，因此如果key存在返回1，不存在返回0\r\n\r\n```c++\r\nif (mymap.count(key) == 0)\r\n    cout << \"no this key\" << endl;\r\n```\r\n\r\n\r\n\r\n\r\n\r\n## unordered\r\n\r\nunordered_set,unordered_map,unorder_multiset,unorder_multimap\r\n\r\n和上面map，set，类似，增删改查的时间复杂度是o(1)\r\n\r\n不支持lower_bound()/upper_bound() ；支持迭代器的++可以用于遍历，不支持--;','比赛基础语法','2023-07-17','http://rx9s3wx2k.hb-bkt.clouddn.com/%E5%B0%8F%E7%A6%BB.jpg','原创','','','c++基础','2023-07-17',4,25,1);

/*Table structure for table `t_tag` */

DROP TABLE IF EXISTS `t_tag`;

CREATE TABLE `t_tag` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `recommend` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

/*Data for the table `t_tag` */

insert  into `t_tag`(`id`,`name`,`recommend`) values (1,'错误记录',''),(2,'JavaScript','\0'),(3,'链表',''),(4,'计算机操作系统',''),(5,'二分查找',''),(7,'dfs',''),(8,'bfs',''),(9,'栈',''),(10,'服务器','\0'),(11,'Java','\0'),(12,'动态规划','\0'),(13,'二叉树','\0');

/*Table structure for table `t_tag_blog` */

DROP TABLE IF EXISTS `t_tag_blog`;

CREATE TABLE `t_tag_blog` (
  `blog_id` bigint(20) NOT NULL,
  `tag_id` bigint(20) NOT NULL,
  KEY `t_tag_blog_ibfk_1` (`blog_id`),
  KEY `t_tag_blog_ibfk_2` (`tag_id`),
  CONSTRAINT `t_tag_blog_ibfk_1` FOREIGN KEY (`blog_id`) REFERENCES `t_blog` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `t_tag_blog_ibfk_2` FOREIGN KEY (`tag_id`) REFERENCES `t_tag` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_tag_blog` */

insert  into `t_tag_blog`(`blog_id`,`tag_id`) values (23,2),(24,11),(25,11),(12,11),(26,3),(26,4),(27,1),(27,4),(28,3);

/*Table structure for table `t_type` */

DROP TABLE IF EXISTS `t_type`;

CREATE TABLE `t_type` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `recommend` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8;

/*Data for the table `t_type` */

insert  into `t_type`(`id`,`name`,`recommend`) values (1,'JavaSE',''),(25,'数据结构与算法','\0'),(26,'计算机操作系统','\0'),(27,'Redis','\0'),(30,'spring Cloud','\0'),(31,'SpringBoot','\0'),(32,'Mybaits-plus',''),(33,'计算机网络',''),(34,'计算机组成原理',''),(35,'JavaWeb','\0'),(36,'Vue','\0'),(37,'JavaScript','\0'),(38,'Spring',''),(39,'SpringMVC',''),(40,'邵高祥','\0');

/*Table structure for table `t_user` */

DROP TABLE IF EXISTS `t_user`;

CREATE TABLE `t_user` (
  `id` bigint(20) NOT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `create_time` date DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `nickname` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `update_time` date DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_user` */

insert  into `t_user`(`id`,`avatar`,`create_time`,`email`,`nickname`,`password`,`type`,`update_time`,`username`) values (1,'https://cn.bing.com/images/search?q=%E7%86%8A%E4%BA%8C%E5%A4%B4%E5%83%8F&FORM=IQFRBA&id=915659068C229C5F7CDA6E82EE069F44E610C949',NULL,'157816609@qq.com','熊二','8a2af487d7e6900a5f6b2e63f6709636',NULL,NULL,'157816609');

/*Table structure for table `type` */

DROP TABLE IF EXISTS `type`;

CREATE TABLE `type` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `recommend` bit(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `type` */

insert  into `type`(`id`,`name`,`recommend`) values (1,'数据结构','');

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` bigint(20) NOT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `create_time` date DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `nickname` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `update_time` date DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `user` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
