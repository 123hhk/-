/*
 Navicat Premium Dump SQL

 Source Server         : aaa
 Source Server Type    : MySQL
 Source Server Version : 90400 (9.4.0)
 Source Host           : localhost:3306
 Source Schema         : my_blog_system

 Target Server Type    : MySQL
 Target Server Version : 90400 (9.4.0)
 File Encoding         : 65001

 Date: 04/01/2026 17:26:59
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for t_article
-- ----------------------------
DROP TABLE IF EXISTS `t_article`;
CREATE TABLE `t_article`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '文章标题',
  `author` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '作者用户名',
  `content` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '文章具体内容',
  `created` datetime NOT NULL COMMENT '发表时间',
  `modified` datetime NULL DEFAULT NULL COMMENT '修改时间',
  `categories` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '默认分类' COMMENT '文章分类',
  `tags` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '文章标签',
  `allow_comment` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否允许评论',
  `thumbnail` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '文章缩略图',
  `user_id` int NULL DEFAULT NULL COMMENT '作者ID',
  `location` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '发布地点',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 43 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of t_article
-- ----------------------------
INSERT INTO `t_article` VALUES (1, '2018新版Java学习路线图', '东方不败', '&ensp;&ensp;&ensp;&ensp;播妞深知广大爱好Java的人学习是多么困难，没视频没资源，上网花钱还老担心被骗。因此专门整理了新版的学习路线图，不管你是不懂电脑的小白，还是已经步入开发的大牛，这套路线图绝对不容错过！12年传智播客黑马程序员分享免费视频教程长达10余万小时，累计下载量3000余万次，受益人数达千万。2018年我们不忘初心，继续前行。 路线图的宗旨就是分享，专业，便利，让喜爱Java的人，都能平等的学习。从今天起不要再找借口，不要再说想学Java却没有资源，赶快行动起来，Java等你来探索，高薪距你只差一步！\r\n\r\n**一、2018新版Java学习路线图---每阶段市场价值及可解决的问题**\r\n![alt](/article_img/roadmap/1.jpg)\r\n\r\n**二、2018新版Java学习路线图---学习大纲及各阶段知识点**\r\n![alt](/article_img/roadmap/2.jpg)\r\n\r\n![alt](/article_img/roadmap/3.jpg)\r\n\r\n**三、2018新版Java学习路线图---升级后新增知识点一览**\r\n![alt](/article_img/roadmap/4.jpg)\r\n\r\n\r\n\r\n', '2018-10-10 00:00:00', NULL, '默认分类', '2018,Java,学习路线图', 1, '/api/images/11.png', 3, NULL);
INSERT INTO `t_article` VALUES (2, '2018新版Python学习线路图', '东方不败', '&ensp;&ensp;&ensp;&ensp;12年历经风雨，传智播客黑马程序员已免费分享视频教程长达10万余小时，累计下载量超2000万次，受益人数达千万。2018年我们不忘初心，继续前行。学习路线图的宗旨就是分享，专业，便利，让喜爱Python的人，都能平等的学习。据悉，Python已经入驻小学生教材，未来不学Python不仅知识会脱节，可能与小朋友都没有了共同话题~~所以，从今天起不要再找借口，不要再说想学Python却没有资源，赶快行动起来，Python等你来探索，高薪距你只差一步！\r\n\r\n**一、2018新版Python学习路线图---每阶段市场价值及可解决的问题**\r\n![alt](/article_img/phmap/1.jpg)\r\n\r\n![alt](/article_img/phmap/2.jpg)\r\n\r\n**二、2018新版Python学习路线图---学习大纲及各阶段知识点**\r\n![alt](/article_img/phmap/3.jpg)\r\n\r\n![alt](/article_img/phmap/4.jpg)\r\n\r\n**三、2018新版Python学习路线图---升级版Python成长路径**\r\n![alt](/article_img/phmap/5.jpg)\r\n\r\n![alt](/article_img/phmap/6.jpg)', '2018-10-23 00:00:00', '2025-12-02 00:00:00', '默认分类', '2018,Python,学习线路图', 1, '/api/images/23f79d77-ee9d-4899-a2f3-da6415b3f098.jpg', 3, NULL);
INSERT INTO `t_article` VALUES (3, '2018新版前端与移动开发学习线路图', '东方不败', '&ensp;&ensp;&ensp;&ensp;传智播客黑马程序员作为一个IT学习平台，历经12年的成长，免费分享视频教程长达10万余小时，累计下载量超3000万次，受益人数达千万。2018年我们不忘初心，继续前行！路线图的宗旨就是分享，专业，便利，让更多想要学习IT的人都能系统的学习！从今天起不要再找借口，不要再说想学却没有资源，赶快行动起来，前端与移动开发等你来探索，高薪距你只差一步！注：新版前端与移动开发学习大纲于2018年2月26日完成升级，本学习路线图依据最新升级后的规划制作！\r\n\r\n**一、2018新版前端与移动开发学习路线图---每阶段可掌握的能力及可解决的问题**\r\n![alt](/article_img/frmap/1.jpg)\r\n\r\n![alt](/article_img/frmap/2.jpg)\r\n\r\n**二、2018新版前端与移动开发学习路线图---学习大纲及各阶段知识点**\r\n![alt](/article_img/frmap/3.jpg)\r\n\r\n![alt](/article_img/frmap/4.jpg)\r\n\r\n**三、2018新版前端与移动开发学习路线图--升级后新增知识点设计理念**\r\n![alt](/article_img/frmap/5.jpg)', '2018-11-13 00:00:00', NULL, '默认分类', '2018,前端与移动,学习线路图', 1, '/api/images/9.png', 3, NULL);
INSERT INTO `t_article` VALUES (4, '2018新版PHP学习线路图', '东方不败', '&ensp;&ensp;&ensp;&ensp;传智播客黑马程序员作为一个IT学习平台，历经12年的成长，免费分享视频教程长达10万余小时，累计下载量超3000万次，受益人数达千万。2018年我们不忘初心，继续前行！路线图的宗旨就是分享，专业，便利，让更多喜爱PHP的人都能系统的学习！从今天起不要再找借口，不要再说想学PHP却没有资源，赶快行动起来，PHP等你来探索，高薪距你只差一步！\r\n\r\n**一、2018新版PHP学习路线图---每阶段市场价值及可解决的问题**\r\n![alt](/article_img/phpmap/1.jpg)\r\n\r\n![alt](/article_img/phpmap/2.jpg)\r\n\r\n**二、2018新版PHP学习路线图---学习大纲及各阶段知识点**\r\n![alt](/article_img/phpmap/3.jpg)\r\n\r\n![alt](/article_img/phpmap/4.jpg)\r\n\r\n**三、2018新版PHP学习路线图---升级后新增知识点设计理念**\r\n![alt](/article_img/phpmap/5.jpg)\r\n', '2018-11-16 00:00:00', NULL, '默认分类', '2018,PHP,学习线路图', 1, '/api/images/8.png', 3, NULL);
INSERT INTO `t_article` VALUES (5, '2018版Go语言+区块链学习线路图', '东方不败', '&ensp;&ensp;&ensp;&ensp;12年传智播客黑马程序员分享免费视频教程长达10万余小时，累计下载量超3000万次，受益人数达千万。2018年我们不忘初心，继续前行。 路线图的宗旨就是分享，专业，便利，让喜爱Go语言+区块链的人，都能平等的学习。从今天起不要再找借口，不要再说想学Go语言+区块链却没有资源，赶快行动起来，Go语言+区块链等你来探索，高薪距你只差一步！\r\n\r\n**一、2018新版Go语言+区块链学习路线图---每阶段市场价值及可解决的问题**\r\n![alt](/article_img/gomap/1.jpg)\r\n\r\n![alt](/article_img/gomap/2.jpg)\r\n\r\n**二、2018新版Go语言+区块链学习路线图---每阶段可掌握的核心能力**\r\n![alt](/article_img/gomap/3.jpg)\r\n\r\n**三、2018新版Go语言+区块链学习路线图---每阶段的设计理念**\r\n![alt](/article_img/gomap/4.jpg)\r\n\r\n**四、2018新版Go语言+区块链学习路线图---学习大纲及各阶段知识点**\r\n![alt](/article_img/gomap/5.jpg)\r\n\r\n![alt](/article_img/gomap/6.jpg)', '2018-11-27 00:00:00', NULL, '默认分类', '2018,Go语言,区块链,学习线路图', 1, '/api/images/7.png', 3, NULL);
INSERT INTO `t_article` VALUES (6, 'JDK 8——Lambda表达式介绍', 'tom', '  Lambda表达式是JDK 8中一个重要的新特性，它使用一个清晰简洁的表达式来表达一个接口，同时Lambda表达式也简化了对集合以及数组数据的遍历、过滤和提取等操作。下面，本篇文章就对Lambda表达式进行简要介绍，并进行演示说明。\r\n\r\n**1. Lambda表达式入门**  \r\n\r\n  匿名内部类存在的一个问题是，如果匿名内部类的实现非常简单，例如只包含一个抽象方法的接口，那么匿名内部类的语法仍然显得比较冗余。为此，JDK 8中新增了一个特性Lambda表达式，这种表达式只针对有一个抽象方法的接口实现，以简洁的表达式形式实现接口功能来作为方法参数。  \r\n  一个Lambda表达式由三个部分组成，分别为参数列表、“->”和表达式主体，其语法格式如下：\r\n```js\r\n ([数据类型 参数名,数据类型 参数名,...]) -> {表达式主体}\r\n```  \r\n  从上述语法格式上看，Lambda表达式的书写非常简单，下面针对Lambda表达式的组成部分进行简单介绍，具体如下：  \r\n  （1）([数据类型 参数名,数据类型 参数名,...])：用来向表达式主体传递接口方法需要的参数，多个参数名中间必须用英文逗号“,”进行分隔；在编写Lambda表达式时，可以省略参数的数据类型，后面的表达式主体会自动进行校对和匹配；同时，如果只有一个参数，则可以省略括号“()”。  \r\n  （2）->：表示Lambda表达式箭牌，用来指定参数数据指向，不能省略，且必须用英文横线和大于号书写。  \r\n  （3）{表达式主体}：由单个表达式或语句块组成的主体，本质就是接口中抽象方法的具体实现，如果表达式主体只有一条语句，那么可以省略包含主体的大括号；另外，在Lambda表达式主体中允许有返回值，当只有一条return语句时，也可以省略return关键字。  \r\n  了解了Lambda表达式的语法后，接下来编写一个示例文件对Lambda表达式的基本使用进行介绍，具体代码如下所示。\r\n```js\r\n 1	// 定义动物类接口\r\n 2	interface Animal { \r\n 3		void shout(); // 定义方法shout()\r\n 4	}\r\n 5	public class Example22 {\r\n 6		public static void main(String[] args) {\r\n 7	       String name = \"小花\"; \r\n 8	       // 1、匿名内部类作为参数传递给animalShout()方法\r\n 9		  animalShout(new Animal() { \r\n 10				 public void shout() { \r\n 11				    System.out.println(\"匿名内部类输出：\"+name+\"喵喵...\");\r\n 12				}\r\n 13		  });\r\n 14		  // 2、使用Lambda表达式作为参数传递给animalShout()方法\r\n 15	       animalShout(()-> System.out.println(\"Lambda表达式输出：\"\r\n 16	                                                   +name+\"喵喵...\"));\r\n 17		}\r\n 18	    // 创建一个animalShout()静态方法，接收接口类型的参数\r\n 19		public static void animalShout(Animal an) {\r\n 20			an.shout();  \r\n 21		}\r\n 22	}\r\n```  \r\n  运行结果下图所示。\r\n![alt](/article_img/lambda/1.jpg)\r\n  上述代码示例中，先定义了只有一个抽象方法的接口Animal，然后分别使用匿名内部类和Lambda表达式的方式实现了接口方法。从图中可以看出，使用匿名内部类和Lambda表达式都能实现接口中方法，但很显然使用Lambda表达式更加简洁和清晰。', '2018-11-27 00:00:00', NULL, '默认分类', '2018,Lambda表达式', 1, '/api/images/6.png', 4, NULL);
INSERT INTO `t_article` VALUES (7, '函数式接口', 'tom', '&emsp;&emsp;虽然Lambda表达式可以实现匿名内部类的功能，但在使用时却有一个局限，即接口中有且只有一个抽象方法时才能使用Lamdba表达式代替匿名内部类。这是因为Lamdba表达式是基于函数式接口实现的，所谓函数式接口是指有且仅有一个抽象方法的接口，Lambda表达式就是Java中函数式编程的体现，只有确保接口中有且仅有一个抽象方法，Lambda表达式才能顺利地推导出所实现的这个接口中的方法。  \r\n&emsp;&emsp;在JDK 8中，专门为函数式接口引入了一个@FunctionalInterface注解，该注解只是显示的标注了接口是一个函数式接口，并强制编辑器进行更严格的检查，确保该接口是函数式接口，如果不是函数式接口，那么编译器就会报错，而对程序运行并没有实质上的影响。  \r\n&emsp;&emsp;接下来通过一个案例来演示函数式接口的定义与使用，示例代码如下所示。\r\n```js\r\n 1	// 定义无参、无返回值的函数式接口\r\n 2	@FunctionalInterface\r\n 3	interface Animal {\r\n 4		void shout();\r\n 5	}\r\n 6	// 定义有参、有返回值的函数式接口\r\n 7	interface Calculate {\r\n 8		int sum(int a, int b);\r\n 9	}\r\n 10	public class Example23 {\r\n 11		public static void main(String[] args) {\r\n 12		   // 分别两个函数式接口进行测试\r\n 13		   animalShout(() -> System.out.println(\"无参、无返回值的函数式接口调用\"));\r\n 14		   showSum(10, 20, (x, y) -> x + y);\r\n 15		}\r\n 16		// 创建一个动物叫的方法，并传入接口对象Animal作为参数\r\n 17		private static void animalShout(Animal animal) {\r\n 18			animal.shout();\r\n 19		}\r\n 20		// 创建一个求和的方法，并传入两个int类型以及接口Calculate类型的参数\r\n 21		private static void showSum(int x, int y, Calculate calculate) {\r\n 22		   System.out.println(x + \"+\" + y + \"的和为：\" + calculate.sum(x, y));\r\n 23		}\r\n 24	}\r\n```  \r\n&emsp;&emsp;运行结果如下图所示。\r\n\r\n![alt](/article_img/lambda/2.jpg)\r\n&emsp;&emsp;上述代码示例中，先定义了两个函数式接口Animal和Calculate，然后在测试类中分别编写了两个静态方法，并将这两个函数式接口以参数的形式传入，最后在main()方法中分别调用这两个静态方法，并将所需要的函数式接口参数以Lambda表达式的形式传入。从图中可以看出，程序中函数式接口的定义和使用完全正确。\r\n', '2018-12-01 00:00:00', NULL, '默认分类', '接口,函数式接口', 1, '/api/images/5.png', 4, NULL);
INSERT INTO `t_article` VALUES (8, 'JDK 8——聚合操作', 'tom', '&emsp;&emsp;在Java8版本中，JDK包含许多聚合操作（如平均值，总和，最小，最大，和计数），返回一个计算流stream的聚合结果。这些聚合操作被称为聚合操作。JDK除返回单个值的聚合操作外，还有很多聚合操作返回一个collection集合实例。很多的reduce操作执行特定的任务，如求平均值或按类别分组元素。  \r\n\r\n**1. 聚合操作简介**\r\n\r\n  在开发中，多数情况下会涉及到对集合、数组中元素的操作，在JDK 8之前都是通过普通的循环遍历出每一个元素，然后还会穿插一些if条件语句选择性的对元素进行查找、过滤、修改等操作，这种原始的操作方法虽然可行，但是代码量较大并且执行效率较低。  \r\n  为此，JDK 8中新增了一个Stream接口，该接口可以将集合、数组的中的元素转换为Stream流的形式，并结合Lambda表达式的优势来进一步简化集合、数组中元素的查找、过滤、转换等操作，这一新功能就是JDK 8中的聚合操作。  \r\n  在程序中，使用聚合操作没有绝对的语法规范，根据实际操作流程，主要可以分为以下3个步骤：  \r\n  （1）将原始集合或者数组对象转换为Stream流对象；  \r\n  （2）对Stream流对象中的元素进行一系列的过滤、查找等中间操作（Intermediate Operations），然后仍然返回一个Stream流对象；  \r\n  （3）对Stream流进行遍历、统计、收集等终结操作（Terminal Operation），获取想要的结果。  \r\n  接下来，就根据上面聚合操作的3个步骤，通过一个案例来演示聚合操作的基本用法，具体示例代码如下所示。\r\n```js\r\n 1	import java.util.*;\r\n 2	import java.util.stream.Stream;\r\n 3	public class Example31 {\r\n 4		public static void main(String[] args) {\r\n 5	          // 创建一个List集合对象\r\n 6			List<String> list = new ArrayList<>(); \r\n 7			list.add(\"张三\");\r\n 8			list.add(\"李四\");\r\n 9			list.add(\"张小明\");\r\n 10			list.add(\"张阳\");\r\n 11			// 1、创建一个Stream流对象\r\n 12			Stream<String> stream = list.stream();\r\n 13			// 2、对Stream流中的元素分别进行过滤、截取操作\r\n 14		       Stream<String> stream2 = stream.filter(i -> i.startsWith(\"张\"));\r\n 15			Stream<String> stream3 = stream2.limit(2);\r\n 16			// 3、对Stream流中的元素进行终结操作，进行遍历输出\r\n 17			stream3.forEach(j -> System.out.println(j));\r\n 18			System.out.println(\"=======\");\r\n 19	         // 通过链式表达式的形式完成聚合操作\r\n 20			list.stream().filter(i -> i.startsWith(\"张\"))\r\n 21						 .limit(2)\r\n 22						 .forEach(j -> System.out.println(j));\r\n 23		}\r\n 24	}\r\n``` \r\n   运行结果如下图所示。\r\n![alt](/article_img/lambda/3.jpg)\r\n  上述示例代码中，先创建了一个List集合，然后根据聚合操作的3个步骤实现了集合对象的聚合操作，对集合中的元素使用Stream流的形式进行过滤（filter）、截取（limit），并进行遍历输出。其中第12~17行代码分步骤详细展示了聚合操作，而第20~22行代码是使用了链式表达式（调用有返回值的方法时不获取返回值而是直接再调用另一个方法）实现了聚合操作，该表达式的语法格式更简洁、高效，这种链式调用也被称为操作管道流。\r\n\r\n**2. 创建Stream流对象**  \r\n  在上一小节中，介绍了聚合操作的主要使用步骤，其中首要解决的问题就是创建Stream流对象。聚合操作针对的就是可迭代数据进行的操作，如集合、数组等，所以创建Stream流对象其实就是将集合、数组等通过一些方法转换为Stream流对象。  \r\n  在Java中，集合对象有对应的集合类，可以通过集合类提供的静态方法创建Stream流对象，而数组数据却没有对应的数组类，所以必须通过其他方法创建Stream流对象。针对不同的源数据，Java提供了多种创建Stream流对象的方式，分别如下：  \r\n  （1）所有的Collections集合都可以使用stream()静态方法获取Stream流对象；  \r\n  （2）Stream接口的of()静态方法可以获取基本类型包装类数组、引用类型数组和单个元素的Stream流对象；  \r\n  （3）Arrays数组工具类的stream()静态方法也可以获取数组元素的Stream流对象。  \r\n  接下来，通过一个案例来学习聚合操作中如何创建Stream流对象，具体示例代码如下所示。\r\n```js\r\n 1	import java.util.*;\r\n 2	import java.util.stream.Stream;\r\n 3	public class Example32 {\r\n 4		public static void main(String[] args) {\r\n 5	          // 创建一个数组\r\n 6			Integer[] array = { 9, 8, 3, 5, 2 };       \r\n 7	          // 将数组转换为List集合\r\n 8			List<Integer> list = Arrays.asList(array); \r\n 9			// 1、使用集合对象的stream()静态方法创建Stream流对象\r\n 10			Stream<Integer> stream = list.stream();\r\n 11			stream.forEach(i -> System.out.print(i+\" \"));\r\n 12			System.out.println();\r\n 13			// 2、使用Stream接口的of()静态方法创建Stream流对象\r\n 14			Stream<Integer> stream2 = Stream.of(array);\r\n 15			stream2.forEach(i -> System.out.print(i+\" \"));\r\n 16			System.out.println();\r\n 17			// 3、使用Arrays数组工具类的stream()静态方法创建Stream流对象\r\n 18			Stream<Integer> stream3 = Arrays.stream(array);\r\n 19			stream3.forEach(i -> System.out.print(i+\" \"));\r\n 20		}\r\n 21	}\r\n```  \r\n  运行结果如下图所示。\r\n![alt](/article_img/lambda/4.jpg)\r\n  上述示例代码中，先创建了一个数组和一个集合，然后通过三种方式实现了Stream流对象的创建，并通过Stream流对象的forEach()方法结合Lambda表达式完成了集合和数组中元素的遍历。  \r\n\r\n**小提示：**  \r\n  在JDK 8中，只针对单列集合Collections接口对象提供了stream()静态方法获取Stream流对象，并未对Map集合提供相关方法获取Stream流对象，所以想要用Map集合创建Stream流对象必须先通过Map集合的keySet()、values()、entrySet()等方法将Map集合转换为单列Set集合，然后再使用单列集合的stream()静态方法获取对应键、值集合的Stream流对象。\r\n\r\n', '2018-12-02 00:00:00', NULL, '默认分类', 'JDK 8,聚合操作', 1, '/api/img/images/4.png', 4, NULL);
INSERT INTO `t_article` VALUES (9, '虚拟化容器技术——Docker运行机制介绍', 'tom', '  Docker是一个开源的应用容器引擎，它基于go语言开发，并遵从Apache2.0开源协议。使用Docker可以让开发者封装他们的应用以及依赖包到一个可移植的容器中，然后发布到任意的Linux机器上，也可以实现虚拟化。Docker容器完全使用沙箱机制，相互之间不会有任何接口，这保证了容器之间的安全性。  \r\n\r\n**1. Docker的引擎介绍**\r\n\r\n  Docker Engine（Docker引擎）是Docker的核心部分，使用的是客户端-服务器（C/S）架构模式，其主要组成部分如下图所示。\r\n![alt](/article_img/docker/1.png)\r\n  从上图可以看出，Docker Engine中包含了三个核心组件（docker CLI、REST API和docker daemon），这三个组件的具体说明如下：  \r\n  ①docker CLI（command line interface）：表示Docker命令行接口，开发者可以在命令行中使用Docker相关指令与Docker守护进程进行交互，从而管理诸如image（镜像）、container（容器）、network（网络）和data volumes（数据卷）等实体。  \r\n  ②REST API：表示应用程序API接口，开发者通过该API接口可以与Docker的守护进程进行交互，从而指示后台进行相关操作。  \r\n  ③docker daemon：表示Docker的服务端组件，他是Docker架构中运行在后台的一个守护进程，可以接收并处理来自命令行接口及API接口的指令，然后进行相应的后台操作。  \r\n  对于开发者而言，既可以使用编写好的脚本文件通过REST API来实现与Docker进程交互，又可以直接使用Docker相关指令通过命令行接口来与Docker进程交互，而其他一些Docker应用则是通过底层的API和CLI进行交互的。\r\n\r\n**2. Docker的架构介绍**\r\n\r\n  了解了Docker内部引擎及作用后，我们还需要通过Docker的具体架构，来了解Docker的整个运行流程。接下来借助Docker官网的架构图来对Docker架构进行详细说明，如下图所示。\r\n![alt](/article_img/docker/2.jpg)\r\n  从图中可以看出，Docker架构主要包括Client、DOCKER_HOST和Register三部分，关于这三部分的具体说明如下。  \r\n&emsp;&emsp;**（1）Client（客户端）**  \r\n  Client即Docker客户端，也就是上一小节Docker Engine中介绍的docker CLI。开发者通过这个客户端使用Docker的相关指令与Docker守护进程进行交互，从而进行Docker镜像的创建、拉取和运行等操作。  \r\n&emsp;&emsp;**（2）DOCKER_HOST（Docker主机）**  \r\n  DOCKER_HOST即Docker内部引擎运行的主机，主要指Docker daemon（Docker守护进程）。可以通过Docker守护进程与客户端还有Docker的镜像仓库Registry进行交互，从而管理Images（镜像）和Containers（容器）等。  \r\n&emsp;&emsp;**（3）Registry（注册中心）**  \r\n  Registry即Docker注册中心，实质就是Docker镜像仓库，默认使用的是Docker官方远程注册中心Docker Hub，也可以使用开发者搭建的本地仓库。Registry中包含了大量的镜像，这些镜像可以是官网基础镜像，也可以是其他开发者上传的镜像。  \r\n  我们在实际使用Docker时，除了会涉及到图中的三个主要部分外，还会涉及到很多Docker Objects（Docker对象），例如Images（镜像）、Containers（容器）、Networks（网络）、Volumes（数据卷）、Plugins（插件）等。其中常用的两个对象Image和Containers的说明如下。  \r\n  ①Images（镜像）  \r\n  Docker 镜像就是一个只读的模板，包含了一些创建Docker容器的操作指令。通常情况下，一个Docker镜像是基于另一个基础镜像创建的，并且新创建的镜像会额外包含一些功能配置。例如：开发者可以依赖于一个Ubuntu的基础镜像创建一个新镜像，并可以在新镜像中安装Apache等软件或其它应用程序。  \r\n  ②Containers（容器）  \r\n  Docker容器属于镜像的一个可运行实例（镜像与容器的关系其实与Java中的类与对象相似），开发者可以通过API接口或者CLI命令行接口来创建、运行、停止、移动、删除一个容器，也可以将一个容器连接到一个或多个网络中，将数据存储与容器进行关联。\r\n\r\n\r\n\r\n', '2018-12-03 00:00:00', NULL, '默认分类', '虚拟化容器,Docker,运行机制', 1, '/api/images/3.png', 4, NULL);
INSERT INTO `t_article` VALUES (10, 'Docker常用客户端指令介绍', 'tom', '  在使用Docker之前，首先会为对应的项目编写Dockerfile镜像构建文件，然后通过Docker的相关指令进行镜像构建，完成镜像的构建后，就可以使用这些项目镜像进行启动测试了。所以要想知道如何使用Docker来执行这些Dockerfile镜像构建文件，还需要学习Docker客户端的常用指令，本篇文章将对Docker客户端的常用指令进行详细讲解。  \r\n\r\n**1.列出镜像**  \r\n  通过docker images指令可以查看本地镜像列表中已有的镜像，具体使用方式如下。\r\n```js\r\n$ docker images\r\n```  \r\n  执行上述指令后，系统会将所有本地镜像都展示出来，如下图所示。\r\n![alt](/article_img/docker/3.png)\r\n  从图中可以看出，系统终端将本地镜像列表中的3个镜像分5列进行了展示，每一列的具体含义如下。  \r\n  ●REPOSITORY：镜像名称。  \r\n  ●TAG：镜像的参数，类似于版本号，默认是latest。  \r\n  ●IMAGE ID：镜像ID，是唯一值。此处看到的是一个长度为12的字符串，实际上它是64位完整镜像ID的缩写形式。  \r\n  ●CREATED：距今创建镜像的时间。  \r\n  ●SIZE：镜像大小。    \r\n\r\n**2.搜索镜像**  \r\n  想知道在Docker Hub中包含了哪些镜像，除了可以登录Docker Hub，在官网中心进行查看外，还可以直接在Docker客户端进行查询。例如想要查询Ubuntu镜像，可以使用如下指令。\r\n```js\r\n$ docker search ubuntu\r\n```  \r\n  执行上述指令后，系统终端就会将搜索到的有关Ubuntu的镜像展示出来，如下图所示。\r\n![alt](/article_img/docker/4.png)\r\n  从图所示的结果可以看出，系统终端分5列将搜索到的Ubuntu相关镜像都列举出来了，这5列的具体含义如下。  \r\n  ●NAME：表示镜像的名称，这里有两种格式的名称，其中不带有“/”的表示官方镜像，而带有“/”的表示其他用户的公开镜像。公开镜像“/”前面是用户在Docker Hub上的用户名（唯一），后面是对应的镜像名；官方镜像与用户镜像，除了从镜像名称上可以区分外，还可以通过第4列的OFFICIAL声明中看出（该列下内容为OK表示官方镜像）。  \r\n  ●DESCRIPTION：表示镜像的描述，这里只显示了一小部分。  \r\n  ●STARS：表示该镜像的收藏数，用户可以在Docker Hub上对镜像进行收藏，一般可以通过该数字反应出该镜像的受欢迎程度。  \r\n  ●OFFICIAL：表示是否为官方镜像。  \r\n  ●AUTOMATED：表示是否自动构建镜像。例如，用户可以将自己的Docker Hub绑定到如Github上，当代码提交更新后，可以自动构建镜像。   \r\n \r\n**3.拉取镜像**  \r\n  通过docker pull指令可以拉取仓库镜像到本地（默认都是拉取Docker Hub仓库镜像，也可以指定“IP+端口”拉取某个Docker机器上的私有仓库镜像），具体使用方式如下。\r\n```js\r\n$ docker pull ubuntu\r\n```  \r\n  执行上述指令后，Docker会自动从Docker Hub上下载最新版本的Ubuntu到本地，当然也可以使用以下指令拉取指定版本的镜像到本地，具体指令如下。\r\n```js\r\n$ docker pull ubuntu:14.04\r\n```  \r\n**4.构建镜像**  \r\n  除了可以通过docker pull指令从仓库拉取镜像外，还可以通过docker build指令构建Docker镜像，通常情况下都是通过Dockerfile文件来构建镜像的。  \r\n  这里假设linux系统home目录下/shitou/workspace/dockerspace文件夹中编写有对应的Dockerfile文件，则构建镜像直立示例如下所示。 \r\n```js\r\n$ docker build -t hellodocker3 /home/shitou/workspace/dockerspace/.\r\n```\r\n**5.删除镜像**  \r\n  当本地存放过多不需要的镜像时，可以通过docker rmi指令将其删除。在删除镜像时，需要指定镜像名称或镜像ID。删除镜像的使用方式如下。\r\n```js\r\n$ docker rmi -f hellodocker2 hellodocker3\r\n```  \r\n  上述指令中，docker rmi表示删除镜像，-f表示进行强制删除，而hellodocker2和hellodocker3分别表示需要删除的镜像名称，这里同时删除两个镜像。除了根据名称删除镜像外，还也可以根据镜像ID来删除镜像，只是这里如果指定了删除ID为23c617a866d4的镜像后，会同时删除hellodocker、hellodocker2和hellodocker3三个镜像。  \r\n  需要特别强调的是，在进行镜像删除操作时，如果是通过镜像ID进行镜像删除，那么由该镜像创建的容器必须提前删除或停止。另外，在通过镜像名称操作镜像时，如果出现镜像重名的情况，必须在镜像名称后面指定镜像标签tag参数来确保唯一性。\r\n\r\n**6.创建并启动容器**  \r\n  Docker镜像主要用于创建容器，可以使用docker run指令创建并启动容器，具体使用方式如下。\r\n```js\r\n$ docker run -d -p 5000:80 --name test hellodocker\r\n```  \r\n  上述创建并启动容器的指令略微复杂，具体分析如下。  \r\n  ●docker run：表示创建并启动一个容器，而后面的hellodocker就表示要启动运行的镜像名称；  \r\n  ●-d：表示容器启动时在后台运行；  \r\n  ●-p 5000:80：表示将容器内暴露的80端口映射到宿主机指定的5000端口，也可以将-p 5000:80更改为-P来映射主机的随机端口（注意p字母的大小写）；  \r\n  ●--name test：表示为创建后的容器指定名称为test，如果没有该参数配置，则生成的容器会设置一个随机名称。  \r\n  docker run命令是Docker操作中较为复杂的一个，它可以携带多个参数和参数，我们可以通过docker run --help指令进行查看，其中有些参数如-e、-v和-w等都可以在Dockerfile文件中预先声明。 \r\n \r\n**7.列出容器**  \r\n  生成容器后，可以通过docker ps指令查看当前运行的所有容器，具体使用方式如下。\r\n```js\r\n$ docker ps\r\n```  \r\n  执行上述命令后，会将所有当前运行的容器都展示出来，具体如下图所示。\r\n![alt](/article_img/docker/5.png)\r\n  从图中可以看出，系统终端通过7列对当前的正在运行的一个容器进行了展示，图中每一列的具体含义如下。  \r\n  ●CONTAINER ID：表示生成的容器ID；  \r\n  ●IMAGE：表示生成该容器的镜像名称；  \r\n  ●COMMAND：表示启动容器时运行的命令，Docker要求在启动容器时必须运行一个命令；  \r\n  ●CREATED：表示容器创建的时间；  \r\n  ●STATUS：表示容器运行状态，例如Up表示运行中，Exited表示已停止；  \r\n  ●PORTS：表示容器内部暴露的端口映射到主机的端口；  \r\n  ●NAMES：表示生成容器的名称，由Docker引擎自动生成，可以像上述示例中使用--name参数指定生成容器的名称。  \r\n  另外，docker ps指令运行过程中可以指定多个参数，还可以通过docker ps --help指令对ps指令的其他信息进行查看。\r\n\r\n**8.删除容器**  \r\n  当不需要使用容器时，则可以使用docker rm指令删除已停止的容器，具体使用方式如下。\r\n```js\r\n$ docker rm f0c9a8b6e8c5\r\n```  \r\n  需要注意的是，上述指令只能删除已经停止运行的容器，而不能删除正在运行的容器。如果想要删除正在运行的容器，则需要添加-f参数强制删除，具体使用方式如下。\r\n```js\r\n$ docker rm -f f0c9a8b6e8c5\r\n```  \r\n  当需要删除的容器过多时，如果还一个个的删除就略显麻烦了，此时可以通过如下指令将全部容器删除。\r\n```js\r\n$ docker rm -f $(docker ps -aq)\r\n```  \r\n  上述指令中，首先会通过$(docker ps -aq)获取所有容器的ID，然后通过docker rm -f指令进行强制删除。如果开发者有自己特殊的删除需求，可以根据前面docker ps指令进行组装来获取需要删除的容器ID。  \r\n  Docker提供的操作指令远不止这些，这里就不一一列举了，想要了解更多Docker的操作指令，可以通过docker --help指令进行查看。\r\n\r\n\r\n', '2018-12-05 00:00:00', NULL, '默认分类', 'Docker,客户端指令', 1, '/api/images/2.png', 4, NULL);
INSERT INTO `t_article` VALUES (11, 'Docker数据管理介绍', 'tom', '  当我们对容器进行相关操作时，产生的一系列数据都会存储在容器中，而Docker内部又是如果管理这些数据的呢？本篇文章将针对Docker数据管理的一些知识进行介绍。\r\n  \r\n**1. Docker数据存储机制**  \r\n  使用Docker时，我们操作的都是镜像和由镜像生成的容器，所以想要更好的了解Docker内部的数据存储机制，就必须从镜像、容器与数据存储的关系出发。  \r\n  Docker镜像是通过读取Dockerfile文件中的指令构建的，Dockerfile中的每条指令都会创建一个镜像层，并且每层都是只读的，这一系列的镜像层就构成了Docker镜像。接下来以一个Dockerfile文件为例进行说明，具体如下列代码示例所示。\r\n```js\r\n 1	FROM ubuntu:16.04\r\n 2	COPY . /app\r\n 3	RUN make /app\r\n 4	CMD python /app/app.py\r\n```  \r\n   上述文件示例中的Dockerfile包含了4条指令，每条指令都会创建一个镜像层，其中每一层与前一层都有所不同，并且是层层叠加的。通过镜像构建容器时，会在镜像层上增加一个容器层（即可写层），所有对容器的更改都会写入容器层，这也是Docker默认的数据存储方式。  \r\n  下面通过一个效果图进行说明，具体如下图所示。\r\n![alt](/article_img/docker/6.png)\r\n  从图中可以看出，Docker容器和镜像之间的主要区别是顶部的容器层，而所有对容器中数据的添加、修改等操作都会被存储在容器层中。当容器被删除时，容器层也会被删除，其中存储的数据会被一同删除，而下面的镜像层却保持不变。  \r\n  由于所有的容器都是通过镜像构建的，所以每个容器都有各自的容器层，对于容器数据的更改就会保存在各自的容器层中。也就是说，由同一个镜像构建的多个容器，它们会拥有相同的底部镜像层，而拥有不同的容器层，多个容器可以访问相同的镜像层，并且有自己的独立数据状态。具体说明如下图所示。 \r\n![alt](/article_img/docker/7.png)\r\n  从图中可以看出，基于同一个镜像构建的多个容器可以共享该镜像层，但是多个容器想要共享相同的数据，就需要将这些数据存储到容器之外的地方，而这种方式就是下一节要提到的Docker volume数据外部挂载机制。  \r\n\r\n**2. Docker数据存储方式**    \r\n  在默认情况下，Docker中的数据都是存放在容器层的，但是这样存储数据却有较多的缺陷，具体表现如下。    \r\n  ●当容器不再运行时，容器中的数据无法持久化保存，如果另一个进程需要这些数据，那么将很难从容器中获取数据；  \r\n  ●容器层与正在运行的主机紧密耦合，不能轻易地移动数据；  \r\n  ●容器层需要一个存储驱动程序来管理文件系统，存储驱动程序提供了一个使用Linux内核的联合文件系统，这种额外的抽象化降低了性能。  \r\n  基于上述种种原因，多数情况下Docker数据管理都不会直接将数据写入容器层，而是使用另一种叫做Docker volume数据外部挂载的机制进行数据管理。  \r\n  针对Docker volume数据外部挂载机制，Docker提供了三种不同的方式将数据从容器映射到Docker宿主机，他们分别为：volumes（数据卷）、bind mounts（绑定挂载）和tmpfs mounts（tmpfs挂载）。这三种数据管理方式的具体选择，需要结合实际情况进行考虑，其中的volumes数据卷是最常用也是官方推荐的数据管理方式。无论选择使用哪种数据管理方式，数据在容器内看起来都一样的，而在容器外则会被被挂载到文件系统中的某个目录或文件中。    \r\n  下面通过一张图来展示数据卷、绑定挂载和tmpfs挂载之间的差异，如下图所示。  \r\n![alt](/article_img/docker/8.png)\r\n  从图中可以看出，Docker提供的三种数据管理方式略有不同，具体分析如下。  \r\n  ●volumes：存储在主机文件系统中（在Linux系统下是存在于/var/lib/Docker/volumes/目录），并由Docker管理，非Docker进程无法修改文件系统的这个部分。  \r\n  ●bind mounts：可以存储在主机系统的任意位置，甚至可能是重要的系统文件或目录，在Docker主机或容器上的非Docker进程可以对他们进行任意修改。  \r\n  ●tmpfs mounts：只存储在主机系统的内存中，并没有写入到主机的文件系统中。\r\n\r\n\r\n', '2018-12-07 00:00:00', NULL, '默认分类', 'Docker,数据管理', 1, '/api/images/1.png', 4, NULL);
INSERT INTO `t_article` VALUES (12, 'Spring Boot 2 权威发布', '123', '  如果这两天登录 [https://start.spring.io/ ](https://start.spring.io/ )就会发现，Spring Boot 默认版本已经升到了 2.1.0。这是因为 Spring Boot 刚刚发布了 2.1.0 版本，我们来看下 Spring Boot 2 发布以来第一个子版本都发布了哪些内容？  \r\n\r\n**2.1 中的新特性**     \r\n  ●将spring-boot-starter-oauth2-oidc-client重命名为spring-boot-starter-oauth2-client命名更简洁  \r\n  ●添加 OAuth2 资源服务 starter，OAuth2 一个用于认证的组件  \r\n  ●支持 ConditionalOnBean 和 ConditionalOnMissingBean 下的参数化容器  \r\n  ●自动配置 applicationTaskExecutor bean 的延迟加载来避免不必要的日志记录  \r\n  ●将 DatabaseDriver＃SAP 重命名为 DatabaseDriver  \r\n  ●跳过重启器不仅适用于 JUnit4，也适用于 JUnit5  \r\n  ●在 Jest HealthIndicator 中使用集群端点  \r\n  ●当 DevTools 禁用重启时添加日志输出  \r\n  ●添加注解：@ConditionalOnMissingServletFilter提高 Servlet Filters 的自动装配。\r\n  \r\n**2.1 中的组件升级**  \r\n  ●升级 Hibernate 5.3，Hibernate 的支持升级到了 5.3  \r\n  ●升级 Tomcat 9 ，支持最新的 tomcat 9  \r\n  ●支持 Java 11，Java 现在更新越来越快，Spring 快赶不上了    \r\n  ●升级 Thymeleaf Extras Springsecurity 到 3.0.4.RELEASE ，thymeleaf-extras-springsecurity 是 Thymeleaf 提供集成 Spring Security 的组件  \r\n  ●升级 Joda Time 2.10.1，Joda-Time， 面向 Java 应用程序的日期/时间库的替代选择，Joda-Time 令时间和日期值变得易于管理、操作和理解。  \r\n  ●升级 Lettuce 5.1.2.RELEASE ，Lettuce 前面说过，传说中 Redis 最快的客户端。  \r\n  ●升级 Reactor Californium-SR2 ，Californium 是物联网云服务的 Java COAP 实现。因此，它更专注的是可扩展性和可用性而不是像嵌入式设备那样关注资源效率。不过，Californium 也适合嵌入式的 JVM。  \r\n  ●升级 Maven Failsafe Plugin 2.22.1 ，Maven 中的测试插件。  \r\n  ●升级 Flyway 5.2.1 ， Flyway是一款开源的数据库版本管理工具  \r\n  ●升级 Aspectj 1.9.2 ，AspectJ 是 Java 中流行的 AOP（Aspect-oriented Programming）编程扩展框架，是 Eclipse 托管给 Apache 基金会的一个开源项目。  \r\n  ●升级 Mysql 8.0.13 ，Mysql 支持到 8。  \r\n  ●...  \r\n&emsp;&emsp;更多的详细内容可以参考这里：[Spring Boot 2.1 Release Notes](https://github.com/spring-projects/spring-boot/wiki/Spring-Boot-2.1-Release-Notes)\r\n', '2018-12-11 00:00:00', '2025-11-19 00:00:00', '默认分类', 'Spring Boot 2', 1, '/api/images/f593a479-539b-4610-a236-1d6567e0cb8f.jpg', 5, NULL);
INSERT INTO `t_article` VALUES (13, '111111', '123', '', '2025-10-26 00:00:00', NULL, '默认分类', '', 1, '/api/images/1.png', 5, NULL);
INSERT INTO `t_article` VALUES (14, '123', '123', '', '2025-10-26 00:00:00', NULL, '默认分类', '', 1, '/api/images/1.png', 5, NULL);
INSERT INTO `t_article` VALUES (15, '234', '123', '<p>234</p>', '2025-10-26 00:00:00', NULL, '默认分类', '', 1, '/api/images/1.png', 5, NULL);
INSERT INTO `t_article` VALUES (16, '12234', '123', '', '2025-10-27 00:00:00', NULL, '默认分类', '', 1, '/api/images/1.png', 5, NULL);
INSERT INTO `t_article` VALUES (17, '123', '李四', '<p><img src=\"/api/images/68bfaff6-608f-473f-8f35-b9430446ca76.jpg\" alt=\"\" width=\"500\" height=\"375\"></p>\n<p>66666</p>', '2025-11-27 00:00:00', NULL, '默认分类', '', 1, '/api/images/1.png', 2, NULL);
INSERT INTO `t_article` VALUES (18, '2202020202', '李四', '<p><img src=\"/api/images/68bfaff6-608f-473f-8f35-b9430446ca76.jpg\" alt=\"\" width=\"500\" height=\"375\"></p>\n<p>66666</p>', '2025-10-27 00:00:00', NULL, '默认分类', '', 1, '/api/images/1.png', 2, NULL);
INSERT INTO `t_article` VALUES (19, 'we', '李四', '<p>123456789<img src=\"/api/images/f07d3fe0-18c0-4a9b-aa4c-177cfb7f6034.jpg\" alt=\"\" width=\"500\" height=\"375\"></p>', '2025-10-27 00:00:00', '2025-12-16 00:00:00', '默认分类', '', 1, '/api/images/1.png', 2, NULL);
INSERT INTO `t_article` VALUES (21, '123', '李四', '<p>123</p>', '2025-12-16 00:00:00', NULL, '默认分类', '', 1, '/api/images/6.png', 2, NULL);
INSERT INTO `t_article` VALUES (22, '这是第几篇文章呢', '李四', '<p>111</p>', '2025-12-16 00:00:00', NULL, '默认分类', '', 1, '/api/images/6.png', 2, NULL);
INSERT INTO `t_article` VALUES (23, '好多bug...', '李四', '好多bug...', '2025-12-17 23:27:12', '2025-12-17 23:27:56', '默认分类', '李四', 1, '', 2, NULL);
INSERT INTO `t_article` VALUES (24, '有个奇怪的bug', 'zzt', '<p>读取id为22以前(包括22)的文章可以正常读取但是22以后的就不能了</p>', '2025-12-17 22:46:34', NULL, '默认分类', '', 1, '/api/images/6.png', 6, NULL);
INSERT INTO `t_article` VALUES (25, '2121', 'zzt', '<p>2121</p>', '2025-12-17 23:52:15', NULL, '默认分类', '', 1, '/api/images/6.png', 6, NULL);
INSERT INTO `t_article` VALUES (26, '测试', 'zzt', '<p>实测</p>', '2025-12-17 23:55:10', '2025-12-18 05:40:43', '默认分类', '', 1, '/api/images/6.png', 6, NULL);
INSERT INTO `t_article` VALUES (27, '123', 'zzt', '<p>23</p>', '2025-12-18 00:15:27', NULL, '默认分类', '', 1, '/api/images/6.png', 6, NULL);
INSERT INTO `t_article` VALUES (28, '123', 'zzt', '<p>23</p>', '2025-12-18 00:15:55', NULL, '默认分类', '', 1, '/api/images/6.png', 6, NULL);
INSERT INTO `t_article` VALUES (29, '新年快乐', 'zzt', '<p>新年快乐!!!</p>', '2026-01-02 04:13:52', NULL, '默认分类', '', 1, '/api/images/6.png', 6, NULL);
INSERT INTO `t_article` VALUES (30, 'IP测试', 'zzt', '<p>新增了显示ip功能,看看能不能成功</p>', '2026-01-02 17:43:31', NULL, '默认分类', '', 1, '/api/images/6.png', 6, NULL);
INSERT INTO `t_article` VALUES (31, '123', 'admin', '<p>1234567</p>', '2026-01-04 02:14:49', NULL, '默认分类', '', 1, '/api/images/6.png', 1, NULL);
INSERT INTO `t_article` VALUES (32, '我再来发布一篇看看', NULL, '<p>现在是2026.01.04.02:17</p>', '2026-01-04 02:18:33', NULL, '默认分类', '', 1, '/api/images/6.png', 1, NULL);
INSERT INTO `t_article` VALUES (33, '我再再来发布一篇看看', NULL, '<p>现在是2026.01.04.02:20</p>', '2026-01-04 02:20:38', NULL, '默认分类', '', 1, '/api/images/6.png', 1, NULL);
INSERT INTO `t_article` VALUES (34, '我看看普通用户能不能创建文章', NULL, '<p>这里是</p>', '2026-01-04 02:23:38', NULL, '默认分类', '', 1, '/api/images/6.png', 5, NULL);
INSERT INTO `t_article` VALUES (35, '我现在要来验证一下分类标签功能是否能正常使用', NULL, '<p>希望可以</p>', '2026-01-04 02:52:44', NULL, '技术/后端/Java', '#Java #技术实现', 1, '/api/images/6.png', 6, NULL);
INSERT INTO `t_article` VALUES (36, '为什么这个图片显示不出来了', NULL, '<p><img src=\"/api/images/0a470eb5-6588-407d-bdd7-bdd88b0d9f39.png\" alt=\"\">现在我上传了一篇带图片的文章</p>', '2026-01-04 03:15:25', NULL, '技术/前端/Vue3', '#bug #交流', 1, '/api/images/d9fbf556-a0e6-4528-96a2-e43c0bc8daa0.png', 1, NULL);
INSERT INTO `t_article` VALUES (37, '测试', NULL, '<p>test</p>', '2026-01-04 08:28:19', NULL, '技术/SpringBoot', '', 1, '/api/images/6.png', 2, NULL);
INSERT INTO `t_article` VALUES (38, 'bug一个', NULL, '<p>为什么无法自动创建文章分类</p>', '2026-01-04 09:05:44', NULL, '默认分类', '#bug #', 1, '/api/images/6.png', 6, NULL);
INSERT INTO `t_article` VALUES (39, '文章必须加标题...', NULL, '', '2026-01-04 09:09:19', '2026-01-04 13:18:33', '默认分类', '', 1, '/api/images/6.png', 1, NULL);
INSERT INTO `t_article` VALUES (40, '测试', NULL, '<p>测试一下根据分类创建文章能不能运行</p>', '2026-01-04 09:12:52', NULL, '技术/SpringBoot', '#test #测试', 1, '/api/images/6.png', 6, NULL);
INSERT INTO `t_article` VALUES (41, 'MOONARY', NULL, '<p><img style=\"display: block; margin-left: auto; margin-right: auto;\" src=\"/api/images/86eda4c3-f738-4e87-924f-1890373f3f0e.jpg\" alt=\"\" width=\"737\" height=\"983\"></p>\n<p>好喝,就是有一点贵</p>\n<p>&nbsp;</p>', '2026-01-04 10:09:39', '2026-01-04 13:11:40', '生活/美食', '#coffee #美饮 #咖啡 #Hong #Kong #香港 #抹茶', 1, '/api/images/f25acfa7-cad6-46c4-a403-5ecee391fd21.jpg', 1, '香港');
INSERT INTO `t_article` VALUES (42, '测试一下定位能否正常工作', NULL, '<p>我现在在东莞理工学院松山湖校区莞逸9栋704</p>', '2026-01-04 13:22:19', NULL, '技术', '#test #测试', 1, '/api/images/6.png', 6, NULL);

-- ----------------------------
-- Table structure for t_article_like
-- ----------------------------
DROP TABLE IF EXISTS `t_article_like`;
CREATE TABLE `t_article_like`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL COMMENT '用户ID',
  `article_id` int NOT NULL COMMENT '文章ID',
  `created` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_user_article`(`user_id` ASC, `article_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_article_like
-- ----------------------------

-- ----------------------------
-- Table structure for t_authority
-- ----------------------------
DROP TABLE IF EXISTS `t_authority`;
CREATE TABLE `t_authority`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `authority` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '权限',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of t_authority
-- ----------------------------
INSERT INTO `t_authority` VALUES (1, 'ROLE_admin');
INSERT INTO `t_authority` VALUES (2, 'ROLE_common');

-- ----------------------------
-- Table structure for t_category
-- ----------------------------
DROP TABLE IF EXISTS `t_category`;
CREATE TABLE `t_category`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `parent_id` int NOT NULL DEFAULT 0 COMMENT '父分类ID，0代表根节点',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '分类名称',
  `sort` int NULL DEFAULT 0 COMMENT '排序（越小越前）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '无限级文章分类表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of t_category
-- ----------------------------
INSERT INTO `t_category` VALUES (1, 0, '技术', 1);
INSERT INTO `t_category` VALUES (2, 0, '生活', 2);
INSERT INTO `t_category` VALUES (3, 1, '后端', 2);
INSERT INTO `t_category` VALUES (4, 1, '前端', 3);
INSERT INTO `t_category` VALUES (5, 3, 'Java', 1);
INSERT INTO `t_category` VALUES (6, 1, 'SpringBoot', 1);
INSERT INTO `t_category` VALUES (7, 4, 'Vue3', 1);
INSERT INTO `t_category` VALUES (8, 0, '学习', 3);
INSERT INTO `t_category` VALUES (9, 2, '美食', 0);

-- ----------------------------
-- Table structure for t_comment
-- ----------------------------
DROP TABLE IF EXISTS `t_comment`;
CREATE TABLE `t_comment`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '评论id',
  `article_id` int NOT NULL COMMENT '关联的文章id',
  `created` datetime NOT NULL COMMENT '评论时间',
  `ip` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '评论用户登录的ip地址',
  `content` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '评论内容',
  `status` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT 'approved' COMMENT '评论状态',
  `author` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '评论用户用户名',
  `user_id` int NULL DEFAULT NULL COMMENT '评论者ID',
  `location` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT 'IP属地',
  `likes` int NULL DEFAULT 0 COMMENT '评论点赞数',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 93 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of t_comment
-- ----------------------------
INSERT INTO `t_comment` VALUES (1, 12, '2018-12-13 00:00:00', '0:0:0:0:0:0:0:1', '很不错，不过这文章排版不太好看啊', 'approved', '李四', 2, NULL, 0);
INSERT INTO `t_comment` VALUES (2, 11, '2018-12-13 00:00:00', '0:0:0:0:0:0:0:1', '很不错的原理分析，受用了！', 'approved', '李四', 2, NULL, 0);
INSERT INTO `t_comment` VALUES (3, 10, '2018-12-13 00:00:00', '0:0:0:0:0:0:0:1', '关于Docker虚拟容器的讲解挺好的额，学习中', 'approved', '李四', 2, NULL, 0);
INSERT INTO `t_comment` VALUES (9, 1, '2018-12-13 00:00:00', '0:0:0:0:0:0:0:1', '非常不错，赞一个！', 'approved', '李四', 2, NULL, 0);
INSERT INTO `t_comment` VALUES (10, 1, '2018-12-13 00:00:00', '0:0:0:0:0:0:0:1', '博主，这资料怎么弄的？有相关资源和教材推荐吗？', 'approved', '李四', 2, NULL, 0);
INSERT INTO `t_comment` VALUES (11, 1, '2018-12-13 00:00:00', '0:0:0:0:0:0:0:1', '很详细，感谢...', 'approved', '东方不败', 3, NULL, 0);
INSERT INTO `t_comment` VALUES (12, 1, '2018-12-13 00:00:00', '0:0:0:0:0:0:0:1', '很全，努力学习中...', 'approved', '东方不败', 3, NULL, 0);
INSERT INTO `t_comment` VALUES (13, 1, '2018-12-13 00:00:00', '0:0:0:0:0:0:0:1', '好东西，先收藏起来，哈哈', 'approved', 'tom', 4, NULL, 0);
INSERT INTO `t_comment` VALUES (14, 8, '2018-12-13 00:00:00', '0:0:0:0:0:0:0:1', 'very good blog', 'approved', 'tom', 4, NULL, 0);
INSERT INTO `t_comment` VALUES (30, 19, '2025-12-16 00:00:00', NULL, '123', 'approved', '123', 5, NULL, 0);
INSERT INTO `t_comment` VALUES (31, 21, '2025-12-17 00:00:00', NULL, '123', 'approved', '李四', 2, NULL, 0);
INSERT INTO `t_comment` VALUES (32, 21, '2025-12-17 00:00:00', NULL, '123123123123123123123', 'approved', '李四', 2, NULL, 0);
INSERT INTO `t_comment` VALUES (33, 19, '2025-12-17 02:54:25', NULL, '你好你', 'approved', '李四', 2, NULL, 0);
INSERT INTO `t_comment` VALUES (34, 22, '2025-12-17 03:04:07', NULL, '我是尼克狐尼克', 'approved', '123', 5, NULL, 0);
INSERT INTO `t_comment` VALUES (35, 21, '2025-12-17 03:24:52', NULL, '你好', 'approved', '123', 5, NULL, 0);
INSERT INTO `t_comment` VALUES (36, 21, '2025-12-17 03:25:06', NULL, 'bh1', 'approved', '123', 5, NULL, 0);
INSERT INTO `t_comment` VALUES (37, 21, '2025-12-17 03:25:07', NULL, '1', 'approved', '123', 5, NULL, 0);
INSERT INTO `t_comment` VALUES (39, 21, '2025-12-17 03:25:09', NULL, '1', 'approved', '123', 5, NULL, 0);
INSERT INTO `t_comment` VALUES (40, 21, '2025-12-17 03:25:10', NULL, '1', 'approved', '123', 5, NULL, 0);
INSERT INTO `t_comment` VALUES (41, 21, '2025-12-17 03:25:10', NULL, '1', 'approved', '123', 5, NULL, 0);
INSERT INTO `t_comment` VALUES (42, 21, '2025-12-17 03:25:16', NULL, '1', 'approved', '123', 5, NULL, 0);
INSERT INTO `t_comment` VALUES (43, 21, '2025-12-17 03:25:17', NULL, '2', 'approved', '123', 5, NULL, 0);
INSERT INTO `t_comment` VALUES (44, 23, '2025-12-17 21:19:58', NULL, '???为什么这个文章显示不出来\n', 'approved', 'zzt', 6, NULL, 0);
INSERT INTO `t_comment` VALUES (45, 24, '2025-12-18 04:43:01', NULL, '已修复', 'approved', 'zzt', 6, NULL, 0);
INSERT INTO `t_comment` VALUES (46, 29, '2026-01-02 04:14:11', NULL, '新年快乐', 'approved', 'zzt', NULL, NULL, 0);
INSERT INTO `t_comment` VALUES (47, 29, '2026-01-02 04:14:34', NULL, '新年快乐', 'approved', '123', NULL, NULL, 0);
INSERT INTO `t_comment` VALUES (48, 1, '2026-01-02 15:30:17', NULL, '真的能高薪吗', 'approved', 'zzt', NULL, NULL, 0);
INSERT INTO `t_comment` VALUES (49, 30, '2026-01-02 17:43:52', '192.168.1.100', '看看ip\n', 'approved', 'zzt', NULL, '本地局域网', 0);
INSERT INTO `t_comment` VALUES (50, 30, '2026-01-02 18:08:01', '192.168.1.100', '再看看', 'approved', 'zzt', NULL, '本地局域网', 0);
INSERT INTO `t_comment` VALUES (51, 30, '2026-01-02 19:59:14', '192.168.1.100', '再看看看', 'approved', '123', NULL, '本地局域网', 0);
INSERT INTO `t_comment` VALUES (52, 30, '2026-01-02 20:02:01', '192.168.1.100', '本地局域网是什么鬼', 'approved', '123', NULL, '本地局域网', 0);
INSERT INTO `t_comment` VALUES (53, 30, '2026-01-03 00:29:10', '142.249.36.58', '看看ip', 'approved', '123', NULL, '未知星球', 0);
INSERT INTO `t_comment` VALUES (54, 30, '2026-01-03 00:33:06', '142.249.36.58', '现在是哪里', 'approved', '123', NULL, '加拿大|0|0|0', 0);
INSERT INTO `t_comment` VALUES (55, 30, '2026-01-03 00:34:51', '141.11.146.76', '再看一眼', 'approved', '123', NULL, '法国|0|0|法国电信', 0);
INSERT INTO `t_comment` VALUES (56, 30, '2026-01-03 06:24:09', '192.168.1.100', '再看看', 'approved', 'zzt', NULL, '本地局域网', 0);
INSERT INTO `t_comment` VALUES (57, 30, '2026-01-03 06:24:22', '45.147.201.215', '再看看\n', 'approved', '123', NULL, '荷兰|0|0|0', 0);
INSERT INTO `t_comment` VALUES (58, 30, '2026-01-03 06:41:07', '192.168.1.100', '有点小bug\n', 'approved', 'zzt', NULL, '本地局域网', 0);
INSERT INTO `t_comment` VALUES (59, 30, '2026-01-03 18:35:01', '192.168.1.100', '1234', 'approved', '123', NULL, '本地局域网', 0);
INSERT INTO `t_comment` VALUES (60, 30, '2026-01-04 00:43:57', '142.249.36.185', '看一下ip', 'approved', '123', NULL, '加拿大|0|0|0', 0);
INSERT INTO `t_comment` VALUES (61, 26, '2026-01-04 01:07:07', '142.249.36.185', '来水一下', 'approved', '123', NULL, '加拿大|0|0|0', 0);
INSERT INTO `t_comment` VALUES (62, 30, '2026-01-04 01:44:57', '142.249.36.185', '你好', 'approved', '123', NULL, '加拿大|0|0|0', 0);
INSERT INTO `t_comment` VALUES (63, 30, '2026-01-04 01:45:52', '142.249.36.185', '你好', 'approved', '123', NULL, '加拿大|0|0|0', 0);
INSERT INTO `t_comment` VALUES (64, 30, '2026-01-04 01:46:20', '142.249.36.185', '你好', 'approved', '123', NULL, '加拿大|0|0|0', 0);
INSERT INTO `t_comment` VALUES (65, 30, '2026-01-04 01:51:20', '192.168.1.100', '你好', 'approved', '123', NULL, '本地局域网', 0);
INSERT INTO `t_comment` VALUES (66, 30, '2026-01-04 01:51:32', '192.168.1.100', '你好', 'approved', '123', NULL, '本地局域网', 0);
INSERT INTO `t_comment` VALUES (67, 30, '2026-01-04 01:54:53', '192.168.1.100', '你好', 'approved', '123', NULL, '本地局域网', 0);
INSERT INTO `t_comment` VALUES (68, 30, '2026-01-04 01:55:05', '192.168.1.100', '数据库为空???\n', 'approved', '123', NULL, '本地局域网', 0);
INSERT INTO `t_comment` VALUES (69, 16, '2026-01-04 02:01:36', '142.249.36.185', '我来评论一下你的文章', 'approved', 'zzt', NULL, '加拿大|0|0|0', 0);
INSERT INTO `t_comment` VALUES (70, 34, '2026-01-04 02:25:39', '192.168.1.100', '我来评论一下你', 'approved', 'zzt', NULL, '本地局域网', 0);
INSERT INTO `t_comment` VALUES (71, 34, '2026-01-04 02:33:50', '192.168.1.100', '我来评论一下我自己的文章', 'approved', '123', NULL, '本地局域网', 0);
INSERT INTO `t_comment` VALUES (72, 33, '2026-01-04 02:34:12', '192.168.1.100', '我来评论一下admin的文章', 'approved', '123', NULL, '本地局域网', 0);
INSERT INTO `t_comment` VALUES (73, 32, '2026-01-04 02:34:31', '192.168.1.100', '我再来评论一下admin的文章', 'approved', '123', NULL, '本地局域网', 0);
INSERT INTO `t_comment` VALUES (74, 31, '2026-01-04 02:34:47', '192.168.1.100', '我继续评论admin的文章\n', 'approved', '123', NULL, '本地局域网', 0);
INSERT INTO `t_comment` VALUES (75, 34, '2026-01-04 02:35:14', '192.168.1.100', '我来评论一下123的文章', 'approved', 'zzt', NULL, '本地局域网', 0);
INSERT INTO `t_comment` VALUES (76, 36, '2026-01-04 03:23:24', '192.168.1.100', '修复成功啦', 'approved', 'zzt', NULL, '本地局域网', 0);
INSERT INTO `t_comment` VALUES (77, 30, '2026-01-04 08:24:58', '192.168.1.105', '我现在在哪里', 'approved', '李四', NULL, '本地局域网', 0);
INSERT INTO `t_comment` VALUES (78, 37, '2026-01-04 08:30:52', '192.168.1.102', '我来回复一下', 'approved', '李四', NULL, '本地局域网', 0);
INSERT INTO `t_comment` VALUES (79, 37, '2026-01-04 08:32:03', '192.168.1.102', '我也来回复一下', 'approved', 'tom', NULL, '本地局域网', 0);
INSERT INTO `t_comment` VALUES (80, 40, '2026-01-04 09:13:37', '192.168.1.102', '看来是可以！', 'approved', '东方不败', NULL, '本地局域网', 0);
INSERT INTO `t_comment` VALUES (82, 41, '2026-01-04 10:30:50', '192.168.1.102', '看起来好好喝', 'approved', '东方不败', NULL, '本地局域网', 0);
INSERT INTO `t_comment` VALUES (83, 41, '2026-01-04 10:32:40', '192.168.1.102', '李四的号有问题', 'approved', 'tom', NULL, '本地局域网', 0);
INSERT INTO `t_comment` VALUES (85, 41, '2026-01-04 10:35:46', '192.168.1.102', '怎么评论不了了?。。。', 'approved', 'tom', NULL, '本地局域网', 0);
INSERT INTO `t_comment` VALUES (86, 41, '2026-01-04 10:35:56', '192.168.1.102', '香港物价就是这样的，一杯要你七八十刀', 'approved', '东方不败', NULL, '本地局域网', 0);
INSERT INTO `t_comment` VALUES (87, 41, '2026-01-04 11:19:08', '192.168.1.102', '亚米亚米', 'approved', '李四', NULL, '本地局域网', 0);
INSERT INTO `t_comment` VALUES (88, 41, '2026-01-04 11:30:11', '192.168.1.102', '香港真是个好地方啊', 'approved', '东方不败', NULL, '本地局域网', 0);
INSERT INTO `t_comment` VALUES (89, 40, '2026-01-04 11:34:26', '192.168.1.102', '评论一下就消失了...', 'approved', 'zzt', NULL, '本地局域网', 0);
INSERT INTO `t_comment` VALUES (90, 23, '2026-01-04 11:34:51', '192.168.1.102', '奇怪', 'approved', 'zzt', NULL, '本地局域网', 0);
INSERT INTO `t_comment` VALUES (92, 41, '2026-01-04 11:50:13', '192.168.1.102', '好是好，但是太贵了！', 'approved', '尊贵的iPhone17ProMax用户', NULL, '本地局域网', 0);

-- ----------------------------
-- Table structure for t_comment_like
-- ----------------------------
DROP TABLE IF EXISTS `t_comment_like`;
CREATE TABLE `t_comment_like`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL COMMENT '用户ID',
  `comment_id` int NOT NULL COMMENT '评论ID',
  `created` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_user_comment`(`user_id` ASC, `comment_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_comment_like
-- ----------------------------

-- ----------------------------
-- Table structure for t_notification
-- ----------------------------
DROP TABLE IF EXISTS `t_notification`;
CREATE TABLE `t_notification`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `sender_id` int NOT NULL COMMENT '发送者ID',
  `sender_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '发送者用户名(缓存)',
  `receiver_id` int NOT NULL COMMENT '接收者ID',
  `article_id` int NULL DEFAULT NULL COMMENT '关联文章ID',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '消息内容摘要',
  `type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '类型: COMMENT(评论), REPLY(回复), SYSTEM(系统)',
  `is_read` tinyint(1) NULL DEFAULT 0 COMMENT '0:未读, 1:已读',
  `created` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 27 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '消息通知表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of t_notification
-- ----------------------------
INSERT INTO `t_notification` VALUES (1, 5, '123', 6, 30, '评论了你的文章: 你好', 'COMMENT', 1, '2026-01-04 01:54:53');
INSERT INTO `t_notification` VALUES (2, 5, '123', 6, 30, '评论了你的文章: 数据库为空???\n', 'COMMENT', 1, '2026-01-04 01:55:05');
INSERT INTO `t_notification` VALUES (3, 6, 'zzt', 5, 16, '评论了你的文章: 我来评论一下你的文章', 'COMMENT', 1, '2026-01-04 02:01:36');
INSERT INTO `t_notification` VALUES (4, 6, 'zzt', 5, 34, '评论了你的文章: 我来评论一下你', 'COMMENT', 1, '2026-01-04 02:25:39');
INSERT INTO `t_notification` VALUES (5, 5, '123', 1, 33, '评论了你的文章: 我来评论一下admin的文章', 'COMMENT', 1, '2026-01-04 02:34:12');
INSERT INTO `t_notification` VALUES (6, 5, '123', 1, 32, '评论了你的文章: 我再来评论一下admin的文章', 'COMMENT', 1, '2026-01-04 02:34:31');
INSERT INTO `t_notification` VALUES (7, 5, '123', 1, 31, '评论了你的文章: 我继续评论admin的文章\n', 'COMMENT', 1, '2026-01-04 02:34:47');
INSERT INTO `t_notification` VALUES (8, 6, 'zzt', 5, 34, '评论了你的文章: 我来评论一下123的文章', 'COMMENT', 1, '2026-01-04 02:35:14');
INSERT INTO `t_notification` VALUES (9, 6, 'zzt', 1, 36, '评论了你的文章: 修复成功啦', 'COMMENT', 1, '2026-01-04 03:23:24');
INSERT INTO `t_notification` VALUES (10, 2, '李四', 6, 30, '评论了你的文章: 我现在在哪里', 'COMMENT', 1, '2026-01-04 08:24:58');
INSERT INTO `t_notification` VALUES (11, 4, 'tom', 2, 37, '评论了你的文章: 我也来回复一下', 'COMMENT', 1, '2026-01-04 08:32:03');
INSERT INTO `t_notification` VALUES (12, 3, '东方不败', 6, 40, '评论了你的文章: 看来是可以！', 'COMMENT', 1, '2026-01-04 09:13:37');
INSERT INTO `t_notification` VALUES (13, 3, '东方不败', 6, 41, '评论了你的文章: 看起来好好喝', 'COMMENT', 1, '2026-01-04 10:30:50');
INSERT INTO `t_notification` VALUES (14, 4, 'tom', 6, 41, '评论了你的文章: 李四的号有问题', 'COMMENT', 1, '2026-01-04 10:32:40');
INSERT INTO `t_notification` VALUES (15, 4, 'tom', 2, NULL, '回复了你的评论: 你好', 'REPLY', 1, '2026-01-04 10:32:46');
INSERT INTO `t_notification` VALUES (16, 3, '东方不败', 6, 41, '评论了你的文章: 🇭🇰物价就是这样的，一杯要你七八十刀', 'COMMENT', 1, '2026-01-04 10:34:29');
INSERT INTO `t_notification` VALUES (17, 3, '东方不败', 6, 41, '评论了你的文章: 🇭🇰物价就是这样的，一杯要你七八十刀', 'COMMENT', 1, '2026-01-04 10:34:49');
INSERT INTO `t_notification` VALUES (18, 3, '东方不败', 6, 41, '评论了你的文章: 🇭🇰物价就是这样的，一杯要你七八十刀', 'COMMENT', 1, '2026-01-04 10:35:12');
INSERT INTO `t_notification` VALUES (19, 4, 'tom', 6, 41, '评论了你的文章: 怎么评论不了了?。。。', 'COMMENT', 1, '2026-01-04 10:35:46');
INSERT INTO `t_notification` VALUES (20, 3, '东方不败', 6, 41, '评论了你的文章: 香港物价就是这样的，一杯要你七八十刀', 'COMMENT', 1, '2026-01-04 10:35:56');
INSERT INTO `t_notification` VALUES (21, 2, '李四', 6, 41, '评论了你的文章: 亚米亚米', 'COMMENT', 1, '2026-01-04 11:19:08');
INSERT INTO `t_notification` VALUES (22, 4, 'tom', 2, NULL, '回复了你的评论: 怎么这样的', 'REPLY', 1, '2026-01-04 11:29:13');
INSERT INTO `t_notification` VALUES (23, 3, '东方不败', 6, 41, '评论了你的文章: 香港真是个好地方啊', 'COMMENT', 1, '2026-01-04 11:30:11');
INSERT INTO `t_notification` VALUES (24, 6, 'zzt', 2, 23, '评论了你的文章: 奇怪', 'COMMENT', 0, '2026-01-04 11:34:51');
INSERT INTO `t_notification` VALUES (25, 6, 'zzt', 1, NULL, '回复了你的评论: 回复一下你', 'REPLY', 1, '2026-01-04 11:35:01');
INSERT INTO `t_notification` VALUES (26, 7, '尊贵的iPhone17ProMax用户', 6, 41, '评论了你的文章: 好是好，但是太贵了！', 'COMMENT', 1, '2026-01-04 11:50:13');

-- ----------------------------
-- Table structure for t_op_log
-- ----------------------------
DROP TABLE IF EXISTS `t_op_log`;
CREATE TABLE `t_op_log`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL COMMENT '用户ID',
  `type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '操作类型：BROWSE(浏览), COMMENT(评论), LOGIN(登录)',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '操作描述，如文章标题',
  `target_id` int NULL DEFAULT NULL COMMENT '关联的目标ID，如文章ID',
  `created` datetime NOT NULL COMMENT '操作时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 312 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户操作日志表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of t_op_log
-- ----------------------------
INSERT INTO `t_op_log` VALUES (1, 1, 'BROWSE', '浏览了文章: 这是第几篇文章呢', 22, '2025-12-17 18:04:48');
INSERT INTO `t_op_log` VALUES (2, 1, 'BROWSE', '浏览了文章: we', 19, '2025-12-17 18:04:51');
INSERT INTO `t_op_log` VALUES (3, 1, 'BROWSE', '浏览了文章: 这是第几篇文章呢', 22, '2025-12-17 18:05:13');
INSERT INTO `t_op_log` VALUES (4, 1, 'BROWSE', '浏览了文章: we', 19, '2025-12-17 18:05:24');
INSERT INTO `t_op_log` VALUES (5, 1, 'BROWSE', '浏览了文章: 这是第几篇文章呢', 22, '2025-12-17 18:05:27');
INSERT INTO `t_op_log` VALUES (6, 1, 'BROWSE', '浏览了文章: 未知文章', 23, '2025-12-17 21:15:35');
INSERT INTO `t_op_log` VALUES (7, 1, 'BROWSE', '浏览了文章: 未知文章', 23, '2025-12-17 21:15:40');
INSERT INTO `t_op_log` VALUES (8, 1, 'BROWSE', '浏览了文章: 这是第几篇文章呢', 22, '2025-12-17 21:15:42');
INSERT INTO `t_op_log` VALUES (9, 1, 'BROWSE', '浏览了文章: 未知文章', 23, '2025-12-17 21:15:46');
INSERT INTO `t_op_log` VALUES (10, 6, 'BROWSE', '浏览了文章: 未知文章', 23, '2025-12-17 21:19:35');
INSERT INTO `t_op_log` VALUES (11, 6, 'COMMENT', '评论了文章: ???为什么这个文章显示不出来\n', 23, '2025-12-17 21:19:58');
INSERT INTO `t_op_log` VALUES (12, 6, 'BROWSE', '浏览了文章: 未知文章', 23, '2025-12-17 21:20:12');
INSERT INTO `t_op_log` VALUES (13, 6, 'BROWSE', '浏览了文章: 这是第几篇文章呢', 22, '2025-12-17 22:43:04');
INSERT INTO `t_op_log` VALUES (14, 6, 'BROWSE', '浏览了文章: 2202020202', 18, '2025-12-17 22:43:08');
INSERT INTO `t_op_log` VALUES (15, 6, 'BROWSE', '浏览了文章: 未知文章', 23, '2025-12-17 22:43:10');
INSERT INTO `t_op_log` VALUES (16, 1, 'BROWSE', '浏览了文章: 这是第几篇文章呢', 22, '2025-12-17 22:45:04');
INSERT INTO `t_op_log` VALUES (17, 1, 'BROWSE', '浏览了文章: 未知文章', 23, '2025-12-17 22:45:08');
INSERT INTO `t_op_log` VALUES (18, 1, 'BROWSE', '浏览了文章: 未知文章', 24, '2025-12-17 22:46:37');
INSERT INTO `t_op_log` VALUES (19, 1, 'BROWSE', '浏览了文章: 未知文章', 24, '2025-12-17 22:47:33');
INSERT INTO `t_op_log` VALUES (20, 6, 'BROWSE', '浏览了文章: 未知文章', 23, '2025-12-17 23:49:05');
INSERT INTO `t_op_log` VALUES (21, 1, 'BROWSE', '浏览了文章: 未知文章', 25, '2025-12-17 23:52:18');
INSERT INTO `t_op_log` VALUES (22, 1, 'BROWSE', '浏览了文章: 2121', 25, '2025-12-17 23:52:50');
INSERT INTO `t_op_log` VALUES (23, 1, 'BROWSE', '浏览了文章: 未知文章', 26, '2025-12-17 23:55:13');
INSERT INTO `t_op_log` VALUES (24, 1, 'BROWSE', '浏览了文章: 123', 27, '2025-12-18 00:15:29');
INSERT INTO `t_op_log` VALUES (25, 1, 'BROWSE', '浏览了文章: 123', 28, '2025-12-18 00:16:03');
INSERT INTO `t_op_log` VALUES (26, 1, 'BROWSE', '浏览了文章: 123', 28, '2025-12-18 00:16:13');
INSERT INTO `t_op_log` VALUES (27, 1, 'BROWSE', '浏览了文章: 123', 28, '2025-12-18 00:18:51');
INSERT INTO `t_op_log` VALUES (28, 6, 'BROWSE', '浏览了文章: 123', 27, '2025-12-18 04:02:41');
INSERT INTO `t_op_log` VALUES (29, 6, 'BROWSE', '浏览了文章: 2018新版Java学习路线图', 1, '2025-12-18 04:02:50');
INSERT INTO `t_op_log` VALUES (30, 6, 'BROWSE', '浏览了文章: 虚拟化容器技术——Docker运行机制介绍', 9, '2025-12-18 04:02:55');
INSERT INTO `t_op_log` VALUES (31, 6, 'BROWSE', '浏览了文章: 有个奇怪的bug', 24, '2025-12-18 04:03:00');
INSERT INTO `t_op_log` VALUES (32, 6, 'BROWSE', '浏览了文章: we', 19, '2025-12-18 04:03:12');
INSERT INTO `t_op_log` VALUES (33, 6, 'BROWSE', '浏览了文章: 有个奇怪的bug', 24, '2025-12-18 04:42:55');
INSERT INTO `t_op_log` VALUES (34, 6, 'COMMENT', '评论了文章: 已修复', 24, '2025-12-18 04:43:01');
INSERT INTO `t_op_log` VALUES (35, 6, 'BROWSE', '浏览了文章: 123', 27, '2025-12-18 04:45:22');
INSERT INTO `t_op_log` VALUES (36, 6, 'BROWSE', '浏览了文章: 123', 27, '2025-12-18 04:48:51');
INSERT INTO `t_op_log` VALUES (37, 6, 'BROWSE', '浏览了文章: 123', 28, '2025-12-18 04:48:52');
INSERT INTO `t_op_log` VALUES (38, 6, 'BROWSE', '浏览了文章: 有个奇怪的bug', 24, '2025-12-18 04:48:55');
INSERT INTO `t_op_log` VALUES (39, 1, 'BROWSE', '浏览了文章: 123', 28, '2025-12-18 05:40:11');
INSERT INTO `t_op_log` VALUES (40, 1, 'BROWSE', '浏览了文章: 123', 28, '2025-12-18 05:40:25');
INSERT INTO `t_op_log` VALUES (41, 1, 'BROWSE', '浏览了文章: 123', 27, '2025-12-18 05:40:27');
INSERT INTO `t_op_log` VALUES (42, 1, 'BROWSE', '浏览了文章: 2121', 25, '2025-12-18 05:40:28');
INSERT INTO `t_op_log` VALUES (43, 1, 'BROWSE', '浏览了文章: 有个奇怪的bug', 24, '2025-12-18 05:40:30');
INSERT INTO `t_op_log` VALUES (44, 1, 'BROWSE', '浏览了文章: 123', 27, '2025-12-18 06:06:13');
INSERT INTO `t_op_log` VALUES (45, 1, 'BROWSE', '浏览了文章: 123', 28, '2025-12-18 06:06:17');
INSERT INTO `t_op_log` VALUES (46, 1, 'BROWSE', '浏览了文章: 2121', 25, '2025-12-18 06:06:24');
INSERT INTO `t_op_log` VALUES (47, 1, 'BROWSE', '浏览了文章: 123', 28, '2025-12-18 06:06:33');
INSERT INTO `t_op_log` VALUES (48, 1, 'BROWSE', '浏览了文章: 123', 28, '2025-12-18 06:06:49');
INSERT INTO `t_op_log` VALUES (49, 1, 'BROWSE', '浏览了文章: 123', 28, '2025-12-18 06:37:25');
INSERT INTO `t_op_log` VALUES (50, 1, 'BROWSE', '浏览了文章: 123', 28, '2025-12-18 06:37:29');
INSERT INTO `t_op_log` VALUES (51, 1, 'BROWSE', '浏览了文章: 123', 28, '2025-12-18 06:37:37');
INSERT INTO `t_op_log` VALUES (52, 1, 'BROWSE', '浏览了文章: 123', 28, '2025-12-18 06:37:40');
INSERT INTO `t_op_log` VALUES (53, 1, 'BROWSE', '浏览了文章: 123', 28, '2025-12-18 06:37:42');
INSERT INTO `t_op_log` VALUES (54, 1, 'BROWSE', '浏览了文章: 123', 28, '2025-12-18 06:41:38');
INSERT INTO `t_op_log` VALUES (55, 1, 'BROWSE', '浏览了文章: 测试', 26, '2025-12-18 06:41:42');
INSERT INTO `t_op_log` VALUES (56, 1, 'BROWSE', '浏览了文章: 123', 28, '2025-12-18 06:41:45');
INSERT INTO `t_op_log` VALUES (57, 1, 'BROWSE', '浏览了文章: 123', 28, '2025-12-18 06:41:47');
INSERT INTO `t_op_log` VALUES (58, 1, 'BROWSE', '浏览了文章: 有个奇怪的bug', 24, '2025-12-18 06:44:13');
INSERT INTO `t_op_log` VALUES (59, 1, 'BROWSE', '浏览了文章: 有个奇怪的bug', 24, '2025-12-18 06:47:33');
INSERT INTO `t_op_log` VALUES (60, 1, 'BROWSE', '浏览了文章: 有个奇怪的bug', 24, '2025-12-18 06:47:37');
INSERT INTO `t_op_log` VALUES (61, 1, 'BROWSE', '浏览了文章: 有个奇怪的bug', 24, '2025-12-18 06:47:40');
INSERT INTO `t_op_log` VALUES (62, 1, 'BROWSE', '浏览了文章: 有个奇怪的bug', 24, '2025-12-18 06:51:35');
INSERT INTO `t_op_log` VALUES (63, 1, 'BROWSE', '浏览了文章: 有个奇怪的bug', 24, '2025-12-18 06:51:37');
INSERT INTO `t_op_log` VALUES (64, 1, 'BROWSE', '浏览了文章: we', 19, '2025-12-18 06:51:39');
INSERT INTO `t_op_log` VALUES (65, 1, 'BROWSE', '浏览了文章: 这是第几篇文章呢', 22, '2025-12-18 06:51:41');
INSERT INTO `t_op_log` VALUES (66, 1, 'BROWSE', '浏览了文章: 有个奇怪的bug', 24, '2025-12-18 06:57:25');
INSERT INTO `t_op_log` VALUES (67, 1, 'BROWSE', '浏览了文章: 有个奇怪的bug', 24, '2025-12-18 06:57:32');
INSERT INTO `t_op_log` VALUES (68, 6, 'BROWSE', '浏览了文章: 有个奇怪的bug', 24, '2025-12-18 06:57:49');
INSERT INTO `t_op_log` VALUES (69, 6, 'BROWSE', '浏览了文章: 有个奇怪的bug', 24, '2025-12-18 07:02:52');
INSERT INTO `t_op_log` VALUES (70, 6, 'BROWSE', '浏览了文章: 123', 27, '2025-12-18 07:06:54');
INSERT INTO `t_op_log` VALUES (71, 6, 'BROWSE', '浏览了文章: 有个奇怪的bug', 24, '2025-12-18 07:06:59');
INSERT INTO `t_op_log` VALUES (72, 6, 'BROWSE', '浏览了文章: 有个奇怪的bug', 24, '2025-12-18 07:07:50');
INSERT INTO `t_op_log` VALUES (73, 6, 'BROWSE', '浏览了文章: we', 19, '2025-12-18 07:08:01');
INSERT INTO `t_op_log` VALUES (74, 6, 'BROWSE', '浏览了文章: 有个奇怪的bug', 24, '2025-12-18 07:08:56');
INSERT INTO `t_op_log` VALUES (75, 6, 'BROWSE', '浏览了文章: 123', 27, '2026-01-02 03:54:57');
INSERT INTO `t_op_log` VALUES (76, 6, 'BROWSE', '浏览了文章: 有个奇怪的bug', 24, '2026-01-02 03:55:09');
INSERT INTO `t_op_log` VALUES (77, 6, 'BROWSE', '浏览了文章: 有个奇怪的bug', 24, '2026-01-02 03:55:19');
INSERT INTO `t_op_log` VALUES (78, 6, 'BROWSE', '浏览了文章: 有个奇怪的bug', 24, '2026-01-02 04:07:34');
INSERT INTO `t_op_log` VALUES (79, 6, 'BROWSE', '浏览了文章: 新年快乐', 29, '2026-01-02 04:14:07');
INSERT INTO `t_op_log` VALUES (80, 6, 'COMMENT', '评论了文章: 新年快乐', 29, '2026-01-02 04:14:11');
INSERT INTO `t_op_log` VALUES (81, 5, 'BROWSE', '浏览了文章: 新年快乐', 29, '2026-01-02 04:14:24');
INSERT INTO `t_op_log` VALUES (82, 5, 'COMMENT', '评论了文章: 新年快乐', 29, '2026-01-02 04:14:34');
INSERT INTO `t_op_log` VALUES (83, 6, 'BROWSE', '浏览了文章: 这是第几篇文章呢', 22, '2026-01-02 04:21:59');
INSERT INTO `t_op_log` VALUES (84, 6, 'BROWSE', '浏览了文章: 新年快乐', 29, '2026-01-02 04:22:55');
INSERT INTO `t_op_log` VALUES (85, 6, 'BROWSE', '浏览了文章: 有个奇怪的bug', 24, '2026-01-02 04:41:40');
INSERT INTO `t_op_log` VALUES (86, 6, 'BROWSE', '浏览了文章: 有个奇怪的bug', 24, '2026-01-02 15:29:33');
INSERT INTO `t_op_log` VALUES (87, 6, 'BROWSE', '浏览了文章: 2018新版Java学习路线图', 1, '2026-01-02 15:29:48');
INSERT INTO `t_op_log` VALUES (88, 6, 'COMMENT', '评论了文章: 真的能高薪吗', 1, '2026-01-02 15:30:17');
INSERT INTO `t_op_log` VALUES (89, 6, 'BROWSE', '浏览了文章: Spring Boot 2 权威发布', 12, '2026-01-02 16:33:13');
INSERT INTO `t_op_log` VALUES (90, 6, 'BROWSE', '浏览了文章: 未知文章', 20, '2026-01-02 16:34:24');
INSERT INTO `t_op_log` VALUES (91, 6, 'BROWSE', '浏览了文章: 新年快乐', 29, '2026-01-02 16:40:08');
INSERT INTO `t_op_log` VALUES (92, 6, 'BROWSE', '浏览了文章: 新年快乐', 29, '2026-01-02 17:42:48');
INSERT INTO `t_op_log` VALUES (93, 6, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-02 17:43:45');
INSERT INTO `t_op_log` VALUES (94, 6, 'COMMENT', '评论了文章: 看看ip\n', 30, '2026-01-02 17:43:52');
INSERT INTO `t_op_log` VALUES (95, 6, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-02 18:07:57');
INSERT INTO `t_op_log` VALUES (96, 6, 'COMMENT', '评论了文章: 再看看', 30, '2026-01-02 18:08:01');
INSERT INTO `t_op_log` VALUES (97, 5, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-02 19:56:36');
INSERT INTO `t_op_log` VALUES (98, 5, 'COMMENT', '评论了文章: 再看看看', 30, '2026-01-02 19:59:14');
INSERT INTO `t_op_log` VALUES (99, 5, 'COMMENT', '评论了文章: 本地局域网是什么鬼', 30, '2026-01-02 20:02:01');
INSERT INTO `t_op_log` VALUES (100, 5, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-03 00:29:04');
INSERT INTO `t_op_log` VALUES (101, 5, 'COMMENT', '评论了文章: 看看ip', 30, '2026-01-03 00:29:10');
INSERT INTO `t_op_log` VALUES (102, 5, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-03 00:31:42');
INSERT INTO `t_op_log` VALUES (103, 5, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-03 00:32:56');
INSERT INTO `t_op_log` VALUES (104, 5, 'COMMENT', '评论了文章: 现在是哪里', 30, '2026-01-03 00:33:06');
INSERT INTO `t_op_log` VALUES (105, 5, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-03 00:34:23');
INSERT INTO `t_op_log` VALUES (106, 5, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-03 00:34:44');
INSERT INTO `t_op_log` VALUES (107, 5, 'COMMENT', '评论了文章: 再看一眼', 30, '2026-01-03 00:34:51');
INSERT INTO `t_op_log` VALUES (108, 5, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-03 00:41:58');
INSERT INTO `t_op_log` VALUES (109, 5, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-03 06:18:58');
INSERT INTO `t_op_log` VALUES (110, 5, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-03 06:20:34');
INSERT INTO `t_op_log` VALUES (111, 5, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-03 06:21:05');
INSERT INTO `t_op_log` VALUES (112, 6, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-03 06:23:54');
INSERT INTO `t_op_log` VALUES (113, 6, 'COMMENT', '评论了文章: 再看看', 30, '2026-01-03 06:24:09');
INSERT INTO `t_op_log` VALUES (114, 5, 'COMMENT', '评论了文章: 再看看\n', 30, '2026-01-03 06:24:22');
INSERT INTO `t_op_log` VALUES (115, 6, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-03 06:26:38');
INSERT INTO `t_op_log` VALUES (116, 5, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-03 06:28:49');
INSERT INTO `t_op_log` VALUES (117, 6, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-03 06:40:45');
INSERT INTO `t_op_log` VALUES (118, 6, 'COMMENT', '评论了文章: 有点小bug\n', 30, '2026-01-03 06:41:07');
INSERT INTO `t_op_log` VALUES (119, 1, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-03 07:00:32');
INSERT INTO `t_op_log` VALUES (120, 1, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-03 07:00:43');
INSERT INTO `t_op_log` VALUES (121, 5, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-03 07:01:30');
INSERT INTO `t_op_log` VALUES (122, 1, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-03 18:34:42');
INSERT INTO `t_op_log` VALUES (123, 5, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-03 18:34:58');
INSERT INTO `t_op_log` VALUES (124, 5, 'COMMENT', '评论了文章: 1234', 30, '2026-01-03 18:35:01');
INSERT INTO `t_op_log` VALUES (125, 5, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-03 18:35:14');
INSERT INTO `t_op_log` VALUES (126, 1, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-04 00:43:28');
INSERT INTO `t_op_log` VALUES (127, 5, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-04 00:43:50');
INSERT INTO `t_op_log` VALUES (128, 5, 'COMMENT', '评论了文章: 看一下ip', 30, '2026-01-04 00:43:57');
INSERT INTO `t_op_log` VALUES (129, 5, 'BROWSE', '浏览了文章: 测试', 26, '2026-01-04 01:06:55');
INSERT INTO `t_op_log` VALUES (130, 5, 'COMMENT', '评论了文章: 来水一下', 26, '2026-01-04 01:07:07');
INSERT INTO `t_op_log` VALUES (131, 5, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-04 01:25:47');
INSERT INTO `t_op_log` VALUES (132, 5, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-04 01:44:43');
INSERT INTO `t_op_log` VALUES (133, 5, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-04 01:44:51');
INSERT INTO `t_op_log` VALUES (134, 5, 'COMMENT', '评论了文章: 你好', 30, '2026-01-04 01:44:57');
INSERT INTO `t_op_log` VALUES (135, 5, 'COMMENT', '评论了文章: 你好', 30, '2026-01-04 01:45:52');
INSERT INTO `t_op_log` VALUES (136, 5, 'COMMENT', '评论了文章: 你好', 30, '2026-01-04 01:46:20');
INSERT INTO `t_op_log` VALUES (137, 1, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-04 01:49:10');
INSERT INTO `t_op_log` VALUES (138, 1, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-04 01:49:26');
INSERT INTO `t_op_log` VALUES (139, 5, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-04 01:50:56');
INSERT INTO `t_op_log` VALUES (140, 5, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-04 01:51:16');
INSERT INTO `t_op_log` VALUES (141, 5, 'COMMENT', '评论了文章: 你好', 30, '2026-01-04 01:51:20');
INSERT INTO `t_op_log` VALUES (142, 5, 'COMMENT', '评论了文章: 你好', 30, '2026-01-04 01:51:32');
INSERT INTO `t_op_log` VALUES (143, 5, 'COMMENT', '评论了文章: 你好', 30, '2026-01-04 01:54:53');
INSERT INTO `t_op_log` VALUES (144, 5, 'COMMENT', '评论了文章: 数据库为空???\n', 30, '2026-01-04 01:55:05');
INSERT INTO `t_op_log` VALUES (145, 5, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-04 01:58:33');
INSERT INTO `t_op_log` VALUES (146, 6, 'BROWSE', '浏览了文章: 12234', 16, '2026-01-04 02:01:20');
INSERT INTO `t_op_log` VALUES (147, 6, 'COMMENT', '评论了文章: 我来评论一下你的文章', 16, '2026-01-04 02:01:36');
INSERT INTO `t_op_log` VALUES (148, 5, 'BROWSE', '浏览了文章: 我再再来发布一篇看看', 33, '2026-01-04 02:23:12');
INSERT INTO `t_op_log` VALUES (149, 1, 'BROWSE', '浏览了文章: 我看看普通用户能不能创建文章', 34, '2026-01-04 02:25:17');
INSERT INTO `t_op_log` VALUES (150, 6, 'BROWSE', '浏览了文章: 我看看普通用户能不能创建文章', 34, '2026-01-04 02:25:25');
INSERT INTO `t_op_log` VALUES (151, 6, 'COMMENT', '评论了文章: 我来评论一下你', 34, '2026-01-04 02:25:39');
INSERT INTO `t_op_log` VALUES (152, 5, 'BROWSE', '浏览了文章: 我看看普通用户能不能创建文章', 34, '2026-01-04 02:32:53');
INSERT INTO `t_op_log` VALUES (153, 5, 'BROWSE', '浏览了文章: 我看看普通用户能不能创建文章', 34, '2026-01-04 02:32:58');
INSERT INTO `t_op_log` VALUES (154, 5, 'BROWSE', '浏览了文章: 我看看普通用户能不能创建文章', 34, '2026-01-04 02:33:34');
INSERT INTO `t_op_log` VALUES (155, 5, 'COMMENT', '评论了文章: 我来评论一下我自己的文章', 34, '2026-01-04 02:33:50');
INSERT INTO `t_op_log` VALUES (156, 5, 'BROWSE', '浏览了文章: 我再再来发布一篇看看', 33, '2026-01-04 02:34:00');
INSERT INTO `t_op_log` VALUES (157, 5, 'COMMENT', '评论了文章: 我来评论一下admin的文章', 33, '2026-01-04 02:34:12');
INSERT INTO `t_op_log` VALUES (158, 5, 'BROWSE', '浏览了文章: 我再来发布一篇看看', 32, '2026-01-04 02:34:19');
INSERT INTO `t_op_log` VALUES (159, 5, 'COMMENT', '评论了文章: 我再来评论一下admin的文章', 32, '2026-01-04 02:34:31');
INSERT INTO `t_op_log` VALUES (160, 5, 'BROWSE', '浏览了文章: 123', 31, '2026-01-04 02:34:37');
INSERT INTO `t_op_log` VALUES (161, 5, 'COMMENT', '评论了文章: 我继续评论admin的文章\n', 31, '2026-01-04 02:34:47');
INSERT INTO `t_op_log` VALUES (162, 6, 'BROWSE', '浏览了文章: 我看看普通用户能不能创建文章', 34, '2026-01-04 02:35:02');
INSERT INTO `t_op_log` VALUES (163, 6, 'COMMENT', '评论了文章: 我来评论一下123的文章', 34, '2026-01-04 02:35:14');
INSERT INTO `t_op_log` VALUES (164, 5, 'BROWSE', '浏览了文章: 我看看普通用户能不能创建文章', 34, '2026-01-04 02:35:24');
INSERT INTO `t_op_log` VALUES (165, 6, 'BROWSE', '浏览了文章: 我现在要来验证一下分类标签功能是否能正常使用', 35, '2026-01-04 02:52:54');
INSERT INTO `t_op_log` VALUES (166, 1, 'BROWSE', '浏览了文章: 为什么这个图片显示不出来了', 36, '2026-01-04 03:15:30');
INSERT INTO `t_op_log` VALUES (167, 1, 'BROWSE', '浏览了文章: 为什么这个图片显示不出来了', 36, '2026-01-04 03:23:07');
INSERT INTO `t_op_log` VALUES (168, 6, 'BROWSE', '浏览了文章: 为什么这个图片显示不出来了', 36, '2026-01-04 03:23:16');
INSERT INTO `t_op_log` VALUES (169, 6, 'COMMENT', '评论了文章: 修复成功啦', 36, '2026-01-04 03:23:24');
INSERT INTO `t_op_log` VALUES (170, 6, 'BROWSE', '浏览了文章: 为什么这个图片显示不出来了', 36, '2026-01-04 07:55:07');
INSERT INTO `t_op_log` VALUES (171, 6, 'BROWSE', '浏览了文章: Docker常用客户端指令介绍', 10, '2026-01-04 07:57:46');
INSERT INTO `t_op_log` VALUES (172, 2, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-04 08:24:51');
INSERT INTO `t_op_log` VALUES (173, 2, 'COMMENT', '评论了文章: 我现在在哪里', 30, '2026-01-04 08:24:58');
INSERT INTO `t_op_log` VALUES (174, 2, 'BROWSE', '浏览了文章: 测试', 37, '2026-01-04 08:30:43');
INSERT INTO `t_op_log` VALUES (175, 2, 'COMMENT', '评论了文章: 我来回复一下', 37, '2026-01-04 08:30:52');
INSERT INTO `t_op_log` VALUES (176, 2, 'BROWSE', '浏览了文章: 测试', 37, '2026-01-04 08:31:03');
INSERT INTO `t_op_log` VALUES (177, 4, 'BROWSE', '浏览了文章: 测试', 37, '2026-01-04 08:31:56');
INSERT INTO `t_op_log` VALUES (178, 4, 'COMMENT', '评论了文章: 我也来回复一下', 37, '2026-01-04 08:32:03');
INSERT INTO `t_op_log` VALUES (179, 6, 'BROWSE', '浏览了文章: 2018新版Java学习路线图', 1, '2026-01-04 08:49:31');
INSERT INTO `t_op_log` VALUES (180, 3, 'BROWSE', '浏览了文章: JDK 8——聚合操作', 8, '2026-01-04 09:06:38');
INSERT INTO `t_op_log` VALUES (181, 3, 'BROWSE', '浏览了文章: 测试', 40, '2026-01-04 09:13:16');
INSERT INTO `t_op_log` VALUES (182, 3, 'BROWSE', '浏览了文章: 测试', 40, '2026-01-04 09:13:22');
INSERT INTO `t_op_log` VALUES (183, 3, 'COMMENT', '评论了文章: 看来是可以！', 40, '2026-01-04 09:13:37');
INSERT INTO `t_op_log` VALUES (184, 6, 'BROWSE', '浏览了文章: 测试', 40, '2026-01-04 09:34:41');
INSERT INTO `t_op_log` VALUES (185, 2, 'BROWSE', '浏览了文章: 未知文章', 20, '2026-01-04 09:53:12');
INSERT INTO `t_op_log` VALUES (186, 2, 'BROWSE', '浏览了文章: 未知文章', 20, '2026-01-04 09:53:15');
INSERT INTO `t_op_log` VALUES (187, 2, 'BROWSE', '浏览了文章: 未知文章', 20, '2026-01-04 09:53:18');
INSERT INTO `t_op_log` VALUES (188, 6, 'BROWSE', '浏览了文章: 未知文章', 20, '2026-01-04 09:53:35');
INSERT INTO `t_op_log` VALUES (189, 6, 'BROWSE', '浏览了文章: 未知文章', 20, '2026-01-04 09:53:39');
INSERT INTO `t_op_log` VALUES (190, 6, 'BROWSE', '浏览了文章: 测试', 40, '2026-01-04 09:53:51');
INSERT INTO `t_op_log` VALUES (191, 6, 'BROWSE', '浏览了文章: 未知文章', 20, '2026-01-04 09:53:55');
INSERT INTO `t_op_log` VALUES (192, 6, 'BROWSE', '浏览了文章: 未知文章', 20, '2026-01-04 09:54:05');
INSERT INTO `t_op_log` VALUES (193, 6, 'BROWSE', '浏览了文章: 未知文章', 20, '2026-01-04 09:54:22');
INSERT INTO `t_op_log` VALUES (194, 6, 'BROWSE', '浏览了文章: 未知文章', 20, '2026-01-04 09:54:29');
INSERT INTO `t_op_log` VALUES (195, 6, 'BROWSE', '浏览了文章: 未知文章', 20, '2026-01-04 09:54:35');
INSERT INTO `t_op_log` VALUES (196, 6, 'BROWSE', '浏览了文章: 未知文章', 20, '2026-01-04 09:54:53');
INSERT INTO `t_op_log` VALUES (197, 6, 'BROWSE', '浏览了文章: 未知文章', 20, '2026-01-04 09:55:06');
INSERT INTO `t_op_log` VALUES (198, 6, 'BROWSE', '浏览了文章: 未知文章', 20, '2026-01-04 09:57:03');
INSERT INTO `t_op_log` VALUES (199, 2, 'BROWSE', '浏览了文章: 未知文章', 20, '2026-01-04 10:09:52');
INSERT INTO `t_op_log` VALUES (200, 2, 'BROWSE', '浏览了文章: 未知文章', 20, '2026-01-04 10:09:56');
INSERT INTO `t_op_log` VALUES (201, 6, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 10:11:17');
INSERT INTO `t_op_log` VALUES (202, 6, 'BROWSE', '浏览了文章: 测试', 40, '2026-01-04 10:11:37');
INSERT INTO `t_op_log` VALUES (203, 6, 'BROWSE', '浏览了文章: bug一个', 38, '2026-01-04 10:11:40');
INSERT INTO `t_op_log` VALUES (204, 6, 'BROWSE', '浏览了文章: 未知文章', 20, '2026-01-04 10:12:14');
INSERT INTO `t_op_log` VALUES (205, 6, 'BROWSE', '浏览了文章: 未知文章', 20, '2026-01-04 10:15:08');
INSERT INTO `t_op_log` VALUES (206, 2, 'BROWSE', '浏览了文章: 未知文章', 20, '2026-01-04 10:15:50');
INSERT INTO `t_op_log` VALUES (207, 2, 'BROWSE', '浏览了文章: 未知文章', 20, '2026-01-04 10:15:57');
INSERT INTO `t_op_log` VALUES (208, 2, 'BROWSE', '浏览了文章: 未知文章', 20, '2026-01-04 10:16:06');
INSERT INTO `t_op_log` VALUES (209, 6, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 10:17:06');
INSERT INTO `t_op_log` VALUES (210, 6, 'BROWSE', '浏览了文章: 未知文章', 20, '2026-01-04 10:19:41');
INSERT INTO `t_op_log` VALUES (211, 6, 'BROWSE', '浏览了文章: 2018新版Java学习路线图', 1, '2026-01-04 10:19:47');
INSERT INTO `t_op_log` VALUES (212, 6, 'BROWSE', '浏览了文章: 未知文章', 20, '2026-01-04 10:20:21');
INSERT INTO `t_op_log` VALUES (213, 6, 'COMMENT', '评论了文章: 我来', 20, '2026-01-04 10:20:27');
INSERT INTO `t_op_log` VALUES (214, 6, 'BROWSE', '浏览了文章: 2018新版Java学习路线图', 1, '2026-01-04 10:20:36');
INSERT INTO `t_op_log` VALUES (215, 6, 'BROWSE', '浏览了文章: 未知文章', 20, '2026-01-04 10:20:41');
INSERT INTO `t_op_log` VALUES (216, 6, 'BROWSE', '浏览了文章: 未知文章', 20, '2026-01-04 10:20:58');
INSERT INTO `t_op_log` VALUES (217, 2, 'BROWSE', '浏览了文章: 未知文章', 20, '2026-01-04 10:22:36');
INSERT INTO `t_op_log` VALUES (218, 2, 'BROWSE', '浏览了文章: 未知文章', 20, '2026-01-04 10:22:39');
INSERT INTO `t_op_log` VALUES (219, 2, 'BROWSE', '浏览了文章: 未知文章', 20, '2026-01-04 10:22:50');
INSERT INTO `t_op_log` VALUES (220, 2, 'BROWSE', '浏览了文章: 未知文章', 20, '2026-01-04 10:22:53');
INSERT INTO `t_op_log` VALUES (221, 2, 'BROWSE', '浏览了文章: 未知文章', 20, '2026-01-04 10:24:20');
INSERT INTO `t_op_log` VALUES (222, 2, 'BROWSE', '浏览了文章: 未知文章', 20, '2026-01-04 10:24:43');
INSERT INTO `t_op_log` VALUES (223, 2, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 10:29:58');
INSERT INTO `t_op_log` VALUES (224, 2, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 10:30:13');
INSERT INTO `t_op_log` VALUES (225, 6, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 10:30:18');
INSERT INTO `t_op_log` VALUES (226, 3, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 10:30:39');
INSERT INTO `t_op_log` VALUES (227, 3, 'COMMENT', '评论了文章: 看起来好好喝', 41, '2026-01-04 10:30:50');
INSERT INTO `t_op_log` VALUES (228, 2, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 10:31:05');
INSERT INTO `t_op_log` VALUES (229, 2, 'BROWSE', '浏览了文章: 为什么这个图片显示不出来了', 36, '2026-01-04 10:31:13');
INSERT INTO `t_op_log` VALUES (230, 2, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 10:31:27');
INSERT INTO `t_op_log` VALUES (231, 4, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 10:32:26');
INSERT INTO `t_op_log` VALUES (232, 4, 'COMMENT', '评论了文章: 李四的号有问题', 41, '2026-01-04 10:32:40');
INSERT INTO `t_op_log` VALUES (233, 6, 'BROWSE', '浏览了文章: ', 39, '2026-01-04 10:33:20');
INSERT INTO `t_op_log` VALUES (234, 6, 'COMMENT', '评论了文章: ???这个文章怎么可以做到没有标题没有内...', 39, '2026-01-04 10:33:39');
INSERT INTO `t_op_log` VALUES (235, 6, 'BROWSE', '浏览了文章: 测试', 37, '2026-01-04 10:33:49');
INSERT INTO `t_op_log` VALUES (236, 3, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 10:34:44');
INSERT INTO `t_op_log` VALUES (237, 6, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 10:35:14');
INSERT INTO `t_op_log` VALUES (238, 4, 'COMMENT', '评论了文章: 怎么评论不了了?。。。', 41, '2026-01-04 10:35:46');
INSERT INTO `t_op_log` VALUES (239, 3, 'COMMENT', '评论了文章: 香港物价就是这样的，一杯要你七八十刀', 41, '2026-01-04 10:35:56');
INSERT INTO `t_op_log` VALUES (240, 6, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 10:36:19');
INSERT INTO `t_op_log` VALUES (241, 6, 'BROWSE', '浏览了文章: 2018新版Java学习路线图', 1, '2026-01-04 10:40:28');
INSERT INTO `t_op_log` VALUES (242, 4, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 10:48:55');
INSERT INTO `t_op_log` VALUES (243, 6, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 10:49:12');
INSERT INTO `t_op_log` VALUES (244, 6, 'BROWSE', '浏览了文章: 测试', 40, '2026-01-04 10:49:14');
INSERT INTO `t_op_log` VALUES (245, 6, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 10:49:25');
INSERT INTO `t_op_log` VALUES (246, 6, 'BROWSE', '浏览了文章: 2018新版前端与移动开发学习线路图', 3, '2026-01-04 10:49:48');
INSERT INTO `t_op_log` VALUES (247, 6, 'BROWSE', '浏览了文章: 123', 31, '2026-01-04 10:49:52');
INSERT INTO `t_op_log` VALUES (248, 6, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 11:11:04');
INSERT INTO `t_op_log` VALUES (249, 6, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 11:11:44');
INSERT INTO `t_op_log` VALUES (250, 6, 'BROWSE', '浏览了文章: 2018新版前端与移动开发学习线路图', 3, '2026-01-04 11:11:46');
INSERT INTO `t_op_log` VALUES (251, 6, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 11:12:12');
INSERT INTO `t_op_log` VALUES (252, 6, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 11:16:23');
INSERT INTO `t_op_log` VALUES (253, 6, 'BROWSE', '浏览了文章: 测试', 40, '2026-01-04 11:16:25');
INSERT INTO `t_op_log` VALUES (254, 6, 'BROWSE', '浏览了文章: bug一个', 38, '2026-01-04 11:16:29');
INSERT INTO `t_op_log` VALUES (255, 6, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 11:17:18');
INSERT INTO `t_op_log` VALUES (256, 6, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 11:18:50');
INSERT INTO `t_op_log` VALUES (257, 2, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 11:19:00');
INSERT INTO `t_op_log` VALUES (258, 2, 'COMMENT', '评论了文章: 亚米亚米', 41, '2026-01-04 11:19:08');
INSERT INTO `t_op_log` VALUES (259, 2, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 11:27:50');
INSERT INTO `t_op_log` VALUES (260, 2, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 11:28:10');
INSERT INTO `t_op_log` VALUES (261, 4, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 11:28:20');
INSERT INTO `t_op_log` VALUES (262, 3, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 11:29:58');
INSERT INTO `t_op_log` VALUES (263, 3, 'COMMENT', '评论了文章: 香港真是个好地方啊', 41, '2026-01-04 11:30:11');
INSERT INTO `t_op_log` VALUES (264, 2, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 11:33:23');
INSERT INTO `t_op_log` VALUES (265, 2, 'BROWSE', '浏览了文章: 好多bug...', 23, '2026-01-04 11:33:35');
INSERT INTO `t_op_log` VALUES (266, 2, 'BROWSE', '浏览了文章: 2121', 25, '2026-01-04 11:33:41');
INSERT INTO `t_op_log` VALUES (267, 2, 'BROWSE', '浏览了文章: 测试', 26, '2026-01-04 11:33:45');
INSERT INTO `t_op_log` VALUES (268, 2, 'BROWSE', '浏览了文章: ', 39, '2026-01-04 11:33:51');
INSERT INTO `t_op_log` VALUES (269, 2, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 11:33:54');
INSERT INTO `t_op_log` VALUES (270, 6, 'BROWSE', '浏览了文章: 测试', 40, '2026-01-04 11:34:11');
INSERT INTO `t_op_log` VALUES (271, 6, 'COMMENT', '评论了文章: 评论一下就消失了...', 40, '2026-01-04 11:34:26');
INSERT INTO `t_op_log` VALUES (272, 6, 'BROWSE', '浏览了文章: ', 39, '2026-01-04 11:34:28');
INSERT INTO `t_op_log` VALUES (273, 6, 'BROWSE', '浏览了文章: bug一个', 38, '2026-01-04 11:34:31');
INSERT INTO `t_op_log` VALUES (274, 6, 'BROWSE', '浏览了文章: 新年快乐', 29, '2026-01-04 11:34:37');
INSERT INTO `t_op_log` VALUES (275, 6, 'BROWSE', '浏览了文章: 好多bug...', 23, '2026-01-04 11:34:42');
INSERT INTO `t_op_log` VALUES (276, 6, 'BROWSE', '浏览了文章: 好多bug...', 23, '2026-01-04 11:34:44');
INSERT INTO `t_op_log` VALUES (277, 6, 'COMMENT', '评论了文章: 奇怪', 23, '2026-01-04 11:34:51');
INSERT INTO `t_op_log` VALUES (278, 6, 'BROWSE', '浏览了文章: 测试', 26, '2026-01-04 11:35:09');
INSERT INTO `t_op_log` VALUES (279, 6, 'BROWSE', '浏览了文章: 有个奇怪的bug', 24, '2026-01-04 11:35:33');
INSERT INTO `t_op_log` VALUES (280, 6, 'BROWSE', '浏览了文章: 测试', 37, '2026-01-04 11:35:42');
INSERT INTO `t_op_log` VALUES (281, 6, 'BROWSE', '浏览了文章: bug一个', 38, '2026-01-04 11:35:46');
INSERT INTO `t_op_log` VALUES (282, 6, 'BROWSE', '浏览了文章: 我现在要来验证一下分类标签功能是否能正常使用', 35, '2026-01-04 11:35:52');
INSERT INTO `t_op_log` VALUES (283, 6, 'BROWSE', '浏览了文章: 123', 27, '2026-01-04 11:35:56');
INSERT INTO `t_op_log` VALUES (284, 6, 'BROWSE', '浏览了文章: IP测试', 30, '2026-01-04 11:36:00');
INSERT INTO `t_op_log` VALUES (285, 6, 'BROWSE', '浏览了文章: 未知文章', 20, '2026-01-04 11:36:06');
INSERT INTO `t_op_log` VALUES (286, 6, 'BROWSE', '浏览了文章: 123', 31, '2026-01-04 11:36:20');
INSERT INTO `t_op_log` VALUES (287, 6, 'BROWSE', '浏览了文章: ', 39, '2026-01-04 11:36:27');
INSERT INTO `t_op_log` VALUES (288, 6, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 11:36:29');
INSERT INTO `t_op_log` VALUES (289, 6, 'BROWSE', '浏览了文章: ', 39, '2026-01-04 11:36:37');
INSERT INTO `t_op_log` VALUES (290, 6, 'COMMENT', '评论了文章: ???', 39, '2026-01-04 11:36:42');
INSERT INTO `t_op_log` VALUES (291, 6, 'BROWSE', '浏览了文章: ', 39, '2026-01-04 11:36:44');
INSERT INTO `t_op_log` VALUES (292, 6, 'BROWSE', '浏览了文章: 好多bug...', 23, '2026-01-04 11:36:49');
INSERT INTO `t_op_log` VALUES (293, 6, 'BROWSE', '浏览了文章: 2121', 25, '2026-01-04 11:36:53');
INSERT INTO `t_op_log` VALUES (294, 4, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 11:41:59');
INSERT INTO `t_op_log` VALUES (295, 7, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 11:49:38');
INSERT INTO `t_op_log` VALUES (296, 7, 'COMMENT', '评论了文章: 好是好，但是太贵了！', 41, '2026-01-04 11:50:13');
INSERT INTO `t_op_log` VALUES (297, 1, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 12:43:20');
INSERT INTO `t_op_log` VALUES (298, 6, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 12:43:38');
INSERT INTO `t_op_log` VALUES (299, 6, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 13:00:14');
INSERT INTO `t_op_log` VALUES (300, 6, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 13:07:44');
INSERT INTO `t_op_log` VALUES (301, 6, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 13:10:54');
INSERT INTO `t_op_log` VALUES (302, 6, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 13:11:14');
INSERT INTO `t_op_log` VALUES (303, 1, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 13:11:44');
INSERT INTO `t_op_log` VALUES (304, 1, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 13:18:48');
INSERT INTO `t_op_log` VALUES (305, 1, 'BROWSE', '浏览了文章: 好多bug...', 23, '2026-01-04 13:19:20');
INSERT INTO `t_op_log` VALUES (306, 6, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 13:19:42');
INSERT INTO `t_op_log` VALUES (307, 6, 'BROWSE', '浏览了文章: 测试一下定位能否正常工作', 42, '2026-01-04 13:22:22');
INSERT INTO `t_op_log` VALUES (308, 6, 'BROWSE', '浏览了文章: 测试一下定位能否正常工作', 42, '2026-01-04 13:25:58');
INSERT INTO `t_op_log` VALUES (309, 6, 'BROWSE', '浏览了文章: MOONARY', 41, '2026-01-04 13:26:02');
INSERT INTO `t_op_log` VALUES (310, 1, 'BROWSE', '浏览了文章: 我看看普通用户能不能创建文章', 34, '2026-01-04 17:26:22');
INSERT INTO `t_op_log` VALUES (311, 1, 'BROWSE', '浏览了文章: 我看看普通用户能不能创建文章', 34, '2026-01-04 17:26:35');

-- ----------------------------
-- Table structure for t_reply
-- ----------------------------
DROP TABLE IF EXISTS `t_reply`;
CREATE TABLE `t_reply`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '回复内容',
  `author` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '回复人',
  `created` datetime NOT NULL COMMENT '回复时间',
  `comment_id` int NOT NULL COMMENT '所属父评论ID',
  `target_author` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '被回复的目标用户',
  `to_uid` int NULL DEFAULT NULL COMMENT '目标用户ID',
  `user_id` int NULL DEFAULT NULL COMMENT '关联的用户ID',
  `ip` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '回复人IP',
  `location` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'IP属地',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 45 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '子评论/回复表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of t_reply
-- ----------------------------
INSERT INTO `t_reply` VALUES (1, '你是谁???', '123', '2025-12-17 00:00:00', 31, '李四', NULL, 1, NULL, NULL);
INSERT INTO `t_reply` VALUES (2, '回复 @123: 111', '123', '2025-12-17 00:00:00', 31, '123', NULL, 1, NULL, NULL);
INSERT INTO `t_reply` VALUES (3, '123123', '123', '2025-12-17 00:00:00', 31, '李四', NULL, 1, NULL, NULL);
INSERT INTO `t_reply` VALUES (4, '123', '123', '2025-12-17 00:00:00', 31, '123', NULL, 1, NULL, NULL);
INSERT INTO `t_reply` VALUES (5, '现在时几点?\n', '123', '2025-12-17 02:51:33', 31, '李四', NULL, 1, NULL, NULL);
INSERT INTO `t_reply` VALUES (6, '你好', '123', '2025-12-17 02:54:17', 30, '123', NULL, 1, NULL, NULL);
INSERT INTO `t_reply` VALUES (7, '尼克狐尼克,你被捕了', '123', '2025-12-17 03:21:42', 34, '123', NULL, 1, NULL, NULL);
INSERT INTO `t_reply` VALUES (8, '你好', 'admin', '2025-12-17 16:58:19', 34, '123', NULL, 1, NULL, NULL);
INSERT INTO `t_reply` VALUES (9, '我来回复一下', 'admin', '2025-12-17 18:05:01', 33, '李四', NULL, 1, NULL, NULL);
INSERT INTO `t_reply` VALUES (10, '怎么这么奇怪', 'zzt', '2025-12-17 21:20:08', 44, 'zzt', NULL, 1, NULL, NULL);
INSERT INTO `t_reply` VALUES (11, '好的', 'zzt', '2025-12-18 04:43:10', 45, 'zzt', NULL, 1, NULL, NULL);
INSERT INTO `t_reply` VALUES (12, '好的', 'zzt', '2025-12-18 04:43:19', 45, 'zzt', NULL, 1, NULL, NULL);
INSERT INTO `t_reply` VALUES (13, '怎么又有问题了\n', 'zzt', '2025-12-18 04:43:49', 45, 'zzt', NULL, 1, NULL, NULL);
INSERT INTO `t_reply` VALUES (14, '现在没问题了吧', 'zzt', '2025-12-18 07:07:10', 45, NULL, NULL, 6, NULL, NULL);
INSERT INTO `t_reply` VALUES (15, '怎么你的用户名是Null', 'zzt', '2025-12-18 07:07:47', 45, NULL, NULL, 6, NULL, NULL);
INSERT INTO `t_reply` VALUES (16, '因为我将索引设置为user_id而不是author,而我的user_id没有内容所以显示为null', 'zzt', '2025-12-18 07:09:56', 45, NULL, 6, 6, NULL, NULL);
INSERT INTO `t_reply` VALUES (17, '123456', 'zzt', '2026-01-02 04:07:43', 45, NULL, 6, 6, NULL, NULL);
INSERT INTO `t_reply` VALUES (18, '新年快乐', 'zzt', '2026-01-02 04:14:17', 46, NULL, NULL, 6, NULL, NULL);
INSERT INTO `t_reply` VALUES (19, '新年快乐', '123', '2026-01-02 04:14:30', 46, NULL, 6, 5, NULL, NULL);
INSERT INTO `t_reply` VALUES (20, '怎么是未知星球', '123', '2026-01-03 00:30:34', 53, NULL, NULL, 5, '142.249.36.58', '未知星球');
INSERT INTO `t_reply` VALUES (21, '怎么是法国电信', '123', '2026-01-03 00:35:04', 55, NULL, NULL, 5, '141.11.146.76', '法国|0|0|法国电信');
INSERT INTO `t_reply` VALUES (22, '为什么是法国电信', '123', '2026-01-03 06:19:16', 55, NULL, NULL, 5, '141.11.146.76', '法国|0|0|法国电信');
INSERT INTO `t_reply` VALUES (23, '现在呢', '123', '2026-01-03 06:21:16', 55, NULL, 5, 5, '45.147.201.215', '荷兰|0|0|0');
INSERT INTO `t_reply` VALUES (24, '怎么数据库存储荷兰然后回复显示法国', '123', '2026-01-03 06:23:29', 55, NULL, 5, 5, '45.147.201.215', '荷兰|0|0|0');
INSERT INTO `t_reply` VALUES (25, '再看看', 'zzt', '2026-01-03 06:24:00', 55, NULL, 5, 6, '192.168.1.100', '本地局域网');
INSERT INTO `t_reply` VALUES (26, '居然是这样', 'zzt', '2026-01-03 06:26:45', 57, NULL, NULL, 6, '192.168.1.100', '本地局域网');
INSERT INTO `t_reply` VALUES (27, '看看你的', 'admin', '2026-01-03 18:34:50', 58, NULL, NULL, 1, '192.168.1.100', '本地局域网');
INSERT INTO `t_reply` VALUES (28, '我来回复一下你', '123', '2026-01-04 01:26:08', 58, NULL, NULL, 5, '192.168.1.100', '本地局域网');
INSERT INTO `t_reply` VALUES (29, '你好', '123', '2026-01-04 01:45:16', 60, NULL, NULL, 5, '142.249.36.185', '加拿大|0|0|0');
INSERT INTO `t_reply` VALUES (30, '回复一下你的评论', '123', '2026-01-04 01:58:49', 56, NULL, NULL, 5, '142.249.36.185', '加拿大|0|0|0');
INSERT INTO `t_reply` VALUES (31, '你好,新年快乐', '123', '2026-01-04 02:35:36', 75, NULL, NULL, 5, '192.168.1.100', '本地局域网');
INSERT INTO `t_reply` VALUES (32, '学的怎么样了', 'zzt', '2026-01-04 08:05:37', 3, NULL, NULL, 6, '192.168.1.102', '本地局域网');
INSERT INTO `t_reply` VALUES (33, '本地局域网。。。', '李四', '2026-01-04 08:25:18', 77, NULL, NULL, 2, '192.168.1.105', '本地局域网');
INSERT INTO `t_reply` VALUES (34, '加拿大', '李四', '2026-01-04 08:25:28', 62, NULL, NULL, 2, '192.168.1.105', '本地局域网');
INSERT INTO `t_reply` VALUES (36, '我怎么发不了评论但是可以回复别人的评论', '李四', '2026-01-04 10:31:54', 82, NULL, NULL, 2, '192.168.1.102', '本地局域网');
INSERT INTO `t_reply` VALUES (37, '你好', 'tom', '2026-01-04 10:32:46', 82, NULL, 2, 4, '192.168.1.102', '本地局域网');
INSERT INTO `t_reply` VALUES (38, '我才发现评论区连emoji都不支持...', 'zzt', '2026-01-04 10:36:41', 85, NULL, NULL, 6, '192.168.1.102', '本地局域网');
INSERT INTO `t_reply` VALUES (39, '哦咦系', 'tom', '2026-01-04 11:28:37', 87, NULL, NULL, 4, '192.168.1.102', '本地局域网');
INSERT INTO `t_reply` VALUES (40, '怎么这样的', 'tom', '2026-01-04 11:29:13', 82, NULL, 2, 4, '192.168.1.102', '本地局域网');
INSERT INTO `t_reply` VALUES (41, '回复一下你', 'zzt', '2026-01-04 11:35:01', 44, NULL, 1, 6, '192.168.1.102', '本地局域网');
INSERT INTO `t_reply` VALUES (43, '并非好地方', '尊贵的iPhone17ProMax用户', '2026-01-04 11:49:52', 88, NULL, NULL, 7, '192.168.1.102', '本地局域网');
INSERT INTO `t_reply` VALUES (44, '你好', 'admin', '2026-01-04 13:19:31', 44, NULL, NULL, 1, '192.168.1.102', '本地局域网');

-- ----------------------------
-- Table structure for t_statistic
-- ----------------------------
DROP TABLE IF EXISTS `t_statistic`;
CREATE TABLE `t_statistic`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `article_id` int NOT NULL COMMENT '关联的文章id',
  `hits` int NOT NULL DEFAULT 0 COMMENT '文章点击总量',
  `comments_num` int NOT NULL DEFAULT 0 COMMENT '文章评论总量',
  `likes` int NULL DEFAULT 0 COMMENT '文章点赞数',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 41 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of t_statistic
-- ----------------------------
INSERT INTO `t_statistic` VALUES (1, 1, 105, 5, 0);
INSERT INTO `t_statistic` VALUES (2, 2, 4, 0, 0);
INSERT INTO `t_statistic` VALUES (3, 3, 8, 0, 0);
INSERT INTO `t_statistic` VALUES (4, 4, 4, 0, 0);
INSERT INTO `t_statistic` VALUES (5, 5, 6, 0, 0);
INSERT INTO `t_statistic` VALUES (6, 6, 18, 0, 0);
INSERT INTO `t_statistic` VALUES (7, 7, 6, 0, 0);
INSERT INTO `t_statistic` VALUES (8, 8, 26, 1, 0);
INSERT INTO `t_statistic` VALUES (9, 9, 23, 0, 0);
INSERT INTO `t_statistic` VALUES (10, 10, 19, 1, 0);
INSERT INTO `t_statistic` VALUES (11, 11, 11, 1, 0);
INSERT INTO `t_statistic` VALUES (12, 12, 43, 1, 0);
INSERT INTO `t_statistic` VALUES (13, 20, 40, 0, 0);
INSERT INTO `t_statistic` VALUES (14, 19, 16, 0, 0);
INSERT INTO `t_statistic` VALUES (15, 18, 6, 0, 0);
INSERT INTO `t_statistic` VALUES (16, 15, 1, 0, 0);
INSERT INTO `t_statistic` VALUES (17, 17, 4, 0, 0);
INSERT INTO `t_statistic` VALUES (18, 21, 17, 0, 0);
INSERT INTO `t_statistic` VALUES (19, 22, 33, 0, 0);
INSERT INTO `t_statistic` VALUES (20, 23, 23, 0, 0);
INSERT INTO `t_statistic` VALUES (21, 24, 32, 0, 0);
INSERT INTO `t_statistic` VALUES (22, 25, 7, 0, 0);
INSERT INTO `t_statistic` VALUES (23, 26, 6, 0, 0);
INSERT INTO `t_statistic` VALUES (24, 27, 10, 0, 0);
INSERT INTO `t_statistic` VALUES (25, 28, 24, 0, 0);
INSERT INTO `t_statistic` VALUES (26, 29, 7, 0, 0);
INSERT INTO `t_statistic` VALUES (27, 30, 42, 0, 0);
INSERT INTO `t_statistic` VALUES (28, 16, 1, 0, 0);
INSERT INTO `t_statistic` VALUES (29, 31, 4, 0, 0);
INSERT INTO `t_statistic` VALUES (30, 32, 1, 0, 0);
INSERT INTO `t_statistic` VALUES (31, 33, 2, 0, 0);
INSERT INTO `t_statistic` VALUES (32, 34, 9, 0, 0);
INSERT INTO `t_statistic` VALUES (33, 35, 2, 0, 0);
INSERT INTO `t_statistic` VALUES (34, 36, 6, 0, 0);
INSERT INTO `t_statistic` VALUES (35, 37, 8, 0, 0);
INSERT INTO `t_statistic` VALUES (36, 38, 4, 0, 0);
INSERT INTO `t_statistic` VALUES (37, 39, 6, 0, 0);
INSERT INTO `t_statistic` VALUES (38, 40, 8, 0, 0);
INSERT INTO `t_statistic` VALUES (39, 41, 55, 0, 0);
INSERT INTO `t_statistic` VALUES (40, 42, 2, 0, 0);

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `password` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `email` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `avatar` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '用户头像',
  `created` date NULL DEFAULT NULL,
  `valid` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES (1, 'admin', '$2a$10$5ooQI8dir8jv0/gCa1Six.GpzAdIPf6pMqdminZ/3ijYzivCyPlfK', '2127269782@qq.com', NULL, '2018-10-01', 1);
INSERT INTO `t_user` VALUES (2, '李四', '$2a$10$5ooQI8dir8jv0/gCa1Six.GpzAdIPf6pMqdminZ/3ijYzivCyPlfK', '1768653040@qq.com', NULL, '2018-11-13', 1);
INSERT INTO `t_user` VALUES (3, '东方不败', '$2a$10$5ooQI8dir8jv0/gCa1Six.GpzAdIPf6pMqdminZ/3ijYzivCyPlfK', '13718391550@163.com', NULL, '2018-12-18', 1);
INSERT INTO `t_user` VALUES (4, 'tom', '$2a$10$5ooQI8dir8jv0/gCa1Six.GpzAdIPf6pMqdminZ/3ijYzivCyPlfK', 'asexeees@sohu.com', NULL, '2018-12-03', 1);
INSERT INTO `t_user` VALUES (5, '123', '$2a$10$.M5V2dSiG0FWYyB4JfqsqOgeFmoPFzUgHQRjpyuDJ/IKcJsses0xq', '123456@qq.com', NULL, '2025-12-09', 1);
INSERT INTO `t_user` VALUES (6, 'zzt', '$2a$10$zZ5vFs0ArzFW6.yUay/8iOaHk5.XgLspxH0AX2osoQ.CW.gEaBbu.', '12345677@qq.com', NULL, '2025-12-17', 1);
INSERT INTO `t_user` VALUES (7, '尊贵的iPhone17ProMax用户', '$2a$10$Bs9s8O8jyKY03YbQAw5rfetElexv8KBHWrCRUB2ZzYX6p/MJ2s.8O', 'wannamanymanymoney@gmail.com', NULL, '2026-01-04', 1);

-- ----------------------------
-- Table structure for t_user_authority
-- ----------------------------
DROP TABLE IF EXISTS `t_user_authority`;
CREATE TABLE `t_user_authority`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL COMMENT '关联的用户id',
  `authority_id` int NOT NULL COMMENT '关联的权限id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of t_user_authority
-- ----------------------------
INSERT INTO `t_user_authority` VALUES (1, 1, 1);
INSERT INTO `t_user_authority` VALUES (2, 2, 2);
INSERT INTO `t_user_authority` VALUES (3, 3, 2);
INSERT INTO `t_user_authority` VALUES (4, 4, 2);
INSERT INTO `t_user_authority` VALUES (5, 5, 2);
INSERT INTO `t_user_authority` VALUES (6, 6, 2);
INSERT INTO `t_user_authority` VALUES (7, 7, 2);

SET FOREIGN_KEY_CHECKS = 1;
