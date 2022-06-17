-- phpMyAdmin SQL Dump
-- version phpStudy 2014
-- http://www.phpmyadmin.net
--
-- 主机: localhost
-- 生成日期: 2020 年 06 月 23 日 07:39
-- 服务器版本: 5.5.53
-- PHP 版本: 5.4.45

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- 数据库: `blog`
--

-- --------------------------------------------------------

--
-- 表的结构 `b_admin`
--

CREATE TABLE IF NOT EXISTS `b_admin` (
  `admin_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `password` varchar(255) NOT NULL,
  `login_time` int(11) NOT NULL DEFAULT '0',
  `addtime` int(11) DEFAULT '0',
  `login_ip` varchar(255) DEFAULT NULL,
  `status` tinyint(3) NOT NULL DEFAULT '1',
  PRIMARY KEY (`admin_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='管理员' AUTO_INCREMENT=2 ;

--
-- 转存表中的数据 `b_admin`
--

INSERT INTO `b_admin` (`admin_id`, `name`, `password`, `login_time`, `addtime`, `login_ip`, `status`) VALUES
(1, 'siro', '56e61ac7c7a52777e4c0b07c82059cd7', 1592894334, 0, '[::1]:62646', 1);

-- --------------------------------------------------------

--
-- 表的结构 `b_log`
--

CREATE TABLE IF NOT EXISTS `b_log` (
  `log_id` int(11) NOT NULL AUTO_INCREMENT,
  `tag_id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `content` text NOT NULL,
  `click` int(11) NOT NULL DEFAULT '0',
  `addtime` int(11) NOT NULL,
  `status` tinyint(3) NOT NULL DEFAULT '1',
  PRIMARY KEY (`log_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='日志' AUTO_INCREMENT=59 ;

--
-- 转存表中的数据 `b_log`
--

INSERT INTO `b_log` (`log_id`, `tag_id`, `title`, `content`, `click`, `addtime`, `status`) VALUES
(56, 9, 'hello', '<h1 style="font-size: 32px; font-weight: bold; border-bottom: 2px solid rgb(204, 204, 204); padding: 0px 4px 0px 0px; text-align: center; margin: 0px 0px 20px;">world</h1><ol class=" list-paddingleft-2" style="list-style-type: decimal;"><li><p>world</p></li><li><p>world</p></li><li><p>world</p></li><li><p>world</p></li><li><p>world</p></li><li><p>world</p></li><li><p>world</p></li><li><p>world</p></li><li><p>world</p></li><li><p>world</p></li><li><p>world</p></li><li><p>world</p></li><li><p style="text-align: center;">world</p><p style="text-align: center;">world<br/></p></li></ol>', 0, 1592811363, 1),
(57, 9, 'work', '<h1 style="font-size: 32px; font-weight: bold; border-bottom: 2px solid rgb(204, 204, 204); padding: 0px 4px 0px 0px; text-align: center; margin: 0px 0px 20px;">test</h1><ul class=" list-paddingleft-2" style="list-style-type: disc;"><li><p>test</p></li><li><p>test</p></li><li><p>test</p></li></ul><p><br/></p><p><br/></p><p><br/></p><p><br/></p><p><br/></p><p style="text-align: center;">test<br/></p><p style="text-align: center;"><strong><span style="color: rgb(255, 0, 0);">test</span></strong></p>', 0, 1592811441, 1),
(58, 9, 'test', '<h1 style="font-size: 32px; font-weight: bold; border-bottom: 2px solid rgb(204, 204, 204); padding: 0px 4px 0px 0px; text-align: center; margin: 0px 0px 20px;">world</h1><ol class=" list-paddingleft-2" style="list-style-type: decimal;"><li><p>world</p></li><li><p>world</p></li><li><p>world</p></li><li><p>world</p></li><li><p>world</p></li><li><p>world</p></li><li><p>world</p></li><li><p>world</p></li><li><p>world</p></li><li><p>world</p></li><li><p>world</p></li><li><p>world</p></li></ol><p style="text-align: center;"><br/></p><p><br/></p><p style="text-align: center;">world<br/></p>', 27, 1592811363, 1);

-- --------------------------------------------------------

--
-- 表的结构 `b_member`
--

CREATE TABLE IF NOT EXISTS `b_member` (
  `member_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `addtime` int(11) DEFAULT NULL,
  `status` tinyint(3) NOT NULL DEFAULT '1',
  PRIMARY KEY (`member_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=12 ;

--
-- 转存表中的数据 `b_member`
--

INSERT INTO `b_member` (`member_id`, `name`, `photo`, `addtime`, `status`) VALUES
(2, 'zero', NULL, 1564456492, 1),
(3, 'zero', NULL, 1564456569, 1),
(4, '2233', NULL, NULL, 1),
(5, '4', NULL, NULL, 1),
(6, 'test', NULL, NULL, 1),
(7, 'add', NULL, 1564544369, 1),
(8, '123', NULL, 1564557884, 1),
(9, '', NULL, 1564564452, 1),
(10, 'zero', NULL, 1564973578, 1),
(11, '123', NULL, 1564973700, 1);

-- --------------------------------------------------------

--
-- 表的结构 `b_remark`
--

CREATE TABLE IF NOT EXISTS `b_remark` (
  `remark_id` int(11) NOT NULL AUTO_INCREMENT,
  `log_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `content` text NOT NULL,
  `addtime` int(11) NOT NULL,
  `status` tinyint(3) NOT NULL DEFAULT '1' COMMENT '1未读2已读',
  PRIMARY KEY (`remark_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='评论' AUTO_INCREMENT=21 ;

--
-- 转存表中的数据 `b_remark`
--

INSERT INTO `b_remark` (`remark_id`, `log_id`, `name`, `email`, `content`, `addtime`, `status`) VALUES
(16, 58, 'test', '970979353@qq.com', 'hi[em_1]', 1592819168, 2),
(17, 58, 'test', '970979353@qq.com', 'hi[em_1][em_17]', 1592819237, 2),
(18, 58, 'test', '970979353@qq.com', 'hi[em_1][em_17][em_6]', 1592819262, 2),
(19, 58, 'test', '970979353@qq.com', 'hi[em_1][em_17][em_6][em_24]', 1592819272, 2),
(20, 58, 'test', '970979353@qq.com', 'test[em_2]', 1592819655, 1);

-- --------------------------------------------------------

--
-- 表的结构 `b_system`
--

CREATE TABLE IF NOT EXISTS `b_system` (
  `system_id` int(11) NOT NULL AUTO_INCREMENT,
  `headimg` varchar(255) NOT NULL,
  `name` varchar(20) NOT NULL,
  `tip` varchar(20) NOT NULL,
  `git` varchar(255) NOT NULL,
  `sina` varchar(255) NOT NULL,
  `qq` varchar(255) NOT NULL,
  `banner` varchar(255) NOT NULL,
  `theme` tinyint(3) NOT NULL DEFAULT '1' COMMENT '主题1默认2简约3少年4少女',
  `copyright` varchar(100) NOT NULL,
  `logo` tinyint(3) NOT NULL DEFAULT '1' COMMENT 'logo',
  PRIMARY KEY (`system_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='系统' AUTO_INCREMENT=2 ;

--
-- 转存表中的数据 `b_system`
--

INSERT INTO `b_system` (`system_id`, `headimg`, `name`, `tip`, `git`, `sina`, `qq`, `banner`, `theme`, `copyright`, `logo`) VALUES
(1, 'static/upload/2020/06/23/eb889a23174ad1b9844d92fc4714420d.jpg', 'Siro@Room', '言为心声，字为心画', 'https://github.com/a279623002/', 'https://weibo.com/u/2284299321', '970979353@qq.com', 'static/upload/2020/06/23/364f72912044775fac600307f8616706.jpg', 1, 'copyright: Siro 电话：18819445610', 2);

-- --------------------------------------------------------

--
-- 表的结构 `b_tag`
--

CREATE TABLE IF NOT EXISTS `b_tag` (
  `tag_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `addtime` int(11) DEFAULT NULL,
  `status` tinyint(3) NOT NULL DEFAULT '1',
  PRIMARY KEY (`tag_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='标签' AUTO_INCREMENT=11 ;

--
-- 转存表中的数据 `b_tag`
--

INSERT INTO `b_tag` (`tag_id`, `name`, `addtime`, `status`) VALUES
(4, 'laravel', 1566874663, 1),
(5, '文档资源', 1566875774, 1),
(6, 'php', 1566979770, 1),
(9, 'Go', 1567666160, 1),
(10, 'MYSQL', 1588149281, 1);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
