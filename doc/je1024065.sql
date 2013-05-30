/*
MySQL Data Transfer
Source Host: 10.12.8.28
Source Database: je1024065
Target Host: 10.12.8.28
Target Database: je1024065
Date: 2013/5/30 ������ 21:51:04
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for album
-- ----------------------------
CREATE TABLE `album` (
  `aid` int(11) NOT NULL auto_increment,
  `name` varchar(45) NOT NULL,
  `uid` int(11) NOT NULL,
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `ispublic` int(11) NOT NULL default '1' COMMENT '0私有\\n1公开',
  `count` int(11) NOT NULL default '0' COMMENT '照片数',
  `cover_uri` varchar(128) default NULL,
  PRIMARY KEY  (`aid`),
  UNIQUE KEY `aid_UNIQUE` (`aid`),
  KEY `fk_album_user_idx` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=gb2312;

-- ----------------------------
-- Table structure for client
-- ----------------------------
CREATE TABLE `client` (
  `cid` int(11) NOT NULL auto_increment,
  `cname` varchar(45) NOT NULL,
  `phone` varchar(45) NOT NULL,
  `mobile` varchar(45) NOT NULL,
  `address` varchar(45) NOT NULL,
  PRIMARY KEY  (`cid`),
  UNIQUE KEY `cid_UNIQUE` (`cid`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=gb2312;

-- ----------------------------
-- Table structure for comment
-- ----------------------------
CREATE TABLE `comment` (
  `cid` int(11) NOT NULL auto_increment,
  `title` varchar(45) default NULL,
  `content` varchar(45) NOT NULL,
  `create_time` datetime NOT NULL,
  `user_uid` int(11) NOT NULL,
  `photo_pid` int(11) NOT NULL,
  PRIMARY KEY  (`cid`),
  UNIQUE KEY `cid_UNIQUE` (`cid`),
  KEY `fk_comment_user1_idx` (`user_uid`),
  KEY `fk_comment_photo1_idx` (`photo_pid`)
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=gb2312;

-- ----------------------------
-- Table structure for customer
-- ----------------------------
CREATE TABLE `customer` (
  `cid` int(11) NOT NULL auto_increment,
  `name` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  PRIMARY KEY  (`cid`),
  UNIQUE KEY `cid_UNIQUE` (`cid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=gb2312;

-- ----------------------------
-- Table structure for photo
-- ----------------------------
CREATE TABLE `photo` (
  `pid` int(11) NOT NULL auto_increment,
  `name` varchar(45) NOT NULL,
  `type` varchar(45) NOT NULL,
  `uri` varchar(255) NOT NULL,
  `size` int(11) NOT NULL,
  `create_time` datetime NOT NULL,
  `album_aid` int(11) NOT NULL,
  `views` int(11) NOT NULL default '0' COMMENT '查看次数',
  PRIMARY KEY  (`pid`),
  UNIQUE KEY `pid_UNIQUE` (`pid`),
  KEY `fk_photo_album1_idx` (`album_aid`)
) ENGINE=InnoDB AUTO_INCREMENT=178 DEFAULT CHARSET=gb2312;

-- ----------------------------
-- Table structure for photo_has_tag
-- ----------------------------
CREATE TABLE `photo_has_tag` (
  `photo_pid` int(11) NOT NULL,
  `tag_tid` int(11) NOT NULL,
  PRIMARY KEY  (`photo_pid`,`tag_tid`),
  KEY `fk_photo_has_tag_tag1_idx` (`tag_tid`),
  KEY `fk_photo_has_tag_photo1_idx` (`photo_pid`),
  CONSTRAINT `fk_photo_has_tag_photo1` FOREIGN KEY (`photo_pid`) REFERENCES `photo` (`pid`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_photo_has_tag_tag1` FOREIGN KEY (`tag_tid`) REFERENCES `tag` (`tid`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=gb2312;

-- ----------------------------
-- Table structure for role
-- ----------------------------
CREATE TABLE `role` (
  `rid` int(11) NOT NULL auto_increment,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY  (`rid`),
  UNIQUE KEY `rid_UNIQUE` (`rid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=gb2312;

-- ----------------------------
-- Table structure for tag
-- ----------------------------
CREATE TABLE `tag` (
  `tid` int(11) NOT NULL auto_increment,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY  (`tid`),
  UNIQUE KEY `tid_UNIQUE` (`tid`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=gb2312;

-- ----------------------------
-- Table structure for user
-- ----------------------------
CREATE TABLE `user` (
  `uid` int(11) NOT NULL auto_increment,
  `name` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `mail` varchar(45) NOT NULL,
  `status` int(11) NOT NULL default '0' COMMENT '0阻止\\n1有效',
  `create_time` datetime NOT NULL,
  `last_login_time` datetime NOT NULL,
  `rid` int(11) NOT NULL,
  `picture` varchar(128) default NULL,
  PRIMARY KEY  (`uid`),
  UNIQUE KEY `uid_UNIQUE` (`uid`),
  UNIQUE KEY `name_UNIQUE` (`name`),
  UNIQUE KEY `mail_UNIQUE` (`mail`),
  KEY `fk_user_Role1_idx` (`rid`),
  CONSTRAINT `fk_user_Role1` FOREIGN KEY (`rid`) REFERENCES `role` (`rid`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=gb2312;

-- ----------------------------
-- Records 
-- ----------------------------
INSERT INTO `album` VALUES ('1', 'Test Album', '1', '1970-01-01 00:00:00', '2013-05-30 21:47:02', '0', '20', 'images/public/u_2/ac13699216221495650.jpg');
INSERT INTO `album` VALUES ('13', '升起的地平线', '2', '2013-05-24 20:13:39', '2013-05-30 21:48:22', '0', '20', 'images/public/u_2/ac1369921579346508.jpg');
INSERT INTO `album` VALUES ('14', '冬日风光', '2', '1970-01-01 00:00:00', '1970-01-01 00:00:00', '1', '20', 'images/public/u_2/cover2.jpg');
INSERT INTO `album` VALUES ('19', '环球风景系列2', '2', '2013-05-25 00:00:00', '2013-05-25 00:00:00', '1', '20', 'images/public/u_2/ac1369458162470230.jpg');
INSERT INTO `album` VALUES ('20', '环球风景系列3', '2', '2013-05-25 00:00:00', '2013-05-25 00:00:00', '1', '20', 'images/public/u_2/ac13694583176957306.jpg');
INSERT INTO `album` VALUES ('21', '环球风景系列6', '2', '2013-05-25 13:15:01', '2013-05-25 13:15:01', '1', '20', 'images/public/u_2/ac13694589016038027.jpg');
INSERT INTO `album` VALUES ('22', 'HelloWorld', '2', '2013-05-25 13:21:28', '2013-05-25 13:21:28', '1', '20', 'images/public/u_2/ac13694592885026007.jpg');
INSERT INTO `album` VALUES ('23', '环球风景系列10', '2', '2013-05-25 13:22:25', '2013-05-25 13:22:25', '1', '20', 'images/public/u_2/ac13694593450603112.jpg');
INSERT INTO `album` VALUES ('24', '环球风景系列10', '2', '2013-05-25 13:23:52', '2013-05-25 13:23:52', '1', '20', 'images/public/u_2/ac13694594323581255.jpg');
INSERT INTO `album` VALUES ('28', '黄昏地平线', '1', '2013-05-26 01:59:29', '2013-05-26 01:59:29', '1', '20', 'images/public/u_1/ac13695047692393362.jpg');
INSERT INTO `album` VALUES ('29', '永远的唐布拉', '2', '2013-05-26 20:42:56', '2013-05-26 20:42:56', '1', '20', 'images/public/u_2/ac13695721764904429.jpg');
INSERT INTO `album` VALUES ('32', 'helloworld', '2', '2013-05-29 11:38:27', '2013-05-29 11:38:27', '1', '20', 'images/public/u_2/ac13697987071071895.jpg');
INSERT INTO `album` VALUES ('33', 'Test Album1', '2', '2013-05-29 22:55:57', '2013-05-29 22:55:57', '1', '21', 'images/public/u_2/ac13698393573793384.jpg');
INSERT INTO `album` VALUES ('39', 'asdfasdfasdfa', '8', '2013-05-30 16:48:23', '2013-05-30 16:48:23', '1', '0', 'images/public/u_8/ac13699037037475681.jpg');
INSERT INTO `album` VALUES ('43', '独留 - 那篇风景', '2', '2013-05-30 20:02:07', '2013-05-30 20:02:07', '1', '9', 'images/public/u_2/ac13699153276903860.jpg');
INSERT INTO `album` VALUES ('44', '迷失在城市夜灯下的天使', '2', '2013-05-30 21:14:52', '2013-05-30 21:14:52', '1', '7', 'images/public/u_2/ac13699196924521543.jpg');
INSERT INTO `client` VALUES ('1', '张三', '56355356', '1393344567', '浙江南路356号');
INSERT INTO `client` VALUES ('3', '李四', '8232345', '1808435456', '北京路840号');
INSERT INTO `client` VALUES ('4', '王五', '4892348', '1808435456', '蔡伦路1432号');
INSERT INTO `client` VALUES ('5', 'Raysmond', '65387934', '18801734441', '蔡伦路1433号');
INSERT INTO `client` VALUES ('6', '测试同学', '98374930', '18801734234', '南京路180号');
INSERT INTO `comment` VALUES ('1', 'none', '照片很精美哦！', '2013-05-25 21:14:32', '2', '36');
INSERT INTO `comment` VALUES ('2', 'none', '照片很精美哦！', '2013-05-25 21:14:42', '2', '36');
INSERT INTO `comment` VALUES ('3', 'none', '照片很精美哦！', '2013-05-25 21:14:44', '2', '36');
INSERT INTO `comment` VALUES ('4', 'none', '照片很精美哦！', '2013-05-25 21:14:47', '2', '36');
INSERT INTO `comment` VALUES ('5', 'none', '照片很精美哦！', '2013-05-25 21:14:49', '2', '36');
INSERT INTO `comment` VALUES ('6', 'none', '照片很精美哦！', '2013-05-25 23:44:38', '2', '36');
INSERT INTO `comment` VALUES ('7', 'none', '照片很精美哦！', '2013-05-25 23:44:42', '2', '36');
INSERT INTO `comment` VALUES ('8', 'none', '照片很精美哦！', '2013-05-25 23:44:43', '2', '36');
INSERT INTO `comment` VALUES ('9', 'none', '照片很精美哦！', '2013-05-25 23:44:45', '2', '36');
INSERT INTO `comment` VALUES ('10', 'none', '照片很精美哦！', '2013-05-25 23:44:47', '2', '36');
INSERT INTO `comment` VALUES ('11', 'none', '照片很精美哦！', '2013-05-25 23:44:48', '2', '36');
INSERT INTO `comment` VALUES ('12', 'none', '照片很精美哦！', '2013-05-25 23:44:50', '2', '36');
INSERT INTO `comment` VALUES ('13', 'none', '照片很精美哦！', '2013-05-25 23:44:52', '2', '36');
INSERT INTO `comment` VALUES ('14', 'none', 'asdlkfasdfasdf', '2013-05-26 00:43:13', '2', '37');
INSERT INTO `comment` VALUES ('15', 'none', '', '2013-05-26 00:59:17', '2', '40');
INSERT INTO `comment` VALUES ('16', 'none', 'hello', '2013-05-26 00:59:55', '2', '40');
INSERT INTO `comment` VALUES ('17', 'none', 'hello', '2013-05-26 01:00:53', '2', '40');
INSERT INTO `comment` VALUES ('18', 'none', 'hello', '2013-05-26 01:01:47', '2', '40');
INSERT INTO `comment` VALUES ('33', 'none', '	adfasdf					', '2013-05-26 01:15:19', '2', '36');
INSERT INTO `comment` VALUES ('34', 'none', 'hello						', '2013-05-26 01:15:30', '2', '36');
INSERT INTO `comment` VALUES ('35', 'none', '很喜欢', '2013-05-26 01:17:57', '2', '36');
INSERT INTO `comment` VALUES ('36', 'none', '太喜欢啦！', '2013-05-26 01:19:45', '2', '37');
INSERT INTO `comment` VALUES ('37', 'none', '好想去旅游', '2013-05-26 01:20:52', '2', '37');
INSERT INTO `comment` VALUES ('38', 'none', '好想去旅游', '2013-05-26 01:20:57', '2', '37');
INSERT INTO `comment` VALUES ('39', 'none', '这是哪里？', '2013-05-26 01:22:03', '2', '38');
INSERT INTO `comment` VALUES ('40', 'none', '这是哪里？？？？', '2013-05-26 01:22:10', '2', '38');
INSERT INTO `comment` VALUES ('41', 'none', '好给力！', '2013-05-26 01:22:41', '2', '38');
INSERT INTO `comment` VALUES ('42', 'none', '好给力！', '2013-05-26 01:22:45', '2', '38');
INSERT INTO `comment` VALUES ('43', 'none', '小心心本学期第一次慢跑', '2013-05-26 01:24:43', '2', '105');
INSERT INTO `comment` VALUES ('44', 'none', 'QQ么？', '2013-05-26 01:38:04', '2', '39');
INSERT INTO `comment` VALUES ('45', 'none', '234', '2013-05-26 01:38:33', '2', '39');
INSERT INTO `comment` VALUES ('46', 'none', 'hello', '2013-05-26 01:39:43', '2', '39');
INSERT INTO `comment` VALUES ('47', 'none', 'asdf', '2013-05-26 01:40:57', '2', '36');
INSERT INTO `comment` VALUES ('48', 'none', 'adsf', '2013-05-26 01:41:18', '2', '36');
INSERT INTO `comment` VALUES ('49', 'none', 'a', '2013-05-26 01:41:29', '2', '36');
INSERT INTO `comment` VALUES ('50', 'none', 'hello', '2013-05-26 01:43:14', '2', '36');
INSERT INTO `comment` VALUES ('51', 'none', 'asdf', '2013-05-26 01:43:47', '2', '36');
INSERT INTO `comment` VALUES ('52', 'none', 'ddd', '2013-05-26 01:44:37', '2', '36');
INSERT INTO `comment` VALUES ('53', 'none', 'ddda', '2013-05-26 01:44:42', '2', '36');
INSERT INTO `comment` VALUES ('54', 'none', 'dddasdf', '2013-05-26 01:44:51', '2', '36');
INSERT INTO `comment` VALUES ('55', 'none', 'dsafasdfasdfasdfasdf', '2013-05-26 01:45:47', '2', '36');
INSERT INTO `comment` VALUES ('56', 'none', 'dafsadf', '2013-05-26 01:46:31', '2', '36');
INSERT INTO `comment` VALUES ('57', 'none', '呵呵', '2013-05-26 01:46:38', '2', '37');
INSERT INTO `comment` VALUES ('58', 'none', '照片很精美哦照片很精美哦照片很精美哦照片很精美哦照片很精美哦照片很精美哦照片很精美哦', '2013-05-26 01:53:17', '2', '36');
INSERT INTO `comment` VALUES ('59', 'none', '不错！', '2013-05-26 01:57:38', '1', '32');
INSERT INTO `comment` VALUES ('60', 'none', '不错！不错！不错！不错！不错！不错！不错！不错！不错！', '2013-05-26 01:58:35', '1', '32');
INSERT INTO `comment` VALUES ('61', 'none', '不错！不错！不错！不错！不错！不错！不错！不错！不错！', '2013-05-26 01:58:41', '1', '32');
INSERT INTO `comment` VALUES ('62', 'none', '不错！不错！不错！不错！不错！不错！不错！不错！不错！', '2013-05-26 01:58:43', '1', '32');
INSERT INTO `comment` VALUES ('63', 'none', 'hello', '2013-05-26 02:07:48', '1', '33');
INSERT INTO `comment` VALUES ('64', 'none', 'sdafasd', '2013-05-26 02:10:13', '1', '116');
INSERT INTO `comment` VALUES ('65', 'none', '风景很好看！', '2013-05-26 20:53:06', '2', '118');
INSERT INTO `comment` VALUES ('66', 'none', 'hello', '2013-05-27 09:22:56', '2', '121');
INSERT INTO `comment` VALUES ('67', 'none', '走在路上', '2013-05-27 09:24:50', '2', '118');
INSERT INTO `comment` VALUES ('68', 'none', '膜拜霸天', '2013-05-27 09:27:07', '2', '55');
INSERT INTO `comment` VALUES ('69', 'none', 'Beautiful', '2013-05-29 11:44:37', '5', '114');
INSERT INTO `comment` VALUES ('70', 'none', '很好看哦！', '2013-05-30 21:27:52', '2', '177');
INSERT INTO `comment` VALUES ('71', 'none', '迷失在城市夜灯下的天使', '2013-05-30 21:28:00', '2', '177');
INSERT INTO `customer` VALUES ('1', '张三', '123', 'zhangsan@sina.com.cn');
INSERT INTO `customer` VALUES ('2', '李四', '134', 'lisi@126.com');
INSERT INTO `photo` VALUES ('32', '环球风景0', 'image/jpeg', 'images/public/u_1/1.jpg', '34657', '2013-05-23 00:00:00', '1', '3');
INSERT INTO `photo` VALUES ('33', '环球风景1', 'image/jpeg', 'images/public/u_1/2.jpg', '34657', '2013-05-23 00:00:00', '1', '3');
INSERT INTO `photo` VALUES ('34', '环球风景2', 'image/jpeg', 'images/public/u_1/3.jpg', '34657', '2013-05-23 00:00:00', '1', '3');
INSERT INTO `photo` VALUES ('35', '环球风景3', 'image/jpeg', 'images/public/u_1/4.jpg', '34657', '2013-05-23 00:00:00', '1', '3');
INSERT INTO `photo` VALUES ('36', '环球风景0', 'image/jpeg', 'images/public/u_1/1.jpg', '34657', '2013-05-23 00:00:00', '7', '3');
INSERT INTO `photo` VALUES ('37', '环球风景1', 'image/jpeg', 'images/public/u_1/2.jpg', '34657', '2013-05-23 00:00:00', '7', '3');
INSERT INTO `photo` VALUES ('38', '环球风景2', 'image/jpeg', 'images/public/u_1/3.jpg', '34657', '2013-05-23 00:00:00', '7', '3');
INSERT INTO `photo` VALUES ('39', '环球风景3', 'image/jpeg', 'images/public/u_1/4.jpg', '34657', '2013-05-23 00:00:00', '7', '3');
INSERT INTO `photo` VALUES ('40', '环球风景0', 'image/jpeg', 'images/public/u_1/1.jpg', '34657', '2013-05-23 00:00:00', '8', '3');
INSERT INTO `photo` VALUES ('41', '环球风景1', 'image/jpeg', 'images/public/u_1/2.jpg', '34657', '2013-05-23 00:00:00', '8', '3');
INSERT INTO `photo` VALUES ('42', '环球风景2', 'image/jpeg', 'images/public/u_1/3.jpg', '34657', '2013-05-23 00:00:00', '8', '3');
INSERT INTO `photo` VALUES ('43', '环球风景3', 'image/jpeg', 'images/public/u_1/4.jpg', '34657', '2013-05-23 00:00:00', '8', '3');
INSERT INTO `photo` VALUES ('44', '环球风景0', 'image/jpeg', 'images/public/u_1/1.jpg', '34657', '2013-05-23 00:00:00', '1', '3');
INSERT INTO `photo` VALUES ('45', '环球风景1', 'image/jpeg', 'images/public/u_1/2.jpg', '34657', '2013-05-23 00:00:00', '1', '3');
INSERT INTO `photo` VALUES ('46', '环球风景2', 'image/jpeg', 'images/public/u_1/3.jpg', '34657', '2013-05-23 00:00:00', '1', '3');
INSERT INTO `photo` VALUES ('47', '环球风景3', 'image/jpeg', 'images/public/u_1/4.jpg', '34657', '2013-05-23 00:00:00', '1', '3');
INSERT INTO `photo` VALUES ('48', '环球风景0', 'image/jpeg', 'images/public/u_1/1.jpg', '34657', '2013-05-23 00:00:00', '7', '3');
INSERT INTO `photo` VALUES ('49', '环球风景1', 'image/jpeg', 'images/public/u_1/2.jpg', '34657', '2013-05-23 00:00:00', '7', '3');
INSERT INTO `photo` VALUES ('50', '环球风景2', 'image/jpeg', 'images/public/u_1/3.jpg', '34657', '2013-05-23 00:00:00', '7', '3');
INSERT INTO `photo` VALUES ('51', '环球风景3', 'image/jpeg', 'images/public/u_1/4.jpg', '34657', '2013-05-23 00:00:00', '7', '3');
INSERT INTO `photo` VALUES ('52', '环球风景0', 'image/jpeg', 'images/public/u_1/1.jpg', '34657', '2013-05-23 00:00:00', '7', '3');
INSERT INTO `photo` VALUES ('53', '环球风景1', 'image/jpeg', 'images/public/u_1/2.jpg', '34657', '2013-05-23 00:00:00', '7', '3');
INSERT INTO `photo` VALUES ('54', '环球风景2', 'image/jpeg', 'images/public/u_1/3.jpg', '34657', '2013-05-23 00:00:00', '7', '3');
INSERT INTO `photo` VALUES ('55', '环球风景3', 'image/jpeg', 'images/public/u_1/4.jpg', '34657', '2013-05-23 00:00:00', '7', '3');
INSERT INTO `photo` VALUES ('106', '行吟纪Vol.1：升起的地平线-13763', 'application/octet-stream', 'images/public/u_2/c8bd1317-aacb-4616-8581-7e10982b8476.jpg', '62323', '2013-05-25 20:33:15', '13', '0');
INSERT INTO `photo` VALUES ('107', '行吟纪Vol.1：升起的地平线-13760', 'application/octet-stream', 'images/public/u_2/2f2752ca-79ae-4dfc-bf89-e25c78515ff8.jpg', '47784', '2013-05-25 20:33:15', '13', '0');
INSERT INTO `photo` VALUES ('112', '行吟纪Vol.1：升起的地平线-13760', 'application/octet-stream', 'images/public/u_1/fe6acb70-9009-45eb-9b78-64e0f0541482.jpg', '47784', '2013-05-26 01:59:47', '28', '0');
INSERT INTO `photo` VALUES ('113', '行吟纪Vol.1：升起的地平线-13763', 'application/octet-stream', 'images/public/u_1/aa3b5bb5-a72d-4713-a4f5-65de5a018f9e.jpg', '62323', '2013-05-26 01:59:47', '28', '0');
INSERT INTO `photo` VALUES ('114', '行吟纪Vol.1：升起的地平线-13765', 'application/octet-stream', 'images/public/u_1/87b4192f-c450-4ca8-a129-c25077658ae5.jpg', '51041', '2013-05-26 01:59:48', '28', '0');
INSERT INTO `photo` VALUES ('115', '行吟纪Vol.1：升起的地平线-13767', 'application/octet-stream', 'images/public/u_1/a1e7db3b-12a0-4194-859f-04137117bae1.jpg', '37033', '2013-05-26 01:59:48', '28', '0');
INSERT INTO `photo` VALUES ('116', '行吟纪Vol.1：升起的地平线-13769', 'application/octet-stream', 'images/public/u_1/9666bf1d-7366-4160-96b4-7ed207771186.jpg', '65744', '2013-05-26 01:59:48', '28', '0');
INSERT INTO `photo` VALUES ('117', '行吟纪Vol.1：升起的地平线-13771', 'application/octet-stream', 'images/public/u_1/68ca0368-3cea-47ac-9ae3-d91c9164ca95.jpg', '56732', '2013-05-26 01:59:48', '28', '0');
INSERT INTO `photo` VALUES ('118', '永远的唐布拉', 'application/octet-stream', 'images/public/u_2/489ddc27-9476-4cca-8454-3bcc1624e5f8.jpg', '424573', '2013-05-26 20:43:16', '29', '0');
INSERT INTO `photo` VALUES ('119', '永远的唐布拉', 'application/octet-stream', 'images/public/u_2/e506e562-7334-4169-b629-063123e08559.jpg', '357402', '2013-05-26 20:43:16', '29', '0');
INSERT INTO `photo` VALUES ('120', '永远的唐布拉', 'application/octet-stream', 'images/public/u_2/b9661875-82c9-4d75-86cb-3b2bcd36a282.jpg', '141553', '2013-05-26 20:43:16', '29', '0');
INSERT INTO `photo` VALUES ('121', '永远的唐布拉', 'application/octet-stream', 'images/public/u_2/4f8bbd08-7ffd-4a7e-a921-97edf979b820.jpg', '474093', '2013-05-26 20:43:17', '29', '0');
INSERT INTO `photo` VALUES ('122', '永远的唐布拉', 'application/octet-stream', 'images/public/u_2/65d67619-e953-46af-b680-94446cbc6395.jpg', '316218', '2013-05-26 20:43:17', '29', '0');
INSERT INTO `photo` VALUES ('123', '永远的唐布拉', 'application/octet-stream', 'images/public/u_2/4e05da63-3d89-4ed7-a780-2cfedf152dbb.jpg', '405362', '2013-05-26 20:43:17', '29', '0');
INSERT INTO `photo` VALUES ('129', '0b55b319ebc4b745f788cba7cffc1e178a821566', 'application/octet-stream', 'images/public/u_2/0624823b-ecfd-44ad-80f0-3c823bc5de6e.jpg', '386448', '2013-05-29 22:56:09', '33', '0');
INSERT INTO `photo` VALUES ('130', '3bf33a87e950352ac4dc4d475343fbf2b2118b3b', 'application/octet-stream', 'images/public/u_2/2e1b2765-27b8-4a45-9a60-82254632378c.jpg', '267352', '2013-05-29 22:56:09', '33', '0');
INSERT INTO `photo` VALUES ('131', '37d3d539b6003af3f0c07b2f352ac65c1038b603', 'application/octet-stream', 'images/public/u_2/51fc9e85-19ba-42b1-a6b6-0e13567b480b.jpg', '112297', '2013-05-29 22:56:09', '33', '0');
INSERT INTO `photo` VALUES ('132', '0b55b319ebc4b745f788cba7cffc1e178a821566', 'application/octet-stream', 'images/public/u_2/5ef4dfae-0ab4-4ebf-acfc-a87b87549797.jpg', '386448', '2013-05-29 23:04:45', '33', '0');
INSERT INTO `photo` VALUES ('133', '3bf33a87e950352ac4dc4d475343fbf2b2118b3b', 'application/octet-stream', 'images/public/u_2/6438ae78-0549-4fbd-8954-1ff270e03eb8.jpg', '267352', '2013-05-29 23:06:22', '33', '0');
INSERT INTO `photo` VALUES ('134', '267f9e2f07082838cc18af5bb899a9014c08f16c', 'application/octet-stream', 'images/public/u_2/9fcc0a53-2428-477d-bb94-dfd95144dad0.jpg', '134918', '2013-05-29 23:14:45', '33', '0');
INSERT INTO `photo` VALUES ('135', '23984828asdfgwsfg124', 'application/octet-stream', 'images/public/u_2/e04af866-57ec-4bcb-b680-a0a3f90a780f.png', '35043', '2013-05-29 23:15:57', '33', '0');
INSERT INTO `photo` VALUES ('136', '267f9e2f07082838cc18af5bb899a9014c08f16c', 'application/octet-stream', 'images/public/u_2/214b114c-d81e-4631-ba96-ef619a03a385.jpg', '134918', '2013-05-29 23:16:34', '33', '0');
INSERT INTO `photo` VALUES ('137', '0120250032', 'application/octet-stream', 'images/public/u_2/90f7edb2-541c-4d4a-8539-f01a905665ce.jpg', '86072', '2013-05-29 23:17:13', '33', '0');
INSERT INTO `photo` VALUES ('138', '3692056_202646622322_2', 'application/octet-stream', 'images/public/u_2/7d7c185f-8b75-471e-9351-68afc4a91d3e.jpg', '242245', '2013-05-29 23:18:30', '33', '0');
INSERT INTO `photo` VALUES ('139', '3692056_202646622322_2', 'application/octet-stream', 'images/public/u_2/a8998a0f-a927-4f49-8c7e-b0b952a36c3a.jpg', '242245', '2013-05-29 23:19:10', '33', '0');
INSERT INTO `photo` VALUES ('140', '行吟纪Vol.1：升起的地平线-13760', 'application/octet-stream', 'images/public/u_2/5a4281a2-3adc-4204-a8b1-320ad05689e9.jpg', '47784', '2013-05-29 23:20:00', '33', '0');
INSERT INTO `photo` VALUES ('141', '3692056_202646622322_2', 'application/octet-stream', 'images/public/u_2/844d2dc9-8323-467b-8888-3412c9a09469.jpg', '242245', '2013-05-29 23:21:25', '33', '0');
INSERT INTO `photo` VALUES ('142', '头的元素解析', 'application/octet-stream', 'images/public/u_2/2e56047e-6d73-4eea-b725-680756943345.jpg', '925945', '2013-05-29 23:21:45', '33', '0');
INSERT INTO `photo` VALUES ('143', 'QQ截图20130519215309', 'application/octet-stream', 'images/public/u_2/4f6be339-06cb-4d61-a536-1eceb7f16525.png', '27941', '2013-05-29 23:22:09', '33', '0');
INSERT INTO `photo` VALUES ('144', 'raysmond', 'application/octet-stream', 'images/public/u_2/e0dc5fe5-72bf-4831-846d-f0a29ad38b87.jpg', '6728', '2013-05-29 23:23:01', '33', '0');
INSERT INTO `photo` VALUES ('145', 'DON`T EAT BUILDINGS', 'application/octet-stream', 'images/public/u_2/a2c996d9-c237-47f1-b427-037aa7215db0.jpg', '359584', '2013-05-29 23:23:16', '33', '0');
INSERT INTO `photo` VALUES ('146', 'd8f9d72a6059252d19faacb6349b033b5ab5b997', 'application/octet-stream', 'images/public/u_2/3fc27f68-d272-4b3b-8814-a671818779c9.jpg', '424236', '2013-05-29 23:23:51', '33', '0');
INSERT INTO `photo` VALUES ('147', 'DON`T EAT BUILDINGS', 'application/octet-stream', 'images/public/u_2/2ec3019c-897b-4155-be91-b7a502a44827.jpg', '359584', '2013-05-29 23:24:28', '33', '0');
INSERT INTO `photo` VALUES ('148', 'd8f9d72a6059252d19faacb6349b033b5ab5b997', 'application/octet-stream', 'images/public/u_2/18a21f9a-4631-447c-9147-e926bc626ef9.jpg', '424236', '2013-05-29 23:27:24', '33', '0');
INSERT INTO `photo` VALUES ('149', '3bf33a87e950352ac4dc4d475343fbf2b2118b3b', 'application/octet-stream', 'images/public/u_2/feb82e9f-1933-46ff-bc33-f6dfe1c6ceeb.jpg', '267352', '2013-05-29 23:28:02', '33', '0');
INSERT INTO `photo` VALUES ('151', '3bf33a87e950352ac4dc4d475343fbf2b2118b3b', 'application/octet-stream', 'images/public/u_6/96defa60-2ba8-4679-8916-2bc0eca10b88.jpg', '267352', '2013-05-30 16:38:49', '35', '0');
INSERT INTO `photo` VALUES ('152', '0b55b319ebc4b745f788cba7cffc1e178a821566', 'application/octet-stream', 'images/public/u_6/8d2be57c-d66d-4633-bc6d-f835c5a58968.jpg', '386448', '2013-05-30 16:38:49', '35', '0');
INSERT INTO `photo` VALUES ('153', '37d3d539b6003af3f0c07b2f352ac65c1038b603', 'application/octet-stream', 'images/public/u_6/20a0d1f2-e3e4-4d93-840f-c0a021b16aac.jpg', '112297', '2013-05-30 16:38:49', '35', '0');
INSERT INTO `photo` VALUES ('154', '267f9e2f07082838cc18af5bb899a9014c08f16c', 'application/octet-stream', 'images/public/u_6/ce6e78ff-c419-45d4-8b93-9f655739b596.jpg', '134918', '2013-05-30 16:38:49', '35', '0');
INSERT INTO `photo` VALUES ('155', '3692056_202646622322_2', 'application/octet-stream', 'images/public/u_6/39075110-b152-4901-a9dd-049dc473e6bd.jpg', '242245', '2013-05-30 16:39:14', '35', '0');
INSERT INTO `photo` VALUES ('158', '0b55b319ebc4b745f788cba7cffc1e178a821566', 'application/octet-stream', 'images/public/u_7/6d5642c3-115a-4653-b3a0-436cb8676cc4.jpg', '386448', '2013-05-30 16:44:11', '37', '0');
INSERT INTO `photo` VALUES ('159', '3bf33a87e950352ac4dc4d475343fbf2b2118b3b', 'application/octet-stream', 'images/public/u_7/8050a3fb-9733-4f62-8c89-001063da793a.jpg', '267352', '2013-05-30 16:44:11', '37', '0');
INSERT INTO `photo` VALUES ('160', '37d3d539b6003af3f0c07b2f352ac65c1038b603', 'application/octet-stream', 'images/public/u_7/1b7264c1-de31-4c2a-ba0a-b09b98833099.jpg', '112297', '2013-05-30 16:44:11', '37', '0');
INSERT INTO `photo` VALUES ('161', '267f9e2f07082838cc18af5bb899a9014c08f16c', 'application/octet-stream', 'images/public/u_7/359aab5d-7881-42e7-8032-630c51a63674.jpg', '134918', '2013-05-30 16:44:11', '37', '0');
INSERT INTO `photo` VALUES ('162', '8326cffc1e178a82098718f0f603738da977e823', 'application/octet-stream', 'images/public/u_2/67661c78-706c-4de4-b70e-b66e0c27675a.jpg', '24513', '2013-05-30 20:02:56', '43', '0');
INSERT INTO `photo` VALUES ('163', '83025aafa40f4bfb7a0dda0d034f78f0f636188d', 'application/octet-stream', 'images/public/u_2/ce3002c6-333b-41f3-bf2d-2a318a8844ed.jpg', '316218', '2013-05-30 20:02:56', '43', '0');
INSERT INTO `photo` VALUES ('164', '2934349b033b5bb52c0864a736d3d539b700bc88', 'application/octet-stream', 'images/public/u_2/faab38a6-b20a-4069-9f41-2434dec1f649.jpg', '474093', '2013-05-30 20:02:56', '43', '0');
INSERT INTO `photo` VALUES ('165', '9922720e0cf3d7ca8d53411ff21fbe096b63a936', 'application/octet-stream', 'images/public/u_2/1674bba8-eb95-41ff-96b6-a230c47dcc8d.jpg', '164688', '2013-05-30 20:02:57', '43', '0');
INSERT INTO `photo` VALUES ('166', 'a8014c086e061d95009c17057af40ad162d9ca30', 'application/octet-stream', 'images/public/u_2/01b76135-d5e5-45c2-b532-e143cbbf341b.jpg', '1101232', '2013-05-30 20:02:57', '43', '0');
INSERT INTO `photo` VALUES ('167', 'b151f8198618367a2e4552e02f738bd4b31ce53b', 'application/octet-stream', 'images/public/u_2/b76bf90d-ad03-4990-b3b0-6d8717bf842d.jpg', '148447', '2013-05-30 20:02:58', '43', '0');
INSERT INTO `photo` VALUES ('168', '风景', 'd000baa1cd11728be830af1fc9fcc3cec3fd2ce9', 'images/public/u_2/440d35d5-9197-4525-9c3c-4206426e6c0a.jpg', '109658', '2013-05-30 20:02:58', '43', '0');
INSERT INTO `photo` VALUES ('169', 'test', 'f9dcd100baa1cd1126733679b912c8fcc2ce2da5', 'images/public/u_2/0abeeb40-49cb-4b7c-849d-49a7755a5009.jpg', '405362', '2013-05-30 20:02:58', '43', '0');
INSERT INTO `photo` VALUES ('170', '独留 - 那篇风景', 'fc1f4134970a304ebb2682c7d0c8a786c9175c82', 'images/public/u_2/ce4c36e2-c188-4362-85b3-1fd62a075bb7.jpg', '121517', '2013-05-30 20:02:58', '43', '0');
INSERT INTO `photo` VALUES ('171', '复件(20121008 10351420) 震撼：迷失在城市夜灯下的天使-499', 'application/octet-stream', 'images/public/u_2/46f70df4-784e-4cf0-bf67-e47f1edfcff6.jpg', '281358', '2013-05-30 21:15:10', '44', '0');
INSERT INTO `photo` VALUES ('172', '复件(20121008 10351347) 震撼：迷失在城市夜灯下的天使-498', 'application/octet-stream', 'images/public/u_2/7e0ae277-913c-413d-b319-ca42d45dfb3f.jpg', '529879', '2013-05-30 21:15:10', '44', '0');
INSERT INTO `photo` VALUES ('173', '复件(20121008 103512485) 震撼：迷失在城市夜灯下的天使-498', 'application/octet-stream', 'images/public/u_2/ce1d35b2-7bb0-417f-8f5f-669fbc4642c5.jpg', '613248', '2013-05-30 21:15:10', '44', '0');
INSERT INTO `photo` VALUES ('174', '复件(20121008 103514643) 震撼：迷失在城市夜灯下的天使-499', 'application/octet-stream', 'images/public/u_2/4ab643e9-01f0-4d79-9f36-da296913f42b.jpg', '644649', '2013-05-30 21:15:11', '44', '0');
INSERT INTO `photo` VALUES ('175', '复件(20121008 103514829) 震撼：迷失在城市夜灯下的天使-499', 'application/octet-stream', 'images/public/u_2/6c6943ec-c352-4377-9157-d427fb8b6b7f.jpg', '639193', '2013-05-30 21:15:11', '44', '0');
INSERT INTO `photo` VALUES ('176', '复件(20121008 103515587) 震撼：迷失在城市夜灯下的天使-499', 'application/octet-stream', 'images/public/u_2/68d8196c-7391-4d4e-a53b-96befdc36008.jpg', '700365', '2013-05-30 21:15:11', '44', '0');
INSERT INTO `photo` VALUES ('177', '复件(20121008 103516803) 震撼：迷失在城市夜灯下的天使-500', 'application/octet-stream', 'images/public/u_2/8de18509-0630-4305-851f-64e3f39f2f80.jpg', '364906', '2013-05-30 21:15:12', '44', '0');
INSERT INTO `photo_has_tag` VALUES ('121', '1');
INSERT INTO `photo_has_tag` VALUES ('36', '2');
INSERT INTO `photo_has_tag` VALUES ('36', '3');
INSERT INTO `photo_has_tag` VALUES ('37', '3');
INSERT INTO `photo_has_tag` VALUES ('36', '4');
INSERT INTO `photo_has_tag` VALUES ('39', '5');
INSERT INTO `photo_has_tag` VALUES ('37', '6');
INSERT INTO `photo_has_tag` VALUES ('38', '7');
INSERT INTO `photo_has_tag` VALUES ('40', '8');
INSERT INTO `photo_has_tag` VALUES ('40', '9');
INSERT INTO `photo_has_tag` VALUES ('40', '10');
INSERT INTO `photo_has_tag` VALUES ('41', '11');
INSERT INTO `photo_has_tag` VALUES ('42', '12');
INSERT INTO `photo_has_tag` VALUES ('43', '13');
INSERT INTO `photo_has_tag` VALUES ('40', '14');
INSERT INTO `photo_has_tag` VALUES ('41', '15');
INSERT INTO `photo_has_tag` VALUES ('42', '16');
INSERT INTO `photo_has_tag` VALUES ('43', '17');
INSERT INTO `photo_has_tag` VALUES ('44', '18');
INSERT INTO `photo_has_tag` VALUES ('118', '19');
INSERT INTO `photo_has_tag` VALUES ('118', '20');
INSERT INTO `photo_has_tag` VALUES ('55', '21');
INSERT INTO `photo_has_tag` VALUES ('155', '22');
INSERT INTO `photo_has_tag` VALUES ('161', '23');
INSERT INTO `photo_has_tag` VALUES ('177', '24');
INSERT INTO `role` VALUES ('1', 'admin');
INSERT INTO `role` VALUES ('2', 'normal');
INSERT INTO `tag` VALUES ('12', 'Beautiful');
INSERT INTO `tag` VALUES ('17', 'Can you hear me?');
INSERT INTO `tag` VALUES ('1', 'hello');
INSERT INTO `tag` VALUES ('2', 'helloa');
INSERT INTO `tag` VALUES ('18', 'helo');
INSERT INTO `tag` VALUES ('5', 'QQ');
INSERT INTO `tag` VALUES ('23', 'test');
INSERT INTO `tag` VALUES ('21', '霸天');
INSERT INTO `tag` VALUES ('22', '不错啊');
INSERT INTO `tag` VALUES ('4', '冬天');
INSERT INTO `tag` VALUES ('3', '风景');
INSERT INTO `tag` VALUES ('20', '公路');
INSERT INTO `tag` VALUES ('6', '海');
INSERT INTO `tag` VALUES ('10', '呵呵');
INSERT INTO `tag` VALUES ('14', '极地风光');
INSERT INTO `tag` VALUES ('9', '开心');
INSERT INTO `tag` VALUES ('15', '靠经大自然');
INSERT INTO `tag` VALUES ('8', '旅游');
INSERT INTO `tag` VALUES ('24', '迷失在城市夜灯下的天使');
INSERT INTO `tag` VALUES ('19', '汽车');
INSERT INTO `tag` VALUES ('7', '夏天');
INSERT INTO `tag` VALUES ('13', '笑一个');
INSERT INTO `tag` VALUES ('16', '一个人去旅游');
INSERT INTO `tag` VALUES ('11', '走走看看');
INSERT INTO `user` VALUES ('1', 'je1024065', '111111', '10300240065@fudan.edu.cn', '1', '2013-05-22 17:38:07', '2013-05-22 17:38:11', '1', 'images/public/u_1/picture.jpg');
INSERT INTO `user` VALUES ('2', 'Raysmond', '111111', 'jiankunlei@126.com', '1', '1970-01-01 00:00:00', '2013-05-30 21:45:34', '1', 'images/public/u_2/picture13699076368967734.jpg');
INSERT INTO `user` VALUES ('3', '10300240065', '12345678', 'jiankunlei@gmail.com', '1', '2013-05-23 00:00:00', '1970-01-01 00:00:00', '2', 'images/default_picture.jpg');
INSERT INTO `user` VALUES ('8', 'Jiankun Lei', '111111', 'jiankunlei@sina.com', '1', '2013-05-30 00:00:00', '2013-05-30 17:33:38', '1', 'images/default_picture.jpg');
INSERT INTO `user` VALUES ('9', '张三', '111111', 'zhangsan@fudan.edu.cn', '1', '2013-05-30 17:57:01', '2013-05-30 17:58:32', '1', 'images/public/u_9/picture13699079351173241.jpg');
