-- 创建数据库
CREATE DATABASE IF NOT EXISTS flyticket DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE flyticket;

-- 管理员表
CREATE TABLE IF NOT EXISTS `admin` (
  `admin_id` varchar(32) NOT NULL COMMENT '管理员ID',
  `admin_name` varchar(50) NOT NULL COMMENT '管理员姓名',
  `admin_pwd` varchar(50) NOT NULL COMMENT '管理员密码',
  `admin_email` varchar(50) DEFAULT NULL COMMENT '管理员邮箱',
  `admin_phone` varchar(20) DEFAULT NULL COMMENT '管理员电话',
  PRIMARY KEY (`admin_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='管理员信息表';

-- 航班信息表
CREATE TABLE IF NOT EXISTS `flight` (
  `flight_id` varchar(32) NOT NULL COMMENT '航班ID',
  `flight_number` varchar(20) NOT NULL COMMENT '航班号',
  `flight_start_place` varchar(50) NOT NULL COMMENT '出发城市',
  `flight_end_place` varchar(50) NOT NULL COMMENT '到达城市',
  `flight_start_airport` varchar(50) NOT NULL COMMENT '出发机场',
  `flight_end_airport` varchar(50) NOT NULL COMMENT '到达机场',
  `flight_start_time` datetime NOT NULL COMMENT '出发时间',
  `flight_end_time` datetime NOT NULL COMMENT '到达时间',
  `flight_high_price` decimal(10,2) DEFAULT NULL COMMENT '头等舱价格',
  `flight_middle_price` decimal(10,2) DEFAULT NULL COMMENT '商务舱价格',
  `flight_base_price` decimal(10,2) DEFAULT NULL COMMENT '经济舱价格',
  `flight_high_number` int(11) DEFAULT '0' COMMENT '头等舱座位数',
  `flight_middle_number` int(11) DEFAULT '0' COMMENT '商务舱座位数',
  `flight_base_number` int(11) DEFAULT '0' COMMENT '经济舱座位数',
  `flight_type` varchar(20) DEFAULT NULL COMMENT '航班类型',
  PRIMARY KEY (`flight_id`),
  UNIQUE KEY `uk_flight_number` (`flight_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='航班信息表';

-- 用户表
CREATE TABLE IF NOT EXISTS `user` (
  `user_id` varchar(32) NOT NULL COMMENT '用户ID',
  `user_name` varchar(50) NOT NULL COMMENT '用户名',
  `user_pwd` varchar(50) NOT NULL COMMENT '用户密码',
  `user_email` varchar(50) DEFAULT NULL COMMENT '用户邮箱',
  `user_phone` varchar(20) DEFAULT NULL COMMENT '用户电话',
  `user_sex` varchar(5) DEFAULT NULL COMMENT '用户性别',
  `user_age` int(11) DEFAULT NULL COMMENT '用户年龄',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `uk_user_name` (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户信息表';

-- 订单表
CREATE TABLE IF NOT EXISTS `order` (
  `order_id` varchar(32) NOT NULL COMMENT '订单ID',
  `order_number` varchar(50) DEFAULT NULL COMMENT '订单号',
  `user_id` varchar(32) DEFAULT NULL COMMENT '用户ID',
  `user_name` varchar(50) DEFAULT NULL COMMENT '用户姓名',
  `flight_id` varchar(32) DEFAULT NULL COMMENT '航班ID',
  `flight_number` varchar(20) DEFAULT NULL COMMENT '航班号',
  `passenger_name` varchar(50) DEFAULT NULL COMMENT '乘客姓名',
  `passenger_id` varchar(20) DEFAULT NULL COMMENT '乘客身份证',
  `contact_name` varchar(50) DEFAULT NULL COMMENT '联系人姓名',
  `contact_phone` varchar(20) DEFAULT NULL COMMENT '联系人电话',
  `grade` varchar(1) DEFAULT NULL COMMENT '舱位等级',
  `price` decimal(10,2) DEFAULT NULL COMMENT '价格',
  `order_date` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '订单日期',
  `order_status` int(11) DEFAULT '0' COMMENT '订单状态（0-待支付，1-已支付，2-已取消）',
  PRIMARY KEY (`order_id`),
  UNIQUE KEY `uk_order_number` (`order_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='订单信息表';

-- 留言评论表
CREATE TABLE IF NOT EXISTS `discuss` (
  `discuss_id` varchar(32) NOT NULL COMMENT '评论ID',
  `user_id` varchar(32) DEFAULT NULL COMMENT '用户ID',
  `user_name` varchar(50) DEFAULT NULL COMMENT '用户名',
  `discuss_content` text COMMENT '评论内容',
  `discuss_date` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '评论日期',
  PRIMARY KEY (`discuss_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='留言评论表';

-- 广告信息表
CREATE TABLE IF NOT EXISTS `content` (
  `content_id` varchar(32) NOT NULL COMMENT '广告ID',
  `describe` varchar(200) DEFAULT NULL COMMENT '广告描述',
  `picture` varchar(200) DEFAULT NULL COMMENT '广告图片',
  `url` varchar(200) DEFAULT NULL COMMENT '广告链接',
  PRIMARY KEY (`content_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='广告信息表';

-- 插入测试数据

-- 插入管理员数据
INSERT INTO `admin` (`admin_id`, `admin_name`, `admin_pwd`, `admin_email`, `admin_phone`) VALUES
('admin001', 'admin', '123456', 'admin@flyticket.com', '13800138000');

-- 插入航班数据
INSERT INTO `flight` (`flight_id`, `flight_number`, `flight_start_place`, `flight_end_place`, `flight_start_airport`, `flight_end_airport`, `flight_start_time`, `flight_end_time`, `flight_high_price`, `flight_middle_price`, `flight_base_price`, `flight_high_number`, `flight_middle_number`, `flight_base_number`, `flight_type`) VALUES
('F20241225001', 'CA1234', '北京', '上海', '首都国际机场', '浦东国际机场', '2025-01-15 08:00:00', '2025-01-15 10:30:00', 2500.00, 1500.00, 800.00, 10, 20, 150, '国内航班'),
('F20241225002', 'MU5678', '上海', '北京', '浦东国际机场', '首都国际机场', '2025-01-15 14:00:00', '2025-01-15 16:30:00', 2500.00, 1500.00, 800.00, 10, 20, 150, '国内航班'),
('F20241225003', 'CZ3456', '广州', '深圳', '白云国际机场', '宝安国际机场', '2025-01-16 09:00:00', '2025-01-16 10:00:00', 1200.00, 800.00, 500.00, 8, 15, 120, '国内航班'),
('F20241225004', 'HU7890', '深圳', '广州', '宝安国际机场', '白云国际机场', '2025-01-16 15:00:00', '2025-01-16 16:00:00', 1200.00, 800.00, 500.00, 8, 15, 120, '国内航班'),
('F20241225005', 'CA9876', '北京', '成都', '首都国际机场', '双流国际机场', '2025-01-17 07:30:00', '2025-01-17 11:00:00', 3000.00, 2000.00, 1200.00, 12, 25, 180, '国内航班');

-- 插入用户数据
INSERT INTO `user` (`user_id`, `user_name`, `user_pwd`, `user_email`, `user_phone`, `user_sex`, `user_age`) VALUES
('user001', 'zhangsan', '123456', 'zhangsan@example.com', '13900139001', '男', 28),
('user002', 'lisi', '123456', 'lisi@example.com', '13900139002', '女', 25),
('user003', 'wangwu', '123456', 'wangwu@example.com', '13900139003', '男', 30);

-- 插入广告数据
INSERT INTO `content` (`content_id`, `describe`, `picture`, `url`) VALUES
('content001', '春节特惠机票', '/images/ad1.jpg', '#'),
('content002', '会员专享折扣', '/images/ad2.jpg', '#'),
('content003', '新航线开通', '/images/ad3.jpg', '#');
