/*
MySQL Data Transfer
Source Host: 10.12.8.28
Source Database: je1024065
Target Host: 10.12.8.28
Target Database: je1024065
Date: 2013/6/6 ������ 23:06:40
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
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=gb2312;

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
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=gb2312;

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
) ENGINE=InnoDB AUTO_INCREMENT=242 DEFAULT CHARSET=gb2312;

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
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=gb2312;

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
INSERT INTO `album` VALUES ('51', '独留那片风景', '2', '2013-06-06 13:43:22', '2013-06-06 13:43:22', '1', '8', 'images/public/u_2/ac13704974029939758.jpg');
INSERT INTO `album` VALUES ('52', '环球风景系列', '2', '2013-06-06 13:44:19', '2013-06-06 13:44:19', '1', '6', 'images/public/u_2/ac13704974591181631.jpg');
INSERT INTO `album` VALUES ('53', '黄昏地平线', '2', '2013-06-06 13:44:44', '2013-06-06 13:44:44', '1', '4', 'images/public/u_2/ac13704974849209843.jpg');
INSERT INTO `album` VALUES ('54', 'Hello', '2', '2013-06-06 13:45:16', '2013-06-06 13:45:16', '1', '4', 'images/public/u_2/ac13704975161477553.jpg');
INSERT INTO `album` VALUES ('55', '永远的唐布拉', '2', '2013-06-06 13:46:10', '2013-06-06 13:46:10', '1', '1', 'images/public/u_2/ac13704975701998239.jpg');
INSERT INTO `album` VALUES ('56', '迷失在城市夜灯下的天使', '2', '2013-06-06 13:47:10', '2013-06-06 13:47:10', '1', '9', 'images/public/u_2/ac13704976308739081.jpg');
INSERT INTO `album` VALUES ('58', 'test', '2', '2013-06-06 13:52:53', '2013-06-06 13:52:53', '1', '2', 'images/public/u_2/ac13704979732645023.jpg');
INSERT INTO `album` VALUES ('59', '我的相册', '1', '2013-06-06 13:53:56', '2013-06-06 13:53:56', '1', '4', 'images/public/u_1/ac13704980360961557.jpg');
INSERT INTO `album` VALUES ('60', '我的相册2', '1', '2013-06-06 13:54:27', '2013-06-06 13:54:27', '1', '4', 'images/public/u_1/ac13704980676142261.jpg');
INSERT INTO `album` VALUES ('61', '我的相册3', '1', '2013-06-06 14:00:52', '2013-06-06 14:00:52', '1', '2', 'images/public/u_1/ac13704984525426089.jpg');
INSERT INTO `album` VALUES ('63', 'Test album1', '2', '2013-06-06 14:32:17', '2013-06-06 14:32:17', '1', '4', 'images/public/u_2/ac13705003379198134.jpg');
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
INSERT INTO `comment` VALUES ('72', 'none', 'Hi', '2013-06-05 17:34:28', '2', '184');
INSERT INTO `comment` VALUES ('73', 'none', '独留那篇风景', '2013-06-05 20:34:40', '2', '185');
INSERT INTO `comment` VALUES ('74', 'none', '你好！', '2013-06-06 11:57:44', '2', '185');
INSERT INTO `comment` VALUES ('75', 'none', '城市风景', '2013-06-06 13:50:00', '2', '222');
INSERT INTO `comment` VALUES ('76', 'none', 'hello', '2013-06-06 13:52:07', '2', '213');
INSERT INTO `comment` VALUES ('77', 'none', '测试评论', '2013-06-06 14:23:22', '2', '198');
INSERT INTO `comment` VALUES ('78', 'none', 'hello', '2013-06-06 14:33:31', '2', '193');
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
INSERT INTO `photo` VALUES ('118', '永远的唐布拉', 'application/octet-stream', 'images/public/u_2/489ddc27-9476-4cca-8454-3bcc1624e5f8.jpg', '424573', '2013-05-26 20:43:16', '29', '0');
INSERT INTO `photo` VALUES ('119', '永远的唐布拉', 'application/octet-stream', 'images/public/u_2/e506e562-7334-4169-b629-063123e08559.jpg', '357402', '2013-05-26 20:43:16', '29', '0');
INSERT INTO `photo` VALUES ('120', '永远的唐布拉', 'application/octet-stream', 'images/public/u_2/b9661875-82c9-4d75-86cb-3b2bcd36a282.jpg', '141553', '2013-05-26 20:43:16', '29', '0');
INSERT INTO `photo` VALUES ('121', '永远的唐布拉', 'application/octet-stream', 'images/public/u_2/4f8bbd08-7ffd-4a7e-a921-97edf979b820.jpg', '474093', '2013-05-26 20:43:17', '29', '0');
INSERT INTO `photo` VALUES ('122', '永远的唐布拉', 'application/octet-stream', 'images/public/u_2/65d67619-e953-46af-b680-94446cbc6395.jpg', '316218', '2013-05-26 20:43:17', '29', '0');
INSERT INTO `photo` VALUES ('123', '永远的唐布拉', 'application/octet-stream', 'images/public/u_2/4e05da63-3d89-4ed7-a780-2cfedf152dbb.jpg', '405362', '2013-05-26 20:43:17', '29', '0');
INSERT INTO `photo` VALUES ('151', '3bf33a87e950352ac4dc4d475343fbf2b2118b3b', 'application/octet-stream', 'images/public/u_6/96defa60-2ba8-4679-8916-2bc0eca10b88.jpg', '267352', '2013-05-30 16:38:49', '35', '0');
INSERT INTO `photo` VALUES ('152', '0b55b319ebc4b745f788cba7cffc1e178a821566', 'application/octet-stream', 'images/public/u_6/8d2be57c-d66d-4633-bc6d-f835c5a58968.jpg', '386448', '2013-05-30 16:38:49', '35', '0');
INSERT INTO `photo` VALUES ('153', '37d3d539b6003af3f0c07b2f352ac65c1038b603', 'application/octet-stream', 'images/public/u_6/20a0d1f2-e3e4-4d93-840f-c0a021b16aac.jpg', '112297', '2013-05-30 16:38:49', '35', '0');
INSERT INTO `photo` VALUES ('154', '267f9e2f07082838cc18af5bb899a9014c08f16c', 'application/octet-stream', 'images/public/u_6/ce6e78ff-c419-45d4-8b93-9f655739b596.jpg', '134918', '2013-05-30 16:38:49', '35', '0');
INSERT INTO `photo` VALUES ('155', '3692056_202646622322_2', 'application/octet-stream', 'images/public/u_6/39075110-b152-4901-a9dd-049dc473e6bd.jpg', '242245', '2013-05-30 16:39:14', '35', '0');
INSERT INTO `photo` VALUES ('158', '0b55b319ebc4b745f788cba7cffc1e178a821566', 'application/octet-stream', 'images/public/u_7/6d5642c3-115a-4653-b3a0-436cb8676cc4.jpg', '386448', '2013-05-30 16:44:11', '37', '0');
INSERT INTO `photo` VALUES ('159', '3bf33a87e950352ac4dc4d475343fbf2b2118b3b', 'application/octet-stream', 'images/public/u_7/8050a3fb-9733-4f62-8c89-001063da793a.jpg', '267352', '2013-05-30 16:44:11', '37', '0');
INSERT INTO `photo` VALUES ('160', '37d3d539b6003af3f0c07b2f352ac65c1038b603', 'application/octet-stream', 'images/public/u_7/1b7264c1-de31-4c2a-ba0a-b09b98833099.jpg', '112297', '2013-05-30 16:44:11', '37', '0');
INSERT INTO `photo` VALUES ('161', '267f9e2f07082838cc18af5bb899a9014c08f16c', 'application/octet-stream', 'images/public/u_7/359aab5d-7881-42e7-8032-630c51a63674.jpg', '134918', '2013-05-30 16:44:11', '37', '0');
INSERT INTO `photo` VALUES ('171', '复件(20121008 10351420) 震撼：迷失在城市夜灯下的天使-499', 'application/octet-stream', 'images/public/u_2/46f70df4-784e-4cf0-bf67-e47f1edfcff6.jpg', '281358', '2013-05-30 21:15:10', '44', '0');
INSERT INTO `photo` VALUES ('172', '复件(20121008 10351347) 震撼：迷失在城市夜灯下的天使-498', 'application/octet-stream', 'images/public/u_2/7e0ae277-913c-413d-b319-ca42d45dfb3f.jpg', '529879', '2013-05-30 21:15:10', '44', '0');
INSERT INTO `photo` VALUES ('173', ' 震撼：迷失在城市夜灯下的天使', '复件(20121008 103512485) 震撼：迷失在城市夜灯下的天使-498', 'images/public/u_2/ce1d35b2-7bb0-417f-8f5f-669fbc4642c5.jpg', '613248', '2013-05-30 21:15:10', '44', '0');
INSERT INTO `photo` VALUES ('174', '复件(20121008 103514643) 震撼：迷失在城市夜灯下的天使-499', 'application/octet-stream', 'images/public/u_2/4ab643e9-01f0-4d79-9f36-da296913f42b.jpg', '644649', '2013-05-30 21:15:11', '44', '0');
INSERT INTO `photo` VALUES ('175', '复件(20121008 103514829) 震撼：迷失在城市夜灯下的天使-499', 'application/octet-stream', 'images/public/u_2/6c6943ec-c352-4377-9157-d427fb8b6b7f.jpg', '639193', '2013-05-30 21:15:11', '44', '0');
INSERT INTO `photo` VALUES ('176', '复件(20121008 103515587) 震撼：迷失在城市夜灯下的天使-499', 'application/octet-stream', 'images/public/u_2/68d8196c-7391-4d4e-a53b-96befdc36008.jpg', '700365', '2013-05-30 21:15:11', '44', '0');
INSERT INTO `photo` VALUES ('180', '3', 'application/octet-stream', 'images/public/u_2/5ff16c7c-2f3f-4857-9a51-b093923b9649.jpg', '56732', '2013-06-05 17:32:28', '44', '0');
INSERT INTO `photo` VALUES ('181', '4', 'application/octet-stream', 'images/public/u_2/b9ab029a-b17e-48a8-b5e6-e45fc98596c5.jpg', '259982', '2013-06-05 17:32:28', '44', '0');
INSERT INTO `photo` VALUES ('182', '城市光景', '5', 'images/public/u_2/82129e44-e3ca-4c7c-afd9-60553bd9fb13.jpg', '776883', '2013-06-05 17:32:28', '44', '0');
INSERT INTO `photo` VALUES ('183', '5bafa40f4bfbfbed2992722678f0f736aec31f9b', 'application/octet-stream', 'images/public/u_2/b91f9459-b055-4401-8cd2-15e61c2e05fd.jpg', '357402', '2013-06-05 17:32:28', '44', '0');
INSERT INTO `photo` VALUES ('184', '9f2f070828381f30e904a194a8014c086e06f0e9', 'application/octet-stream', 'images/public/u_2/789a615b-e8dd-4180-9e29-9e010a11eb2a.jpg', '310777', '2013-06-05 17:32:28', '44', '0');
INSERT INTO `photo` VALUES ('185', '独留那篇风景', '63d0f703918fa0ecd55f035d269759ee3c6ddbc2', 'images/public/u_2/71edd102-08c7-4b48-93af-c5573a62a607.jpg', '61989', '2013-06-05 17:32:28', '44', '0');
INSERT INTO `photo` VALUES ('192', '4', 'application/octet-stream', 'images/public/u_2/c158caf5-984e-467c-9095-dd0a39bd5797.jpg', '259982', '2013-06-06 13:43:40', '51', '0');
INSERT INTO `photo` VALUES ('193', '5', 'application/octet-stream', 'images/public/u_2/ec6924ec-9044-455d-87ad-d29c39dc02bf.jpg', '776883', '2013-06-06 13:43:40', '51', '0');
INSERT INTO `photo` VALUES ('194', '5bafa40f4bfbfbed2992722678f0f736aec31f9b', 'application/octet-stream', 'images/public/u_2/93417272-5ef8-4750-bee1-6db2ccde9783.jpg', '357402', '2013-06-06 13:43:40', '51', '0');
INSERT INTO `photo` VALUES ('195', '9f2f070828381f30e904a194a8014c086e06f0e9', 'application/octet-stream', 'images/public/u_2/f0b3ecf7-b92f-4586-829d-5383b194b9ca.jpg', '310777', '2013-06-06 13:43:40', '51', '0');
INSERT INTO `photo` VALUES ('196', '63d0f703918fa0ecd55f035d269759ee3c6ddbc2', 'application/octet-stream', 'images/public/u_2/27481da7-44cf-44d3-b1cb-d2025a2e8b20.jpg', '61989', '2013-06-06 13:43:40', '51', '0');
INSERT INTO `photo` VALUES ('197', '8326cffc1e178a82098718f0f603738da977e823', 'application/octet-stream', 'images/public/u_2/6516161a-ac70-4da3-ae72-b90d611366fe.jpg', '24513', '2013-06-06 13:43:40', '51', '0');
INSERT INTO `photo` VALUES ('198', '风景', '83025aafa40f4bfb7a0dda0d034f78f0f636188d', 'images/public/u_2/ececf431-c7aa-4184-ac40-7fbcb2f43da7.jpg', '316218', '2013-06-06 13:43:40', '51', '0');
INSERT INTO `photo` VALUES ('199', '2', 'application/octet-stream', 'images/public/u_2/da83f007-26b1-4d5c-8e1a-6b7746ba368a.jpg', '141553', '2013-06-06 13:44:28', '52', '0');
INSERT INTO `photo` VALUES ('200', '0b55b319ebc4b745f788cba7cffc1e178a821566', 'application/octet-stream', 'images/public/u_2/0e0409ea-18e8-4e54-8b04-c8d5061e3a63.jpg', '386448', '2013-06-06 13:44:28', '52', '0');
INSERT INTO `photo` VALUES ('201', '2e2eb9389b504fc2c194f45ce5dde71191ef6d9b', 'application/octet-stream', 'images/public/u_2/d58ec1ba-d21a-4bbf-a0e5-1f9be630fcae.jpg', '90464', '2013-06-06 13:44:28', '52', '0');
INSERT INTO `photo` VALUES ('202', '3bf33a87e950352ac4dc4d475343fbf2b2118b3b', 'application/octet-stream', 'images/public/u_2/a38ac749-eb4a-44e1-aa79-c03859e8e6c5.jpg', '267352', '2013-06-06 13:44:28', '52', '0');
INSERT INTO `photo` VALUES ('203', '4', 'application/octet-stream', 'images/public/u_2/1149a1b5-5501-4e8e-a6fe-e42d1e920b7b.jpg', '56732', '2013-06-06 13:44:28', '52', '0');
INSERT INTO `photo` VALUES ('204', '37d3d539b6003af3f0c07b2f352ac65c1038b603', 'application/octet-stream', 'images/public/u_2/32f4f0fb-e47c-4ea4-9a74-d6dec99b1405.jpg', '112297', '2013-06-06 13:44:28', '52', '0');
INSERT INTO `photo` VALUES ('205', '4', 'application/octet-stream', 'images/public/u_2/43fc2cea-222a-4038-b00f-de7e30a2199f.jpg', '56732', '2013-06-06 13:44:57', '53', '0');
INSERT INTO `photo` VALUES ('206', '行吟纪Vol.1：升起的地平线-13760', 'application/octet-stream', 'images/public/u_2/a4901c3a-8425-4e0f-bcb1-3c27656c9391.jpg', '47784', '2013-06-06 13:44:57', '53', '0');
INSERT INTO `photo` VALUES ('207', '行吟纪Vol.1：升起的地平线-13763', 'application/octet-stream', 'images/public/u_2/81ed13f0-7ff7-4001-8b49-e7f59933247a.jpg', '62323', '2013-06-06 13:44:57', '53', '0');
INSERT INTO `photo` VALUES ('208', '行吟纪Vol.1：升起的地平线-13765', 'application/octet-stream', 'images/public/u_2/37e72cfc-89ae-45f0-a7b4-39529f4cfda5.jpg', '51041', '2013-06-06 13:44:57', '53', '0');
INSERT INTO `photo` VALUES ('209', '2', 'application/octet-stream', 'images/public/u_2/c0a64c6d-650f-415e-b7f0-ee2701e11d33.jpg', '141553', '2013-06-06 13:45:30', '54', '0');
INSERT INTO `photo` VALUES ('210', '0b55b319ebc4b745f788cba7cffc1e178a821566', 'application/octet-stream', 'images/public/u_2/37332630-e639-4e7d-b5e6-a716e6564b5d.jpg', '386448', '2013-06-06 13:45:30', '54', '0');
INSERT INTO `photo` VALUES ('211', '2e2eb9389b504fc2c194f45ce5dde71191ef6d9b', 'application/octet-stream', 'images/public/u_2/c36add54-f745-47be-a961-9858f66f93b5.jpg', '90464', '2013-06-06 13:45:30', '54', '0');
INSERT INTO `photo` VALUES ('212', '3bf33a87e950352ac4dc4d475343fbf2b2118b3b', 'application/octet-stream', 'images/public/u_2/2bd68df6-0f1f-4785-8e91-0fff56f3d965.jpg', '267352', '2013-06-06 13:45:31', '54', '0');
INSERT INTO `photo` VALUES ('213', '2', 'application/octet-stream', 'images/public/u_2/176a1f5c-7f63-430f-aafc-f8bb079895f2.jpg', '141553', '2013-06-06 13:46:21', '55', '0');
INSERT INTO `photo` VALUES ('214', '复件(20121008 10351420) 震撼：迷失在城市夜灯下的天使-499', 'application/octet-stream', 'images/public/u_2/58e7907d-c603-4024-bbbb-39bfb9083846.jpg', '281358', '2013-06-06 13:47:23', '56', '0');
INSERT INTO `photo` VALUES ('215', '复件(20121008 10351347) 震撼：迷失在城市夜灯下的天使-498', 'application/octet-stream', 'images/public/u_2/d6556472-dabb-4f84-aa75-13c4cb2c713e.jpg', '529879', '2013-06-06 13:47:23', '56', '0');
INSERT INTO `photo` VALUES ('216', '复件(20121008 103512485) 震撼：迷失在城市夜灯下的天使-498', 'application/octet-stream', 'images/public/u_2/74aea45e-6213-4557-b08e-e283c85806a5.jpg', '613248', '2013-06-06 13:47:23', '56', '0');
INSERT INTO `photo` VALUES ('217', '复件(20121008 103514643) 震撼：迷失在城市夜灯下的天使-499', 'application/octet-stream', 'images/public/u_2/fe09dab5-6feb-4045-97d5-f46b995f4f3d.jpg', '644649', '2013-06-06 13:47:23', '56', '0');
INSERT INTO `photo` VALUES ('218', '复件(20121008 103514829) 震撼：迷失在城市夜灯下的天使-499', 'application/octet-stream', 'images/public/u_2/dd4d7365-5c53-4ce2-89ca-e89823e5dbad.jpg', '639193', '2013-06-06 13:47:23', '56', '0');
INSERT INTO `photo` VALUES ('219', '复件(20121008 103515587) 震撼：迷失在城市夜灯下的天使-499', 'application/octet-stream', 'images/public/u_2/df4e1da4-2833-4a7a-8bc8-21063452b228.jpg', '700365', '2013-06-06 13:47:23', '56', '0');
INSERT INTO `photo` VALUES ('220', '复件(20121008 103516803) 震撼：迷失在城市夜灯下的天使-500', 'application/octet-stream', 'images/public/u_2/0358e7f2-51e5-4fd0-9c54-aa97c2d2ca59.jpg', '364906', '2013-06-06 13:47:23', '56', '0');
INSERT INTO `photo` VALUES ('221', '震撼：迷失在城市夜灯下的天使-499 (1)', 'application/octet-stream', 'images/public/u_2/86497523-eb1a-48d2-a32a-e81453af160a.jpg', '654425', '2013-06-06 13:47:23', '56', '0');
INSERT INTO `photo` VALUES ('222', '震撼：迷失在城市夜灯下的天使-499', 'application/octet-stream', 'images/public/u_2/b17e51cf-85ea-4afe-bfe7-f8d9b8677825.jpg', '654425', '2013-06-06 13:47:23', '56', '0');
INSERT INTO `photo` VALUES ('226', '2013-05-25 160852', 'application/octet-stream', 'images/public/u_2/296f19da-c997-4057-8eb4-2004da8a0cc2.jpg', '634523', '2013-06-06 13:53:03', '58', '0');
INSERT INTO `photo` VALUES ('227', '2013-05-25 161029', 'application/octet-stream', 'images/public/u_2/357ae56c-28f0-4b3f-a96d-df35e5880c1a.jpg', '757699', '2013-06-06 13:53:03', '58', '0');
INSERT INTO `photo` VALUES ('228', '2', 'application/octet-stream', 'images/public/u_1/e38369c4-7efb-4a5b-97f8-3454cd5cbbd0.jpg', '141553', '2013-06-06 13:54:07', '59', '0');
INSERT INTO `photo` VALUES ('229', '0b55b319ebc4b745f788cba7cffc1e178a821566', 'application/octet-stream', 'images/public/u_1/34473747-abbd-4111-b3d9-ca0ca3aabb25.jpg', '386448', '2013-06-06 13:54:07', '59', '0');
INSERT INTO `photo` VALUES ('230', '2e2eb9389b504fc2c194f45ce5dde71191ef6d9b', 'application/octet-stream', 'images/public/u_1/9c295513-06dd-46a3-a58b-e0ee0d2aaf63.jpg', '90464', '2013-06-06 13:54:07', '59', '0');
INSERT INTO `photo` VALUES ('231', '3bf33a87e950352ac4dc4d475343fbf2b2118b3b', 'application/octet-stream', 'images/public/u_1/6561ec5b-037f-414f-a19b-fc3794661b77.jpg', '267352', '2013-06-06 13:54:07', '59', '0');
INSERT INTO `photo` VALUES ('232', '0b55b319ebc4b745f788cba7cffc1e178a821566', 'application/octet-stream', 'images/public/u_1/03d549e0-b2f2-47b9-8879-468f133ebdb2.jpg', '386448', '2013-06-06 13:54:34', '60', '0');
INSERT INTO `photo` VALUES ('233', '2', 'application/octet-stream', 'images/public/u_1/815902a9-b6a0-476d-a655-b8b60a3277ac.jpg', '141553', '2013-06-06 13:54:35', '60', '0');
INSERT INTO `photo` VALUES ('234', '2e2eb9389b504fc2c194f45ce5dde71191ef6d9b', 'application/octet-stream', 'images/public/u_1/19aab341-7891-4487-868e-353e2e86bc8c.jpg', '90464', '2013-06-06 13:54:35', '60', '0');
INSERT INTO `photo` VALUES ('235', '3bf33a87e950352ac4dc4d475343fbf2b2118b3b', 'application/octet-stream', 'images/public/u_1/ea2453de-0d6f-403b-8bd8-818282e1cd26.jpg', '267352', '2013-06-06 13:54:35', '60', '0');
INSERT INTO `photo` VALUES ('236', 'DON`T EAT BUILDINGS', 'application/octet-stream', 'images/public/u_1/2a8e0039-ee8a-434a-9742-91bdd159e1f0.jpg', '359584', '2013-06-06 14:01:02', '61', '0');
INSERT INTO `photo` VALUES ('237', 'd8f9d72a6059252d19faacb6349b033b5ab5b997', 'application/octet-stream', 'images/public/u_1/bb368947-9d32-413a-93fb-64b2c3bff61f.jpg', '424236', '2013-06-06 14:01:02', '61', '0');
INSERT INTO `photo` VALUES ('238', 'Blue hills', 'application/octet-stream', 'images/public/u_2/8469254b-1536-4dc2-b449-e9b56aa876ae.jpg', '28521', '2013-06-06 14:32:53', '63', '0');
INSERT INTO `photo` VALUES ('239', 'Winter', 'application/octet-stream', 'images/public/u_2/27506bb6-214a-4ff3-81ae-6d26b241e553.jpg', '105542', '2013-06-06 14:32:53', '63', '0');
INSERT INTO `photo` VALUES ('240', 'Sunset', 'application/octet-stream', 'images/public/u_2/c1b8ac50-0531-456f-bce1-393627b2f485.jpg', '71189', '2013-06-06 14:32:53', '63', '0');
INSERT INTO `photo` VALUES ('241', 'Water lilies', 'application/octet-stream', 'images/public/u_2/226afb34-79e0-48d1-9151-e3c6bda0453b.jpg', '83794', '2013-06-06 14:32:53', '63', '0');
INSERT INTO `photo_has_tag` VALUES ('121', '1');
INSERT INTO `photo_has_tag` VALUES ('196', '1');
INSERT INTO `photo_has_tag` VALUES ('213', '1');
INSERT INTO `photo_has_tag` VALUES ('227', '1');
INSERT INTO `photo_has_tag` VALUES ('36', '2');
INSERT INTO `photo_has_tag` VALUES ('36', '3');
INSERT INTO `photo_has_tag` VALUES ('37', '3');
INSERT INTO `photo_has_tag` VALUES ('198', '3');
INSERT INTO `photo_has_tag` VALUES ('36', '4');
INSERT INTO `photo_has_tag` VALUES ('39', '5');
INSERT INTO `photo_has_tag` VALUES ('37', '6');
INSERT INTO `photo_has_tag` VALUES ('38', '7');
INSERT INTO `photo_has_tag` VALUES ('40', '8');
INSERT INTO `photo_has_tag` VALUES ('40', '9');
INSERT INTO `photo_has_tag` VALUES ('40', '10');
INSERT INTO `photo_has_tag` VALUES ('41', '11');
INSERT INTO `photo_has_tag` VALUES ('119', '11');
INSERT INTO `photo_has_tag` VALUES ('182', '11');
INSERT INTO `photo_has_tag` VALUES ('183', '11');
INSERT INTO `photo_has_tag` VALUES ('184', '11');
INSERT INTO `photo_has_tag` VALUES ('42', '12');
INSERT INTO `photo_has_tag` VALUES ('43', '13');
INSERT INTO `photo_has_tag` VALUES ('40', '14');
INSERT INTO `photo_has_tag` VALUES ('41', '15');
INSERT INTO `photo_has_tag` VALUES ('42', '16');
INSERT INTO `photo_has_tag` VALUES ('43', '17');
INSERT INTO `photo_has_tag` VALUES ('44', '18');
INSERT INTO `photo_has_tag` VALUES ('118', '19');
INSERT INTO `photo_has_tag` VALUES ('118', '20');
INSERT INTO `photo_has_tag` VALUES ('119', '20');
INSERT INTO `photo_has_tag` VALUES ('55', '21');
INSERT INTO `photo_has_tag` VALUES ('155', '22');
INSERT INTO `photo_has_tag` VALUES ('161', '23');
INSERT INTO `photo_has_tag` VALUES ('213', '23');
INSERT INTO `photo_has_tag` VALUES ('184', '25');
INSERT INTO `photo_has_tag` VALUES ('185', '26');
INSERT INTO `photo_has_tag` VALUES ('106', '27');
INSERT INTO `photo_has_tag` VALUES ('107', '27');
INSERT INTO `photo_has_tag` VALUES ('106', '28');
INSERT INTO `photo_has_tag` VALUES ('120', '29');
INSERT INTO `photo_has_tag` VALUES ('122', '29');
INSERT INTO `photo_has_tag` VALUES ('123', '29');
INSERT INTO `photo_has_tag` VALUES ('213', '29');
INSERT INTO `photo_has_tag` VALUES ('222', '30');
INSERT INTO `photo_has_tag` VALUES ('217', '31');
INSERT INTO `photo_has_tag` VALUES ('219', '31');
INSERT INTO `photo_has_tag` VALUES ('220', '31');
INSERT INTO `photo_has_tag` VALUES ('222', '31');
INSERT INTO `photo_has_tag` VALUES ('218', '32');
INSERT INTO `photo_has_tag` VALUES ('197', '33');
INSERT INTO `photo_has_tag` VALUES ('208', '34');
INSERT INTO `photo_has_tag` VALUES ('207', '35');
INSERT INTO `photo_has_tag` VALUES ('207', '36');
INSERT INTO `photo_has_tag` VALUES ('193', '37');
INSERT INTO `role` VALUES ('1', 'admin');
INSERT INTO `role` VALUES ('2', 'normal');
INSERT INTO `tag` VALUES ('12', 'Beautiful');
INSERT INTO `tag` VALUES ('17', 'Can you hear me?');
INSERT INTO `tag` VALUES ('32', 'city');
INSERT INTO `tag` VALUES ('1', 'hello');
INSERT INTO `tag` VALUES ('2', 'helloa');
INSERT INTO `tag` VALUES ('18', 'helo');
INSERT INTO `tag` VALUES ('25', 'Hi');
INSERT INTO `tag` VALUES ('5', 'QQ');
INSERT INTO `tag` VALUES ('37', 'tag1');
INSERT INTO `tag` VALUES ('23', 'test');
INSERT INTO `tag` VALUES ('21', '霸天');
INSERT INTO `tag` VALUES ('22', '不错啊');
INSERT INTO `tag` VALUES ('30', '不错不错');
INSERT INTO `tag` VALUES ('31', '城市');
INSERT INTO `tag` VALUES ('27', '地平线');
INSERT INTO `tag` VALUES ('35', '地平线风景');
INSERT INTO `tag` VALUES ('4', '冬天');
INSERT INTO `tag` VALUES ('26', '独留那篇风景');
INSERT INTO `tag` VALUES ('3', '风景');
INSERT INTO `tag` VALUES ('36', '高山');
INSERT INTO `tag` VALUES ('20', '公路');
INSERT INTO `tag` VALUES ('6', '海');
INSERT INTO `tag` VALUES ('10', '呵呵');
INSERT INTO `tag` VALUES ('34', '黄昏地平线');
INSERT INTO `tag` VALUES ('14', '极地风光');
INSERT INTO `tag` VALUES ('9', '开心');
INSERT INTO `tag` VALUES ('15', '靠经大自然');
INSERT INTO `tag` VALUES ('33', '旅行');
INSERT INTO `tag` VALUES ('8', '旅游');
INSERT INTO `tag` VALUES ('24', '迷失在城市夜灯下的天使');
INSERT INTO `tag` VALUES ('19', '汽车');
INSERT INTO `tag` VALUES ('28', '山顶风光');
INSERT INTO `tag` VALUES ('7', '夏天');
INSERT INTO `tag` VALUES ('13', '笑一个');
INSERT INTO `tag` VALUES ('16', '一个人去旅游');
INSERT INTO `tag` VALUES ('29', '永远的唐布拉');
INSERT INTO `tag` VALUES ('11', '走走看看');
INSERT INTO `user` VALUES ('1', 'je1024065', '111111', '10300240065@fudan.edu.cn', '1', '2013-05-22 17:38:07', '2013-06-06 13:53:44', '1', 'images/public/u_1/picture.jpg');
INSERT INTO `user` VALUES ('2', 'Raysmond', '111111', 'jiankunlei@126.com', '1', '1970-01-01 00:00:00', '2013-06-06 18:09:53', '1', 'images/public/u_2/picture1370497959993684.jpg');
INSERT INTO `user` VALUES ('3', '10300240065', '12345678', 'jiankunlei@gmail.com', '1', '2013-05-23 00:00:00', '1970-01-01 00:00:00', '2', 'images/default_picture.jpg');
INSERT INTO `user` VALUES ('8', 'Jiankun Lei', '111111', 'jiankunlei@sina.com', '1', '2013-05-30 00:00:00', '2013-05-30 17:33:38', '1', 'images/default_picture.jpg');
INSERT INTO `user` VALUES ('9', '张三', '111111', 'zhangsan@fudan.edu.cn', '1', '2013-05-30 17:57:01', '2013-05-30 17:58:32', '1', 'images/public/u_9/picture13699079351173241.jpg');
