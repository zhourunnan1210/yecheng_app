/*
 Navicat Premium Data Transfer

 Source Server         : yecheng_app
 Source Server Type    : MySQL
 Source Server Version : 80026
 Source Host           : localhost:3306
 Source Schema         : yecheng_app

 Target Server Type    : MySQL
 Target Server Version : 80026
 File Encoding         : 65001

 Date: 09/06/2022 14:22:40
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for QRTZ_BLOB_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_BLOB_TRIGGERS`;
CREATE TABLE `QRTZ_BLOB_TRIGGERS`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `blob_data` blob NULL COMMENT '存放持久化Trigger对象',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `QRTZ_BLOB_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `QRTZ_TRIGGERS` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'Blob类型的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_BLOB_TRIGGERS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_CALENDARS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_CALENDARS`;
CREATE TABLE `QRTZ_CALENDARS`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调度名称',
  `calendar_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '日历名称',
  `calendar` blob NOT NULL COMMENT '存放持久化calendar对象',
  PRIMARY KEY (`sched_name`, `calendar_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '日历信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_CALENDARS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_CRON_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_CRON_TRIGGERS`;
CREATE TABLE `QRTZ_CRON_TRIGGERS`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `cron_expression` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'cron表达式',
  `time_zone_id` varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '时区',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `QRTZ_CRON_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `QRTZ_TRIGGERS` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'Cron类型的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_CRON_TRIGGERS
-- ----------------------------
INSERT INTO `QRTZ_CRON_TRIGGERS` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME1', 'DEFAULT', '0/10 * * * * ?', 'Asia/Shanghai');
INSERT INTO `QRTZ_CRON_TRIGGERS` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME2', 'DEFAULT', '0/15 * * * * ?', 'Asia/Shanghai');
INSERT INTO `QRTZ_CRON_TRIGGERS` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME3', 'DEFAULT', '0/20 * * * * ?', 'Asia/Shanghai');

-- ----------------------------
-- Table structure for QRTZ_FIRED_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_FIRED_TRIGGERS`;
CREATE TABLE `QRTZ_FIRED_TRIGGERS`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调度名称',
  `entry_id` varchar(95) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调度器实例id',
  `trigger_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `instance_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调度器实例名',
  `fired_time` bigint NOT NULL COMMENT '触发的时间',
  `sched_time` bigint NOT NULL COMMENT '定时器制定的时间',
  `priority` int NOT NULL COMMENT '优先级',
  `state` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '状态',
  `job_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '任务名称',
  `job_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '任务组名',
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否并发',
  `requests_recovery` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否接受恢复执行',
  PRIMARY KEY (`sched_name`, `entry_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '已触发的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_FIRED_TRIGGERS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_JOB_DETAILS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_JOB_DETAILS`;
CREATE TABLE `QRTZ_JOB_DETAILS`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调度名称',
  `job_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '任务组名',
  `description` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '相关介绍',
  `job_class_name` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '执行任务类名称',
  `is_durable` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '是否持久化',
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '是否并发',
  `is_update_data` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '是否更新数据',
  `requests_recovery` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '是否接受恢复执行',
  `job_data` blob NULL COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '任务详细信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_JOB_DETAILS
-- ----------------------------
INSERT INTO `QRTZ_JOB_DETAILS` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME1', 'DEFAULT', NULL, 'com.ruoyi.quartz.util.QuartzDisallowConcurrentExecution', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F504552544945537372001E636F6D2E72756F79692E71756172747A2E646F6D61696E2E5379734A6F6200000000000000010200084C000A636F6E63757272656E747400124C6A6176612F6C616E672F537472696E673B4C000E63726F6E45787072657373696F6E71007E00094C000C696E766F6B6554617267657471007E00094C00086A6F6247726F757071007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B4C00076A6F624E616D6571007E00094C000D6D697366697265506F6C69637971007E00094C000673746174757371007E000978720027636F6D2E72756F79692E636F6D6D6F6E2E636F72652E646F6D61696E2E42617365456E7469747900000000000000010200074C0008637265617465427971007E00094C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C0006706172616D7371007E00034C000672656D61726B71007E00094C000B73656172636856616C756571007E00094C0008757064617465427971007E00094C000A75706461746554696D6571007E000C787074000561646D696E7372000E6A6176612E7574696C2E44617465686A81014B597419030000787077080000017C0B1253F878707400007070707400013174000E302F3130202A202A202A202A203F74001172795461736B2E72794E6F506172616D7374000744454641554C547372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B02000078700000000000000001740018E7B3BBE7BB9FE9BB98E8AEA4EFBC88E697A0E58F82EFBC8974000133740001317800);
INSERT INTO `QRTZ_JOB_DETAILS` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME2', 'DEFAULT', NULL, 'com.ruoyi.quartz.util.QuartzDisallowConcurrentExecution', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F504552544945537372001E636F6D2E72756F79692E71756172747A2E646F6D61696E2E5379734A6F6200000000000000010200084C000A636F6E63757272656E747400124C6A6176612F6C616E672F537472696E673B4C000E63726F6E45787072657373696F6E71007E00094C000C696E766F6B6554617267657471007E00094C00086A6F6247726F757071007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B4C00076A6F624E616D6571007E00094C000D6D697366697265506F6C69637971007E00094C000673746174757371007E000978720027636F6D2E72756F79692E636F6D6D6F6E2E636F72652E646F6D61696E2E42617365456E7469747900000000000000010200074C0008637265617465427971007E00094C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C0006706172616D7371007E00034C000672656D61726B71007E00094C000B73656172636856616C756571007E00094C0008757064617465427971007E00094C000A75706461746554696D6571007E000C787074000561646D696E7372000E6A6176612E7574696C2E44617465686A81014B597419030000787077080000017C0B1253F878707400007070707400013174000E302F3135202A202A202A202A203F74001572795461736B2E7279506172616D7328277279272974000744454641554C547372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B02000078700000000000000002740018E7B3BBE7BB9FE9BB98E8AEA4EFBC88E69C89E58F82EFBC8974000133740001317800);
INSERT INTO `QRTZ_JOB_DETAILS` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME3', 'DEFAULT', NULL, 'com.ruoyi.quartz.util.QuartzDisallowConcurrentExecution', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000F5441534B5F50524F504552544945537372001E636F6D2E72756F79692E71756172747A2E646F6D61696E2E5379734A6F6200000000000000010200084C000A636F6E63757272656E747400124C6A6176612F6C616E672F537472696E673B4C000E63726F6E45787072657373696F6E71007E00094C000C696E766F6B6554617267657471007E00094C00086A6F6247726F757071007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B4C00076A6F624E616D6571007E00094C000D6D697366697265506F6C69637971007E00094C000673746174757371007E000978720027636F6D2E72756F79692E636F6D6D6F6E2E636F72652E646F6D61696E2E42617365456E7469747900000000000000010200074C0008637265617465427971007E00094C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C0006706172616D7371007E00034C000672656D61726B71007E00094C000B73656172636856616C756571007E00094C0008757064617465427971007E00094C000A75706461746554696D6571007E000C787074000561646D696E7372000E6A6176612E7574696C2E44617465686A81014B597419030000787077080000017C0B1253F878707400007070707400013174000E302F3230202A202A202A202A203F74003872795461736B2E72794D756C7469706C65506172616D7328277279272C20747275652C20323030304C2C203331362E3530442C203130302974000744454641554C547372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B02000078700000000000000003740018E7B3BBE7BB9FE9BB98E8AEA4EFBC88E5A49AE58F82EFBC8974000133740001317800);

-- ----------------------------
-- Table structure for QRTZ_LOCKS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_LOCKS`;
CREATE TABLE `QRTZ_LOCKS`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调度名称',
  `lock_name` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '悲观锁名称',
  PRIMARY KEY (`sched_name`, `lock_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '存储的悲观锁信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_LOCKS
-- ----------------------------
INSERT INTO `QRTZ_LOCKS` VALUES ('RuoyiScheduler', 'STATE_ACCESS');
INSERT INTO `QRTZ_LOCKS` VALUES ('RuoyiScheduler', 'TRIGGER_ACCESS');

-- ----------------------------
-- Table structure for QRTZ_PAUSED_TRIGGER_GRPS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_PAUSED_TRIGGER_GRPS`;
CREATE TABLE `QRTZ_PAUSED_TRIGGER_GRPS`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调度名称',
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  PRIMARY KEY (`sched_name`, `trigger_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '暂停的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_PAUSED_TRIGGER_GRPS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_SCHEDULER_STATE
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_SCHEDULER_STATE`;
CREATE TABLE `QRTZ_SCHEDULER_STATE`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调度名称',
  `instance_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '实例名称',
  `last_checkin_time` bigint NOT NULL COMMENT '上次检查时间',
  `checkin_interval` bigint NOT NULL COMMENT '检查间隔时间',
  PRIMARY KEY (`sched_name`, `instance_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '调度器状态表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_SCHEDULER_STATE
-- ----------------------------
INSERT INTO `QRTZ_SCHEDULER_STATE` VALUES ('RuoyiScheduler', '0967b2e6f2d61646559827307', 1654755764218, 15000);

-- ----------------------------
-- Table structure for QRTZ_SIMPLE_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_SIMPLE_TRIGGERS`;
CREATE TABLE `QRTZ_SIMPLE_TRIGGERS`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `repeat_count` bigint NOT NULL COMMENT '重复的次数统计',
  `repeat_interval` bigint NOT NULL COMMENT '重复的间隔时间',
  `times_triggered` bigint NOT NULL COMMENT '已经触发的次数',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `QRTZ_SIMPLE_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `QRTZ_TRIGGERS` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '简单触发器的信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_SIMPLE_TRIGGERS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_SIMPROP_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_SIMPROP_TRIGGERS`;
CREATE TABLE `QRTZ_SIMPROP_TRIGGERS`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `str_prop_1` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第一个参数',
  `str_prop_2` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第二个参数',
  `str_prop_3` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第三个参数',
  `int_prop_1` int NULL DEFAULT NULL COMMENT 'int类型的trigger的第一个参数',
  `int_prop_2` int NULL DEFAULT NULL COMMENT 'int类型的trigger的第二个参数',
  `long_prop_1` bigint NULL DEFAULT NULL COMMENT 'long类型的trigger的第一个参数',
  `long_prop_2` bigint NULL DEFAULT NULL COMMENT 'long类型的trigger的第二个参数',
  `dec_prop_1` decimal(13, 4) NULL DEFAULT NULL COMMENT 'decimal类型的trigger的第一个参数',
  `dec_prop_2` decimal(13, 4) NULL DEFAULT NULL COMMENT 'decimal类型的trigger的第二个参数',
  `bool_prop_1` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Boolean类型的trigger的第一个参数',
  `bool_prop_2` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Boolean类型的trigger的第二个参数',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `QRTZ_SIMPROP_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `QRTZ_TRIGGERS` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '同步机制的行锁表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_SIMPROP_TRIGGERS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_TRIGGERS`;
CREATE TABLE `QRTZ_TRIGGERS`  (
  `sched_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '触发器的名字',
  `trigger_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '触发器所属组的名字',
  `job_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_job_details表job_name的外键',
  `job_group` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'qrtz_job_details表job_group的外键',
  `description` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '相关介绍',
  `next_fire_time` bigint NULL DEFAULT NULL COMMENT '上一次触发时间（毫秒）',
  `prev_fire_time` bigint NULL DEFAULT NULL COMMENT '下一次触发时间（默认为-1表示不触发）',
  `priority` int NULL DEFAULT NULL COMMENT '优先级',
  `trigger_state` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '触发器状态',
  `trigger_type` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '触发器的类型',
  `start_time` bigint NOT NULL COMMENT '开始时间',
  `end_time` bigint NULL DEFAULT NULL COMMENT '结束时间',
  `calendar_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '日程表名称',
  `misfire_instr` smallint NULL DEFAULT NULL COMMENT '补偿执行的策略',
  `job_data` blob NULL COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  INDEX `sched_name`(`sched_name`, `job_name`, `job_group`) USING BTREE,
  CONSTRAINT `QRTZ_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `job_name`, `job_group`) REFERENCES `QRTZ_JOB_DETAILS` (`sched_name`, `job_name`, `job_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '触发器详细信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_TRIGGERS
-- ----------------------------
INSERT INTO `QRTZ_TRIGGERS` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME1', 'DEFAULT', 'TASK_CLASS_NAME1', 'DEFAULT', NULL, 1654682080000, -1, 5, 'PAUSED', 'CRON', 1654682073000, 0, NULL, 2, '');
INSERT INTO `QRTZ_TRIGGERS` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME2', 'DEFAULT', 'TASK_CLASS_NAME2', 'DEFAULT', NULL, 1654682085000, -1, 5, 'PAUSED', 'CRON', 1654682074000, 0, NULL, 2, '');
INSERT INTO `QRTZ_TRIGGERS` VALUES ('RuoyiScheduler', 'TASK_CLASS_NAME3', 'DEFAULT', 'TASK_CLASS_NAME3', 'DEFAULT', NULL, 1654682080000, -1, 5, 'PAUSED', 'CRON', 1654682075000, 0, NULL, 2, '');

-- ----------------------------
-- Table structure for all_index
-- ----------------------------
DROP TABLE IF EXISTS `all_index`;
CREATE TABLE `all_index`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `sort` int NOT NULL DEFAULT 0,
  `gmt_create` datetime NULL DEFAULT NULL,
  `gmt_modified` datetime NULL DEFAULT NULL,
  `deleted` tinyint NOT NULL DEFAULT 0,
  `parent_id` bigint NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 64 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '索引' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of all_index
-- ----------------------------
INSERT INTO `all_index` VALUES (3, 'key', '自贸港政策', 0, '2021-09-23 01:34:17', '2021-09-23 01:34:17', 0, 11);
INSERT INTO `all_index` VALUES (4, 'key', '人才认定政策', 0, '2021-09-23 01:35:54', '2021-09-23 01:35:54', 0, 11);
INSERT INTO `all_index` VALUES (5, 'key', '金融政策', 0, '2021-09-23 01:36:43', '2021-09-23 01:36:43', 0, 11);
INSERT INTO `all_index` VALUES (6, 'key', '科技创新政策', 0, '2021-09-23 01:37:03', '2021-09-23 01:37:03', 0, 11);
INSERT INTO `all_index` VALUES (7, 'key', '奖励政策', 0, '2021-09-23 01:37:22', '2021-09-23 01:37:22', 0, 11);
INSERT INTO `all_index` VALUES (8, 'key', '项目申报政策', 0, '2021-09-23 01:37:37', '2021-09-23 01:37:37', 0, 11);
INSERT INTO `all_index` VALUES (9, 'key', '其他政策', 0, '2021-09-23 01:37:47', '2021-09-23 01:37:47', 0, 11);
INSERT INTO `all_index` VALUES (10, 'index', '政策索引', 0, '2021-09-23 01:37:47', '2021-09-23 01:37:47', 0, 0);
INSERT INTO `all_index` VALUES (11, 'list', '政策分类', 0, '2021-09-23 01:37:47', '2021-09-23 01:37:47', 0, 10);
INSERT INTO `all_index` VALUES (12, 'index', '科技索引', 0, '2021-09-23 01:34:17', '2021-09-23 01:34:17', 0, -1);
INSERT INTO `all_index` VALUES (13, 'list', '行业领域', 0, '2021-09-23 01:35:54', '2021-09-23 01:35:54', 0, 12);
INSERT INTO `all_index` VALUES (14, 'key', '互联网+', 0, '2021-09-23 01:36:43', '2021-09-23 01:36:43', 0, 13);
INSERT INTO `all_index` VALUES (15, 'key', '生物医药', 0, '2021-09-23 01:37:03', '2021-09-23 01:37:03', 0, 13);
INSERT INTO `all_index` VALUES (16, 'key', '新一代信息技术', 0, '2021-09-23 01:37:22', '2021-09-23 01:37:22', 0, 13);
INSERT INTO `all_index` VALUES (17, 'key', '高端智能设备', 0, '2021-09-23 01:37:37', '2021-09-23 01:37:37', 0, 13);
INSERT INTO `all_index` VALUES (18, 'key', '新能源', 0, '2021-09-23 01:37:47', '2021-09-23 01:37:47', 0, 13);
INSERT INTO `all_index` VALUES (19, 'key', '新材料', 0, '2021-09-23 01:37:47', '2021-09-23 01:37:47', 0, 13);
INSERT INTO `all_index` VALUES (20, 'key', '高技术服务', 0, '2021-09-23 01:37:47', '2021-09-23 01:37:47', 0, 13);
INSERT INTO `all_index` VALUES (21, 'key', '资源与环境', 0, '2021-09-23 01:37:47', '2021-09-23 01:37:47', 0, 13);
INSERT INTO `all_index` VALUES (22, 'key', '先进制造业', 0, '2021-09-23 01:37:47', '2021-09-23 01:37:47', 0, 13);
INSERT INTO `all_index` VALUES (24, 'index', '咨询索引', 0, '2021-09-23 01:37:03', '2021-09-23 01:37:03', 0, 0);
INSERT INTO `all_index` VALUES (25, 'list', '咨询分类', 0, '2021-09-23 01:37:22', '2021-09-23 01:37:22', 0, 24);
INSERT INTO `all_index` VALUES (26, 'key', '高企申报咨询', 0, '2021-09-23 01:37:37', '2021-09-23 01:37:37', 0, 25);
INSERT INTO `all_index` VALUES (27, 'key', '奖励政策咨询', 0, '2021-09-23 01:37:47', '2021-09-23 01:37:47', 0, 25);
INSERT INTO `all_index` VALUES (28, 'key', '项目申报咨询', 0, '2021-09-23 01:37:47', '2021-09-23 01:37:47', 0, 25);
INSERT INTO `all_index` VALUES (29, 'key', '科技成果咨询', 0, '2021-09-23 01:37:47', '2021-09-23 01:37:47', 0, 25);
INSERT INTO `all_index` VALUES (30, 'key', '金融政策咨询', 0, '2021-09-23 01:37:47', '2021-09-23 01:37:47', 0, 25);
INSERT INTO `all_index` VALUES (31, 'key', '其他政策咨询', 0, '2021-09-23 01:37:47', '2021-09-23 01:37:47', 0, 25);
INSERT INTO `all_index` VALUES (32, 'key', '农业', 0, '2021-09-29 19:56:09', '2021-09-29 19:56:13', 0, 13);
INSERT INTO `all_index` VALUES (33, 'key', '食品加工', 0, '2021-09-29 21:17:10', '2021-09-29 21:17:13', 0, 13);
INSERT INTO `all_index` VALUES (34, 'index', '人才索引', 0, NULL, NULL, 0, 0);
INSERT INTO `all_index` VALUES (35, 'list', '公司行业', 0, NULL, NULL, 0, 34);
INSERT INTO `all_index` VALUES (36, 'key', '电子商务', 0, NULL, NULL, 0, 35);
INSERT INTO `all_index` VALUES (37, 'key', '游戏', 0, NULL, NULL, 0, 35);
INSERT INTO `all_index` VALUES (38, 'key', '媒体', 0, NULL, NULL, 0, 35);
INSERT INTO `all_index` VALUES (39, 'key', '广告营销', 0, NULL, NULL, 0, 35);
INSERT INTO `all_index` VALUES (40, 'key', '数据服务', 0, NULL, NULL, 0, 35);
INSERT INTO `all_index` VALUES (41, 'key', '医疗健康', 0, NULL, NULL, 0, 35);
INSERT INTO `all_index` VALUES (42, 'key', '生活服务', 0, NULL, NULL, 0, 35);
INSERT INTO `all_index` VALUES (43, 'key', '旅游', 0, NULL, NULL, 0, 35);
INSERT INTO `all_index` VALUES (44, 'key', '分类信息', 0, NULL, NULL, 0, 35);
INSERT INTO `all_index` VALUES (45, 'key', '音乐/视频/阅读', 0, NULL, NULL, 0, 35);
INSERT INTO `all_index` VALUES (46, 'key', '在线教育', 0, NULL, NULL, 0, 35);
INSERT INTO `all_index` VALUES (47, 'key', '社交网络', 0, NULL, NULL, 0, 35);
INSERT INTO `all_index` VALUES (48, 'key', '人力资源服务', 0, NULL, NULL, 0, 35);
INSERT INTO `all_index` VALUES (49, 'key', '企业服务', 0, NULL, NULL, 0, 35);
INSERT INTO `all_index` VALUES (50, 'key', '信息安全', 0, NULL, NULL, 0, 35);
INSERT INTO `all_index` VALUES (51, 'key', '智能硬件', 0, NULL, NULL, 0, 35);
INSERT INTO `all_index` VALUES (52, 'key', '移动互联网', 0, NULL, NULL, 0, 35);
INSERT INTO `all_index` VALUES (53, 'key', '互联网', 0, NULL, NULL, 0, 35);
INSERT INTO `all_index` VALUES (54, 'key', '计算机软件', 0, NULL, NULL, 0, 35);
INSERT INTO `all_index` VALUES (55, 'key', '通信/网络设备', 0, NULL, NULL, 0, 35);
INSERT INTO `all_index` VALUES (56, 'key', '广告/公关/会展', 0, NULL, NULL, 0, 35);
INSERT INTO `all_index` VALUES (57, 'key', '互联网金融', 0, NULL, NULL, 0, 35);
INSERT INTO `all_index` VALUES (58, 'key', '物流/仓储', 0, NULL, NULL, 0, 35);
INSERT INTO `all_index` VALUES (59, 'key', '贸易/进出口', 0, NULL, NULL, 0, 35);
INSERT INTO `all_index` VALUES (60, 'key', '咨询', 0, NULL, NULL, 0, 35);
INSERT INTO `all_index` VALUES (61, 'key', '工程施工', 0, NULL, NULL, 0, 35);
INSERT INTO `all_index` VALUES (62, 'key', '汽车生产', 0, NULL, NULL, 0, 35);
INSERT INTO `all_index` VALUES (63, 'key', '其他行业', 0, NULL, NULL, 0, 35);

-- ----------------------------
-- Table structure for business_info
-- ----------------------------
DROP TABLE IF EXISTS `business_info`;
CREATE TABLE `business_info`  (
  `business_id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名称',
  `corporate` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '法人',
  `type` tinyint NULL DEFAULT NULL COMMENT '类型（1：有效期高企，2：培育库入库企业，3：当年申报企业）',
  `manege_scope` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '经营范围',
  `introduction` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '简介',
  `found_date` date NULL DEFAULT NULL COMMENT '成立日期',
  `manege_deadline` date NULL DEFAULT NULL COMMENT '经营期限',
  `website` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '网址',
  `email` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `capital` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '注册资本',
  `location` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '位置（省市县）',
  `address` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '详细地址',
  `code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '统一社会信用代码',
  `telephone` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '固定电话',
  `contact_id` bigint NULL DEFAULT NULL COMMENT '联系人id',
  `reg_office` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '登记机关',
  `examine_date` date NULL DEFAULT NULL COMMENT '核准日期',
  `image_url` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '公司图片',
  `examine_image` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '审核所需资料',
  `user_id` bigint NULL DEFAULT NULL COMMENT '用户id',
  `status` tinyint NULL DEFAULT NULL COMMENT '审核状态 [1：正在审核，2：审核通过，3：审核失败]',
  PRIMARY KEY (`business_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '企业信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of business_info
-- ----------------------------

-- ----------------------------
-- Table structure for consultation
-- ----------------------------
DROP TABLE IF EXISTS `consultation`;
CREATE TABLE `consultation`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL COMMENT '用户id',
  `category` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '咨询内容类型（1：申报政策 2：金融政策 3：科技服务 4：人才政策 5：科技园区 6：其他）',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '咨询内容',
  `email` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `parent_id` bigint NOT NULL DEFAULT 0 COMMENT '回复信息对应的咨询信息的id（咨询信息的parent_id为0）\n',
  `publish_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发布时间',
  `is_read` tinyint NOT NULL DEFAULT 0 COMMENT '是否已读（0：未读 1：已读）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 37 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '咨询' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of consultation
-- ----------------------------
INSERT INTO `consultation` VALUES (2, 1, '高企申报咨询', '此处为脱敏后的示例内容。', 'consultation2@example.com', '18828292201', 0, '2021-04-18 15:38:53', 0);
INSERT INTO `consultation` VALUES (4, 2, '问题咨询2', '此处为脱敏后的示例内容。', 'consultation4@example.com', '18336970166', 2, '2021-04-19 16:17:05', 0);
INSERT INTO `consultation` VALUES (5, 1, '高企申报咨询', '此处为脱敏后的示例内容。', 'consultation5@example.com', '13989523698', 0, '2021-04-20 05:32:39', 0);
INSERT INTO `consultation` VALUES (9, 1, '高企申报咨询', '此处为脱敏后的示例内容。', 'consultation9@example.com', '13767395614', 0, '2021-04-20 06:28:23', 0);
INSERT INTO `consultation` VALUES (10, 1, '高企申报咨询', '此处为脱敏后的示例内容。', 'consultation10@example.com', '15991484170', 0, '2021-04-20 06:29:39', 0);
INSERT INTO `consultation` VALUES (11, 1, '高企申报咨询', '此处为脱敏后的示例内容。', 'consultation11@example.com', '13776787286', 0, '2021-04-20 06:29:59', 0);
INSERT INTO `consultation` VALUES (12, 1, '高企申报咨询', '此处为脱敏后的示例内容。', 'consultation12@example.com', '18302652550', 0, '2021-04-20 06:30:20', 0);
INSERT INTO `consultation` VALUES (13, 1, NULL, '此处为脱敏后的示例内容。', NULL, NULL, 5, '2021-04-21 05:55:58', 0);
INSERT INTO `consultation` VALUES (15, 1, '奖励政策咨询', '此处为脱敏后的示例内容。', 'consultation15@example.com', '13653991648', 0, '2021-04-21 16:21:40', 0);
INSERT INTO `consultation` VALUES (16, 1, NULL, '此处为脱敏后的示例内容。', NULL, NULL, 15, '2021-04-21 16:22:03', 0);
INSERT INTO `consultation` VALUES (17, 1, '奖励政策咨询', '此处为脱敏后的示例内容。', 'consultation17@example.com', '15130128288', 0, '2021-04-21 16:25:10', 0);
INSERT INTO `consultation` VALUES (18, 1, NULL, '此处为脱敏后的示例内容。', NULL, NULL, 17, '2021-04-21 16:25:38', 0);
INSERT INTO `consultation` VALUES (19, 1, '其他政策咨询', '此处为脱敏后的示例内容。', 'consultation19@example.com', '18282257550', 0, '2021-04-21 17:04:41', 0);
INSERT INTO `consultation` VALUES (20, 1, NULL, '此处为脱敏后的示例内容。', NULL, NULL, 19, '2021-04-21 17:10:42', 0);
INSERT INTO `consultation` VALUES (21, 1, '科技成果咨询', '此处为脱敏后的示例内容。', 'consultation21@example.com', '18762771784', 0, '2021-04-21 17:19:18', 0);
INSERT INTO `consultation` VALUES (22, 1, '科技成果咨询', '此处为脱敏后的示例内容。', 'consultation22@example.com', '13806243099', 0, '2021-04-21 17:25:34', 0);
INSERT INTO `consultation` VALUES (23, 1, NULL, '此处为脱敏后的示例内容。', NULL, NULL, 22, '2021-04-21 17:25:57', 0);
INSERT INTO `consultation` VALUES (24, 1, '金融政策咨询', '此处为脱敏后的示例内容。', 'consultation24@example.com', '13541547032', 0, '2021-04-21 17:34:47', 0);
INSERT INTO `consultation` VALUES (25, 1, '金融政策咨询', '此处为脱敏后的示例内容。', 'consultation25@example.com', '13913489352', 0, '2021-04-21 17:35:34', 0);
INSERT INTO `consultation` VALUES (26, 1, NULL, '此处为脱敏后的示例内容。', NULL, NULL, 25, '2021-04-21 17:35:46', 0);
INSERT INTO `consultation` VALUES (27, 1, '项目申报咨询', '此处为脱敏后的示例内容。', 'consultation27@example.com', '18252106018', 0, '2021-04-21 17:50:17', 0);
INSERT INTO `consultation` VALUES (28, 1, NULL, '此处为脱敏后的示例内容。', NULL, NULL, 27, '2021-04-21 17:50:37', 0);
INSERT INTO `consultation` VALUES (29, 1, '高企申报咨询', '此处为脱敏后的示例内容。', 'consultation29@example.com', '18337555275', 0, '2021-07-06 03:31:03', 0);
INSERT INTO `consultation` VALUES (30, 0, '高企申报咨询', '此处为脱敏后的示例内容。', 'consultation30@example.com', '13663208659', 0, '2021-07-06 03:50:49', 0);
INSERT INTO `consultation` VALUES (32, 3, '高企申报咨询', '此处为脱敏后的示例内容。', 'consultation32@example.com', '13609145941', 0, '2021-09-18 11:57:20', 0);
INSERT INTO `consultation` VALUES (33, 3, '高企申报咨询', '此处为脱敏后的示例内容。', 'consultation33@example.com', '15040011182', 0, '2021-09-18 13:33:12', 0);
INSERT INTO `consultation` VALUES (35, 3, '高企申报咨询', '此处为脱敏后的示例内容。', 'consultation35@example.com', '18825383616', 0, '2021-11-15 14:34:13', 0);
INSERT INTO `consultation` VALUES (36, 3, '高企申报咨询', '此处为脱敏后的示例内容。', 'consultation36@example.com', '13536899489', 0, '2022-01-19 01:48:32', 0);

-- ----------------------------
-- Table structure for contact
-- ----------------------------
DROP TABLE IF EXISTS `contact`;
CREATE TABLE `contact`  (
  `contact_id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '姓名',
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电话',
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `address` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '地址',
  `position` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '单位',
  PRIMARY KEY (`contact_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '联系人' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of contact
-- ----------------------------
INSERT INTO `contact` VALUES (1, '朱文泽', '15011551638', 'contact1@example.com', NULL, NULL);
INSERT INTO `contact` VALUES (2, '陶平然', '18840098369', 'contact2@example.com', '深圳市南山区解放路150号', '总监');
INSERT INTO `contact` VALUES (3, '陶红华', '13791077715', 'contact3@example.com', '南京市鼓楼区创业大道91号', '经理');
INSERT INTO `contact` VALUES (4, '姜磊军', '15192422497', 'contact4@example.com', '武汉市江汉区滨海大道92号', '工程师');
INSERT INTO `contact` VALUES (5, '陈霞怡', '13735808095', 'contact5@example.com', NULL, NULL);
INSERT INTO `contact` VALUES (6, '华娜', '15853309119', 'contact6@example.com', NULL, NULL);
INSERT INTO `contact` VALUES (7, '褚涛泽', '13612545430', 'contact7@example.com', '西安市雁塔区滨海大道58号', '经理');
INSERT INTO `contact` VALUES (8, '孔磊华', '15845904023', 'contact8@example.com', '深圳市南山区振兴街167号', '主管');
INSERT INTO `contact` VALUES (9, '严丽燕', '15008617242', 'contact9@example.com', '深圳市南山区滨海大道172号', '经理');
INSERT INTO `contact` VALUES (10, '朱平', '13670583611', NULL, NULL, NULL);
INSERT INTO `contact` VALUES (11, '韩超燕', '13927194930', 'contact11@example.com', NULL, NULL);
INSERT INTO `contact` VALUES (12, '施静', '18870067184', 'contact12@example.com', '深圳市南山区滨海大道6号', '专员');
INSERT INTO `contact` VALUES (13, '蒋涛然', '13504641427', 'contact13@example.com', '上海市浦东新区解放路14号', '负责人');
INSERT INTO `contact` VALUES (14, '周强伟', '15059982879', 'contact14@example.com', '海口市美兰区科技路108号', '工程师');
INSERT INTO `contact` VALUES (15, '蒋志然', '15143998821', 'contact15@example.com', '北京市朝阳区人民大道194号', '负责人');
INSERT INTO `contact` VALUES (16, '褚敏', '13943354784', 'contact16@example.com', '广州市天河区滨海大道113号', '总监');
INSERT INTO `contact` VALUES (17, '姜红', '18256217294', 'contact17@example.com', '成都市锦江区科技路140号', '总监');
INSERT INTO `contact` VALUES (18, '孙娜', '13997211291', 'contact18@example.com', '西安市雁塔区创业大道90号', '主管');
INSERT INTO `contact` VALUES (19, '周英', '18203255958', 'contact19@example.com', '广州市天河区滨海大道165号', '经理');
INSERT INTO `contact` VALUES (20, '王军杰', '13997522621', NULL, NULL, NULL);
INSERT INTO `contact` VALUES (21, '褚霞怡', '18762497619', NULL, NULL, NULL);
INSERT INTO `contact` VALUES (22, '秦勇怡', '18805831007', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for ensure_method_index
-- ----------------------------
DROP TABLE IF EXISTS `ensure_method_index`;
CREATE TABLE `ensure_method_index`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '担保方式检索' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ensure_method_index
-- ----------------------------
INSERT INTO `ensure_method_index` VALUES (1, '抵押');
INSERT INTO `ensure_method_index` VALUES (2, '质押');
INSERT INTO `ensure_method_index` VALUES (3, '信保基金');
INSERT INTO `ensure_method_index` VALUES (4, '一般保证');
INSERT INTO `ensure_method_index` VALUES (5, '信用');

-- ----------------------------
-- Table structure for ensure_money_index
-- ----------------------------
DROP TABLE IF EXISTS `ensure_money_index`;
CREATE TABLE `ensure_money_index`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '贷款额度检索' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ensure_money_index
-- ----------------------------
INSERT INTO `ensure_money_index` VALUES (1, '100万及以下');
INSERT INTO `ensure_money_index` VALUES (2, '200万及以下');
INSERT INTO `ensure_money_index` VALUES (3, '300万及以下');
INSERT INTO `ensure_money_index` VALUES (4, '500万及以下');
INSERT INTO `ensure_money_index` VALUES (5, '1000万及以下');
INSERT INTO `ensure_money_index` VALUES (6, '1000万及以上');
INSERT INTO `ensure_money_index` VALUES (7, '其他金额');

-- ----------------------------
-- Table structure for financial_product
-- ----------------------------
DROP TABLE IF EXISTS `financial_product`;
CREATE TABLE `financial_product`  (
  `financial_product_id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '产品名称',
  `publish_time` datetime NULL DEFAULT NULL COMMENT '发布时间',
  `description` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '产品描述',
  `image` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '详情图片',
  `rate` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '利率范围 （1%-2%）',
  `loan_money` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '担保额度',
  `ensure_method` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '担保方式',
  `loan_deadline` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '贷款期限',
  `apply_condition` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '申请条件',
  `contact_id` bigint NULL DEFAULT NULL COMMENT '联系人id',
  `financial_institution_id` bigint NULL DEFAULT NULL COMMENT '金融机构id',
  PRIMARY KEY (`financial_product_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '金融产品' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of financial_product
-- ----------------------------
INSERT INTO `financial_product` VALUES (1, '海南科技成果转化投资基金介绍', '2020-11-04 14:23:12', '海南科技成果转化投资基金，是海南省科技厅加快推动我省科技成果的产业化及我省科技型企业的发展，发挥财政资金的引导作用，吸引撬动社会加大对我省科技成果转化的投入而推动设立的一支以市场化运作为导向的政府引导基金。\r\n基金总规模为2亿元，基金投向新技术（包括但不限于互联网、物联网技术及行业升级的大数据、SaaS、企业服务等）、新工艺、新装置、新产品（包括但不限于科技硬件、芯片等）、新材料等科技成果的转化应用，主要包括但不限于海洋科技产业、航空航天和医疗健康产业的科技成果转化产业化及国家科技成果转化项目库中的项目。\r\n欢迎注册在海南省内，或拟迁入海南省的高新技术企业，拥有独立应用场景的科技成果应用技术，具有完整的运营团队和良好的市场发展空间，能接受股权投资及股权退出的企业投递商业BP；', '/static/defaultImage/1.png', '', '100万及以下', '信用', '12个月及以下', '基金管理人——鲲腾（海南）股权投资基金管理有限公司简介：\r\n鲲腾资本是一支由互联网资深人士所共同发起设立的资本管理机构。发起人来自于前阿里巴巴集团高管、恒生电子联合创始人、前天涯社区高管，在互联网细分产业领域具有丰富经验及资源优势。主要合伙人曾完整经历了中国互联网20年（1999-2019）发展过程中的数个迭代周期，对互联网行业的发展有着深度积累及深刻洞见与判断。同时，我们是一家在海南具备完整基金管理团队，扎根于海南、服务于海南的本土化基金管理公司。', 10, 1);
INSERT INTO `financial_product` VALUES (2, '《海南省科技信贷风险补偿管理暂行办法》政策解读', '2020-12-08 14:36:12', '《海南省科技信贷风险补偿管理暂行办法》有八章三十四条。\r\n\r\n第一章为总则，共四条，定义本办法的依据、意义、目的及政策框架。\r\n\r\n第二章为职责与分工，共六条，主要是政府管理部门责职、合作银行条件与职责、资金管理机构条件与职责、资金管理机构费用保障。省科学技术厅是“琼科贷”工作的管理机构。合作银行应改善业务流程，调整内部绩效评价标准，降低信贷条件，全部信用贷款总额与全部抵押贷款总额比例应不低于3：7，若要求企业为贷款提供自身或第三方不动产进行抵押，该不动产评估价值不得超过贷款额度的50%。\r\n\r\n第三章管理方式，共三条，主要是“琼科贷补偿金”管理、企业池条件、贷款项目条件。企业应为有效期内的高新技术企业或进入海南省高新技术企业培育库的企业。\r\n\r\n第四章运作方式，共五条，包括合作方式、合作银行的遴选、专业管理机构管理、合作银行的协定事项、放大倍数、风险分担机制、企业推荐入池、业务操作流程等。对于合作银行向企业发放的信用贷款形成的不良贷款，由“琼科贷补偿金”按照不良贷款损失的60%进行补助；对于合作银行向入池企业发放的其他形式贷款形成的不良贷款，按照不良贷款损失的50%进行补助。\r\n\r\n第五章风险确认及补偿程序，共五条，明确贷款风险发生条件、补偿程序等。\r\n\r\n第六章监督管理，共六条，明确资金使用、贷款发放、追偿等监督管理事项。\r\n\r\n第七章业务“琼科贷”延续和终止，共三条，明确业务延续和中止条件。\r\n\r\n第八章附则，共两条，明确办法解释单位和有效期。', '/static/defaultImage/1.png', '', '200万及以下', '信保基金', '36个月以上', '2020年11月26日，省科技厅、财政厅印发了《海南省科技信贷风险补偿管理暂行办法》（以下简称办法），设立海南省科技信贷风险补偿资金（以下简称“琼科贷补偿金”）现解读如下：\r\n\r\n一、办法制定依据\r\n\r\n落实《中共海南省委 海南省人民政府关于加快科技创新的实施意见》（琼发〔2017〕12号）和《海南省支持高新技术企业发展若干政策（试行）》（琼府〔2020〕50号）有关要求，加大对我省高新技术企业的信贷支持力度，发挥财政资金引导作用，加强科技要素和金融创新相结合，切实提高企业自主创新能力，助推企业创新发展。\r\n\r\n二、设立“琼科贷补偿金”的目的\r\n\r\n   “琼科贷补偿金”的宗旨是通过转变财政科技资金投入方式，激发金融机构向高新技术企业贷款的积极性。简化高新技术企业贷款手续、降低贷款门槛，推进高新技术企业快速发展。鼓励银行降低标准、简化程序，向高新技术企业提供贷款。对于合作银行向科技企业发放的信用贷款形成的不良贷款，按照不良贷款损失的60%进行补助，同时要求信用贷款与抵押贷款比例不低于3：7。\r\n\r\n三、“琼科贷补偿金”预算安排和运作方式\r\n\r\n   科技信贷业务采取“政府+银行”模式，委托第三方专业机构进行管理。合作银行直接向高新技术企业提供信贷融资，“琼科贷补偿金”和合作银行按约定比例承担不良贷款代偿损失，其中：信用贷款分担比例为6：4,其他贷款分担比例5：5。“琼科贷补偿金”以科技贷补偿资金池全部财政资金额为上限。', 11, 1);
INSERT INTO `financial_product` VALUES (3, '海南省科技创新券管理办法', '2020-10-30 22:00:32', '第一条 为进一步优化海南省创新创业生态体系，更好地发挥科技创新券（以下简称创新券）支持企业和创客团队开展科技创新创业活动，推动科技资源开放共享，加大科技研发投入等方面的作用，根据《海南省财政科技计划项目管理办法》（琼科﹝2018﹞48号）和《海南省财政科技计划项目经费管理办法》（琼财教﹝2018﹞117号）等文件，为加强科技创新券管理，制定本办法。\r\n第二条 省科技厅负责发放科技创新券，采取无偿资助的方式。符合一定条件的企业、创客团队向高校、科研院所、科技服务机构等单位或其它企业（以下统称科技创新服务单位）购买与其科技创新活动直接相关的创新服务和技术成果。科技创新券由企业、创客团队申请和兑现。\r\n　　第三条 省科技厅负责制定创新券相关政策，编制年度申请指南，管理和监督创新券的使用相关事宜，研究确定创新券实施过程中的有关重大事项。\r\n　　第四条 创新券的使用和管理应当遵守国家有关法律法规，遵循公开普惠、自主申领、专款专用、据实列支的原则。', NULL, NULL, NULL, NULL, NULL, '科技创新券支持企业为在海南省注册的具备法人资格的企业，创客团队应当为入驻市县级以上（认定）备案的众创空间；同时符合以下条件：\r\n    （一）应当与科技创新服务机构订立服务协议；\r\n    （二）申请科技创新券所涉及的科技创新服务内容未获得财政性资金的支持，与科技创新活动直接相关；\r\n    （三）企业、创客团队自筹配套资金不低于申请的科技创新券额度；\r\n（四）与开展合作的单位无任何隶属、共建、产权纽带等关联关系。', 11, NULL);
INSERT INTO `financial_product` VALUES (4, '国家外汇管理局关于金融支持海南全面深化改革开放的意见', '2021-03-30 01:09:23', '海南省人民政府：\r\n\r\n为深入贯彻习近平总书记在庆祝海南建省办经济特区30周年大会上的重要讲话精神，落实《中共中央国务院关于支持海南全面深化改革开放的指导意见》和《海南自由贸易港建设总体方案》相关重要战略部署，支持海南全面深化改革开放，推动建立与海南自由贸易港相适应的金融政策和制度框架，经国务院同意，现提出如下意见。\r\n\r\n一、总体原则\r\n\r\n（一）支持海南实体经济发展。坚持深化金融供给侧结构性改革，创新金融政策、产品和工具，聚焦发展旅游业、现代服务业和高新技术产业，重点支持海洋产业、医疗健康、旅游会展、交通运输、现代农业、服务外包等重点领域发展，推动建立开放型生态型服务型产业体系，促进服务业优化升级，推动经济高质量发展。\r\n\r\n（二）服务海南自由贸易港建设。围绕建设全面深化改革开放试验区、国家生态文明试验区、国际旅游消费中心、国家重大战略服务保障区的战略定位，服务国内其他地区与海南自由贸易港资金往来和跨境贸易投资自由化便利化，分阶段、分步骤实施各项金融改革开放与创新举措，推动海南成为新时代全面深化改革开放的新标杆。\r\n\r\n（三）以制度创新为核心深化金融改革开放。坚持对标国际的原则，深化金融改革开放。按照远近结合、循序渐进、突出重点的工作思路，在跨境资金流动自由便利、投融资汇兑便利化、金融业对外开放等方面先行先试，积极探索更加灵活的金融政策体系、监管模式、管理体制。\r\n\r\n（四）加强金融风险防控体系建设。坚持底线思维，稳扎稳打、步步为营，完善与金融开放创新相适应的跨境资金流动风险防控体系，在确保有效监管和风险可控的前提下，稳妥有序推进各项金融开放创新举措，统筹安排好开放节奏和进度，成熟一项推进一项，牢牢守住不发生系统性金融风险的底线。\r\n\r\n二、提升人民币可兑换水平，支持跨境贸易投资自由化便利化\r\n\r\n（五）进一步推动跨境货物贸易、服务贸易以及新型国际贸易结算便利化。根据“了解客户、了解业务、尽职审查”原则，审慎合规的海南自由贸易港银行可试点凭支付指令为优质客户办理真实合规货物贸易和服务贸易结算，实现银行真实性审核从事前审查转为事后核查。实施与跨境服务贸易配套的资金支付与转移制度。支持海南自由贸易港试点银行，在强化对客户分级管理的基础上，进一步便利真实合规新型国际贸易的跨境结算。\r\n\r\n（六）探索适应市场需求新形态的跨境投资外汇管理。在风险可控前提下，允许海南自由贸易港内合格境外有限合伙人（QFLP）按照余额管理模式自由汇出、汇入资金，简化外汇登记手续。将海南自由贸易港纳入合格境内有限合伙人（QDLP）试点，给予海南自由贸易港QDLP试点基础额度，每年可按一定规则向其增发QDLP额度。\r\n\r\n（七）完善全口径跨境融资宏观审慎管理政策框架。可适当提高海南自由贸易港内注册的非金融企业（不含房地产企业和地方政府融资平台）跨境融资上限，实现更高额度的跨境资金融入规模。\r\n\r\n（八）探索开展跨境资产管理业务试点。支持境外投资者投资海南自由贸易港内金融机构发行的理财产品、证券期货经营机构私募资产管理产品、公募证券投资基金、保险资产管理产品等资产管理产品。\r\n\r\n（九）探索放宽个人跨境交易政策。支持在海南自由贸易港内就业的境外个人开展包括证券投资在内的各类境内投资。允许符合条件的非居民按实需原则在海南自由贸易港内购买房地产，对符合条件的非居民购房给予汇兑便利。研究进一步便利海南居民个人用汇。\r\n\r\n（十）在海南开展本外币合一跨境资金池业务试点。支持符合条件的跨国企业集团在境内外成员之间集中开展本外币资金余缺调剂和归集业务，专户内资金按实需兑换，对跨境资金流动实行双向宏观审慎管理。\r\n\r\n（十一）支持符合资格的非银行金融机构开展结售汇业务试点。符合资格的非银行金融机构满足一定条件后可参与到银行间外汇市场，依法合规开展人民币对外汇即期业务和相关衍生品交易。\r\n\r\n三、完善海南金融市场体系\r\n\r\n（十二）支持海南银行业发展。支持海南引进全国性股份制商业银行设立分行。研究海南农村信用社改革，推动其更好服务乡村振兴战略实施。强化海洋产业、高新技术产业等领域的金融服务。支持海南引进外资，参股地方性资产管理公司。\r\n\r\n（十三）支持符合条件的海南企业首发上市，通过多层次股权市场发展壮大。继续支持海南企业并购重组，实现转型升级。\r\n\r\n（十四）支持海南企业发行债券融资。积极支持符合条件的海南企业在银行间市场和交易所市场发行公司信用类债券，进一步提高直接融资规模。支持市场主体扩大在受托管理机构、交易场所等方面的自主选择空间。支持海南企业通过资产证券化盘活存量、拓宽资金来源。\r\n\r\n（十五）支持海南相关基金发展。支持公募基金落户海南，支持符合条件的机构在海南依法申请设立合资公募基金管理公司，支持符合条件的境外金融机构在海南全资拥有或控股参股期货公司。对投向海南种业、现代农业等重点领域的私募股权投资基金，给予登记备案绿色通道。\r\n\r\n四、扩大海南金融业对外开放\r\n\r\n（十六）扩大银行业对外开放。鼓励境外金融机构落户海南，支持设立中外合资银行。支持海南的银行引进符合条件的境外战略投资者，改善股权结构，完善公司治理，进一步提高海南的银行业对外开放程度。\r\n\r\n（十七）扩大保险业对外开放。就海南与港澳地区保险市场深度合作加强研究。借鉴国际经验和通行做法，探索制定适合再保险离岸业务的偿付能力监管政策。\r\n\r\n（十八）设立银行业准入事项快速通道，建立准入事项限时办结制度，提高审批效率。\r\n\r\n（十九）落实外商投资的国民待遇要求，支持符合条件的外资机构在海南依法合规获取支付业务许可证。\r\n\r\n（二十）允许已取得离岸银行业务资格的中资商业银行总行授权海南自由贸易港内分行开展离岸银行业务。\r\n\r\n五、加强金融产品和服务创新\r\n\r\n（二十一）鼓励创新面向国际市场的人民币金融产品及业务，扩大境外人民币投资海南金融产品的范围。在依法合规前提下，允许海南市场主体在境外发行人民币计价的债券等产品引入境外人民币资金，重点支持高新技术、医疗健康、旅游会展、交通运输等产业发展。\r\n\r\n（二十二）稳步扩大跨境资产转让范围。在宏观审慎管理框架下，按照风险可控和规模可调节原则，在海南自由贸易港内试点扩大可跨境转出的信贷资产范围和参与机构范围。\r\n\r\n（二十三）支持海南探索推进农垦国有农用地使用权抵押担保试点，推动完善确权登记发证、抵押担保登记、土地流转平台建设、抵押物价值评估等配套措施。\r\n\r\n（二十四）创新发展保险业务。支持符合条件的保险机构在海南设立保险资产管理公司，并在账户独立、风险隔离的前提下，向境外发行人民币计价的资产管理产品。支持海南保险机构开展境外投资业务。鼓励保险机构加强创新，围绕环境、农业、旅游、健康、养老等领域，研发适应海南需求的特色保险产品。\r\n\r\n（二十五）发展绿色金融。鼓励绿色金融创新业务在海南先行先试，支持国家生态文明试验区建设。加大对生态环境保护，特别是应对气候变化的投融资支持力度。\r\n\r\n（二十六）支持科技金融发展，推动发展海洋科技。在依法合规、风险可控前提下，鼓励海南法人银行加强与创投机构合作，探索科技金融新模式，支持海南加强深海科技创新。创新科技金融政策、产品和工具。\r\n\r\n（二十七）在依法合规、风险可控前提下加强金融科技创新应用。支持海南自由贸易港在金融管理部门统筹下开展金融科技创新业务试点，稳妥推进科技与金融业务深度融合。\r\n\r\n六、提升金融服务水平\r\n\r\n（二十八）支持在海南探索开展本外币合一银行账户体系试点。\r\n\r\n（二十九）支持商业银行、中国银联联合产业各方推进开展小微企业卡、乡村振兴卡等业务，聚焦金融服务小微企业、服务“三农”产业的支付结算、融资增信、企业增值服务体系等环节，满足小微企业和“三农”产业互联网化、移动化支付结算需求。\r\n\r\n（三十）提升跨境移动支付便利化水平。便利境外居民在海南使用移动电子支付工具。支持境内移动支付机构在境外开展业务，逐步扩大其通过人民币跨境支付系统（CIPS）境外参与机构进行跨境移动支付的地区范围。\r\n\r\n（三十一）持续推进海南中小微企业信用体系建设，支持构建小微企业综合金融服务平台，并与全国“信易贷”平台互联互通，做好中小微企业信用信息归集与应用，更高效地对接金融服务。深入推进海南农村信用体系建设，扩展农村地区信用信息覆盖广度，强化信用信息服务，有效对接普惠金融、乡村振兴战略，支持实体经济和海南特色产业发展。支持海南引进有市场影响力的信用评级机构。建立健全信用信息共享机制，支持海南地方社会信用体系建设。\r\n\r\n（三十二）支持海南加快发展航运金融、船舶融资租赁等现代服务业。\r\n\r\n（三十三）支持文化、体育、旅游业发展。强化文化、体育和旅游领域金融服务。建立文化、体育和旅游企业信用大数据平台，破解文化、体育和旅游企业信用不充分、与金融机构之间信息不对称的融资瓶颈。推广文化、体育和旅游产业专项债券，优化文化、体育和旅游产业融资结构，逐步降低融资成本。建设区域文化和旅游金融服务平台，完善产业金融服务体系。针对邮轮游艇等海南国际旅游岛特色产业，重点支持邮轮游艇产业集聚园区和相关公共服务配套设施建设。\r\n\r\n（三十四）在房地产长效机制框架下，支持海南在住房租赁领域发展房地产投资信托基金(REITs)，鼓励银行业金融机构创新金融产品和服务，支持住房租赁市场规范发展。\r\n\r\n七、加强金融监管，防范化解金融风险\r\n\r\n（三十五）构建金融宏观审慎管理体系，加强对重大风险的识别和对系统性金融风险的防范。依托资金流信息监测管理系统，建立健全资金流动监测和风险防控体系。完善反洗钱、反恐怖融资和反逃税制度体系和工作机制，研究建立洗钱风险评估机制，定期评估洗钱和恐怖融资风险。构建适应海南自由贸易港建设的金融监管协调机制，有效履行属地金融监管职责，确保风险防控能力与金融改革创新相适应。\r\n\r\n（三十六）支持海南设立金融与破产专业审判机构，集中审理海南金融与破产案件，提升金融与破产案件专业化审理水平，为当事人提供更加优质高效的司法保障。\r\n\r\n（三十七）加强金融消费者权益保护。支持海南银行、证券、保险领域消费纠纷调解组织充分发挥作用，建立公正、高效、便民的金融纠纷非诉第三方解决机制。加强与当地人民法院和司法行政部门的沟通合作，落实银行、证券、保险领域矛盾纠纷诉调对接机制，发挥金融行业调解组织专业化优势，探索建立金融行业纠纷调解协议司法确认制度。开展集中性金融知识普及活动,在海南建立金融知识普及教育示范基地。进一步发挥证券期货投资者教育基地作用。\r\n\r\n中国人民银行\r\n\r\n中国银行保险监督管理委员会\r\n\r\n中国证券监督管理委员会\r\n\r\n国家外汇管理局\r\n\r\n2021年3月30日', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for financing_need
-- ----------------------------
DROP TABLE IF EXISTS `financing_need`;
CREATE TABLE `financing_need`  (
  `financing_need_id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '项目名称',
  `publish_time` datetime NULL DEFAULT NULL COMMENT '发布时间',
  `project_description` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '项目描述',
  `field` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '行业领域',
  `project_image` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '项目详情图片',
  `team_introduction` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '团队介绍',
  `financing_introduction` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '融资介绍',
  `financing_money` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '融资金额',
  `financing_method` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '融资方式',
  `financing_phase` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '融资阶段',
  `contact_id` bigint NULL DEFAULT NULL COMMENT '联系人id',
  `business_id` bigint NULL DEFAULT NULL COMMENT '企业id',
  PRIMARY KEY (`financing_need_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '融资需求' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of financing_need
-- ----------------------------
INSERT INTO `financing_need` VALUES (1, '充电桩', '2022-03-25 15:02:11', '充电桩产品系列齐全：\n第一代充电桩产品有：交流充电桩、落地式直流充电桩，整机功率≤180KW；\n第二代充电桩产品有：交流充电桩、便携式直流充电桩、落地式直流充电桩，整机功率≤400KW。', '高端智能设备', '/static/defaultImage/1.png', '冯文 西安交通大学 电气自动化专业\n研发总监', '融资2000万，出让20%股权，寻求银行贷款500万', '5000万以上', '债务性融资', '其他', 16, 1);
INSERT INTO `financing_need` VALUES (2, '细胞器多组学科研和医学服务产业化项目', '2022-03-25 15:05:44', '细胞器多组学科研和医学服务产业化，突破细胞器分离纯化难题', '生物医药', '/static/defaultImage/1.png', '公司设有6个部门，包含行政人事部、销售部、实验部、项目管理部、产品部、生物信息部。共有员工32人，其中硕士以上学历18人，公司核心团队成员从事高通量测序领域8年以上。', '细胞器多组学科研和医学服务产业化项目融资300万，出让5%股权', '100万-500万', '出让股权', '其他', 18, 1);

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table`  (
  `table_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `package_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '生成功能作者',
  `gen_type` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 58 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '代码生成业务表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table
-- ----------------------------
INSERT INTO `gen_table` VALUES (43, 'business_info', '企业信息', NULL, NULL, 'BusinessInfo', 'crud', 'com.ruoyi.data', 'data', 'businessInfo', '企业信息', 'ruoyi', '0', '/', NULL, 'admin', '2021-09-30 12:15:30', '', NULL, NULL);
INSERT INTO `gen_table` VALUES (44, 'talent_need', '人才需求', NULL, NULL, 'TalentNeed', 'crud', 'com.ruoyi.data', 'data', 'talentNeed', '人才需求', 'ruoyi', '0', '/', NULL, 'admin', '2021-09-30 12:15:31', '', NULL, NULL);
INSERT INTO `gen_table` VALUES (45, 'talent_supply', '人才供应', NULL, NULL, 'TalentSupply', 'crud', 'com.ruoyi.data', 'data', 'talentSupply', '人才供应', 'ruoyi', '0', '/', NULL, 'admin', '2021-09-30 12:15:31', '', NULL, NULL);
INSERT INTO `gen_table` VALUES (46, 'technology_achievement', '技术成果', NULL, NULL, 'TechnologyAchievement', 'crud', 'com.ruoyi.data', 'data', 'technologyAchievement', '技术成果', 'ruoyi', '0', '/', NULL, 'admin', '2021-09-30 12:15:32', '', NULL, NULL);
INSERT INTO `gen_table` VALUES (47, 'technology_need', '技术需求', NULL, NULL, 'TechnologyNeed', 'crud', 'com.ruoyi.data', 'data', 'technologyNeed', '技术需求', 'ruoyi', '0', '/', NULL, 'admin', '2021-09-30 12:15:32', '', NULL, NULL);
INSERT INTO `gen_table` VALUES (48, 'user', '用户', NULL, NULL, 'User', 'crud', 'com.ruoyi.data', 'data', 'user', '用户', 'ruoyi', '0', '/', NULL, 'admin', '2021-09-30 12:15:33', '', NULL, NULL);
INSERT INTO `gen_table` VALUES (49, 'financial_product', '金融产品', NULL, NULL, 'FinancialProduct', 'crud', 'com.ruoyi.data', 'data', 'financialProduct', '金融产品', 'ruoyi', '0', '/', NULL, 'admin', '2021-09-30 12:16:20', '', NULL, NULL);
INSERT INTO `gen_table` VALUES (50, 'financing_need', '融资需求', NULL, NULL, 'FinancingNeed', 'crud', 'com.ruoyi.data', 'data', 'financingNeed', '融资需求', 'ruoyi', '0', '/', NULL, 'admin', '2021-09-30 12:16:20', '', NULL, NULL);
INSERT INTO `gen_table` VALUES (51, 'park', '科技园区', NULL, NULL, 'Park', 'crud', 'com.ruoyi.data', 'data', 'park', '科技园区', 'ruoyi', '0', '/', NULL, 'admin', '2021-09-30 12:16:21', '', NULL, NULL);
INSERT INTO `gen_table` VALUES (52, 'policy', '政策', NULL, NULL, 'Policy', 'crud', 'com.ruoyi.data', 'data', 'policy', '政策', 'ruoyi', '0', '/', NULL, 'admin', '2021-09-30 12:16:21', '', NULL, NULL);
INSERT INTO `gen_table` VALUES (53, 'school_info', '学校信息', NULL, NULL, 'SchoolInfo', 'crud', 'com.ruoyi.data', 'data', 'schoolInfo', '学校信息', 'ruoyi', '0', '/', NULL, 'admin', '2021-09-30 12:16:22', '', NULL, NULL);
INSERT INTO `gen_table` VALUES (54, 'service_product', '服务产品', NULL, NULL, 'ServiceProduct', 'crud', 'com.ruoyi.data', 'data', 'serviceProduct', '服务产品', 'ruoyi', '0', '/', NULL, 'admin', '2021-09-30 12:16:22', '', NULL, NULL);
INSERT INTO `gen_table` VALUES (55, 'consultation', '咨询', NULL, NULL, 'Consultation', 'crud', 'com.ruoyi.data', 'data', 'consultation', '咨询', 'ruoyi', '0', '/', NULL, 'admin', '2021-09-30 12:16:34', '', NULL, NULL);
INSERT INTO `gen_table` VALUES (56, 'all_index', '索引', NULL, NULL, 'AllIndex', 'crud', 'com.ruoyi.data', 'data', 'allIndex', '索引', 'ruoyi', '0', '/', NULL, 'admin', '2021-09-30 12:16:45', '', NULL, NULL);
INSERT INTO `gen_table` VALUES (57, 'news', '新闻', NULL, NULL, 'News', 'crud', 'com.ruoyi.data', 'data', 'news', '新闻', 'ruoyi', '0', '/', NULL, 'admin', '2022-02-17 11:48:39', '', NULL, NULL);

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column`  (
  `column_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `sort` int NULL DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 731 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '代码生成业务表字段' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------
INSERT INTO `gen_table_column` VALUES (550, '43', 'business_id', 'id', 'bigint', 'Long', 'businessId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2021-09-30 12:15:30', '', NULL);
INSERT INTO `gen_table_column` VALUES (551, '43', 'name', '名称', 'varchar(50)', 'String', 'name', '0', '0', NULL, '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2021-09-30 12:15:30', '', NULL);
INSERT INTO `gen_table_column` VALUES (552, '43', 'corporate', '法人', 'varchar(10)', 'String', 'corporate', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2021-09-30 12:15:30', '', NULL);
INSERT INTO `gen_table_column` VALUES (553, '43', 'type', '类型（1：有效期高企，2：培育库入库企业，3：当年申报企业）', 'tinyint', 'Long', 'type', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'select', '', 4, 'admin', '2021-09-30 12:15:30', '', NULL);
INSERT INTO `gen_table_column` VALUES (554, '43', 'manege_scope', '经营范围', 'varchar(20)', 'String', 'manegeScope', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2021-09-30 12:15:30', '', NULL);
INSERT INTO `gen_table_column` VALUES (555, '43', 'introduction', '简介', 'varchar(1000)', 'String', 'introduction', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'textarea', '', 6, 'admin', '2021-09-30 12:15:30', '', NULL);
INSERT INTO `gen_table_column` VALUES (556, '43', 'found_date', '成立日期', 'date', 'Date', 'foundDate', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'datetime', '', 7, 'admin', '2021-09-30 12:15:30', '', NULL);
INSERT INTO `gen_table_column` VALUES (557, '43', 'manege_deadline', '经营期限', 'date', 'Date', 'manegeDeadline', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'datetime', '', 8, 'admin', '2021-09-30 12:15:30', '', NULL);
INSERT INTO `gen_table_column` VALUES (558, '43', 'website', '网址', 'varchar(100)', 'String', 'website', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 9, 'admin', '2021-09-30 12:15:30', '', NULL);
INSERT INTO `gen_table_column` VALUES (559, '43', 'email', '邮箱', 'varchar(100)', 'String', 'email', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 10, 'admin', '2021-09-30 12:15:30', '', NULL);
INSERT INTO `gen_table_column` VALUES (560, '43', 'capital', '注册资本', 'varchar(20)', 'String', 'capital', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 11, 'admin', '2021-09-30 12:15:30', '', NULL);
INSERT INTO `gen_table_column` VALUES (561, '43', 'location', '位置（省市县）', 'varchar(20)', 'String', 'location', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 12, 'admin', '2021-09-30 12:15:30', '', NULL);
INSERT INTO `gen_table_column` VALUES (562, '43', 'address', '详细地址', 'varchar(100)', 'String', 'address', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 13, 'admin', '2021-09-30 12:15:30', '', NULL);
INSERT INTO `gen_table_column` VALUES (563, '43', 'code', '统一社会信用代码', 'varchar(100)', 'String', 'code', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 14, 'admin', '2021-09-30 12:15:30', '', NULL);
INSERT INTO `gen_table_column` VALUES (564, '43', 'telephone', '固定电话', 'varchar(30)', 'String', 'telephone', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 15, 'admin', '2021-09-30 12:15:31', '', NULL);
INSERT INTO `gen_table_column` VALUES (565, '43', 'contact_id', '联系人id', 'bigint', 'Long', 'contactId', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 16, 'admin', '2021-09-30 12:15:31', '', NULL);
INSERT INTO `gen_table_column` VALUES (566, '43', 'reg_office', '登记机关', 'varchar(100)', 'String', 'regOffice', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 17, 'admin', '2021-09-30 12:15:31', '', NULL);
INSERT INTO `gen_table_column` VALUES (567, '43', 'examine_date', '核准日期', 'date', 'Date', 'examineDate', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'datetime', '', 18, 'admin', '2021-09-30 12:15:31', '', NULL);
INSERT INTO `gen_table_column` VALUES (568, '43', 'image_url', '公司图片', 'varchar(200)', 'String', 'imageUrl', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 19, 'admin', '2021-09-30 12:15:31', '', NULL);
INSERT INTO `gen_table_column` VALUES (569, '43', 'examine_image', '审核所需资料', 'varchar(1000)', 'String', 'examineImage', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'imageUpload', '', 20, 'admin', '2021-09-30 12:15:31', '', NULL);
INSERT INTO `gen_table_column` VALUES (570, '43', 'user_id', '用户id', 'bigint', 'Long', 'userId', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 21, 'admin', '2021-09-30 12:15:31', '', NULL);
INSERT INTO `gen_table_column` VALUES (571, '43', 'status', '审核状态 [1：正在审核，2：审核通过，3：审核失败]', 'tinyint', 'Long', 'status', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'radio', '', 22, 'admin', '2021-09-30 12:15:31', '', NULL);
INSERT INTO `gen_table_column` VALUES (572, '44', 'talent_need_id', 'id', 'bigint', 'Long', 'talentNeedId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2021-09-30 12:15:31', '', NULL);
INSERT INTO `gen_table_column` VALUES (573, '44', 'position', '职位工作', 'text', 'String', 'position', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'textarea', '', 2, 'admin', '2021-09-30 12:15:31', '', NULL);
INSERT INTO `gen_table_column` VALUES (574, '44', 'publish_time', '发布时间', 'datetime', 'Date', 'publishTime', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'datetime', '', 3, 'admin', '2021-09-30 12:15:31', '', NULL);
INSERT INTO `gen_table_column` VALUES (575, '44', 'location', '位置（省市县）', 'text', 'String', 'location', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'textarea', '', 4, 'admin', '2021-09-30 12:15:31', '', NULL);
INSERT INTO `gen_table_column` VALUES (576, '44', 'address', '详细地址', 'varchar(100)', 'String', 'address', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2021-09-30 12:15:31', '', NULL);
INSERT INTO `gen_table_column` VALUES (577, '44', 'contact_id', '联系人id', 'bigint', 'Long', 'contactId', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 6, 'admin', '2021-09-30 12:15:31', '', NULL);
INSERT INTO `gen_table_column` VALUES (578, '44', 'job', '工作内容', 'varchar(1000)', 'String', 'job', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'textarea', '', 7, 'admin', '2021-09-30 12:15:31', '', NULL);
INSERT INTO `gen_table_column` VALUES (579, '44', 'demand', '职位要求', 'varchar(1000)', 'String', 'demand', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'textarea', '', 8, 'admin', '2021-09-30 12:15:31', '', NULL);
INSERT INTO `gen_table_column` VALUES (580, '44', 'image', '详情图片', 'varchar(200)', 'String', 'image', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'imageUpload', '', 9, 'admin', '2021-09-30 12:15:31', '', NULL);
INSERT INTO `gen_table_column` VALUES (581, '44', 'business_id', '企业id', 'bigint', 'Long', 'businessId', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 10, 'admin', '2021-09-30 12:15:31', '', NULL);
INSERT INTO `gen_table_column` VALUES (582, '44', 'education', '学历', 'varchar(100)', 'String', 'education', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 11, 'admin', '2021-09-30 12:15:31', '', NULL);
INSERT INTO `gen_table_column` VALUES (583, '45', 'talent_supply_id', 'id', 'bigint', 'Long', 'talentSupplyId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2021-09-30 12:15:31', '', NULL);
INSERT INTO `gen_table_column` VALUES (584, '45', 'publish_time', '发布时间', 'datetime', 'Date', 'publishTime', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'datetime', '', 2, 'admin', '2021-09-30 12:15:31', '', NULL);
INSERT INTO `gen_table_column` VALUES (585, '45', 'name', '姓名', 'varchar(50)', 'String', 'name', '0', '0', NULL, '1', '1', '1', '1', 'LIKE', 'input', '', 3, 'admin', '2021-09-30 12:15:31', '', NULL);
INSERT INTO `gen_table_column` VALUES (586, '45', 'image', '照片', 'varchar(200)', 'String', 'image', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'imageUpload', '', 4, 'admin', '2021-09-30 12:15:31', '', NULL);
INSERT INTO `gen_table_column` VALUES (587, '45', 'age', '年龄', 'int', 'Long', 'age', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2021-09-30 12:15:31', '', NULL);
INSERT INTO `gen_table_column` VALUES (588, '45', 'profession', '专业', 'varchar(20)', 'String', 'profession', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 6, 'admin', '2021-09-30 12:15:31', '', NULL);
INSERT INTO `gen_table_column` VALUES (589, '45', 'gender', '性别 [1:男，2：女]', 'tinyint', 'Long', 'gender', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 7, 'admin', '2021-09-30 12:15:32', '', NULL);
INSERT INTO `gen_table_column` VALUES (590, '45', 'job', '求职意向', 'varchar(20)', 'String', 'job', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 8, 'admin', '2021-09-30 12:15:32', '', NULL);
INSERT INTO `gen_table_column` VALUES (591, '45', 'contact_id', '联系人id', 'bigint', 'Long', 'contactId', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 9, 'admin', '2021-09-30 12:15:32', '', NULL);
INSERT INTO `gen_table_column` VALUES (592, '45', 'skill', '专业技能', 'mediumtext', 'String', 'skill', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'textarea', '', 10, 'admin', '2021-09-30 12:15:32', '', NULL);
INSERT INTO `gen_table_column` VALUES (593, '45', 'experience', '个人经历', 'varchar(1000)', 'String', 'experience', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'textarea', '', 11, 'admin', '2021-09-30 12:15:32', '', NULL);
INSERT INTO `gen_table_column` VALUES (594, '45', 'enter_date', '入学时间', 'date', 'Date', 'enterDate', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'datetime', '', 12, 'admin', '2021-09-30 12:15:32', '', NULL);
INSERT INTO `gen_table_column` VALUES (595, '45', 'graduate_date', '毕业时间', 'date', 'Date', 'graduateDate', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'datetime', '', 13, 'admin', '2021-09-30 12:15:32', '', NULL);
INSERT INTO `gen_table_column` VALUES (596, '45', 'school_id', '学校id', 'bigint', 'Long', 'schoolId', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 14, 'admin', '2021-09-30 12:15:32', '', NULL);
INSERT INTO `gen_table_column` VALUES (597, '45', 'resume_url', '上传简历', 'varchar(200)', 'String', 'resumeUrl', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 15, 'admin', '2021-09-30 12:15:32', '', NULL);
INSERT INTO `gen_table_column` VALUES (598, '46', 'technology_achievement_id', 'id', 'bigint', 'Long', 'technologyAchievementId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2021-09-30 12:15:32', '', NULL);
INSERT INTO `gen_table_column` VALUES (599, '46', 'title', '标题', 'varchar(50)', 'String', 'title', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2021-09-30 12:15:32', '', NULL);
INSERT INTO `gen_table_column` VALUES (600, '46', 'publish_time', '发布时间', 'datetime', 'Date', 'publishTime', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'datetime', '', 3, 'admin', '2021-09-30 12:15:32', '', NULL);
INSERT INTO `gen_table_column` VALUES (601, '46', 'category', '分类', 'varchar(20)', 'String', 'category', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2021-09-30 12:15:32', '', NULL);
INSERT INTO `gen_table_column` VALUES (602, '46', 'website', '网址', 'varchar(100)', 'String', 'website', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2021-09-30 12:15:32', '', NULL);
INSERT INTO `gen_table_column` VALUES (603, '46', 'description', '描述', 'varchar(1000)', 'String', 'description', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'textarea', '', 6, 'admin', '2021-09-30 12:15:32', '', NULL);
INSERT INTO `gen_table_column` VALUES (604, '46', 'field', '行业领域', 'varchar(20)', 'String', 'field', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 7, 'admin', '2021-09-30 12:15:32', '', NULL);
INSERT INTO `gen_table_column` VALUES (605, '46', 'image', '详情图片', 'varchar(1000)', 'String', 'image', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'imageUpload', '', 8, 'admin', '2021-09-30 12:15:32', '', NULL);
INSERT INTO `gen_table_column` VALUES (606, '46', 'contact_id', '联系人id', 'bigint', 'Long', 'contactId', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 9, 'admin', '2021-09-30 12:15:32', '', NULL);
INSERT INTO `gen_table_column` VALUES (607, '46', 'publisher_type', '发布者类型 [1：高新企业，3：学校]', 'tinyint', 'Long', 'publisherType', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'select', '', 10, 'admin', '2021-09-30 12:15:32', '', NULL);
INSERT INTO `gen_table_column` VALUES (608, '46', 'publisher_id', '企业或者学校id，根据发布者类型判断', 'bigint', 'Long', 'publisherId', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 11, 'admin', '2021-09-30 12:15:32', '', NULL);
INSERT INTO `gen_table_column` VALUES (609, '47', 'technology_need_id', 'id', 'bigint', 'Long', 'technologyNeedId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2021-09-30 12:15:32', '', NULL);
INSERT INTO `gen_table_column` VALUES (610, '47', 'title', '标题', 'varchar(50)', 'String', 'title', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2021-09-30 12:15:32', '', NULL);
INSERT INTO `gen_table_column` VALUES (611, '47', 'publish_time', '发布时间', 'datetime', 'Date', 'publishTime', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'datetime', '', 3, 'admin', '2021-09-30 12:15:32', '', NULL);
INSERT INTO `gen_table_column` VALUES (612, '47', 'description', '描述', 'varchar(1000)', 'String', 'description', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'textarea', '', 4, 'admin', '2021-09-30 12:15:32', '', NULL);
INSERT INTO `gen_table_column` VALUES (613, '47', 'category', '分类', 'varchar(20)', 'String', 'category', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2021-09-30 12:15:32', '', NULL);
INSERT INTO `gen_table_column` VALUES (614, '47', 'field', '行业领域', 'varchar(20)', 'String', 'field', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 6, 'admin', '2021-09-30 12:15:32', '', NULL);
INSERT INTO `gen_table_column` VALUES (615, '47', 'image', '详情图片', 'varchar(1000)', 'String', 'image', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'imageUpload', '', 7, 'admin', '2021-09-30 12:15:33', '', NULL);
INSERT INTO `gen_table_column` VALUES (616, '47', 'contact_id', '联系人id', 'bigint', 'Long', 'contactId', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 8, 'admin', '2021-09-30 12:15:33', '', NULL);
INSERT INTO `gen_table_column` VALUES (617, '47', 'business_id', '企业id', 'bigint', 'Long', 'businessId', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 9, 'admin', '2021-09-30 12:15:33', '', NULL);
INSERT INTO `gen_table_column` VALUES (618, '47', 'contact_name', '联系人姓名', 'varchar(20)', 'String', 'contactName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 10, 'admin', '2021-09-30 12:15:33', '', NULL);
INSERT INTO `gen_table_column` VALUES (619, '47', 'contact_phone', '联系人电话', 'varchar(30)', 'String', 'contactPhone', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 11, 'admin', '2021-09-30 12:15:33', '', NULL);
INSERT INTO `gen_table_column` VALUES (620, '47', 'contact_email', '联系人邮箱', 'varchar(50)', 'String', 'contactEmail', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 12, 'admin', '2021-09-30 12:15:33', '', NULL);
INSERT INTO `gen_table_column` VALUES (621, '48', 'user_id', '用户id', 'bigint', 'Long', 'userId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2021-09-30 12:15:33', '', NULL);
INSERT INTO `gen_table_column` VALUES (622, '48', 'username', '昵称', 'varchar(10)', 'String', 'username', '0', '0', NULL, '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2021-09-30 12:15:33', '', NULL);
INSERT INTO `gen_table_column` VALUES (623, '48', 'password', '密码', 'varchar(100)', 'String', 'password', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2021-09-30 12:15:33', '', NULL);
INSERT INTO `gen_table_column` VALUES (624, '48', 'real_name', '真实姓名', 'varchar(10)', 'String', 'realName', '0', '0', NULL, '1', '1', '1', '1', 'LIKE', 'input', '', 4, 'admin', '2021-09-30 12:15:33', '', NULL);
INSERT INTO `gen_table_column` VALUES (625, '48', 'gender', '性别 [1:男，2：女]', 'tinyint', 'Long', 'gender', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2021-09-30 12:15:33', '', NULL);
INSERT INTO `gen_table_column` VALUES (626, '48', 'location', '位置（省市县）', 'varchar(20)', 'String', 'location', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 6, 'admin', '2021-09-30 12:15:33', '', NULL);
INSERT INTO `gen_table_column` VALUES (627, '48', 'address', '地址', 'varchar(100)', 'String', 'address', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 7, 'admin', '2021-09-30 12:15:33', '', NULL);
INSERT INTO `gen_table_column` VALUES (628, '48', 'phone', '手机号', 'varchar(11)', 'String', 'phone', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 8, 'admin', '2021-09-30 12:15:33', '', NULL);
INSERT INTO `gen_table_column` VALUES (629, '48', 'email', '电子邮箱', 'varchar(50)', 'String', 'email', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 9, 'admin', '2021-09-30 12:15:33', '', NULL);
INSERT INTO `gen_table_column` VALUES (630, '48', 'type', '用户类型（0:未认定用户，1：高新企业，2：科技主管部门，3：学校，4：金融机构，5：服务机构）', 'tinyint', 'Long', 'type', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'select', '', 10, 'admin', '2021-09-30 12:15:33', '', NULL);
INSERT INTO `gen_table_column` VALUES (631, '48', 'status', '审核状态（0:未认定，1：正在审核，2：审核通过）', 'tinyint', 'Long', 'status', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'radio', '', 11, 'admin', '2021-09-30 12:15:33', '', NULL);
INSERT INTO `gen_table_column` VALUES (632, '48', 'token', 'token', 'varchar(50)', 'String', 'token', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 12, 'admin', '2021-09-30 12:15:33', '', NULL);
INSERT INTO `gen_table_column` VALUES (633, '48', 'gmt_create', NULL, 'datetime', 'Date', 'gmtCreate', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'datetime', '', 13, 'admin', '2021-09-30 12:15:33', '', NULL);
INSERT INTO `gen_table_column` VALUES (634, '48', 'gmt_modified', NULL, 'datetime', 'Date', 'gmtModified', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'datetime', '', 14, 'admin', '2021-09-30 12:15:33', '', NULL);
INSERT INTO `gen_table_column` VALUES (635, '48', 'deleted', NULL, 'tinyint', 'Long', 'deleted', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 15, 'admin', '2021-09-30 12:15:33', '', NULL);
INSERT INTO `gen_table_column` VALUES (636, '49', 'financial_product_id', 'id', 'bigint', 'Long', 'financialProductId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2021-09-30 12:16:20', '', NULL);
INSERT INTO `gen_table_column` VALUES (637, '49', 'title', '产品名称', 'varchar(50)', 'String', 'title', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2021-09-30 12:16:20', '', NULL);
INSERT INTO `gen_table_column` VALUES (638, '49', 'publish_time', '发布时间', 'datetime', 'Date', 'publishTime', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'datetime', '', 3, 'admin', '2021-09-30 12:16:20', '', NULL);
INSERT INTO `gen_table_column` VALUES (639, '49', 'description', '产品描述', 'mediumtext', 'String', 'description', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'textarea', '', 4, 'admin', '2021-09-30 12:16:20', '', NULL);
INSERT INTO `gen_table_column` VALUES (640, '49', 'image', '详情图片', 'varchar(1000)', 'String', 'image', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'imageUpload', '', 5, 'admin', '2021-09-30 12:16:20', '', NULL);
INSERT INTO `gen_table_column` VALUES (641, '49', 'rate', '利率范围 （1%-2%）', 'varchar(20)', 'String', 'rate', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 6, 'admin', '2021-09-30 12:16:20', '', NULL);
INSERT INTO `gen_table_column` VALUES (642, '49', 'loan_money', '担保额度', 'varchar(20)', 'String', 'loanMoney', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 7, 'admin', '2021-09-30 12:16:20', '', NULL);
INSERT INTO `gen_table_column` VALUES (643, '49', 'ensure_method', '担保方式', 'varchar(20)', 'String', 'ensureMethod', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 8, 'admin', '2021-09-30 12:16:20', '', NULL);
INSERT INTO `gen_table_column` VALUES (644, '49', 'loan_deadline', '贷款期限', 'varchar(20)', 'String', 'loanDeadline', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 9, 'admin', '2021-09-30 12:16:20', '', NULL);
INSERT INTO `gen_table_column` VALUES (645, '49', 'apply_condition', '申请条件', 'varchar(1000)', 'String', 'applyCondition', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'textarea', '', 10, 'admin', '2021-09-30 12:16:20', '', NULL);
INSERT INTO `gen_table_column` VALUES (646, '49', 'contact_id', '联系人id', 'bigint', 'Long', 'contactId', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 11, 'admin', '2021-09-30 12:16:20', '', NULL);
INSERT INTO `gen_table_column` VALUES (647, '49', 'financial_institution_id', '金融机构id', 'bigint', 'Long', 'financialInstitutionId', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 12, 'admin', '2021-09-30 12:16:20', '', NULL);
INSERT INTO `gen_table_column` VALUES (648, '50', 'financing_need_id', 'id', 'bigint', 'Long', 'financingNeedId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2021-09-30 12:16:20', '', NULL);
INSERT INTO `gen_table_column` VALUES (649, '50', 'title', '项目名称', 'varchar(50)', 'String', 'title', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2021-09-30 12:16:20', '', NULL);
INSERT INTO `gen_table_column` VALUES (650, '50', 'publish_time', '发布时间', 'datetime', 'Date', 'publishTime', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'datetime', '', 3, 'admin', '2021-09-30 12:16:20', '', NULL);
INSERT INTO `gen_table_column` VALUES (651, '50', 'project_description', '项目描述', 'varchar(1000)', 'String', 'projectDescription', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'textarea', '', 4, 'admin', '2021-09-30 12:16:20', '', NULL);
INSERT INTO `gen_table_column` VALUES (652, '50', 'field', '行业领域', 'varchar(20)', 'String', 'field', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2021-09-30 12:16:20', '', NULL);
INSERT INTO `gen_table_column` VALUES (653, '50', 'project_image', '项目详情图片', 'varchar(1000)', 'String', 'projectImage', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'imageUpload', '', 6, 'admin', '2021-09-30 12:16:20', '', NULL);
INSERT INTO `gen_table_column` VALUES (654, '50', 'team_introduction', '团队介绍', 'varchar(1000)', 'String', 'teamIntroduction', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'textarea', '', 7, 'admin', '2021-09-30 12:16:21', '', NULL);
INSERT INTO `gen_table_column` VALUES (655, '50', 'financing_introduction', '融资介绍', 'varchar(1000)', 'String', 'financingIntroduction', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'textarea', '', 8, 'admin', '2021-09-30 12:16:21', '', NULL);
INSERT INTO `gen_table_column` VALUES (656, '50', 'financing_money', '融资金额', 'varchar(20)', 'String', 'financingMoney', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 9, 'admin', '2021-09-30 12:16:21', '', NULL);
INSERT INTO `gen_table_column` VALUES (657, '50', 'financing_method', '融资方式', 'varchar(20)', 'String', 'financingMethod', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 10, 'admin', '2021-09-30 12:16:21', '', NULL);
INSERT INTO `gen_table_column` VALUES (658, '50', 'financing_phase', '融资阶段', 'varchar(20)', 'String', 'financingPhase', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 11, 'admin', '2021-09-30 12:16:21', '', NULL);
INSERT INTO `gen_table_column` VALUES (659, '50', 'contact_id', '联系人id', 'bigint', 'Long', 'contactId', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 12, 'admin', '2021-09-30 12:16:21', '', NULL);
INSERT INTO `gen_table_column` VALUES (660, '50', 'business_id', '企业id', 'bigint', 'Long', 'businessId', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 13, 'admin', '2021-09-30 12:16:21', '', NULL);
INSERT INTO `gen_table_column` VALUES (661, '51', 'park_id', '园区id', 'int', 'Long', 'parkId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2021-09-30 12:16:21', '', NULL);
INSERT INTO `gen_table_column` VALUES (662, '51', 'park_name', '园区名称', 'varchar(50)', 'String', 'parkName', '0', '0', NULL, '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2021-09-30 12:16:21', '', NULL);
INSERT INTO `gen_table_column` VALUES (663, '51', 'park_image_url', '园区图片url', 'varchar(1000)', 'String', 'parkImageUrl', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'textarea', '', 3, 'admin', '2021-09-30 12:16:21', '', NULL);
INSERT INTO `gen_table_column` VALUES (664, '51', 'park_phone', '园区电话', 'varchar(50)', 'String', 'parkPhone', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2021-09-30 12:16:21', '', NULL);
INSERT INTO `gen_table_column` VALUES (665, '51', 'park_website', '园区网址', 'varchar(100)', 'String', 'parkWebsite', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2021-09-30 12:16:21', '', NULL);
INSERT INTO `gen_table_column` VALUES (666, '51', 'park_introduction', '园区简介', 'text', 'String', 'parkIntroduction', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'textarea', '', 6, 'admin', '2021-09-30 12:16:21', '', NULL);
INSERT INTO `gen_table_column` VALUES (667, '51', 'avatar', '园区头像', 'varchar(200)', 'String', 'avatar', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 7, 'admin', '2021-09-30 12:16:21', '', NULL);
INSERT INTO `gen_table_column` VALUES (668, '51', 'park_supporting', '配套设施', 'text', 'String', 'parkSupporting', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'textarea', '', 8, 'admin', '2021-09-30 12:16:21', '', NULL);
INSERT INTO `gen_table_column` VALUES (669, '51', 'favoured_policy', '优惠政策', 'text', 'String', 'favouredPolicy', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'textarea', '', 9, 'admin', '2021-09-30 12:16:21', '', NULL);
INSERT INTO `gen_table_column` VALUES (670, '51', 'product_positioning', '产品定位', 'text', 'String', 'productPositioning', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'textarea', '', 10, 'admin', '2021-09-30 12:16:21', '', NULL);
INSERT INTO `gen_table_column` VALUES (671, '51', 'key_points', '招商重点', 'text', 'String', 'keyPoints', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'textarea', '', 11, 'admin', '2021-09-30 12:16:21', '', NULL);
INSERT INTO `gen_table_column` VALUES (672, '52', 'policy_id', 'id', 'bigint', 'Long', 'policyId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2021-09-30 12:16:21', '', NULL);
INSERT INTO `gen_table_column` VALUES (673, '52', 'title', '标题', 'varchar(50)', 'String', 'title', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2021-09-30 12:16:21', '', NULL);
INSERT INTO `gen_table_column` VALUES (674, '52', 'publish_time', '发布时间', 'datetime', 'Date', 'publishTime', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'datetime', '', 3, 'admin', '2021-09-30 12:16:21', '', NULL);
INSERT INTO `gen_table_column` VALUES (675, '52', 'number', '文号', 'varchar(50)', 'String', 'number', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2021-09-30 12:16:21', '', NULL);
INSERT INTO `gen_table_column` VALUES (676, '52', 'category', '分类', 'varchar(20)', 'String', 'category', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2021-09-30 12:16:21', '', NULL);
INSERT INTO `gen_table_column` VALUES (677, '52', 'content', '内容', 'text', 'String', 'content', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'editor', '', 6, 'admin', '2021-09-30 12:16:21', '', NULL);
INSERT INTO `gen_table_column` VALUES (678, '52', 'link', '链接', 'varchar(200)', 'String', 'link', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 7, 'admin', '2021-09-30 12:16:21', '', NULL);
INSERT INTO `gen_table_column` VALUES (679, '52', 'image', '详情图片', 'varchar(1000)', 'String', 'image', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'imageUpload', '', 8, 'admin', '2021-09-30 12:16:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (680, '52', 'addition', '附件', 'varchar(200)', 'String', 'addition', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 9, 'admin', '2021-09-30 12:16:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (681, '52', 'user_id', '用户id', 'bigint', 'Long', 'userId', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 10, 'admin', '2021-09-30 12:16:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (682, '52', 'gmt_create', NULL, 'datetime', 'Date', 'gmtCreate', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'datetime', '', 11, 'admin', '2021-09-30 12:16:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (683, '52', 'gmt_modified', NULL, 'datetime', 'Date', 'gmtModified', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'datetime', '', 12, 'admin', '2021-09-30 12:16:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (684, '52', 'deleted', NULL, 'tinyint', 'Long', 'deleted', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 13, 'admin', '2021-09-30 12:16:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (685, '53', 'school_id', 'id', 'bigint', 'Long', 'schoolId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2021-09-30 12:16:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (686, '53', 'name', '名称', 'varchar(50)', 'String', 'name', '0', '0', NULL, '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2021-09-30 12:16:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (687, '53', 'website', '网址', 'varchar(100)', 'String', 'website', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2021-09-30 12:16:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (688, '53', 'location', '位置（省市县）', 'varchar(20)', 'String', 'location', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2021-09-30 12:16:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (689, '53', 'address', '详细地址', 'varchar(100)', 'String', 'address', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2021-09-30 12:16:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (690, '53', 'code', '统一社会信用代码', 'varchar(100)', 'String', 'code', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 6, 'admin', '2021-09-30 12:16:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (691, '53', 'telephone', '固定电话', 'varchar(11)', 'String', 'telephone', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 7, 'admin', '2021-09-30 12:16:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (692, '53', 'email', '邮箱', 'varchar(100)', 'String', 'email', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 8, 'admin', '2021-09-30 12:16:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (693, '53', 'contact_id', '联系人id', 'bigint', 'Long', 'contactId', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 9, 'admin', '2021-09-30 12:16:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (694, '53', 'image_url', '学校图片', 'varchar(200)', 'String', 'imageUrl', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 10, 'admin', '2021-09-30 12:16:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (695, '53', 'examine_image', '审核所需资料', 'varchar(1000)', 'String', 'examineImage', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'imageUpload', '', 11, 'admin', '2021-09-30 12:16:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (696, '53', 'user_id', '用户id', 'bigint', 'Long', 'userId', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 12, 'admin', '2021-09-30 12:16:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (697, '53', 'status', '审核状态 [1：正在审核，2：审核通过，3：审核失败]', 'tinyint', 'Long', 'status', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'radio', '', 13, 'admin', '2021-09-30 12:16:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (698, '54', 'service_product_id', 'id', 'bigint', 'Long', 'serviceProductId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2021-09-30 12:16:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (699, '54', 'title', '产品名称', 'varchar(50)', 'String', 'title', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2021-09-30 12:16:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (700, '54', 'publish_time', '发布时间', 'datetime', 'Date', 'publishTime', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'datetime', '', 3, 'admin', '2021-09-30 12:16:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (701, '54', 'description', '产品描述', 'varchar(1000)', 'String', 'description', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'textarea', '', 4, 'admin', '2021-09-30 12:16:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (702, '54', 'service_type', '服务类型', 'varchar(20)', 'String', 'serviceType', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'select', '', 5, 'admin', '2021-09-30 12:16:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (703, '54', 'image', '详情图片', 'varchar(1000)', 'String', 'image', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'imageUpload', '', 6, 'admin', '2021-09-30 12:16:22', '', NULL);
INSERT INTO `gen_table_column` VALUES (704, '54', 'contact_id', '联系人id', 'bigint', 'Long', 'contactId', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 7, 'admin', '2021-09-30 12:16:23', '', NULL);
INSERT INTO `gen_table_column` VALUES (705, '54', 'service_institution_id', '服务机构id', 'bigint', 'Long', 'serviceInstitutionId', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 8, 'admin', '2021-09-30 12:16:23', '', NULL);
INSERT INTO `gen_table_column` VALUES (706, '55', 'id', NULL, 'bigint', 'Long', 'id', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2021-09-30 12:16:34', '', NULL);
INSERT INTO `gen_table_column` VALUES (707, '55', 'user_id', '用户id', 'bigint', 'Long', 'userId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2021-09-30 12:16:34', '', NULL);
INSERT INTO `gen_table_column` VALUES (708, '55', 'category', '咨询内容类型（1：申报政策 2：金融政策 3：科技服务 4：人才政策 5：科技园区 6：其他）', 'varchar(20)', 'String', 'category', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2021-09-30 12:16:34', '', NULL);
INSERT INTO `gen_table_column` VALUES (709, '55', 'content', '咨询内容', 'text', 'String', 'content', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'editor', '', 4, 'admin', '2021-09-30 12:16:34', '', NULL);
INSERT INTO `gen_table_column` VALUES (710, '55', 'email', '邮箱', 'varchar(100)', 'String', 'email', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2021-09-30 12:16:34', '', NULL);
INSERT INTO `gen_table_column` VALUES (711, '55', 'phone', '联系电话', 'varchar(11)', 'String', 'phone', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 6, 'admin', '2021-09-30 12:16:34', '', NULL);
INSERT INTO `gen_table_column` VALUES (712, '55', 'parent_id', '回复信息对应的咨询信息的id（咨询信息的parent_id为0）\n', 'bigint', 'Long', 'parentId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 7, 'admin', '2021-09-30 12:16:34', '', NULL);
INSERT INTO `gen_table_column` VALUES (713, '55', 'publish_time', '发布时间', 'datetime', 'Date', 'publishTime', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'datetime', '', 8, 'admin', '2021-09-30 12:16:34', '', NULL);
INSERT INTO `gen_table_column` VALUES (714, '55', 'is_read', '是否已读（0：未读 1：已读）', 'tinyint', 'Long', 'isRead', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 9, 'admin', '2021-09-30 12:16:34', '', NULL);
INSERT INTO `gen_table_column` VALUES (715, '56', 'id', NULL, 'bigint', 'Long', 'id', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2021-09-30 12:16:45', '', NULL);
INSERT INTO `gen_table_column` VALUES (716, '56', 'type', NULL, 'varchar(20)', 'String', 'type', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'select', '', 2, 'admin', '2021-09-30 12:16:45', '', NULL);
INSERT INTO `gen_table_column` VALUES (717, '56', 'name', NULL, 'varchar(50)', 'String', 'name', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 3, 'admin', '2021-09-30 12:16:45', '', NULL);
INSERT INTO `gen_table_column` VALUES (718, '56', 'sort', NULL, 'int', 'Long', 'sort', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2021-09-30 12:16:45', '', NULL);
INSERT INTO `gen_table_column` VALUES (719, '56', 'gmt_create', NULL, 'datetime', 'Date', 'gmtCreate', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'datetime', '', 5, 'admin', '2021-09-30 12:16:45', '', NULL);
INSERT INTO `gen_table_column` VALUES (720, '56', 'gmt_modified', NULL, 'datetime', 'Date', 'gmtModified', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'datetime', '', 6, 'admin', '2021-09-30 12:16:45', '', NULL);
INSERT INTO `gen_table_column` VALUES (721, '56', 'deleted', NULL, 'tinyint', 'Long', 'deleted', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 7, 'admin', '2021-09-30 12:16:45', '', NULL);
INSERT INTO `gen_table_column` VALUES (722, '56', 'parent_id', NULL, 'bigint', 'Long', 'parentId', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 8, 'admin', '2021-09-30 12:16:45', '', NULL);
INSERT INTO `gen_table_column` VALUES (723, '57', 'id', NULL, 'bigint', 'Long', 'id', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2022-02-17 11:48:39', '', NULL);
INSERT INTO `gen_table_column` VALUES (724, '57', 'title', '标题', 'varchar(100)', 'String', 'title', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2022-02-17 11:48:39', '', NULL);
INSERT INTO `gen_table_column` VALUES (725, '57', 'content', '内容\n', 'text', 'String', 'content', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'editor', '', 3, 'admin', '2022-02-17 11:48:39', '', NULL);
INSERT INTO `gen_table_column` VALUES (726, '57', 'link', '原文链接', 'varchar(200)', 'String', 'link', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2022-02-17 11:48:39', '', NULL);
INSERT INTO `gen_table_column` VALUES (727, '57', 'publish_time', '发布日期', 'datetime', 'Date', 'publishTime', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'datetime', '', 5, 'admin', '2022-02-17 11:48:39', '', NULL);
INSERT INTO `gen_table_column` VALUES (728, '57', 'gmt_create', NULL, 'datetime', 'Date', 'gmtCreate', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'datetime', '', 6, 'admin', '2022-02-17 11:48:39', '', NULL);
INSERT INTO `gen_table_column` VALUES (729, '57', 'gmt_modified', NULL, 'datetime', 'Date', 'gmtModified', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'datetime', '', 7, 'admin', '2022-02-17 11:48:39', '', NULL);
INSERT INTO `gen_table_column` VALUES (730, '57', 'deleted', NULL, 'tinyint', 'Long', 'deleted', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 8, 'admin', '2022-02-17 11:48:39', '', NULL);

-- ----------------------------
-- Table structure for invest_field_index
-- ----------------------------
DROP TABLE IF EXISTS `invest_field_index`;
CREATE TABLE `invest_field_index`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '投资领域检索' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of invest_field_index
-- ----------------------------
INSERT INTO `invest_field_index` VALUES (1, '现代物流');
INSERT INTO `invest_field_index` VALUES (2, '新型服务');
INSERT INTO `invest_field_index` VALUES (3, '文化教育');
INSERT INTO `invest_field_index` VALUES (4, '大数据');
INSERT INTO `invest_field_index` VALUES (5, '新材料');
INSERT INTO `invest_field_index` VALUES (6, '新能源');
INSERT INTO `invest_field_index` VALUES (7, '高端制备');
INSERT INTO `invest_field_index` VALUES (8, '智能制造');
INSERT INTO `invest_field_index` VALUES (9, '农林牧鱼');
INSERT INTO `invest_field_index` VALUES (10, '电子商务');

-- ----------------------------
-- Table structure for invest_money_index
-- ----------------------------
DROP TABLE IF EXISTS `invest_money_index`;
CREATE TABLE `invest_money_index`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '投资金额检索' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of invest_money_index
-- ----------------------------
INSERT INTO `invest_money_index` VALUES (1, '50万以内');
INSERT INTO `invest_money_index` VALUES (2, '50-100万');
INSERT INTO `invest_money_index` VALUES (3, '100-500万');
INSERT INTO `invest_money_index` VALUES (4, '500-1000万');
INSERT INTO `invest_money_index` VALUES (5, '1000-5000万');
INSERT INTO `invest_money_index` VALUES (6, '5000万以上');

-- ----------------------------
-- Table structure for loan_deadline_index
-- ----------------------------
DROP TABLE IF EXISTS `loan_deadline_index`;
CREATE TABLE `loan_deadline_index`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '贷款期限检索' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of loan_deadline_index
-- ----------------------------
INSERT INTO `loan_deadline_index` VALUES (1, '3个月及以下');
INSERT INTO `loan_deadline_index` VALUES (2, '6个月及以下');
INSERT INTO `loan_deadline_index` VALUES (3, '12个月及以下');
INSERT INTO `loan_deadline_index` VALUES (4, '36个月及以下');
INSERT INTO `loan_deadline_index` VALUES (5, '36个月以上');

-- ----------------------------
-- Table structure for news
-- ----------------------------
DROP TABLE IF EXISTS `news`;
CREATE TABLE `news`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标题',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '内容\n',
  `link` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '原文链接',
  `publish_time` datetime NULL DEFAULT NULL COMMENT '发布日期',
  `gmt_create` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `gmt_modified` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` tinyint NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '新闻' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of news
-- ----------------------------
INSERT INTO `news` VALUES (4, '“跨国企业海南行”系列活动启动\r\n', '本报海口1月17日讯(记者 陈雪怡)1月17日，“跨国企业海南行”系列活动在海口拉开帷幕。由30多位知名跨国企业相关负责人组成的代表团，将通过参加专题推介会、考察重点园区等形式，深入了解海南自由贸易港政策优势和发展新机遇。\r\n\r\n“经梳理得出，钻石珠宝首饰加工制造、香化产品加工制造等行业可以形成‘前店后厂’模式，今天与会的爱特思集团、雀巢、宝洁等企业，相对应涉及高端服装、健康食品、家化产品等产业，可以充分把握海南自贸港‘保税加工+离岛免税’政策，拓展更大发展空间……”在17日下午举行的“跨国企业海南行”海南自贸港专题推介交流座谈会上，海南相关职能部门不仅介绍自贸港政策优势、建设进展、产业体系等，还为与会企业“量身定制”投资方案，吸引企业参与海南自贸港建设。\r\n\r\n17日上午，代表团一行还考察了海口国家高新区美安生态科技新城。“第一天行程的收获便超出预期。”雀巢大中华区集团事务及可持续发展副总裁方军涛说，“海南相关职能部门想在我们前面，根据企业所属行业领域‘匹配’相关政策措施，定制‘专属’投资方案。”\r\n\r\n中国发展研究基金会副理事长兼秘书长方晋表示，“跨国企业海南行”系列活动通过组织专题推介会、考察重点园区等形式，将让企业深入了解海南自贸港政策、建设进展和成效等，助力企业参与自贸港建设，也为跨国企业在海南、在中国更好发展提供新机遇。', 'https://www.hainan.gov.cn/hainan/5309/202201/d78567d830d14eb983aaa2143178ce96.shtml', '2022-01-18 00:00:00', NULL, NULL, NULL);
INSERT INTO `news` VALUES (5, '人大代表议案建议持续转化为促发展、惠民生的政策措施 推动海南自贸港建设行稳致远', '人大代表议案建议持续转化为促发展、惠民生的政策措施，推动海南自贸港建设行稳致远——\r\n为人民群众鼓与呼\r\n\r\n海南日报记者 易宗平\r\n\r\n2021年，省人大常委会全面贯彻落实中央人大工作会议精神，按照推动代表议案建议实现“内容高质量、办理高质量”和“既要重结果、也要重过程”的要求，不仅在十三届全国人大四次会议上大力协助海南代表团提出高质量议案建议，还采取了多种措施加大代表议案建议督办力度，确保省六届人大四次会议代表议案建议工作接地气、察民情、聚民智、惠民生，更好地践行以人民为中心的发展思想，更好地服务海南自贸港建设。\r\n\r\n全国人大采纳海南多项议案建议\r\n\r\n“现在不砍树了，热带雨林腹地的居民逐渐退场搬迁出来，小水电等也退出来，给海南长臂猿等珍稀物种留下更多空间。”1月17日，多年前曾在雨林里当过伐木工的护林员陈学波感慨地说。\r\n\r\n改变背后的动因是什么?\r\n\r\n2021年3月，在十三届全国人大四次会议上，海南代表团提出了关于保护海南热带雨林的建议，即关于妥善解决海南热带雨林国家公园中商品林及小水电退出等建议，得到国家有关部委高度重视和采纳实施。\r\n\r\n据了解，在十三届全国人大四次会议上，海南代表团共提出5件议案、40件建议，均被大会采纳。\r\n\r\n省人大常委会有关负责人介绍，《中华人民共和国海南自由贸易港法(草案)》完成一审后，省人大常委会主动担当作为，就法律草案深入调研、征集意见，多方面、多渠道加强立法沟通，反映海南诉求，为全国人大常委会高质高效完成该法律二审、三审发挥了积极作用，共有10条建议被采纳。\r\n\r\n加大人大代表议案建议督办力度\r\n\r\n省委书记、省人大常委会主任沈晓明高度重视代表建议办理工作，批示对许巧练代表提出的《关于解决农垦居深化改革中存在问题的建议》进行重点督办，要求认真研究并反馈代表。在省委、省政府领导的关心推动下，我省印发了《农垦居工作人员薪酬待遇指导意见》。目前，18个市县出台了相关方案，各居工作人员的薪酬待遇大幅度提高。省民政厅对建议中提到的相关问题深入研究后，逐条详细答复代表。\r\n\r\n不仅是有关“居”的问题得到有效解决，有关改善营商环境的议案也得到落实。\r\n\r\n为高质量做好海南省第六届运动会保障工作而催生出的“儋州速度”，最近引发不少网友点赞。\r\n\r\n位于儋州市那大镇的运动员公寓4栋18层楼房、3栋17层楼房、1栋15层楼房和1栋14层楼房，现已全部封顶，提前完成预期任务。\r\n\r\n该运动员公寓项目为何跑出“加速度”?“运动员公寓项目采取‘拿地即开工’的运行模式，在一定程度上抢占了先机。”该建设工地有关负责人一语中的。\r\n\r\n据了解，谭春雷等10名省人大代表提出的关于制定《海南自由贸易港优化营商环境条例》的议案，很快被采纳。\r\n\r\n经省六届人大常委会第三十次会议通过的《海南自由贸易港优化营商环境条例》，第二十二条明确规定：政府有关部门应当持续完善全省统一的工程建设项目审批管理制度，统一审批体系、审批标准和信息平台，精简工程项目全流程涉及的行政许可、技术审查、中介服务、市政公用服务等事项，优化审批流程，推动构建“拿地即开工”的建设项目管理机制，并加强事中事后监管。\r\n\r\n构建“拿地即开工”的建设项目管理机制，为海南自贸港许多重点项目加快推进，提供了坚强有力的法律保障。“省人大常委会主任会议成员以重点督办、线上线下实时督查等方式，进一步加大代表议案建议督办力度，工作效率和质量有新的提升。”省人大常委会有关负责人介绍，省六届人大四次会议受理议案14件、建议369件，其中问题已解决、正在解决、列入计划解决的建议共有327件，占比88.6%。\r\n\r\n人大代表带头扛起为民担当\r\n\r\n“作为党员和省人大代表，我要做的就是带好头，带着我厂里的‘家人’一直走下去，越走越好!”省人大代表、文昌金泰椰棕制品有限公司总经理吴敬说。他所说的“家人”就是这家公司的68名员工，其中48名是残疾员工。\r\n\r\n2021年7月1日被授予“海南省优秀共产党员”的吴敬，不但建议各界对残疾人等弱势群体关心关爱和加大支持力度，而且依靠自身力量对一批残疾员工、脱贫群众给予帮扶。\r\n\r\n同样于2021年7月1日被授予“海南省优秀共产党员”的黄丽娇也是省人大代表，她在担任乐东黎族自治县千家镇青岭村党支部书记、村委会主任期间，是为民干实事的典型。\r\n\r\n黄丽娇建议，实施乡村振兴战略，需要在产业和人才融入、资金扶持、公共事业发展等多方面加大支持力度。同时，她还在引进企业盘活村里荒地、争取资金改善农村基础设施条件、发展特色产业持续为农民增收等方面进行探索，取得了实实在在的成效。\r\n\r\n人民选我当代表，我当代表为人民。如吴敬、黄丽娇一般，越来越多的人大代表既深入调研、建言献策，又自觉投入为社会服务的行动中，带头扛起人大代表的为民担当。\r\n\r\n(本报海口1月17日讯)', 'https://www.hainan.gov.cn/hainan/5309/202201/39d01d1e92344e13a7c8ed258c8c8e45.shtml', '2022-01-18 07:32:00', NULL, NULL, NULL);
INSERT INTO `news` VALUES (8, '海南省科学技术厅关于开展2021年度高新技术种子企业、 瞪羚企业、领军企业认定申报工作的通知', '<p>各有关单位：</p><p>	为加快推进高新技术产业发展，培育一批标杆企业，落实好省委、省政府有关工作部署，根据《海南省以超常规手段打赢科技创新翻身仗三年行动方案（2021-2023年）》（琼府办〔2021〕24号）和《海南省高新技术企业“精英行动”实施方案》（琼科〔2021〕233号）文件精神，经研究，决定开展2021年度高新技术种子企业、瞪羚企业、领军企业认定申报工作，现将有关事项通知如下：</p><p>	一、申请要求</p><p>	（一）在我省依法设立、实质经营，具有独立法人资格的有效期内高新技术企业。</p><p>	（二）符合申报类型企业的入库条件，有健全的管理制度，稳定的技术、经营管理团队，良好的生产经营和信用状况，近三年无重大环境、生产、质量安全事故，未发生科研严重失信行为，且未列入严重违法失信企业名单。</p><p>	（三）优先支持属于海南省高新技术产业中的南繁、深海、航天、数字经济、石油化工新材料、现代生物医药等重点领域企业。</p><p>	（四）由企业自愿自主申报，对符合条件的企业按择优入库原则进行评选入库。</p><p>	二、申请条件</p><p>	申请入库高新技术种子企业、瞪羚企业、领军企业的企业需满足《海南省高新技术企业“精英行动”实施方案》（琼科〔2021〕233号）中的相关入库条件。</p><p>	三、申请材料</p><p>	申请高新技术种子企业、瞪羚企业、领军企业入库的需提交以下材料：</p><p>	（一）种子企业</p><p>	1.海南省高新技术种子企业申报书；</p><p>	2.近三年研发费用专项审计报告或鉴证报告；</p><p>	3.近三个会计年度企业所得税年度纳税申报表（包括主表和附表）；</p><p>	4.具有资质的中介机构出具的企业近三个年度的财务会计报告（包括会计报表、会计报表附注和财务情况说明书）；</p><p>	5.知识产权证书及相关材料；</p><p>	6.专职研发人员名单及证明材料；</p><p>	7.按《海南省高新技术种子企业申报书》第四部分“主要事项详细情况说明”中所列内容逐条提交相应佐证材料；</p><p>	8.企业获得国家级或省部级创新创业大赛、国家级或省部级科技奖励证书复印件，承担国家级或省部级科技计划项目（课题）立项通知，国家级或省部级企业研发机构设立材料。（如有）</p><p>	（二）瞪羚企业</p><p>	1.海南省高新技术瞪羚企业申报书；</p><p>	2.近三年研发费用专项审计报告或鉴证报告；</p><p>	3.近三个会计年度企业所得税年度纳税申报表（包括主表和附表）；</p><p>	4.具有资质的中介机构出具的企业近三个年度的财务会计报告（包括会计报表、会计报表附注和财务情况说明书）；</p><p>	5.近三年所获知识产权证书及相关材料；</p><p>	6.专职研发人员名单及证明材料；</p><p>	7.按《海南省高新技术瞪羚企业申报书》第四部分“主要事项详细情况说明”中所列内容逐条提交相应佐证材料；</p><p>	8.主导制定国际、国家或行业标准证明材料；人才计划支持证明材料。（如有）</p><p>	（三）领军企业</p><p>	1.海南省高新技术领军企业申报书；</p><p>	2.近三年研发费用专项审计报告或鉴证报告；</p><p>	3.近三个会计年度企业所得税年度纳税申报表（包括主表和附表）；</p><p>	4.具有资质的中介机构出具的企业近三个年度的财务会计报告（包括会计报表、会计报表附注和财务情况说明书）；</p><p>	5.知识产权证书及科技成果转化说明材料；</p><p>	6.省级以上企业研发机构批准设立材料；</p><p>	7.专职研发人员名单及证明材料；</p><p>	8.科研设备清单及原值发票；</p><p>	9.按《海南省高新技术领军企业申报书》第四部分“主要事项详细情况说明”中所列内容逐条提交相应佐证材料；</p><p>	10.企业承担国家级或省部级科技计划项目立项通知，国家级或省部级科技奖励证书，主导制定国际、国家或行业标准证明材料。（如有）</p><p>	四、入库程序</p><p>	（一）企业自主申请。符合条件企业于12月31日前向市县科技管理部门提出入库申请，并按通知要求提交申报材料。</p><p>	（二）市县初审。市县科技管理部门对企业申请材料进行初审并出具推荐意见，于2022年1月7日前将材料报送至省科技厅。</p><p>	（三）省科技厅评审。省科技厅组织专家进行评审。</p><p>	（四）公示。省科技厅根据专家评审意见，择优进行公示。</p><p>	（五）入库。公示无异议，“种子企业”由海南省科技管理部门授予“海南省高新技术种子企业”；“瞪羚企业”报海南省以超常规手段打赢科技创新翻身仗工作专班审定后，授予“海南省高新技术瞪羚企业”；“领军企业”报省政府审定后，由省政府授予“海南省高新技术领军企业”。</p><p>	五、其他有关事项</p><p>	请申报企业将申请材料胶印成册并加盖骑缝章，一式三份。</p><p>	联系人：朱新民，陈鸿翔 联系电话：65309922，65307581</p><p>	地址：海口市美兰区海府路89号</p><p>	附件：1.海南省高新技术企业“精英行动”实施方案</p><p>	2.海南省高新技术种子企业申报书</p><p>	3.海南省高新技术瞪羚企业申报书</p><p>	4.海南省高新技术领军企业申报书</p><p class=\"ql-align-right\">	海南省科学技术厅</p><p class=\"ql-align-right\">	2021年12月5日</p><p>	（此件主动公开）</p><p>	</p><ul><li>附件：	<a href=\"http://dost.hainan.gov.cn/xxgk/xxgkzl/xxgkml/202112/P020211207361782804370.pdf\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"color: rgb(0, 85, 142);\">1.海南省高新技术企业“精英行动”实施方案.pdf</a></li><li>	<a href=\"http://dost.hainan.gov.cn/xxgk/xxgkzl/xxgkml/202112/P020211207361783027512.docx\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"color: rgb(0, 85, 142);\">2.海南省高新技术种子企业申报书.docx</a></li><li>	<a href=\"http://dost.hainan.gov.cn/xxgk/xxgkzl/xxgkml/202112/P020211207361783104154.docx\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"color: rgb(0, 85, 142);\">3.海南省高新技术瞪羚企业申报书.docx</a></li><li>	<a href=\"http://dost.hainan.gov.cn/xxgk/xxgkzl/xxgkml/202112/P020211207361783197848.docx\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"color: rgb(0, 85, 142);\">4.海南省高新技术领军企业申报书 .docx</a></li></ul><p><br></p>', 'http://dost.hainan.gov.cn/xxgk/xxgkzl/xxgkml/202112/t20211207_3107246.html', '2021-12-07 08:00:00', NULL, NULL, NULL);
INSERT INTO `news` VALUES (9, '海南省科学技术厅关于发布海南省重点研发项目入库申报指南（2022版）的通知', '<p>各有关单位：</p><p>	根据《海南省科技计划体系优化改革方案》（琼科〔2021〕250号），海南省重大科技计划、省重点研发计划整合并入省重点研发专项。按照《海南省重点研发专项和经费管理暂行办法》（琼科规〔2021〕18号），省科技厅重新组织编制了《海南省重点研发项目入库申报指南（2022版）》，现予以发布。请根据指南要求组织入库项目申报工作,现就有关事项通知如下：</p><p>	一、申报范围</p><p>	详见附件《海南省重点研发项目入库申报指南（2022版）》。</p><p>	二、申报方式</p><p>	（一）项目申报实行常态化和集中申报相结合的方式。“海南省科技业务综合管理系统”常年开放接受在线申报。为保持“十四五”期间科技计划实施及科技资源配置的连续性，指南有效期原则上至“十四五”末。省科技厅将结合省委、省政府年度重点工作，适时另行发布集中申报通知。</p><p>	（二）请各有关单位尽快组织填报。原则上省科技厅将分别在每年3月份和8月份组织项目评审立项工作。连续两次参加立项评审未获得立项的项目，将被移出项目库。</p><p>	（三）项目单位登录海南省科技业务综合管理系统——新系统入口（http://202.100.247.126/egrantweb/）网上填报。申报流程为：</p><p>	1.注册帐号。首次申报省级科技项目的单位，需登陆海南省科技业务综合管理系统，点击“注册”，按照提示完成注册流程。每个单位只能注册一个“单位管理员”帐号（“单位管理员”帐号不能直接申报项目），“单位管理员”帐号可以创建本单位“项目申报人”帐号，本单位的“项目申报人”帐号由单位管理员统一管理。已在本系统注册的单位或人员可以直接使用原账号登陆，不需要重新注册。</p><p>	2.在线填写。项目申报人登录系统后按支持方向（高新技术、社会发展、现代农业）在线填写《海南省重点研发项目申报书》，并在附件栏上传相关材料，确认无误后在线提交至本单位管理员进行审核。</p><p>	3.在线审核。申报单位管理员审核申报材料，确认无误后，在管理系统内提交省科技厅，即为入库项目。</p><p>	4.项目修改。入库后的项目申报人可随时撤回或修改完善，经申报单位管理员审核后，重新提交至省科技厅。</p><p>	5.项目出库。进入评审程序的项目，经批准立项后，即为出库项目。项目出库后，申报单位可按要求随时组织继续申报。</p><p>	三、注意事项</p><p>	（一）项目申报实行无纸化申报。申报人填写申报书前，应仔细阅读有关填写说明，并按要求认真填写，务必完整、准确、真实。</p><p>	（二）申报人在管理系统中填写申报书并扫描上传加盖公章的申报书封面页和承诺书。承诺项目申报单位上报的材料、配套资金和数据真实、合法、有效，对申报材料的真实性、合法性、合规性负责，并具备开展项目实施的科研基础条件、科研人员实力和财务基础。</p><p>	（三）申报人未按要求上传相关材料的，形式审查时不予受理。</p><p>	（四）申报单位和申报人在申报过程中如有弄虚作假等有违科研诚信的行为，将被纳入社会信用系统。</p><p>	（五）省科技厅或委托专业机构将按照一定比例对拟立项项目申报材料的真实性进行核查。</p><p>	（六）获得立项的项目将在省科技厅门户网站进行公示。</p><p>	（七）鉴于2022年1月1日后启用新版申报系统，目前已按照《海南省科学技术厅关于发布省重点研发计划项目库入库项目申报指南的通知》（琼科〔2021〕171号）提交入库未立项的项目，请按照本通知要求修改后，重新申报入库。</p><p>	四、申报咨询电话</p><p>	申报系统技术咨询：65347994、65389015；</p><p>	业务咨询：</p><p>	高新技术方向：65323068；</p><p>	现代农业方向：65342626；</p><p>	社会发展方向：66290357。</p><p>	附件:海南省重点研发项目入库申报指南（2022版）</p><p class=\"ql-align-right\">	海南省科学技术厅</p><p class=\"ql-align-right\">	2022年1月27日</p><p>	（此件主动公开）</p><p>	</p><ul><li>附件：	<a href=\"http://dost.hainan.gov.cn/xxgk/xxgkzl/xxgkml/202201/P020220128307902798712.doc\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"color: rgb(0, 85, 142);\">海南省重点研发项目入库申报指南（2022版）.doc</a></li></ul><p><br></p>', 'http://dost.hainan.gov.cn/xxgk/xxgkzl/xxgkml/202201/t20220128_3135998.html', '2022-01-28 08:00:00', NULL, NULL, NULL);
INSERT INTO `news` VALUES (11, '海南省科学技术厅关于2022年省重点研发项目（第一批） 拟立项项目和经费安排的公示', '<p>各有关单位:</p><p>	根据《海南省重点研发专项和经费管理暂行办法》（琼科规〔2021〕18号）和《海南省省级财政科技计划项目立项评审工作细则（试行）》（琼科规〔2020〕7号）要求，经公开申报、形式审查、专家评审、行政决策等程序，2022年省重点研发项目（第一批）拟支持 224个项目，安排经费8500万元。</p><p>	现将拟立项项目予以公示。任何单位和个人对公示内容如有异议，可在公示之日起 5个工作日内（2022年2月18日-2021年2月24日），将加盖单位公章或签署个人真实姓名及联系方式的书面意见和相关材料提交省科技厅审计与监督处，电话：65370256。</p><p>	项目咨询联系方式：</p><p>	高新技术：65323068；</p><p>	现代农业：65342626；</p><p>	社会发展：66290357。</p><p>	附件：2022年省重点研发项目（第一批）拟立项项目和经费安排表</p><p class=\"ql-align-right\">	海南省科学技术厅</p><p class=\"ql-align-right\">	2022年2月18日</p><p>	（此件主动公开） </p><p>	</p><ul><li>附件：	<a href=\"http://dost.hainan.gov.cn/xxgk/xxgkzl/xxgkml/202202/P020220218588956912337.xlsx\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"color: rgb(0, 85, 142);\">2022年省重点研发项目（第一批）拟立项项目和经费安排表.xlsx</a></li></ul>', 'http://dost.hainan.gov.cn/xxgk/xxgkzl/xxgkml/202202/t20220218_3144661.html', '2022-02-18 08:00:00', '2022-02-22 01:29:50', '2022-02-22 01:29:50', 0);
INSERT INTO `news` VALUES (12, '关于闲来互娱（海南）网络科技有限公司等188家企业通过2021年第二批高新技术企业认定的通知', '<p>	各市、县科技管理部门、财政局、税务局及有关单位：</p><p>	根据科技部、财政部、国家税务总局《关于印发&lt;高新技术企业认定管理办法&gt;的通知》(国科发火〔2016〕32号)的有关规定，经企业申报、专家评审、海南省高新技术企业认定委员会会议审议，并报全国高新技术企业认定管理工作领导小组办公室公示、备案，闲来互娱（海南）网络科技有限公司等188家企业通过2021年第二批高新技术企业认定（见附件），发证日期为2021年11月30日，有效期3年。</p><p>	已认定的高新技术企业要严格按照《高新技术企业认定管理办法》《高新技术企业认定管理工作指引》的要求规范管理，履行有关义务。</p><p>	特此通知。</p><p>	附件：海南省2021年第二批高新技术企业名单</p><p class=\"ql-align-right\">	海南省科学技术厅 海南省财政厅</p><p class=\"ql-align-right\">	国家税务总局海南省税务局</p><p class=\"ql-align-right\">	2022年1月11日</p><p>	（此件主动公开）</p><p>	</p><ul><li>附件：	<a href=\"http://dost.hainan.gov.cn/xxgk/xxgkzl/xxgkml/202201/P020220117568013684433.doc\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"color: rgb(0, 85, 142);\">海南省2021年第二批高新技术企业名单.doc</a></li></ul>', 'http://dost.hainan.gov.cn/xxgk/xxgkzl/xxgkml/202201/t20220117_3130299.html', '2022-01-17 08:00:00', '2022-02-22 01:50:24', '2022-02-22 01:50:24', 0);
INSERT INTO `news` VALUES (13, '关于海南甲子牛大力开发有限公司等37家企业通过2021年第三批高新技术企业认定的通知', '<p>	各市、县科技管理部门、财政局、税务局及有关单位：</p><p>	根据科技部、财政部、国家税务总局《关于印发&lt;高新技术企业认定管理办法&gt;的通知》(国科发火〔2016〕32号)的有关规定，经企业申报、专家评审、海南省高新技术企业认定委员会会议审议，并报全国高新技术企业认定管理工作领导小组办公室公示、备案，海南甲子牛大力开发有限公司等37家企业通过2021年第三批高新技术企业认定（见附件），发证日期为2021年11月30日，有效期3年。</p><p>	已认定的高新技术企业要严格按照《高新技术企业认定管理办法》《高新技术企业认定管理工作指引》的要求规范管理，履行有关义务。</p><p>	特此通知。</p><p>	附件：海南省2021年第三批高新技术企业名单</p><p class=\"ql-align-right\">	海南省科学技术厅 海南省财政厅</p><p class=\"ql-align-right\">	国家税务总局海南省税务局</p><p class=\"ql-align-right\">	2022年1月11日</p><p>	（此件主动公开）</p><p>	</p><ul><li>附件：	<a href=\"http://dost.hainan.gov.cn/xxgk/xxgkzl/xxgkml/202201/P020220117564443052456.doc\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"color: rgb(0, 85, 142);\">海南省2021年第三批高新技术企业名单.doc</a></li></ul>', 'http://dost.hainan.gov.cn/xxgk/xxgkzl/xxgkml/202201/t20220117_3130292.html', '2022-01-17 08:00:00', '2022-02-22 01:56:00', '2022-02-22 01:56:00', 0);

-- ----------------------------
-- Table structure for park
-- ----------------------------
DROP TABLE IF EXISTS `park`;
CREATE TABLE `park`  (
  `park_id` int NOT NULL AUTO_INCREMENT COMMENT '园区id',
  `park_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '园区名称',
  `park_image_url` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '园区图片url',
  `park_phone` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '园区电话',
  `park_website` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '园区网址',
  `park_introduction` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '园区简介',
  `avatar` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '园区头像',
  `park_supporting` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '配套设施',
  `favoured_policy` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL COMMENT '优惠政策',
  `product_positioning` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '产品定位',
  `key_points` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '招商重点',
  PRIMARY KEY (`park_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '科技园区' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of park
-- ----------------------------
INSERT INTO `park` VALUES (1, '洋浦经济开发区', '/static/defaultImage/1.png', '0898-28826502', 'http://yangpu.hainan.gov.cn', '洋浦经济开发区位于海南西北部洋浦半岛，是邓小平同志亲自批示，国务院1992年批准设立的我国第一个由外商成片开发、享受保税区政策的国家级开发区，是国家首批新型工业化产业示范基地、国家循环化改造示范试点园区和国家首批绿色园区。', '/static/defaultImage/1.png', '打造宜居宜业的滨海产业新城。开发区内生活设施齐全，工商银行、建设银行、中国银行等银行均设有分行，拥有从幼儿园、小学、初中、高中、中专完整的基础教育体系，医院、影剧院、体育场、宾馆、酒楼等服务设施配套齐全。\r\n\r\n　　公共码头、水、电、气、通讯等设施完备，供应稳定。已建有现代化标准厂房约36600平方米，建有现代化标准公共仓库约20000平方米。建有标准的查验平台、海关监管仓库和检疫处理区等设施。目前正在完善公共管廊、智慧巡防一体化、集中供热、热电联产、危险废物处理中心等公共配套设施。正在新建一批建筑面积14.2万平米标准厂房，建设洋浦加速器创业园区一期工程，总建筑面积15万平米，为成长型较快的科技型中小企业提供科研、工作平台。', '1.深化高新技术产业、现代服务业对外开放，取消船舶制造与维修外资股比限制，取消国际海上运输公司、国际船舶代理公司外资股比限制，取消新能源汽车制造外资准入限制。\r\n\r\n2.实行“一线放开，二线高效管住”的货物进境管理；国内货物入区退税；区内企业自用的生产、管理设备免税。\r\n\r\n', '洋浦经济开发区：西部陆海新通道航运枢纽、先进制造业基地、大宗商品集散交易基地和国际贸易创新示范区。\r\n\r\n　　东方临港产业园：天然气化工产业区、精细化工产业区、能源产业区、南海资源开发装备制造产业区、油气仓储区。\r\n\r\n　　临高金牌港临港产业园：起步区打造全产业链规划装配式建筑产业园。', '洋浦经济开发区、东方临港产业园以油气化工、油气储备、大宗商品及国际能源交易、国际港航物流、海洋装备为主导，临高金牌港临港产业园以装配式建筑材料部件研发制造为主导。\r\n\r\n　　新型石化产业\r\n\r\n　　在已建成千万吨炼油、千万方油气储运的产业基础上，已经形成烯烃-芳烃-特种油品的石化产业格局。招商重点是烯烃下游产业链及精细化工。\r\n\r\n　　高新技术产业\r\n\r\n　　将洋浦打造成为国内高新技术企业走出去的桥头堡、境外高新技术企业走进来的合作交流平台为目标。重点引进新一代信息技术、高档数控机床和机器人、新能源汽车制造、集成电路、高端医疗装备、物联网装备、智能制造装备、新材料等高新技术产业企业。\r\n\r\n　　洋浦管委会与保利通信合作建设洋浦保利科技产业园，洋浦管委会与陕西金控合作建设科创园，洋浦管委会规划建设军民融合产业园，正在招商中。\r\n\r\n　　现代服务业\r\n\r\n　　重点引进国际航运、大宗商品集散、物流仓储、冷链物流、国际贸易、现代金融、研发等现代服务产业。以引进东南亚的农产品、林产品、矿产品等初级产品在洋浦集散，构建完备的物流服务体系为目标');
INSERT INTO `park` VALUES (2, '海口江东新区', '/static/defaultImage/1.png', '0898-68603376', 'http://www.hnftp.gov.cn/yshj/yqzt/jdxq/', '江东新区位于海口东海岸区域，毗邻琼州海峡,总用地面积约298平方公里，分为东部生态功能区和西部产城融合区。其中东部生态功能区包含国际重要湿地东寨港国家级自然保护区;西部产城融合区包含临空经济区、滨海生态总部聚集中心、滨江国际活力中心、国际文化交往组团、国际综合服务组团、国际离岸创新创业组团、国际高教科研组团。园区采取“领导小组+法定机构+平台公司”管理体制。', '/static/defaultImage/1.png', '路网、电网、光网、水网、气网基础设施、学校、医院、商业、文化、体育等设施齐全。', '新落户的从事旅游业、现代服务业等第三产业的综合型(区域型)总部，奖励500万。\r\n\r\n新落户的从事高新技术产业等第二产业的综合型(区域型)总部， 承诺自注册成立之日起1年内形成地方财力贡献不低于3000万元，奖励1000万。\r\n\r\n新落户的从事热带特色高效农业等第一产业的综合型(区域型)总部， 承诺自注册成立之日起1年内形成地方财力贡献不低于1000万元，奖励300万。\r\n\r\n新落户的高成长型总部，承诺自注册成立之日起1年内形成地方财力贡献不低于800万元，奖励200万。', '　发挥区域航空枢纽优势、生态底板优势、开发空间广阔优势以及制度高地优势，以都市型产业为主要形态，聚焦“三大两新”(大物流、大航服、大保障、新消费、新展贸)核心功能，着力构建“临空经济+服务经济+生态经济”的开放型、创新型产业体系，着力打造成为“海南智汇中枢，都市产业范本”。按照土地集约、产业集聚的原则，发挥江东新区的区位与资源优势，打造“一港、两心、两带、四组团”的产业空间格局。', '根据园区功能定位，构建以总部经济为引领，以金融、旅游、科教、文化创意、航空租赁、航空维修、数字贸易、专业服务、健康养生、都市农业等为补充，构建“临空经济+服务经济+生态经济”的开放型、创新型产业体系。');
INSERT INTO `park` VALUES (3, '海口综合保税区', '/static/defaultImage/1.png', '0898-67204908', 'http://ftz.haikou.gov.cn', '海口综合保税区是经国务院批准设立，责权利全部归属海口市，具有口岸、物流、加工等功能的海关特殊监管区域，是海南唯一的综合保税区及2个海关特殊监管区域之一，是目前海南开放层次最高、外向经济集聚度较强的园区。\r\n\r\n', '/static/defaultImage/1.png', '(一)区位交通：海口综合保税区紧邻国家一类口岸-马村港，距秀英港30公里，距环岛高速5公里，15公里范围内有海口、老城、福山3个高铁站，海陆空交通便捷，区位优势明显，园区内道路、水电等基础设施完善，实现“五通一平”。\r\n\r\n　　(二)商务：园区内建设有国际商务中心，可为企业提供办公、会议、金融等服务。\r\n\r\n　　(三)生活配套：园区建有职工食堂以及生活配套区，可为园区企业职工提供宿舍。', '进口货物进入海口综合保税区可以保税。国内其它自由贸易区关于促进贸易的选择性征收关税，以及其他相关进出口税收等政策，均可在区内复制。园区出台进出口贸易、跨境电商、汽车平行进口、融资租赁、保税文化等产业发展政策。', '　海口综合保税区以打造具有全球影响力和竞争力的加工制造中心、研发设计中心、物流分拨中心、检测维修中心和销售服务中心为目标，利用国际国内两个市场、两种资源，大力发展保税加工制造、保税物流、跨境电商、整车进口、现代金融、保税文化、研发设计、检测维修等产业，支持和鼓励新技术、新产业、新业态、新模式发展。', '　　(一)低碳制造\r\n\r\n　　国际品牌商品保税加工制造;新技术、新能源、新材料等高新技术和高附加值的加工和再制造;生产线、零部件、配件制造;其他符合海南产业发展的低碳制造。\r\n\r\n　　(二)研发设计、检测维修\r\n\r\n　　生物医药和医疗设备的研发。高技术、高附加值、符合环保要求的保税检测和全球维修业务。第三方检验检测认证机构在区内开展进出口检验认证服务。\r\n\r\n　　(三)国际商品仓储交易\r\n\r\n　　依托保税政策，开展国际商品大宗仓储、展示交易、期货交割、转口贸易、冷链物流等业务。\r\n\r\n　　(四)跨境电商\r\n\r\n　　依托海口跨境电商综合试验区的政策优势，开展跨境电商进出口业务，鼓励创新跨境电商新模式新品类。\r\n\r\n　　(五)汽车平行进口\r\n\r\n　　依托汽车平行进口试点政策以及海口港区汽车整车进口口岸，开展进口汽车保税存储、展示、交易等业务。\r\n\r\n　　(六)文化保税\r\n\r\n　　在园区设立国际文化艺术品交易场所，开展面向全球的保税文化艺术品存储、展示、拍卖、交易业务。\r\n\r\n　　(七)其他现代服务业\r\n\r\n　　船舶和海洋工程结构物等大型设备融资租赁业务。游艇销售代理。软件测试、文化创意等国际服务外包。');
INSERT INTO `park` VALUES (4, '三亚中央商务区', '/static/defaultImage/1.png', '0898-88660715', '', '三亚中央商务区采取“法定机构+平台公司”管理机制。包括东岸单元、月川单元、凤凰海岸单元及海罗四个单元，旨在更好地统筹和推动三亚总部经济和中央商务区及三亚邮轮游艇产业园的建设管理工作。', '/static/defaultImage/1.png', '区内配套包括广场、水域、绿地、商业、商务办公、服务型公寓、文化娱乐、公共服务配套及邮轮游艇配套。', '初次认定的新落户跨国公司地区总部、综合型(区域型)总部、高成长型总部根据实际到位的注册资本按比例给予补助。放开人才落户限制、加强人才安居保障(人才公寓、租购房补贴)；鼓励各类金融机构在三亚设立分支机构；对文化产业给予贷款贴息、保费补贴、绩效奖励。', '总体定位为以总部商务办公、大型消费商圈为主导，重点发展总部服务配套、自贸服务、文化艺术综合消费、设计咨询等。', '　1.凤凰海岸：以“邮轮经济、游艇经济、总部经济”为平台、“艺术海岸”为特色，建设自贸服务与邮轮、游艇、文化艺术综合消费区。分为北部自贸服务旗舰区、中部邮轮主题休闲区、南部文化艺术体验区、南边海环河口游艇主题消费区以及凤凰岛国际邮轮母港配套服务区五部分。\r\n\r\n　　2.东岸片区：围绕东岸新岸湿地公园，建设全球精品主题购物、总部商务、湿地游乐等功能板块，建设大型综合消费商圈和总部核心区。分为沿迎宾路总部核心启动区和湿地休闲商圈以及综合办公区。\r\n\r\n　　3.月川片区：建设国际商业文化步行街和综合商务区，发展总部商务、国际金融消费和滨水特色休闲商业街区等。分为北部沿迎宾路总部商务区，南部沿临春河、三亚河滨水商业区以及东侧商务配套区。\r\n\r\n　　4.海罗片区：重点建设花园总部和国际人才社区，近期重点建设服务国际人才生活工作需求的社区和配套服务，远期于迎宾路南侧建设花园总部。分为国际人才社区、国际医院、国际学校和国际文化交流配套区以及沿迎宾路花园总部办公区。\r\n\r\n　　5.招商对象：世界500强或行业领先的邮轮游艇产业、通用航空业、文化体育产业、旅游业、金融业、互联网、信息产业、商业零售业、会展业等行业企业。');
INSERT INTO `park` VALUES (5, '陵水黎安国际教育创新试验区', '/static/defaultImage/1.png', '0898-65220571', 'http://www.hnftp.gov.cn/yshj/yqzt/hnlsla/', '海南陵水黎安国际教育试验区采取“法定机构+平台公司”管理体制，支撑以旅游业为龙头的现代服务业和高新技术产业发展，突出国际化和开放型特色，积极引进境内外一流教育资源，举办一批高水平中外合作办学机构(项目)，并引进境外一流工科大学独立办学，培育一批有影响力的教育机构及教育服务机构，大力发展教育服务贸易，打造国家级教育创新发展示范区。', '/static/defaultImage/1.png', '包括基础设施、住宅、医疗、商业、教育及产学研等配套。', '以划拨或出让方式优惠提供办学用地;教学科研设备和仪器、基建用进口设备和物资可享受零关税。\r\n\r\n对海南引进的外籍高级管理人员以及长期工作或投资的外国人，进一步提供办理口岸签证、长期签证、居留许可和永久居留便利引进人才购房政策。\r\n\r\n允许在中国重点高校获得本科及以上学位的优秀外国留学生在海南就业和创业，并提供申请办理居留许可便利。\r\n\r\n允许在学校工作的外国高层次人才参与我国科技计划(专项、基金等)，可担任重大项目主持人或首席科学家。\r\n\r\n建立国际离岸创新创业示范区，推动国际科技成果等在琼集聚流通。', '　支撑以旅游业为龙头的现代服务业发展，大力发展教育服务贸易。', '　1.引进国内一流高校联合境外一流高校开展中外合作办学，开展本科、硕士、博士层次学历教育(含国际学生)。\r\n\r\n　　2.引进国际知名的境外工科院校在试验区独立办学。\r\n\r\n　　3.引进知名国际高中、国际幼儿园等优质教育资源。\r\n\r\n　　4.引进和培育有广泛影响力教育机构及教育服务机构。\r\n\r\n　　5.建设国家级人文交流南方基地、国际汉语推广基地、人工智能教育推广基地等。\r\n\r\n　　6.建设和引进具有世界一流水平的教育运营管理平台。\r\n\r\n　　7.积极探索建设教育离岸创新示范区。');
INSERT INTO `park` VALUES (6, '海口复兴城互联网信息产业园', '/static/defaultImage/1.png', '0898-36661888', 'http://www.hnftp.gov.cn/yshj/yqzt/hkfxc/', '海口复兴城互联网信息产业园由海南复兴城产业园投资管理有限公司开发，定位是打造数字经济总部集聚区、国际离岸创新创业基地，围绕智能物联、数字贸易、科技金融和国际离岸创新创业四大产业方向。包括一期复兴城互联网创新创业基地和二期复兴城西海岸互联网总部基地。\r\n\r\n', '/static/defaultImage/1.png', '　生活配套包括公园、创业餐厅、便利店、时尚餐饮等，运动休闲包括海边的绿色休闲跑道、运动场、足球场、高尔夫练习场等，商业配套包括会议中心、5星级酒店、国际公寓、购物广场、商业街等。', '(一)对新落户的跨国公司地区总部， 给予一次性 300 万元奖励。\r\n\r\n(二)对新落户的从事旅游业、现代服务业等第三产业的综合型(区域型)总部，承诺自注册成立之日起 1 年内形成地方财力贡献不低于2000万元，给予一次性500万元奖励。\r\n\r\n(三)对新落户的从事高新技术产业等第二产业的综合型(区域型)总部，承诺自注册成立之日起1年内形成地方财力贡献不低于3000万元，给予一次性1000万元奖励。', '以数字经济为主导，发展以智能物联、数字贸易、金融科技和国际离岸创新为核心的数字经济产业，打造国际数字经济总部和国际离岸创新创业基地。', '　1.智能物联产业集群：芯片和元器件、传感器、5G、车联网、人工智能等。\r\n\r\n　　2.数字贸易产业集群：数据跨境流动、跨境电商、数字内容、数字服务外包等。\r\n\r\n　　3.金融科技产业集群：区块链、支付清算、基金、投资等。\r\n\r\n　　4.国际离岸创新创业产业集群。');
INSERT INTO `park` VALUES (7, '博鳌乐城国际医疗旅游先行区', '/static/defaultImage/1.png', '0898-62830087', 'http://www.lecityhn.com', '2013年2月28日,海南博鳌乐城国际医疗旅游先行区经国务院批准设立,位于琼海市嘉积镇城区和博鳌亚洲论坛核心区之间的万泉河两岸。园区采取“法定机构+平台公司”管理体制，试点发展特许医疗、健康管理、照护康复、医美抗衰等国际医疗旅游相关产业，聚集国际国内高端医疗旅游服务和国际前沿医药科技成果，创建国际化医疗技术服务产业聚集区，被李克强总理誉为“博鳌亚洲论坛第二乐章”。乐城先行区被定位为是海南自贸区(港)建设的先行区，是中国内地唯一真实世界数据应用的先行区。', '/static/defaultImage/1.png', '　毗邻博鳌国际机场、环岛高铁、东线高速，距离琼海市市区仅10.5公里,交通快捷方便。周边遍布星级度假酒店、温泉体验项目。 被玉带滩、东屿岛、博鳌亚洲论坛永久会址等人文旅游风景区环绕，环境优美怡人。先行区集政务服务、进口药械保税仓、商业服务、生活服务于一体，配套完善、功能齐全，整体开业投入运营后，可为外来投资者、园区医疗企业、企业员工、引进专家、外籍医师和医疗旅游客人提供更加便利的办事、就医、住宿、餐饮、会议、购物、休闲娱乐等服务。', '2013年2月28日，国务院正式批复设立海南博鳌乐城国际医疗旅游先行区，并赋予含金量极高的九条优惠政策，可概括为“四个特许”。', '国际医疗旅游目的地，尖端医学技术研发和转化基地，国家级新的医疗机构集聚地，特色明显、技术先进的临床医学中心，中医特色医疗康复中心，国际标准的健康体检中心，国际著名医疗机构在中国的展示窗口和后续治疗中心，罕见病临床医学中心，国际医学交流中心“三地六中心”。', '　1、引进和培育国际先进水平医疗机构。精准对接国际知名医疗机构和医疗团队，引进和培育一批技术水平先进、市场号召力强的医疗机构。打造若干个高端健康管理机构和医疗旅游保健中心。积极引进、培育具有国际水平的第三方医学检测机构。引导境外医药企业在先行区设立售后服务中心。\r\n\r\n　　2、建设国家级医学教育科研交流基地。引进重点医学院校，与世界知名医学院联合设立医学院校。引进科研院所、国家重点实验室，积极争取国内外重点科研院所和医学院校、国家重点实验室、知名企业在先行区设立分支机构。依托公共平台与省部共建先进技术临床医学研究中心。建立重点实验室，设立院士(国家级重点学科、重点专科带头人)、博士后工作站。争取国内顶尖医疗机构在先行区设立临床试验机构。引进和培育国际学术交流平台和国际性医疗组织，举办博鳌健康论坛年会。\r\n\r\n　　3、建设医药技术成果转移转化服务平台和交易中心，举办新药创制相关科技、产业、资本等高层次论坛和成果交易会。\r\n\r\n　　4、搭建医疗旅游中介服务平台，鼓励相关企业或机构提供医疗旅游中介服务平台的服务。引进专业健康和养老保险机构。\r\n\r\n　　5、与国际药品、医疗器械厂商合作，引进优质医疗健康资源。\r\n\r\n　　6、招募国内外医疗人才，引入吸纳优质医生资源。');
INSERT INTO `park` VALUES (8, '海口国家高新技术产业开发区', '/static/defaultImage/1.png', '0898-65580871', 'http://gxq.haikou.gov.cn', '海口国家高新技术产业开发区成立于1991年，是海南省唯一的国家级高新技术产业开发区，重点发展医药与医疗器械、高端低碳制造业、智能传感器及信息技术等高新技术产业，是海南省、海口市高新技术产业发展的主体承载区。\r\n\r\n', '/static/defaultImage/1.png', '　1、住房方面包括美安南邻中心、美安华府、药谷人才房、永秀花园。\r\n\r\n　　2、教育方面包括上海世外附属海口学校、海南枫叶国际学校。\r\n\r\n　　3、交通方面目前美安园区开设公交专线3可从市中心往返园区，车程仅需35分钟，企业也可根据自身需要定制通勤车辆往返园区和市中心。', '对整体迁入的高新技术企业，在其资格有效期内完成迁移的，根据企业规模和企业所在行业等情况，给予不超过500万元的一次性研发资金补贴。\r\n\r\n对新落户的高成长型总部，承诺自注册成立之日起1年内形成地方财力贡献不低于800万元，给予一次性200万元奖励。\r\n\r\n鼓励企业开发具有自主知识产权的新产品；鼓励工业企业上市融资。', '　制度创新先行区、高新技术产业发展引领区、离岸创新创业集聚区、服务重大战略协同区、国际文旅消费创意中心“四区一中心”。主要发展医药健康、低碳制造、新一代信息技术、服务业等产业。', '美安生态科技新城将努力建成以生物医药与医疗器械、智能传感器与信息技术、新能源与新材料为主导的高新技术产业集群。\r\n\r\n　　药谷工业园是“海口药谷”重点集聚医药、医疗器械及保健品生产和研发企业。\r\n\r\n　　狮子岭工业园重点发展新能源、新材料、功能食品、节能环保及健康产业。\r\n\r\n　　云龙产业园位于海口市云龙镇，重点发展先进装备、旅游工艺品和休闲体育用品制造等轻工产业。\r\n\r\n　　海马工业园是现代服务业配套园区，重点发展汽车零部件产业、现代服务业。');
INSERT INTO `park` VALUES (9, '三亚崖州湾科技城', '/static/defaultImage/1.png', '0898-88759511', 'http://www.sanya.gov.cn/sanyasite/yzkjc/yzwkjc.shtml', '三亚崖州湾科技城位于三亚市西部，毗邻南山文化旅游区和大小洞天风景区，规划面积为26.1平方公里，主要由南繁科技城、深海科技城、大学城、南山港和全球动植物种质资源中转基地(即“一港、三城、一基地”)五部分共同构成。', '/static/defaultImage/1.png', '　三亚崖州湾科技城建设进程中,注重推动经济发展与配套设施建设同频共振。园区基础和配套设施项目全线上马、全力推进,涵盖教育、医疗、住房、交通、商业等方面。', '对认定为国家级、省级科技企业孵化器的，在享受海南省、三亚市奖励的基础上，分别给予200万元、120万元一次性奖励。\r\n\r\n对经三亚崖州湾科技城管理局认定的科技企业孵化器，给予60万元一次性奖励。\r\n\r\n注册且新认定国家级高新技术企业，在享受海南省、三亚市奖励的基础上，给予50万元一次性奖励。', '1.深海科技城：以深海科技研发与应用为主导产业，通用科技产业、海洋配套产业为协同，现代服务业为配套的产业生态体系。\r\n\r\n　　2.南繁科技城：是以南繁科研为基础产业、种业科技为核心产业、热带农科为特色产业，围绕动农作物、林木花草、畜牧水产南繁科研，生物育种技术，种业交易贸易，种业科技知识产权交易，热带特色作物科技、农业服务、农科旅游等领域。\r\n\r\n　　3.科教城：以海洋、农业科研产业为核心。\r\n\r\n　　4.全球动植物种质资源引进中转基地：引入全球动物、植物、微生物种质资源，具备检验隔离、战略储备、产业应用、国际贸易交易等功能。', '　南繁科技城\r\n\r\n　　科研机构签约中国热带农业科学院，加快推动公共技术服务中心项目;龙头企业方面积极推动中国种子集团总部搬迁及进驻协议签署，力争中种总部建设项目取得实质性进展，与隆平高科签订合作协议，与中农发种业签署战略合作协议，接触先正达、利马格兰等一批外资种企。\r\n\r\n　　深海科技城\r\n\r\n　　科研机构方面积极引入自然资源部海洋一所;高校方面探索以创新形式引入哈尔滨工程大学、华南理工大学等第二批涉海科研资源;龙头企业方面强力推动引入亨通集团(海底光缆主要供应商)、科大讯飞等企业;新兴产业转化类企业方面大力争取引入彩虹鱼、云洲智能等企业，开发涉海新装备设备应用场景以及开拓自贸港背景下的国际市场业务。\r\n\r\n　　招商体系建设方面\r\n\r\n　　深化政府(省厅+科技城+市局)+平台公司的政企合作模式，使“平台公司”招商主体地位得以体现，招商功能、作用、裁量权全面升级强化，招商人员队伍配置与招商需求和企业引入强度相匹配，在平台公司内部得到“人、财、物“的全方位优先保障。\r\n\r\n　　通过激励机制构建起密切的利益共同体格局，真正做到，统一目标、统一部署、统一行动。\r\n\r\n　　中转基地方面\r\n\r\n　　一是紧紧围绕国家发改委和海关总署的战略部署，进一步深化中转基地后续产业的研究、论证，确保基地建成后发挥应有的作用。二是加强口岸建设、隔离检验检疫等方面的基础能力建设。三是根据沈省长提出“四个最”的要求，从打造设备最先进、技术最领先、制度最灵活、管理最规范四个方面启动基础能力建设。\r\n\r\n　　高新技术企业方面\r\n\r\n　　关于省政府工作报告重点提出的“做大高新技术企业”，三亚市目前高新技术企业较少，我们争取做到2020年“增量龙头”。崖州湾科技城作为目前科技企业的重要聚集地，将以“孵化+引进”的方式发力高新技术企业聚集发展。');
INSERT INTO `park` VALUES (10, '文昌国际航天城', '/static/defaultImage/1.png', '0898-63330891', 'http://www.hnftp.gov.cn/yshj/yqzt/wcgjhtc/', '文昌国际航天城位于海南省文昌市，是中国首个滨海发射基地，园区采取“法定机构+平台公司”管理体制，起步区分八门湾西片区和航天超算产业片区，明确了“将航天城起步区建设成国际一流、对外开放、融合创新的航天城先行发展示范区”的综合定位，“四基地一中心”的产业定位，即航天领域重大科技创新产业基地、空间科技创新战略产业基地、融合创新示范产业基地、航天国际合作产业基地和航天超算中心。', '/static/defaultImage/1.png', '　文昌国际航天城起步区“三横五纵”路网工程项目已可研批复,会展中心、人才公寓、拆迁安置区、产业服务中心、全民健身中心、项目幼儿园/托儿所等6个项目均处于立项阶段,文昌学校工程项目已获得可研批复。', '从加大财政政策扶持、建立资金保障机制、设立产业引导基金、实行灵活的土地使用方式、实行用地“弹性年期”供应制度、完善公共服务功能、支持体制机制创新等七大方面予以支持。', '　文昌国际航天城以航天科技为主导，重点发展航天发射及配套服务，航天高端产品研发制造，航天大数据开发应用，国际航天交流合作以及“航天+”涉及的教育、金融、会展、旅游、生命科学等产业。\r\n\r\n　　重点打造“四基地一中心”，即航天领域重大科技创新产业基地、空间科技创新战略产业基地、创新融合示范产业基地、航天国际合作产业基地和航天超算中心。\r\n\r\n　　空间科技创新战略产业基地重点发展卫星应用、空间科学与探测;创新融合示范产业基地重点发展电子信息、新材料、高端装备、新能源等内容;航天国际合作产业基地重点发展航天国际交流合作与交易、航天金融服务、航天教育培训;航天超算中心主要用于构建航天大数据产业集群，打造全市新的经济增长极，推动大数据与航天技术深度融合。', '　卫星研制、火箭研发、航天地面设备研制、空间科学与探测、卫星应用、电子信息、高端装备、新材料、新能源、航天国际合作交流与交易、航天金融服务、航天教育培训、航天文创及其他、航天大数据等。');
INSERT INTO `park` VALUES (11, '生态软件园', '/static/defaultImage/1.png', '0898-67201941', 'https://www.rschn.com', '海南生态软件园位于海口西侧、盈滨半岛、美仑河畔，是海南互联网信息产业主要载体和平台，现已依法设立法定机构海南生态软件园管理局。截至2019年12月企业总数4833家,先后被认定为国家级科技企业孵化器、国家新型工业化产业示范基地等。\r\n\r\n', '/static/defaultImage/1.png', '　1. iSchool微城未来学校是海南省首个基础教育改革创新实验学校，12年一贯制个性化基础教育。7*24小时国际双语幼儿园设施齐全先进、户外活动空间充足，提供7*24小时双语教育服务。\r\n\r\n　　2. 蓝海钧华大饭店位于园区一期沃克公园西北角，会议厅、会议室、茶书吧、游泳池、温泉泡池、健身房、餐厅等一应俱全，满足企业商务、会议、培训等需求。\r\n\r\n　　4. 第三时间商业街满足餐厅、商务、休闲、购物等需求，万达影城、大润发购物广场等进驻。\r\n\r\n　　5. 园区公共餐厅提供多种口味健康饮食。\r\n\r\n　　6. 每天数十趟班车往返园区与海口之间，园区企业员工免费乘坐，园区临近高速、火车站。', '1. 创建海南自贸区(港)区块链试验区，在制度创新、科技创新、产业创新等方面先行先试，政府包容监管、容错发展。\r\n\r\n2. 海南生态软件园发起设立的海南数字经济产业投资基金，单个项目最高给予5亿元战略投资。', '园区聚焦发展“一区三业”，以新一代信息技术产业特别是区块链为主导，创建海南自贸区(港)区块链试验区，大力发展数字文创、数字金融、数字健康等产业，致力于打造数字贸易策源地、数字金融创新地和中高端人才聚集地，助力海南自贸区(港)高质量发展。', '　1.互联网、移动互联网、大数据、区块链、云计算、人工智能、信息安全等主导产业方向。\r\n\r\n　　2.数字文体：网络游戏、电子竞技、网络视听、数字内容出版等。\r\n\r\n　　3.数字健康：医疗健康大数据、互联网+医疗健康等。\r\n\r\n　　4.数字金融：金融科技、互联网金融、金融服务创新等。\r\n\r\n　　5.其他：园区公共平台建设、园区合作开发建设以及产业服务机构(会计师事务所、律师事务所、券商、投行、产业投资基金等)。');

-- ----------------------------
-- Table structure for policy
-- ----------------------------
DROP TABLE IF EXISTS `policy`;
CREATE TABLE `policy`  (
  `policy_id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标题',
  `publish_time` datetime NULL DEFAULT NULL COMMENT '发布时间',
  `number` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文号',
  `category` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '分类',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '内容',
  `link` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '链接',
  `image` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '详情图片',
  `addition` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '附件',
  `user_id` bigint NULL DEFAULT NULL COMMENT '用户id',
  `gmt_create` datetime NULL DEFAULT NULL,
  `gmt_modified` datetime NULL DEFAULT NULL,
  `deleted` tinyint NOT NULL DEFAULT 0,
  PRIMARY KEY (`policy_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 42 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '政策' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of policy
-- ----------------------------
INSERT INTO `policy` VALUES (3, '海南自由贸易港建设总体方案', '2020-05-31 08:00:00', '', '自贸港政策', '<p>海南是我国最大的经济特区，具有实施全面深化改革和试验最高水平开放政策的独特优势。支持海南逐步探索、稳步推进中国特色自由贸易港建设，分步骤、分阶段建立自由贸易港政策和制度体系，是习近平总书记亲自谋划、亲自部署、亲自推动的改革开放重大举措，是党中央着眼国内国际两个大局，深入研究、统筹考虑、科学谋划作出的战略决策。当今世界正在经历新一轮大发展大变革大调整，保护主义、单边主义抬头，经济全球化遭遇更大的逆风和回头浪。在海南建设自由贸易港，是推进高水平开放，建立开放型经济新体制的根本要求；是深化市场化改革，打造法治化、国际化、便利化营商环境的迫切需要；是贯彻新发展理念，推动高质量发展，建设现代化经济体系的战略选择；是支持经济全球化，构建人类命运共同体的实际行动。为深入贯彻习近平总书记在庆祝海南建省办经济特区30周年大会上的重要讲话精神，落实《中共中央、国务院关于支持海南全面深化改革开放的指导意见》要求，加快建设高水平的中国特色自由贸易港，制定本方案。</p><p>一、总体要求</p><p>（一）指导思想。以习近平新时代中国特色社会主义思想为指导，全面贯彻党的十九大和十九届二中、三中、四中全会精神，坚持党的全面领导，坚持稳中求进工作总基调，坚持新发展理念，坚持高质量发展，统筹推进“五位一体”总体布局，协调推进“四个全面”战略布局，对标国际高水平经贸规则，解放思想、大胆创新，聚焦贸易投资自由化便利化，建立与高水平自由贸易港相适应的政策制度体系，建设具有国际竞争力和影响力的海关监管特殊区域，将海南自由贸易港打造成为引领我国新时代对外开放的鲜明旗帜和重要开放门户。</p><p>（二）基本原则</p><p>——借鉴国际经验。坚持高起点谋划、高标准建设，主动适应国际经贸规则重构新趋势，充分学习借鉴国际自由贸易港的先进经营方式、管理方法和制度安排，形成具有国际竞争力的开放政策和制度，加快建立开放型经济新体制，增强区域辐射带动作用，打造我国深度融入全球经济体系的前沿地带。</p><p>——体现中国特色。坚持党的集中统一领导，坚持中国特色社会主义道路，坚持以人民为中心，践行社会主义核心价值观，确保海南自由贸易港建设正确方向。充分发挥全国上下一盘棋和集中力量办大事的制度优势，调动各方面积极性和创造性，集聚全球优质生产要素，着力在推动制度创新、培育增长动能、构建全面开放新格局等方面取得新突破，为实现国家战略目标提供坚实支撑。加强与东南亚国家交流合作，促进与粤港澳大湾区联动发展。</p><p>——符合海南定位。紧紧围绕国家赋予海南建设全面深化改革开放试验区、国家生态文明试验区、国际旅游消费中心和国家重大战略服务保障区的战略定位，充分发挥海南自然资源丰富、地理区位独特以及背靠超大规模国内市场和腹地经济等优势，抢抓全球新一轮科技革命和产业变革重要机遇，聚焦发展旅游业、现代服务业和高新技术产业，加快培育具有海南特色的合作竞争新优势。</p><p>——突出改革创新。强化改革创新意识，赋予海南更大改革自主权，支持海南全方位大力度推进改革创新，积极探索建立适应自由贸易港建设的更加灵活高效的法律法规、监管模式和管理体制，下大力气破除阻碍生产要素流动的体制机制障碍。深入推进商品和要素流动型开放，加快推动规则等制度型开放，以高水平开放带动改革全面深化。加强改革系统集成，注重协调推进，使各方面创新举措相互配合、相得益彰，提高改革创新的整体效益。</p><p>——坚持底线思维。坚持稳扎稳打、步步为营，统筹安排好开放节奏和进度，成熟一项推出一项，不急于求成、急功近利。深入推进简政放权、放管结合、优化服务，全面推行准入便利、依法过程监管的制度体系，建立与国际接轨的监管标准和规范制度。加强重大风险识别和系统性风险防范，建立健全风险防控配套措施。完善重大疫情防控体制机制，健全公共卫生应急管理体系。开展常态化评估工作，及时纠偏纠错，确保海南自由贸易港建设方向正确、健康发展。</p><p>（三）发展目标</p><p>到2025年，初步建立以贸易自由便利和投资自由便利为重点的自由贸易港政策制度体系。营商环境总体达到国内一流水平，市场主体大幅增长，产业竞争力显著提升，风险防控有力有效，适应自由贸易港建设的法律法规逐步完善，经济发展质量和效益明显改善。</p><p>到2035年，自由贸易港制度体系和运作模式更加成熟，以自由、公平、法治、高水平过程监管为特征的贸易投资规则基本构建，实现贸易自由便利、投资自由便利、跨境资金流动自由便利、人员进出自由便利、运输来往自由便利和数据安全有序流动。营商环境更加优化，法律法规体系更加健全，风险防控体系更加严密，现代社会治理格局基本形成，成为我国开放型经济新高地。</p><p>到本世纪中叶，全面建成具有较强国际影响力的高水平自由贸易港。</p><p>（四）实施范围。海南自由贸易港的实施范围为海南岛全岛。</p><p>二、制度设计</p><p>以贸易投资自由化便利化为重点，以各类生产要素跨境自由有序安全便捷流动和现代产业体系为支撑，以特殊的税收制度安排、高效的社会治理体系和完备的法治体系为保障，在明确分工和机制措施、守住不发生系统性风险底线的前提下，构建海南自由贸易港政策制度体系。</p><p>（一）贸易自由便利。在实现有效监管的前提下，建设全岛封关运作的海关监管特殊区域。对货物贸易，实行以“零关税”为基本特征的自由化便利化制度安排。对服务贸易，实行以“既准入又准营”为基本特征的自由化便利化政策举措。</p><p>1.“一线”放开。在海南自由贸易港与中华人民共和国关境外其他国家和地区之间设立“一线”。“一线”进（出）境环节强化安全准入（出）监管，加强口岸公共卫生安全、国门生物安全、食品安全、产品质量安全管控。在确保履行我国缔结或参加的国际条约所规定义务的前提下，制定海南自由贸易港禁止、限制进出口的货物、物品清单，清单外货物、物品自由进出，海关依法进行监管。制定海南自由贸易港进口征税商品目录，目录外货物进入自由贸易港免征进口关税。以联运提单付运的转运货物不征税、不检验。从海南自由贸易港离境的货物、物品按出口管理。实行便捷高效的海关监管，建设高标准国际贸易“单一窗口”。</p><p>2.“二线”管住。在海南自由贸易港与中华人民共和国关境内的其他地区（以下简称内地）之间设立“二线”。货物从海南自由贸易港进入内地，原则上按进口规定办理相关手续，照章征收关税和进口环节税。对鼓励类产业企业生产的不含进口料件或者含进口料件在海南自由贸易港加工增值超过30%（含）的货物，经“二线”进入内地免征进口关税，照章征收进口环节增值税、消费税。行邮物品由海南自由贸易港进入内地，按规定进行监管，照章征税。对海南自由贸易港前往内地的运输工具，简化进口管理。货物、物品及运输工具由内地进入海南自由贸易港，按国内流通规定管理。内地货物经海南自由贸易港中转再运往内地无需办理报关手续，应在自由贸易港内海关监管作业场所（场地）装卸，与其他海关监管货物分开存放，并设立明显标识。场所经营企业应根据海关监管需要，向海关传输货物进出场所等信息。</p><p>3.岛内自由。海关对海南自由贸易港内企业及机构实施低干预、高效能的精准监管，实现自由贸易港内企业自由生产经营。由境外启运，经海南自由贸易港换装、分拣集拼，再运往其他国家或地区的中转货物，简化办理海关手续。货物在海南自由贸易港内不设存储期限，可自由选择存放地点。实施“零关税”的货物，海关免于实施常规监管。</p><p>4.推进服务贸易自由便利。实施跨境服务贸易负面清单制度，破除跨境交付、境外消费、自然人移动等服务贸易模式下存在的各种壁垒，给予境外服务提供者国民待遇。实施与跨境服务贸易配套的资金支付与转移制度。在告知、资格要求、技术标准、透明度、监管一致性等方面，进一步规范影响服务贸易自由便利的国内规制。</p><p>（二）投资自由便利。大幅放宽海南自由贸易港市场准入，强化产权保护，保障公平竞争，打造公开、透明、可预期的投资环境，进一步激发各类市场主体活力。</p><p>5.实施市场准入承诺即入制。严格落实“非禁即入”，在“管得住”的前提下，对具有强制性标准的领域，原则上取消许可和审批，建立健全备案制度，市场主体承诺符合相关要求并提交相关材料进行备案，即可开展投资经营活动。备案受理机构从收到备案时起，即开始承担审查责任。对外商投资实施准入前国民待遇加负面清单管理制度，大幅减少禁止和限制条款。</p><p>6.创新完善投资自由制度。实行以过程监管为重点的投资便利制度。建立以电子证照为主的设立便利，以“有事必应”、“无事不扰”为主的经营便利，以公告承诺和优化程序为主的注销便利，以尽职履责为主的破产便利等政策制度。</p><p>7.建立健全公平竞争制度。强化竞争政策的基础性地位，确保各类所有制市场主体在要素获取、标准制定、准入许可、经营运营、优惠政策等方面享受平等待遇。政府采购对内外资企业一视同仁。加强和优化反垄断执法，打破行政性垄断，防止市场垄断，维护公平竞争市场秩序。</p><p>8.完善产权保护制度。依法保护私人和法人财产的取得、使用、处置和继承的权利，以及依法征收私人和法人财产时被征收财产所有人得到补偿的权利。落实公司法等法律法规，加强对中小投资者的保护。加大知识产权侵权惩罚力度，建立健全知识产权领域市场主体信用分类监管、失信惩戒等机制。加强区块链技术在知识产权交易、存证等方面应用，探索适合自由贸易港发展的新模式。</p><p>（三）跨境资金流动自由便利。坚持金融服务实体经济，重点围绕贸易投资自由化便利化，分阶段开放资本项目，有序推进海南自由贸易港与境外资金自由便利流动。</p><p>9.构建多功能自由贸易账户体系。以国内现有本外币账户和自由贸易账户为基础，构建海南金融对外开放基础平台。通过金融账户隔离，建立资金“电子围网”，为海南自由贸易港与境外实现跨境资金自由便利流动提供基础条件。</p><p>10.便利跨境贸易投资资金流动。进一步推动跨境货物贸易、服务贸易和新型国际贸易结算便利化，实现银行真实性审核从事前审查转为事后核查。在跨境直接投资交易环节，按照准入前国民待遇加负面清单模式简化管理，提高兑换环节登记和兑换的便利性，探索适应市场需求新形态的跨境投资管理。在跨境融资领域，探索建立新的外债管理体制，试点合并交易环节外债管理框架，完善企业发行外债备案登记制管理，全面实施全口径跨境融资宏观审慎管理，稳步扩大跨境资产转让范围，提升外债资金汇兑便利化水平。在跨境证券投融资领域，重点服务实体经济投融资需求，扶持海南具有特色和比较优势的产业发展，并在境外上市、发债等方面给予优先支持，简化汇兑管理。</p><p>11.扩大金融业对内对外开放。率先在海南自由贸易港落实金融业扩大开放政策。支持建设国际能源、航运、产权、股权等交易场所。加快发展结算中心。</p><p>12.加快金融改革创新。支持住房租赁金融业务创新和规范发展，支持发展房地产投资信托基金（REITs）。稳步拓宽多种形式的产业融资渠道，放宽外资企业资本金使用范围。创新科技金融政策、产品和工具。</p><p>（四）人员进出自由便利。根据海南自由贸易港发展需要，针对高端产业人才，实行更加开放的人才和停居留政策，打造人才集聚高地。在有效防控涉外安全风险隐患的前提下，实行更加便利的出入境管理政策。</p><p>13.对外籍高层次人才投资创业、讲学交流、经贸活动方面提供出入境便利。完善国际人才评价机制，以薪酬水平为主要指标评估人力资源类别，建立市场导向的人才机制。对外籍人员赴海南自由贸易港的工作许可实行负面清单管理，放宽外籍专业技术技能人员停居留政策。允许符合条件的境外人员担任海南自由贸易港内法定机构、事业单位、国有企业的法定代表人。实行宽松的商务人员临时出入境政策。</p><p>14.建立健全人才服务管理制度。实现工作许可、签证与居留信息共享和联审联检。推进建立人才服务中心，提供工作就业、教育生活服务，保障其合法权益。</p><p>15.实施更加便利的出入境管理政策。逐步实施更大范围适用免签入境政策，逐步延长免签停留时间。优化出入境边防检查管理，为商务人员、邮轮游艇提供出入境通关便利。</p><p>（五）运输来往自由便利。实施高度自由便利开放的运输政策，推动建设西部陆海新通道国际航运枢纽和航空枢纽，加快构建现代综合交通运输体系。</p><p>16.建立更加自由开放的航运制度。建设“中国洋浦港”船籍港。支持海南自由贸易港开展船舶登记。研究建立海南自由贸易港航运经营管理体制及海员管理制度。进一步放宽空域管制与航路航权限制，优化航运路线，鼓励增加运力投放，增开航线航班。</p><p>17.提升运输便利化和服务保障水平。推进船舶联合登临检查。构建高效、便捷、优质的船旗国特殊监管政策。为船舶和飞机融资提供更加优质高效的金融服务，取消船舶和飞机境外融资限制，探索以保险方式取代保证金。加强内地与海南自由贸易港间运输、通关便利化相关设施设备建设，合理配备人员，提升运输来往自由便利水平。</p><p>（六）数据安全有序流动。在确保数据流动安全可控的前提下，扩大数据领域开放，创新安全制度设计，实现数据充分汇聚，培育发展数字经济。</p><p>18.有序扩大通信资源和业务开放。开放增值电信业务，逐步取消外资股比等限制。允许实体注册、服务设施在海南自由贸易港内的企业，面向自由贸易港全域及国际开展在线数据处理与交易处理等业务，并在安全可控的前提下逐步面向全国开展业务。安全有序开放基础电信业务。开展国际互联网数据交互试点，建设国际海底光缆及登陆点，设立国际通信出入口局。</p><p>（七）现代产业体系。大力发展旅游业、现代服务业和高新技术产业，不断夯实实体经济基础，增强产业竞争力。</p><p>19.旅游业。坚持生态优先、绿色发展，围绕国际旅游消费中心建设，推动旅游与文化体育、健康医疗、养老养生等深度融合，提升博鳌乐城国际医疗旅游先行区发展水平，支持建设文化旅游产业园，发展特色旅游产业集群，培育旅游新业态新模式，创建全域旅游示范省。加快三亚向国际邮轮母港发展，支持建设邮轮旅游试验区，吸引国际邮轮注册。设立游艇产业改革发展创新试验区。支持创建国家级旅游度假区和5A级景区。</p><p>20.现代服务业。集聚全球创新要素，深化对内对外开放，吸引跨国公司设立区域总部。创新港口管理体制机制，推动港口资源整合，拓展航运服务产业链，推动保税仓储、国际物流配送、转口贸易、大宗商品贸易、进口商品展销、流通加工、集装箱拆拼箱等业务发展，提高全球供应链服务管理能力，打造国际航运枢纽，推动港口、产业、城市融合发展。建设海南国际设计岛、理工农医类国际教育创新岛、区域性国际会展中心，扩大专业服务业对外开放。完善海洋服务基础设施，积极发展海洋物流、海洋旅游、海洋信息服务、海洋工程咨询、涉海金融、涉海商务等，构建具有国际竞争力的海洋服务体系。建设国家对外文化贸易基地。</p><p>21.高新技术产业。聚焦平台载体，提升产业能级，以物联网、人工智能、区块链、数字贸易等为重点发展信息产业。依托文昌国际航天城、三亚深海科技城，布局建设重大科技基础设施和平台，培育深海深空产业。围绕生态环保、生物医药、新能源汽车、智能汽车等壮大先进制造业。发挥国家南繁科研育种基地优势，建设全球热带农业中心和全球动植物种质资源引进中转基地。建设智慧海南。</p><p>（八）税收制度。按照零关税、低税率、简税制、强法治、分阶段的原则，逐步建立与高水平自由贸易港相适应的税收制度。</p><p>22.零关税。全岛封关运作前，对部分进口商品，免征进口关税、进口环节增值税和消费税。全岛封关运作、简并税制后，对进口征税商品目录以外、允许海南自由贸易港进口的商品，免征进口关税。</p><p>23.低税率。对在海南自由贸易港实质经营的企业，实行企业所得税优惠税率。对符合条件的个人，实行个人所得税优惠税率。</p><p>24.简税制。结合我国税制改革方向，探索推进简化税制。改革税种制度，降低间接税比例，实现税种结构简单科学、税制要素充分优化、税负水平明显降低、收入归属清晰、财政收支大体均衡。</p><p>25.强法治。税收管理部门按实质经济活动所在地和价值创造地原则对纳税行为进行评估和预警，制定简明易行的实质经营地、所在地居住判定标准，强化对偷漏税风险的识别，防范税基侵蚀和利润转移，避免成为“避税天堂”。积极参与国际税收征管合作，加强涉税情报信息共享。加强税务领域信用分类服务和管理，依法依规对违法失信企业和个人采取相应措施。</p><p>26.分阶段。按照海南自由贸易港建设的不同阶段，分步骤实施零关税、低税率、简税制的安排，最终形成具有国际竞争力的税收制度。</p><p>（九）社会治理。着力推进政府机构改革和政府职能转变，鼓励区块链等技术集成应用于治理体系和治理能力现代化，构建系统完备、科学规范、运行有效的自由贸易港治理体系。</p><p>27.深化政府机构改革。进一步推动海南大部门制改革，整合分散在各部门相近或相似的功能职责，推动职能相近部门合并。控制行政综合类公务员比例，行政人员编制向监管部门倾斜，推行市场化的专业人员聘任制。</p><p>28.推动政府职能转变。强化监管立法和执法，加强社会信用体系应用，深化“双随机、一公开”的市场监管体制，坚持对新兴业态实行包容审慎监管。充分发挥“互联网+”、大数据、区块链等现代信息技术作用，通过政务服务等平台建设规范政府服务标准、实现政务流程再造和政务服务“一网通办”，加强数据有序共享，提升政府服务和治理水平。政府作出的承诺须认真履行，对于不能履行承诺或执行不到位而造成损失的，应及时予以赔偿或补偿。</p><p>29.打造共建共治共享的社会治理格局。深化户籍制度改革，进一步放宽户口迁移政策，实行以公民身份号码为唯一标识、全岛统一的居住证制度。赋予行业组织更大自主权，发挥其在市场秩序维护、标准制定实施、行业纠纷调处中的重要作用。赋予社区更大的基层治理权限，加快社区服务与治理创新。</p><p>30.创新生态文明体制机制。深入推进国家生态文明试验区（海南）建设，全面建立资源高效利用制度，健全自然资源产权制度和有偿使用制度。扎实推进国土空间规划体系建设，实行差别化的自然生态空间用途管制。健全自然保护地内自然资源资产特许经营权等制度，探索生态产品价值实现机制。建立热带雨林等国家公园，构建以国家公园为主体的自然保护地体系。探索建立政府主导、企业和社会参与、市场化运作、可持续的生态保护补偿机制。加快构建自然资源统一调查评价监测和确权登记制度。健全生态环境监测和评价制度。</p><p>（十）法治制度。建立以海南自由贸易港法为基础，以地方性法规和商事纠纷解决机制为重要组成的自由贸易港法治体系，营造国际一流的自由贸易港法治环境。</p><p>31.制定实施海南自由贸易港法。以法律形式明确自由贸易港各项制度安排，为自由贸易港建设提供原则性、基础性的法治保障。</p><p>32.制定经济特区法规。在遵循宪法规定和法律、行政法规基本原则前提下，支持海南充分行使经济特区立法权，立足自由贸易港建设实际，制定经济特区法规。</p><p>33.建立多元化商事纠纷解决机制。完善国际商事纠纷案件集中审判机制，提供国际商事仲裁、国际商事调解等多种非诉讼纠纷解决方式。</p><p>（十一）风险防控体系。制定实施有效措施，有针对性防范化解贸易、投资、金融、数据流动、生态和公共卫生等领域重大风险。</p><p>34.贸易风险防控。高标准建设开放口岸和“二线口岸”基础设施、监管设施，加大信息化系统建设和科技装备投入力度，实施智能精准监管，依托全岛“人流、物流、资金流”信息管理系统、社会管理监管系统、口岸监管系统“三道防线”，形成海南社会管理信息化平台，对非设关地实施全天候动态监控。加强特定区域监管，在未设立口岸查验机构的区域设立综合执法点，对载运工具、上下货物、物品实时监控和处理。海南自由贸易港与内地之间进出的货物、物品、人员、运输工具等均需从口岸进出。完善口岸监管设备设施的配置。海关负责口岸及其他海关监管区的监管和查缉走私工作。海南省政府负责全省反走私综合治理工作，对下级政府反走私综合治理工作进行考评。建立与广东省、广西壮族自治区等地的反走私联防联控机制。</p><p>35.投资风险防控。完善与投资规则相适应的过程监管制度，严格落实备案受理机构的审查责任和备案主体的备案责任。明确加强过程监管的规则和标准，压实监管责任，依法对投资经营活动的全生命周期实施有效监管，对新技术、新产业、新业态、新模式实行包容审慎监管，对高风险行业和领域实行重点监管。建立健全法律责任制度，针对备案主体提供虚假备案信息、违法经营等行为，制定严厉的惩戒措施。实施好外商投资安全审查，在创造稳定、透明和可预期的投资环境同时，有效防范国家安全风险。</p><p>36.金融风险防控。优化金融基础设施和金融法治环境，加强金融消费者权益保护，依托资金流信息监测管理系统，建立健全资金流动监测和风险防控体系。建立自由贸易港跨境资本流动宏观审慎管理体系，加强对重大风险的识别和系统性金融风险的防范。加强反洗钱、反恐怖融资和反逃税审查，研究建立洗钱风险评估机制，定期评估洗钱和恐怖融资风险。构建适应海南自由贸易港建设的金融监管协调机制。</p><p>37.网络安全和数据安全风险防控。深入贯彻实施网络安全等级保护制度，重点保障关键信息基础设施和数据安全，健全网络安全保障体系，提升海南自由贸易港建设相关的网络安全保障能力和水平。建立健全数据出境安全管理制度体系。健全数据流动风险管控措施。</p><p>38.公共卫生风险防控。加强公共卫生防控救治体系建设，建立传染病和突发公共卫生事件监测预警、应急响应平台和决策指挥系统，提高早期预防、风险研判和及时处置能力。加强疾病预防控制体系建设，高标准建设省级疾病预防控制中心，建立国家热带病研究中心海南分中心，加快推进各级疾病预防控制机构基础设施建设，优化实验室检验检测资源配置。加强公共卫生人才队伍建设，提升监测预警、检验检测、现场流行病学调查、应急处置和医疗救治能力。建设生物安全防护三级实验室和传染病防治研究所，强化全面检测、快速筛查能力，优化重要卫生应急物资储备和产能保障体系。健全优化重大疫情救治体系，建设传染病医疗服务网络，依托综合医院或专科医院建立省级和市级传染病医疗中心，改善传染病医疗中心和传染病医院基础设施和医疗条件。重点加强基层传染病医疗服务能力建设，提升县级综合医院传染病诊疗能力。构建网格化紧密型医疗集团，促进资源下沉、医防融合。完善基层医疗卫生机构标准化建设，强化常见病多发病诊治、公共卫生服务和健康管理能力。加强国际卫生检疫合作和国际疫情信息搜集与分析，提升口岸卫生检疫技术设施保障，建设一流的国际旅行卫生保健中心，严格落实出入境人员健康申报制度，加强对来自重点国家或地区的交通工具、人员和货物、物品的卫生检疫，强化联防联控，筑牢口岸检疫防线。加强对全球传染病疫情的监测，推进境外传染病疫情风险早期预警，严防重大传染病跨境传播。建立海关等多部门协作的境外疫病疫情和有害生物联防联控机制。提升进出口商品质量安全风险预警和快速反应监管能力，完善重点敏感进出口商品监管。</p><p>39.生态风险防控。实行严格的进出境环境安全准入管理制度，禁止洋垃圾输入。推进医疗废物等危险废物处置设施建设，提升突发生态环境事件应急准备与响应能力。建立健全环保信用评价制度。</p><p>三、分步骤分阶段安排</p><p>（一）2025年前重点任务。围绕贸易投资自由化便利化，在有效监管基础上，有序推进开放进程，推动各类要素便捷高效流动，形成早期收获，适时启动全岛封关运作。</p><p>1.加强海关特殊监管区域建设。在洋浦保税港区等具备条件的海关特殊监管区域率先实行“一线”放开、“二线”管住的进出口管理制度。根据海南自由贸易港建设需要，增设海关特殊监管区域。</p><p>2.实行部分进口商品零关税政策。除法律法规和相关规定明确不予免税、国家规定禁止进口的商品外，对企业进口自用的生产设备，实行“零关税”负面清单管理；对岛内进口用于交通运输、旅游业的船舶、航空器等营运用交通工具及游艇，实行“零关税”正面清单管理；对岛内进口用于生产自用或以“两头在外”模式进行生产加工活动（或服务贸易过程中）所消耗的原辅料，实行“零关税”正面清单管理；对岛内居民消费的进境商品，实行正面清单管理，允许岛内免税购买。对实行“零关税”清单管理的货物及物品，免征进口关税、进口环节增值税和消费税。清单内容由有关部门根据海南实际需要和监管条件进行动态调整。放宽离岛免税购物额度至每年每人10万元，扩大免税商品种类。</p><p>3.减少跨境服务贸易限制。在重点领域率先规范影响服务贸易自由便利的国内规制。制定出台海南自由贸易港跨境服务贸易负面清单，给予境外服务提供者国民待遇。建设海南国际知识产权交易所，在知识产权转让、运用和税收政策等方面开展制度创新，规范探索知识产权证券化。</p><p>4.实行“极简审批”投资制度。制定出台海南自由贸易港放宽市场准入特别清单、外商投资准入负面清单。对先行开放的特定服务业领域所设立的外商投资企业，明确经营业务覆盖的地域范围。建立健全国家安全审查、产业准入环境标准和社会信用体系等制度，全面推行“极简审批”制度。深化“证照分离”改革。建立健全以信用监管为基础、与负面清单管理方式相适应的过程监管体系。</p><p>5.试点改革跨境证券投融资政策。支持在海南自由贸易港内注册的境内企业根据境内外融资计划在境外发行股票，优先支持企业通过境外发行债券融资，将企业发行外债备案登记制管理下放至海南省发展改革部门。探索开展跨境资产管理业务试点，提高跨境证券投融资汇兑便利。试点海南自由贸易港内企业境外上市外汇登记直接到银行办理。</p><p>6.加快金融业对内对外开放。培育、提升海南金融机构服务对外开放能力，支持金融业对外开放政策在海南自由贸易港率先实施。支持符合条件的境外证券基金期货经营机构在海南自由贸易港设立独资或合资金融机构。支持金融机构立足海南旅游业、现代服务业、高新技术产业等重点产业发展需要，创新金融产品，提升服务质效。依托海南自由贸易港建设，推动发展相关的场外衍生品业务。支持海南在优化升级现有交易场所的前提下，推进产权交易场所建设，研究允许非居民按照规定参与交易和进行资金结算。支持海南自由贸易港内已经设立的交易场所在会员、交易、税负、清算、交割、投资者权益保护、反洗钱等方面，建立与国际惯例接轨的规则和制度体系。在符合相关法律法规的前提下，支持在海南自由贸易港设立财产险、人身险、再保险公司以及相互保险组织和自保公司。</p><p>7.增强金融服务实体经济能力。支持发行公司信用类债券、项目收益票据、住房租赁专项债券等。对有稳定现金流的优质旅游资产，推动开展证券化试点。支持金融机构在依法合规、有效防范风险的前提下，在服务贸易领域开展保单融资、仓单质押贷款、应收账款质押贷款、知识产权质押融资等业务。支持涉海高新技术企业利用股权、知识产权开展质押融资，规范、稳妥开发航运物流金融产品和供应链融资产品。依法有序推进人工智能、大数据、云计算等金融科技领域研究成果在海南自由贸易港率先落地。探索建立与国际商业保险付费体系相衔接的商业性医疗保险服务。支持保险业金融机构与境外机构合作开发跨境医疗保险产品。</p><p>8.实施更加便利的免签入境措施。将外国人免签入境渠道由旅行社邀请接待扩展为外国人自行申报或通过单位邀请接待免签入境。放宽外国人申请免签入境事由限制，允许外国人以商贸、访问、探亲、就医、会展、体育竞技等事由申请免签入境海南。实施外国旅游团乘坐邮轮入境15天免签政策。</p><p>9.实施更加开放的船舶运输政策。以“中国洋浦港”为船籍港，简化检验流程，逐步放开船舶法定检验，建立海南自由贸易港国际船舶登记中心，创新设立便捷、高效的船舶登记程序。取消船舶登记主体外资股比限制。在确保有效监管和风险可控的前提下，境内建造的船舶在“中国洋浦港”登记并从事国际运输的，视同出口并给予出口退税。对以洋浦港作为中转港从事内外贸同船运输的境内船舶，允许其加注本航次所需的保税油；对其加注本航次所需的本地生产燃料油，实行出口退税政策。对符合条件并经洋浦港中转离境的集装箱货物，试行启运港退税政策。加快推进琼州海峡港航一体化。</p><p>10.实施更加开放的航空运输政策。在对等基础上，推动在双边航空运输协定中实现对双方承运人开放往返海南的第三、第四航权，并根据我国整体航空运输政策，扩大包括第五航权在内的海南自由贸易港建设所必需的航权安排。支持在海南试点开放第七航权。允许相关国家和地区航空公司承载经海南至第三国（地区）的客货业务。实施航空国际中转旅客及其行李通程联运。对位于海南的主基地航空公司开拓国际航线给予支持。允许海南进出岛航班加注保税航油。</p><p>11.便利数据流动。在国家数据跨境传输安全管理制度框架下，开展数据跨境传输安全管理试点，探索形成既能便利数据流动又能保障安全的机制。</p><p>12.深化产业对外开放。支持发展总部经济。举办中国国际消费品博览会，国家级展会境外展品在展期内进口和销售享受免税政策，免税政策由有关部门具体制定。支持海南大力引进国外优质医疗资源。总结区域医疗中心建设试点经验，研究支持海南建设区域医疗中心。允许境外理工农医类高水平大学、职业院校在海南自由贸易港独立办学，设立国际学校。推动国内重点高校引进国外知名院校在海南自由贸易港举办具有独立法人资格的中外合作办学机构。建设海南国家区块链技术和产业创新发展基地。</p><p>13.优化税收政策安排。从本方案发布之日起，对注册在海南自由贸易港并实质性运营的鼓励类产业企业，减按15%征收企业所得税。对在海南自由贸易港设立的旅游业、现代服务业、高新技术产业企业，其2025年前新增境外直接投资取得的所得，免征企业所得税。对企业符合条件的资本性支出，允许在支出发生当期一次性税前扣除或加速折旧和摊销。对在海南自由贸易港工作的高端人才和紧缺人才，其个人所得税实际税负超过15%的部分，予以免征。对享受上述优惠政策的高端人才和紧缺人才实行清单管理，由海南省商财政部、税务总局制定具体管理办法。</p><p>14.加大中央财政支持力度。中央财政安排综合财力补助，对地方财政减收予以适当弥补。鼓励海南在国务院批准的限额内发行地方政府债券支持自由贸易港项目建设。在有效防范风险的前提下，稳步增加海南地方政府专项债券发行额度，用于支持重大基础设施建设。鼓励在海南自由贸易港向全球符合条件的境外投资者发行地方政府债券。由海南统筹中央资金和自有财力，设立海南自由贸易港建设投资基金，按政府引导、市场化方式运作。</p><p>15.给予充分法律授权。本方案提出的各项改革政策措施，凡涉及调整现行法律或行政法规的，经全国人大及其常委会或国务院统一授权后实施。研究简化调整现行法律或行政法规的工作程序，推动尽快落地。授权海南制定出台自由贸易港商事注销条例、破产条例、公平竞争条例、征收征用条例。加快推动制定出台海南自由贸易港法。</p><p>16.强化用地用海保障。授权海南在不突破海南省国土空间规划明确的生态保护红线、永久基本农田面积、耕地和林地保有量、建设用地总规模等重要指标并确保质量不降低的前提下，按照国家规定的条件，对全省耕地、永久基本农田、林地、建设用地布局调整进行审批并纳入海南省和市县国土空间规划。积极推进城乡及垦区一体化协调发展和小城镇建设用地新模式，推进农垦土地资产化。建立集约节约用地制度、评价标准以及存量建设用地盘活处置政策体系。总结推广文昌农村土地制度改革三项试点经验，支持海南在全省深入推进农村土地制度改革。依法保障国家重大项目用海需求。</p><p>17.做好封关运作准备工作。制定出台海南自由贸易港进口征税商品目录、限制进口货物物品清单、禁止进口货物物品清单、限制出口货物物品清单、禁止出口货物物品清单、运输工具管理办法，以及与内地海关通关单证格式规范、与内地海关通关操作规程、出口通关操作规程等，增加对外开放口岸，建设全岛封关运作的配套设施。</p><p>18.适时启动全岛封关运作。2025年前，适时全面开展全岛封关运作准备工作情况评估，查堵安全漏洞。待条件成熟后再实施全岛封关运作，不再保留洋浦保税港区、海口综合保税区等海关特殊监管区域。相关监管实施方案由有关部门另行制定。在全岛封关运作的同时，依法将现行增值税、消费税、车辆购置税、城市维护建设税及教育费附加等税费进行简并，启动在货物和服务零售环节征收销售税相关工作。</p><p>（二）2035年前重点任务。进一步优化完善开放政策和相关制度安排，全面实现贸易自由便利、投资自由便利、跨境资金流动自由便利、人员进出自由便利、运输来往自由便利和数据安全有序流动，推进建设高水平自由贸易港。</p><p>1.实现贸易自由便利。进一步创新海关监管制度，建立与总体国家安全观相适应的非关税贸易措施体系，建立自由进出、安全便利的货物贸易管理制度，实现境外货物在海南自由贸易港进出自由便利。建立健全跨境支付业务相关制度，营造良好的支付服务市场环境，提升跨境支付服务效率，依法合规推动跨境服务贸易自由化便利化。</p><p>2.实现投资自由便利。除涉及国家安全、社会稳定、生态保护红线、重大公共利益等国家实行准入管理的领域外，全面放开投资准入。在具有强制性标准的领域，建立“标准制+承诺制”的投资制度，市场主体对符合相关要求作出承诺，即可开展投资经营活动。</p><p>3.实现跨境资金流动自由便利。允许符合一定条件的非金融企业，根据实际融资需要自主借用外债，最终实现海南自由贸易港非金融企业外债项下完全可兑换。</p><p>4.实现人员进出自由便利。进一步放宽人员自由进出限制。实行更加宽松的商务人员临时出入境政策、便利的工作签证政策，进一步完善居留制度。</p><p>5.实现运输来往自由便利。实行特殊的船舶登记审查制度。进一步放宽空域管制与航路航权限制。鼓励国内外航空公司增加运力投放，增开航线航班。根据双边航空运输协定，在审核外国航空公司国际航线经营许可时，优先签发至海南的国际航线航班许可。</p><p>6.实现数据安全有序流动。创新数据出境安全的制度设计，探索更加便利的个人信息安全出境评估办法。开展个人信息入境制度性对接，探索加入区域性国际数据跨境流动制度安排，提升数据传输便利性。积极参与跨境数据流动国际规则制定，建立数据确权、数据交易、数据安全和区块链金融的标准和规则。</p><p>7.进一步推进财税制度改革。对注册在海南自由贸易港并实质性运营的企业（负面清单行业除外），减按15%征收企业所得税。对一个纳税年度内在海南自由贸易港累计居住满183天的个人，其取得来源于海南自由贸易港范围内的综合所得和经营所得，按照3%、10%、15%三档超额累进税率征收个人所得税。扩大海南地方税收管理权限。企业所得税、个人所得税作为中央与地方共享收入，销售税及其他国内税种收入作为地方收入。授权海南根据自由贸易港发展需要，自主减征、免征、缓征除具有生态补偿性质外的政府性基金，自主设立涉企行政事业性收费项目。对中央级行政事业性收费，按照中央统一规定执行。中央财政支持政策结合税制变化情况相应调整，并加大支持力度。进一步研究改进补贴政策框架，为我国参与补贴领域国际规则制定提供参考。</p><p>四、组织实施</p><p>（一）加强党的全面领导。坚持用习近平新时代中国特色社会主义思想武装党员干部头脑，认真贯彻落实党中央、国务院决策部署，增强“四个意识”，坚定“四个自信”，做到“两个维护”。建立健全党对海南自由贸易港建设工作的领导体制机制，充分发挥党总揽全局、协调各方的作用，加强党对海南自由贸易港建设各领域各方面各环节的领导。以党的政治建设为统领，以提升组织力为重点，全面提高党的建设质量，为海南自由贸易港建设提供坚强政治保障。加强基层党组织建设，引导广大党员发挥先锋模范作用，把基层党组织建设成为海南推动自由贸易港建设的坚强战斗堡垒。完善体现新发展理念和正确政绩观要求的干部考核评价体系，建立激励机制和容错纠错机制，旗帜鲜明地为敢于担当、踏实做事、不谋私利的干部撑腰鼓劲。把社会主义核心价值观融入经济社会发展各方面。持之以恒正风肃纪，强化纪检监察工作，营造风清气正良好环境。</p><p>（二）健全实施机制。在推进海南全面深化改革开放领导小组指导下，海南省要切实履行主体责任，加强组织领导，全力推进海南自由贸易港建设各项工作。中央和国家机关有关单位要按照本方案要求，主动指导推动海南自由贸易港建设，进一步细化相关政策措施，制定出台实施方案，确保政策落地见效。推进海南全面深化改革开放领导小组办公室牵头成立指导海南推进自由贸易港建设工作小组，由国家发展改革委、财政部、商务部、中国人民银行、海关总署等部门分别派出干部驻海南实地指导开展自由贸易港建设工作，有关情况及时上报领导小组。国务院发展研究中心组织对海南自由贸易港建设开展全过程评估，牵头设立专家咨询委员会，为海南自由贸易港建设建言献策。</p><p>（三）稳步推进政策落地。加大督促落实力度，将各项政策举措抓实抓细抓出成效。认真研究和妥善解决海南自由贸易港建设中遇到的新情况新问题，对一些重大政策措施做好试点工作，积极稳妥推进方案实施。</p>', 'http://dost.hainan.gov.cn/xxgk/xxgkzl/xxgkml/202010/t20201029_2874711.html', '', '', 1, '2021-09-22 08:00:00', '2021-09-22 08:00:00', 0);
INSERT INTO `policy` VALUES (4, '财政部   税务总局\r\n关于海南自由贸易港企业所得税优惠政策的通知', '2020-06-23 12:31:40', '财税〔2020〕31号', '自贸港政策', '海南省财政厅，国家税务总局海南省税务局：\r\n为支持海南自由贸易港建设，现就有关企业所得税优惠政策通知如下：\r\n一、对注册在海南自由贸易港并实质性运营的鼓励类产业企业，减按15%的税率征收企业所得税。\r\n本条所称鼓励类产业企业，是指以海南自由贸易港鼓励类产业目录中规定的产业项目为主营业务，且其主营业务收入占企业收入总额60%以上的企业。所称实质性运营，是指企业的实际管理机构设在海南自由贸易港，并对企业生产经营、人员、账务、财产等实施实质性全面管理和控制。对不符合实质性运营的企业，不得享受优惠。\r\n海南自由贸易港鼓励类产业目录包括《产业结构调整指导目录（2019年本）》、《鼓励外商投资产业目录（2019年版）》和海南自由贸易港新增鼓励类产业目录。上述目录在本通知执行期限内修订的，自修订版实施之日起按新版本执行。\r\n对总机构设在海南自由贸易港的符合条件的企业，仅就其设在海南自由贸易港的总机构和分支机构的所得，适用15%税率；对总机构设在海南自由贸易港以外的企业，仅就其设在海南自由贸易港内的符合条件的分支机构的所得，适用15%税率。具体征管办法按照税务总局有关规定执行。\r\n二、对在海南自由贸易港设立的旅游业、现代服务业、高新技术产业企业新增境外直接投资取得的所得，免征企业所得税。\r\n本条所称新增境外直接投资所得应当符合以下条件：\r\n（一）从境外新设分支机构取得的营业利润；或从持股比例超过20%（含）的境外子公司分回的，与新增境外直接投资相对应的股息所得。\r\n（二）被投资国（地区）的企业所得税法定税率不低于5%。\r\n本条所称旅游业、现代服务业、高新技术产业，按照海南自由贸易港鼓励类产业目录执行。\r\n三、对在海南自由贸易港设立的企业，新购置（含自建、自行开发）固定资产或无形资产，单位价值不超过500万元（含）的，允许一次性计入当期成本费用在计算应纳税所得额时扣除，不再分年度计算折旧和摊销；新购置（含自建、自行开发）固定资产或无形资产，单位价值超过500万元的，可以缩短折旧、摊销年限或采取加速折旧、摊销的方法。\r\n本条所称固定资产，是指除房屋、建筑物以外的固定资产。\r\n四、本通知自2020年1月1日起执行至2024年12月31日。\r\n\r\n财政部   税务总局\r\n2020年6月23日', '', '', 'http://dost.hainan.gov.cn/xxgk/xxgkzl/xxgkml/202003/P020200310590842637006.doc', 1, '2021-09-23 01:37:47', '2021-09-23 01:37:47', 0);
INSERT INTO `policy` VALUES (5, '中共海南省委 海南省人民政府\r\n关于加快科技创新的实施意见', '2017-06-01 15:12:32', '发改体改规〔2020〕1880号', '自贸港政策', '为深入贯彻落实全国科技创新大会精神，主动适应经济发展新常态，坚持把创新作为引领发展的第一动力，补齐科技创新短板，着力解决我省科技创新能力薄弱、科技创新体制不顺和机制不灵活、科技创新人才缺乏、科技与产业结合不紧密，特别是科技创新的氛围不浓厚、企业作为创新主体的作用尚未有效发挥等突出问题，根据中共中央、国务院《关于深化体制机制改革加快实施创新驱动发展战略的若干意见》（中发〔2015〕8 号）等文件精神，结合海南实际，提出如下实施意见。\r\n　　一、指导思想和总体目标\r\n　　（一）指导思想。全面贯彻党的十八大和十八届三中、四中、五中、六中全会精神，深入学习贯彻习近平总书记系列重要讲话精神和治国理政新理念新思想新战略，牢固树立创新、协调、绿色、开放、共享的发展理念，全面落实中央关于深化科技体制机制改革、加快实施创新驱动发展的决策部署，立足省情，加快实施创新驱动发展战略，着力推进供给侧结构性改革，培育壮大以现代服务业为主的 12 个重点产业，提高经济发展质量和效益，为全面建设国际旅游岛、全面建成小康社会提供有力的科技支撑。\r\n　　（二）总体目标。到“十三五”期末，全省研究与试验发展经费占地区生产总值的比重达到 1.5%以上，与经济社会发展相适应的区域科技创新体系进一步完善，企业技术创新主体地位明显增强，科技创新和成果转化应用能力显著提高，科技基础条件明显加强，科技创新资源和服务平台共享机制基本形成，科技人才队伍得到较快发展，全民科学素质明显提升。在重点领域和重点产业的关键共性技术取得突破，自主创新能力显著增强，战略性新兴产业和高新技术产业快速发展，科技支撑和引领经济社会发展的作用更加显著，基本形成以企业为主体、市场为导向、产学研相结合的技术创新体系。\r\n　　 二、加强科技创新的统筹协调\r\n　　（三）加强科技创新驱动发展战略的顶层设计。强化顶层设计，搭建公开统一的省科技计划管理平台，建立省科技计划管理厅际联席会议制度，成立战略咨询与综合评审委员会，优化形成符合我省实际、与国家五大科技计划衔接的省级科技计划体系。改革科技创新战略规划和资源配置体制机制，深化产学研合作，加强科技创新统筹协调，加快建立健全各主体、各方面、各环节有机互动、协同高效的科技创新体系。\r\n　　（四）建立以产业创新为重点的科技创新新机制。着力围绕产业链部署创新链、围绕创新链完善资金链，聚焦全省经济社会发展战略目标，整合和优化创新资源要素配置，形成科技创新合力。围绕加快培育深海、航天、医疗健康、新能源、新材料、互联网、热带特色高效农业和现代旅游等产业，组织实施一批重大科技计划项目，突破一批具有引领和带动作用的核心关键技术，形成一批有竞争力的新产品、新企业、新业态，争取在深海、航天和热带高效农业等领域成为领跑全国的创新高地。\r\n　　三、强化企业技术创新主体地位\r\n　　（五）培育发展高新技术企业。开展科技型企业认定工作，重点支持具有一定规模和良好成长性的科技型企业开展技术创新活动，建立高新技术企业培育库，培育期 3 年。每年根据入库企业年度研发实际投入和培育期内企业规模的成长，给予不超过 50万元的研发资金补贴，用于企业技术攻关、新产品研发和标准研制，提高企业自主创新能力。\r\n　　（六）积极引进高新技术企业。引进一批符合我省产业需求的高新技术企业，培育壮大我省高新技术企业队伍，促进我省高新技术产业快速发展。对整体迁入我省的高新技术企业，在其高新技术企业资格有效期内完成迁移的，根据企业规模和企业所在行业等情况，给予不超过 500 万元的一次性研发资金补贴，用于企业开展技术创新活动。省外高新技术企业在我省设立的具有独立法人资格的企业，经所在园区或市县科技部门推荐、省科技厅审核，直接纳入高新技术企业培育库。\r\n　　（七）鼓励企业开发具有自主知识产权的新产品。鼓励企业积极开展新技术、新产品的研发攻关、专利化和产业化应用，被认定为海南省高新技术产品的，一次性给予最高不超过 20 万元的研发资金补贴。鼓励各市县和科技园区给予相应的政策扶持。\r\n　　（八）强化企业技术创新的制度保障。认真落实国家支持企业技术创新的研发费用加计扣除、高新技术企业所得税优惠、固定资产加速折旧、股权激励、技术入股、技术服务和转让等税收优惠及分红激励政策。对按规定可享受研发费用加计扣除所得税优惠政策企业的实际研发投入，企业所在市县(区)政府要按一定比例给予补助。把研发投入和技术创新能力作为政府支持企业技术创新的前提条件。鼓励有条件的企业牵头开展重大科技研发活动。\r\n　　（九）加快创新创业载体建设。鼓励社会力量投资建设或管理运营创新创业载体，积极推动科技企业孵化器和众创空间的建设和发展。经认定的国家级科技企业孵化器一次性奖励 200 万元，省级科技企业孵化器一次性奖励 100 万元，省级众创空间一次性奖励 30 万元；对科技企业孵化器和众创空间实行年度考核、动态管理。根据考核结果，对科技企业孵化器和众创空间的运营给予一定资金补贴。\r\n　　四、加快科技创新成果转化\r\n　　（十）加强科技成果转化平台建设。支持国内外高等院校、科研院所、企业在我省建设技术转移转化中心、中试与转化基地、新型研发机构、产业技术创新战略联盟等科技成果转化平台。符合规定的，省科技部门给予立项支持。鼓励市县政府、高新园区、开发区为新型研发机构提供长期免费或低租金的办公、科研场所。经省科技部门认定为新型研发机构的，其专门科研用地可按程序以科教用地办理土地出让手续；经营性产业用地采取招标出让的，出让底价可以在参照工业用地基准地价及相应的土地用途修正系数进行价格评估后集体决策确定。\r\n　　（十一）加强科技服务机构建设。加强科技评估、技术市场、标准服务、检验检测认证、创业孵化、知识产权、科技咨询、科技金融、科学普及等科技服务机构建设，积极探索以政府购买服务、“后补助”等方式支持公共科技服务发展，提升科技服务业对科技创新和产业发展的支撑能力。\r\n　　（十二）强化知识产权创造和运用。通过国家知识产权管理体系认证机构审核认证的贯标企业一次性支持 20 万元；通过国家知识产权局审核准予备案的产业知识产权联盟，一次性支持 30 万元；经国家知识产权局确认的国家级知识产权示范企业、优势企业，分别一次性支持 50 万元、30 万元。加强知识产权交易服务平台建设，经批准设立的知识产权运营公共服务平台，一次性支持100 万元；支持知识产权质押融资，鼓励知识产权质押融资评估担保机构、商业银行和保险公司等机构开展知识产权质押融资服务工作，每年根据年度考核，给予一定补助。\r\n　　五、加强科技创新平台建设\r\n　　（十三）积极培育海南国家农业高新技术产业开发区。以现有国家农业科技园区为基础，培育海南国家农业高新技术产业开发区，集聚高等院校、科研院所、创新创业人才和高新技术企业入驻园区，实现产业链的融合，引领海南现代农业发展。\r\n　　（十四）支持高新技术产业园区建设。从人才引进、住房优惠、科技创新奖励、招商资源配备、重大招商项目审批等方面出台专项优惠政策，积极支持海口国家高新技术产业开发区、海南生态软件园、博鳌乐城国际医疗旅游先行区等产业园区建设。开展省级高新技术产业开发区认定和管理工作。\r\n　　（十五）加大力度引进科研机构。对国内外著名科研院所、大学在我省设立科研机构，给予大力支持。设立整建制科研机构，给予最高不超过 2000 万元的支持；设立分支机构，给予最高不超过 500 万元的支持。省财政、发展改革、科技等相关部门，采取一事一议的方式决定支持额度，省财政安排经费，支持科研机构完善科研条件和引进、培养人才等。\r\n　　（十六）加强海洋科技创新载体建设。对从事海洋等领域科学技术研究的公益性科研机构用地，以划拨方式供应所需建设用地，保障岸线和用海需求。支持国家级深海等科研平台建设，争取海洋领域的国家重大科技专项落户海南，打造海洋科技创新新高地。\r\n　　（十七）加强科普载体建设。着眼于科普可持续发展，聚焦科普设施、科普活动、科普内容开发、科技传播载体建设等，加快专业科技馆、虚拟科技馆等各类科普教育基地建设，提升科普公共服务能力。\r\n　　六、鼓励科技人才创新创业\r\n　　（十八）实施创新创业人才培养计划。加大推送本土人才进入国家高层次人才行列力度，制定入选国家级项目人才配套支持政策。依托重大科技项目、重点科研基地，培养科技创新创业领军人才。加大力度推进创业英才培养计划实施，完善支持政策，创新支持方式，对在我省重点发展的优势产业和领域做出突出贡献的创新创业型人才给予奖励。\r\n　　（十九）加强高层次人才和团队的引进。围绕 12 个产业、6类产业园区和海洋等领域，实施高层次人才和科技创新团队引进计划，按照有关政策，对引进带项目、带资金的科技型创新创业领军人才，给予每人 100 万元的项目启动经费及其他相关补贴；对引进的院士、国家“千人计划”等高层次人才，以及引进人才被认定为我省“百人专项”专家的，享受相关人才政策奖补待遇；对引进的科技创新团队，给予 200—500 万元创业启动经费支持。对我省急需紧缺的特殊人才，开辟专门渠道，采取一事一议方式给予特殊支持；允许高等院校、科研院所设立一定比例流动岗位，吸引有创新创业经验的企业家和企业科技人才担任兼职教授或创业导师。完善柔性引才政策，简化手续，吸引国内外“候鸟”高端人才来琼交流服务。\r\n　　（二十）落实人才配套政策。放宽引进人才落户限制，符合标准的高层次人才可在全省自由落户。进一步开展人才服务管理改革试点工作，积极扩大试点范围，解决人才在工作、生活、保险、住房、子女入学、配偶安置等方面的困难。出台引进高层次人才安居政策，通过提供免费人才公寓、公租房、共有产权房或发放住房补贴等方式多渠道解决人才居住需求，以居住成本优势增强对省外人才的吸引力。\r\n　　（二十一）鼓励开展各类创新创业活动。鼓励社会力量围绕大众创业、万众创新组织开展各类活动，让大众创业、万众创新在全社会蔚然成风。通过举办中国创新创业大赛（海南赛区）暨海南省创新创业大赛等赛事活动，鼓励各行业、各市县举办各类创新创业竞赛活动，广泛聚集创新人才、创新团队在我省创新创业。\r\n　　 七、促进科技与金融结合\r\n 　　（二十二）创新财政科技投入方式与机制。继续加大财政资金对科技创新的投入，积极构建以政府投入为引导、企业投入为主体，财政资金与社会资金、股权融资与债权融资、直接融资与间接融资有机结合的科技投融资体系。综合运用无偿资助、政府性基金引导、风险补偿、贷款贴息以及后补助等多种方式，引导和带动社会资本参与科技创新。\r\n　　（二十三）加大对科技创新的信贷支持。鼓励银行业金融机构先行先试，积极探索科技型中小企业贷款模式、产品和服务创新。建立科技型中小企业贷款风险补偿机制，形成政府、银行、企业以及中介机构多元参与的信贷风险分担机制。鼓励符合条件的银行业金融机构与创业投资、股权投资机构开展投贷联动，为科技型企业提供股权和债权相结合的融资服务。\r\n　　（二十四）开展发放科技创新券试点。面向企业发放科技创新券，按一定比例支持企业向高校、科研院所等科技服务机构购买技术成果、专利技术、测试检测、科技咨询等科技创新服务，创新服务履行完毕后由企业或服务机构持科技创新券向科技部门兑现。通过科技创新券的发放，降低企业创新成本，促进产学研合作，激发大众创业、万众创新活力。\r\n　　（二十五）加大科技型企业创业投资基金投入。支持设立科技成果转化投资基金，加大政策性资金投入力度，引导金融资本和民间资本支持科技成果的转移转化。鼓励各市县设立科技成果转化投资基金，或与社会投资机构共同出资设立基金，优先投入高新技术领域中小微企业。支持各园区、众创空间整合集聚创业者、创业导师、创投机构、民间组织等各类创新创业资源，围绕种子期、初创期科技型企业创新链资源整合，提供创业导师辅导、天使投资、创业投资等服务。\r\n　　 八、完善科技创新激励机制\r\n　　（二十六）完善科技创新资源配置。整合科技资源，优化配置，稳定支持基础性、前沿性、公益性科学研究。加大各类科技计划向公共科研平台建设倾斜支持力度，提高公益性科研机构运行经费保障水平，支持科研机构软、硬件建设，改善科研机构科技创新条件。\r\n　　（二十七）推进科技成果处置权和收益权改革。赋予高等院校、科研机构科技成果自主处置权。除涉及国家安全、国家利益和重大社会公共利益外，高等院校、科研机构可自主决定科技成果的实施、转让、对外投资和实施许可等科技成果转化事项，取得的科技成果 1 年内未实施转化的，成果研发团队或完成人拥有科技成果转化的优先处置权，可自行实施转化；科技成果转化收益全部留归单位自主分配，纳入单位预算，实行统一管理，处置收入不上缴国库。科技成果转化收益用于人员激励的支出部分，在本单位绩效工资总量中单列，不作为绩效工资总量基数。高等院校、科研机构转化职务科技成果，以股份或出资比例等股权形式给予个人奖励的，获奖人可暂不缴纳个人所得税，在转让其股权或获得分红时再缴纳。\r\n　　（二十八）完善科技人员职称评审政策。突出用人单位在职称评审中的主导作用，逐步分级分批下放职称评审权。具备条件的省属本科高校、科研院所实行自主评审，强化事前事中事后监管。将专利创造、标准制定及成果转化作为职称评审的重要依据之一。\r\n　　（二十九）改革完善科技奖励制度。修订科技进步奖励办法和科技成果转化奖励办法，优化奖励结构，制定激励约束并重、突出价值导向、公开公平公正的评价标准和方法。进一步完善科技奖励评审方式，引进省外专家或实行异地评审，增强评审的客观性和公正性。\r\n　　（三十）推进科技资源开放共享。推进财政投入的大型科学仪器设备、科技文献、种质资源、科学数据等科技资源以非营利方式向企业和社会开放共享。对财政资金资助的科技项目和科研基础设施，建立统一的管理数据库和科技报告制度。引导和鼓励科研院所和高校的科研设施设备、科学数据、科技文献等科技资源向社会开放。建立以开放服务绩效为导向的科研平台运行评价体系和资源共享激励机制。\r\n　　九、改进财政科研项目资金管理机制\r\n　　（三十一）下放预算调剂权限。在项目总预算不变的情况下，将直接费用中的材料费、测试化验加工费、燃料动力费，以及出版、文献、信息传播、知识产权事务费和其他支出预算调剂权下放给项目承担单位。确需要调剂的，由项目承担单位据实核准，验收（结题）时报项目主管部门备案。简化预算编制科目，合并会议费、差旅费、国际合作与交流费科目，由科研人员结合科研活动实际需要编制预算并按规定统筹安排使用，其中不超过直接费用 10%的，不需要提供预算测算依据。\r\n　　（三十二）加大对科研人员的绩效激励力度。取消科研项目绩效支出比例限制。项目承担单位在统筹安排间接费用时，要处理好合理分摊间接成本和对科研人员激励的关系，绩效支出安排与科研人员在项目工作中的实际贡献挂钩。承担单位中的国有企事业单位从科研项目资金（含项目承担单位以市场委托方式取得的横向经费）中列支的编制内有工资性收入科研人员的绩效支出，在本单位绩效工资总量中单列，不作为绩效工资总量基数。\r\n　　（三十三）劳务费开支不设比例限制。参与项目研究的研究生、博士后、访问学者以及项目聘用的研究人员、科研辅助人员等，均可开支劳务费。项目聘用人员的劳务费开支标准，参照当地科学研究和技术服务业从业人员平均工资水平，根据其在项目研究中承担的工作任务确定，其社会保险补助纳入劳务费科目列支。劳务费预算不设比例限制，由项目承担单位和科研人员据实编制。\r\n　　（三十四）改进结转结余资金留用处理方式。项目实施期间，年度剩余资金可结转下一年度继续使用。项目完成任务目标并通过验收后，结余资金按规定留归项目承担单位使用，在 2 年内由项目承担单位统筹安排用于科研活动；2 年后未使用完的，按规定收回。\r\n　　十、强化科技创新保障\r\n　　（三十五）加强组织领导。各级党委和政府要从全局高度，把加快实施创新驱动发展战略纳入重要议事日程，切实做好各项工作的推进和协调服务，强化科技管理能力建设，充分发挥各类创新主体的积极性，形成推进科技创新的强大合力，统筹推进全省科技体制改革和区域创新体系建设各项工作。\r\n　　（三十六）加强财政支持和政策衔接。各级政府要加大对科技创新的投入，优先保障科技经费投入，规范财政科技投入口径，优化支出结构。省政府印发的《海南省鼓励和支持战略性新兴产业和高新技术产业发展的若干政策（暂行）》（琼府〔2011〕52 号）、《海南省促进高新技术产业发展的若干规定》（琼府〔2012〕9 号）等文件规定，与本意见不一致的，以本意见为准。各有关部门要做好政策衔接工作。\r\n　　（三十七）落实职责任务。各有关部门要各司其职、协调配合，加强对科技创新工作的分类指导。科技、发展改革、工业和信息化、国有资产管理、财政、教育、人力资源和社会保障、工商、税务、金融等有关部门要结合实际，制定和完善配套办法及细化措施，抓好各项政策的落实，并加强对相关政策的绩效评估。科研院所、高校、企业、科技社团等有关单位，要主动承担和落实好科技改革发展的有关任务。\r\n（三十八）强化考核监督。加强对科技创新的目标责任考核，将科技创新发展评价指标纳入我省经济社会发展绩效考核指标体系，作为各级党政领导班子和领导干部综合考核评价指标体系的组成部分。省委办公厅、省政府办公厅、省科技厅要加强对科技创新重点工作和重大项目的督查，确保各项决策部署落到实处。', '', '', 'http://dost.hainan.gov.cn/xxgk/xxgkzl/xxgkml/202101/P020210126601538845197.zip', 1, '2021-09-23 01:37:47', '2021-09-23 01:37:47', 0);
INSERT INTO `policy` VALUES (6, '海南省人民政府关于印发海南省支持\r\n高新技术企业发展若干政策的通知', '2020-10-24 00:41:53', '琼府〔2020〕50号', '奖励政策', '各市、县、自治县人民政府，省政府直属各单位：\r\n　　《海南省支持高新技术企业发展若干政策(试行)》已经2020年10月13日七届海南省人民政府第59次常务会议审议通过，现印发给你们，请认真贯彻执行。\r\n\r\n\r\n海南省人民政府\r\n2020年10月24日\r\n\r\n　　(此件主动公开)\r\n\r\n海南省支持高新技术企业发展若干政策(试行)\r\n\r\n为贯彻习近平总书记“4·13”重要讲话和中央12号文件精神，加快落实《海南自由贸易港建设总体方案》，按照省委、省政府有关工作部署，做好高新技术企业引进和培育工作，推动我省高新技术产业高质量发展，制定本政策。\r\n一、支持高新技术企业享受海南自由贸易港政策\r\n高新技术企业科研和生产所需进口的原辅料、设备等按规定进入自贸港相关政策的“正面清单”或者不列入“负面清单”，享受“零关税”政策。高新技术企业的高端人才和紧缺人才，根据相关规定享受海南自由贸易港个人所得税优惠政策。高新技术企业新增境外直接投资取得的所得，免征企业所得税。(责任单位：按《海南自由贸易港总体方案》分工落实)\r\n二、奖励高新技术企业加大研发投入\r\n对高新技术企业研发经费增量给予奖励，每年额度为企业年度研发经费增量的30%，规模以上企业(纳入省统计局一套表网报平台企业)不高于200万元人民币，其他企业不高于100万元人民币；研发经费以企业所得税纳税申报表中“可加计扣除研发费”为准。(责任单位：海南省科学技术厅、海南省财政厅)\r\n三、奖励新增高新技术企业\r\n鼓励各市县、洋浦经济开发区对首次通过高新技术企业认定的企业给予不低于20万元人民币的认定奖励。(责任单位：各市县人民政府、洋浦经济开发区管理委员会)\r\n四、奖励引进高新技术企业\r\n有效期内整体迁入我省的高新技术企业，按企业完成迁入注册后12个月的固定资产投资、研发投入等给予奖励，额度为企业完成固定资产投资的5%或研发投入10%，最高不超过500万元人民币。(责任单位：海南省科学技术厅、海南省财政厅)\r\n五、鼓励高新技术企业积极申报海南省重点产业扶持奖励\r\n在海南省重点产业扶持政策中支持高新技术企业发展，鼓励高新技术企业加大研发投入、自主创新，增强核心竞争力。高新技术企业一旦签订“对赌”协议，要采取有力措施，落实“对赌”条款。(责任单位：海南省发展和改革委员会、海南省科学技术厅、海南省财政厅)\r\n六、减免高新技术企业房产税和城镇土地使用税\r\n高新技术企业经营发生严重亏损，缴纳房产税、城镇土地使用税确有困难的，可按规定申请房产税和城镇土地使用税困难减免税。(责任单位：国家税务总局海南省税务局、海南省科学技术厅)\r\n七、保障高新技术产业用地\r\n将高新技术产业用地纳入各级国土空间规划，鼓励市县创新用地供给，实行带项目招标或者挂牌、长期租赁、先租后让、租让结合、弹性年期等供应方式供地，同时积极盘活闲置土地和城镇低效用地，保障高新技术产业发展用地需求。在新一轮产业用地基准地价标准出台前，高新技术产业项目用地的基准地价，可按照相对应土地用途现行基准地价的60%确定，经省招商联席会议审议通过的具有重大产业带动作用的高新技术产业项目的基准地价，还可结合全国工业用地最低价标准，由市县政府按照集体决策方式确定产业用地出让起始价和底价。在高新技术产业园区积极推行实施标准地制度，支持市县政府以土地使用权作价出资或者入股方式，向园区平台供应标准厂房、科技孵化器等用地。(责任单位：海南省自然资源和规划厅，各市县人民政府)\r\n八、加大高新技术企业金融支持力度\r\n用好、用足现有的金融扶持政策，依托银行金融机构和政府性融资担保机构，创新开发科技贷款保险资金池、融资担保、科技保险、贷款贴息等符合我省高新技术企业需求的科技金融产品，为高新技术企业提供信贷和融资担保等金融服务。(责任单位：海南省科学技术厅、海南省财政厅、海南省地方金融监督管理局)\r\n九、大力支持高新技术企业科技创新\r\n申报省重大科技计划项目和课题的企业一般应为高新技术企业或在本领域国内、省内具有技术优势的企业，高新技术企业申报省级科技计划项目不受限项限制。大力支持高新技术企业建设省企业技术中心、重点实验室、技术创新中心、院士创新平台、成果转化中心、国际科技合作基地等科技创新平台，省级创新券加大支持高新技术企业技术创新和技术服务力度。(责任单位：海南省科学技术厅)\r\n本政策适用有效期内高新技术企业。为了做好我省高新技术企业奖励政策衔接，2019年新认定的高新技术企业可按本政策第二条、第三条，由省财政在2020年进行奖励。省政府原有支持高新技术企业相关政策与本政策不一致的，按本政策执行。\r\n　　本政策自公布之日起施行，至2022年12月31日结束。政策期满后，根据高新技术企业发展情况，适时调整。\r\n　　本政策由海南省科学技术厅商海南省财政厅解释。', NULL, NULL, NULL, 1, '2021-09-23 01:37:47', '2021-09-23 01:37:47', 0);
INSERT INTO `policy` VALUES (7, '海口市人民政府关于印发《海口市支持总部经济发展若干政策》的通知 ', '2018-06-01 00:42:57', NULL, '自贸港政策', '各区人民政府、市政府直属有关单位:\r\n　　《海口市支持总部经济发展若干政策》已经第十三届市委常委会(2018)第 30次会议审议通过,现印发给你们,请认真贯彻执行。\r\n　　海口市人民政府\r\n　　2018年6月1日\r\n(此件主动公开)\r\n\r\n　　海口市支持总部经济发展若干政策\r\n　　第一章总则\r\n　　第一条为贯彻落实《中共中央国务院关于支持海南全面深化改革开放的指导意见》(中发〔2018〕12号)和《海南省人民政府办公厅关于促进总部经济发展的工作意见》琼府办(〔2018〕37号),加快引导海口自由贸易区(港)总部经济向高端化、集约化和规模化发展,外部引进与内部培育并重,真正发挥企业总部集聚效应,带动产业转型升级,增强海口城市综合竞争力,特制定若干政策。\r\n　　第二条本政策所称总部包括新落户总部和现有总部。\r\n　　新落户总部是指2018 年1月1日(含)以后在我市设立或迁入本市的跨国公司地区总部、综合型(区域型)总部、高成长型总部、国际组织(机构)地区总部。\r\n　　现有总部是指2018年 1月1日以前在本市范围内设立且存续至今的跨国公司地区总部、综合型(区域型)总部、高成长型总部。\r\n　　第三条本政策适用于在本市范围内设立,工商注册和税务登记地在本市并取得海南省促进总部经济发展联席会议依据《海南省总部企业认定管理办法》颁发认定证书的总部。自《海南省总部企业认定管理办法》出台后,海南省内总部企业重新变更注册地在海口市的,不纳入本政策扶持对象,不享受相关扶持政策。\r\n　　第二章政策支持条款\r\n　　第四条开办奖励:\r\n　　(一)对新落户的跨国公司地区总部,给予一次性300万元奖励。\r\n　　(二)对新落户的从事旅游业、现代服务业等第三产业的综合型(区域型)总部,承诺自注册成立之日起1年内形成地方财力贡献不低于2000万元,给予一次性 500万元奖励。\r\n　　(三)对新落户的从事高新技术产业等第二产业的综合型(区域型)总部,承诺自注册成立之日起1年内形成地方财力贡献不低于3000万元,给予一次性 1000万元奖励。\r\n　　(四)对新落户的从事热带特色高效农业等第一产业的综合型(区域型)总部,承诺自注册成立之日起1年内形成地方财力贡献不低于1000万元,给予一次性 300万元奖励。\r\n　　(五)对新落户的高成长型总部,承诺自注册成立之日起1年内形成地方财力贡献不低于800万元,给予一次性200万元奖励。\r\n　　(六)对新落户的国际组织(机构)地区总部,给予一次性200万元奖励;在本市新设立分支机构的,给予一次性 100万元奖励。\r\n　　第五条在海口市无自有产权办公用房的,经初次认定的总部企业租用办公用房的,自认定当年起,根据租赁合同金额给予\r\n　　对新落户的总部企业分别按以下情形给予一次性年租金补贴,在5年内,按照年租金金额的前三年 50%、后两年30%给予补贴,5年内累计补贴金额最高不超过300万元。\r\n　　在海口市无自有产权办公用房的,经初次认定的总部企业购买自用办公用房的,给予购房价5%的补贴,累计补贴金额最高不超过1000万元。在取得房屋产权证后分 2年支付,每年支付50%。\r\n　　享受租用及购买自用办公用房补贴政策的总部须承诺办公用房投入使用后10年内不改变房屋用途、不转让或转租,如因特殊原因必须改变房屋用途、转让或转租,总部企业已领取的办公补贴资金应予退还。\r\n　　第六条经认定的现有总部,按其年地方财力贡献市级留成部分环比增长额的50%予以奖励,奖励期限 5年。\r\n　　新落户总部,自认定当年起,按其年地方财力贡献市级留成部分(不含个人所得税),前三年给予60%资金支持,后两年给予40%资金支持。\r\n　　第七条跨国公司地区总部、综合型(区域型)总部、高成长型总部的高层管理人员、专业技术骨干和国际组织(机构)地区总部经认定的高级管理人员,年工资薪金所得达到50万以上的,按其缴纳的工资薪金所得地方财力贡献市级留成部分前三年50%、后两年30%给予奖励。符合条件的人才可在任职满1年后享受此项奖励(领取奖励时,必须仍为该总部的在职员工)。\r\n　　总部高管人员,是指由投资方委派,在总部担任董事长、副董事长、总经理、副总经理、总监及相当于上述级别的高级管理人员。专业技术骨干是指经具有国家级专业认证在生产和服务领域岗位一线,掌握专门知识和技术的人员。国际组织(机构)地区总部经认定的高级管理人员,需由国际组织(机构)全球总部委派。\r\n　　总部企业高管人员享受海口市相关人才服务政策,包括落户、医疗、子女教育、人事档案管理、职称评定、社会保障等。\r\n　　第八条对形成总部经济集聚的园区运营管理机构,根据园区内企业形成的地方财力贡献市级留成部分予以一定比例奖励。\r\n　　第九条对经认定的总部企业首次被评为世界企业500强的,给予一次性2000 万元奖励;对评为中国企业500强的,给予一次性500万元奖励;对评为中国民营企业 500强的,给予一次性200万元奖励。\r\n　　第十条重点引进并对我市产业发展具有重大带动作用的龙头企业和知名机构,可以申请为总部经济企业,并按照“一企一策”方式给予重点支持。\r\n　　第十一条在市政府服务中心设立总部企业绿色服务窗口,经认定的总部企业需要办理行政审批手续的,凭认定文件可享受全程代办和优先服务。\r\n　　第三章组织实施\r\n　　第十二条建立海口市促进总部经济发展联席会议(以下简称“联席会议”)制度,统筹全市总部经济发展工作。联席会议第一召集人为常务副市长,召集人为分管副市长,成员由海口市相关部门、各区政府、经济开发区负责人组成,负责研究解决工作推进中的重大问题和事项。联席会议办公室(以下简称“联席办”)设在市商务局,承担联席会议日常工作。\r\n　　第十三条增设海口市总部经济发展促进机构,负责拟定总部经济发展战略、规划,统筹推动总部经济发展;为符合条件的总部企业代办扶持政策兑现等“一站式”绿色服务。建立海口市总部企业常态化联系制度,实行重点服务和信息互联互通。\r\n　　第十四条规定涉及的扶持政策,与本市出台的其他优惠政策类同的,企业可按就高原则申请享受,但不重复享受。\r\n　　第十五条企业在申请奖励补贴资金过程中,如未达到其承诺对地方财力贡献的,应全额返还已获得的奖励补贴资金。\r\n　　总部企业[国际组织(机构)地区总部除外]每年享受本政策的奖补金额,不超过总部企业当年在海口产生的对海南省级和海口地方财力贡献总额,超过部分可结转到后续年度予以拨付。\r\n　　第十六条申请企业应书面承诺自享受海口总部扶持资金之日起,10年内工商注册地和税务登记地将在本市存续,并配合相关职能部门履行好社会责任。\r\n　　第十七条企业在申报、执行受支持项目过程中有弄虚作假、不按规定专款专用的,拒绝配合产业资金绩效评价和监督检查的,将视情取消或收回扶持资金,5年内不得获取产业资金扶持,并录入诚信黑名单,及时向市相关部门及相关区予以通报。\r\n　　第四章附则\r\n　　第十八条总部企业应于每财务年度结束后第一个月内向联席办提交上一年度财务审计报告。\r\n　　第十九条政策执行期如遇中央、省政策调整,按就高、就新的原则给予扶持。\r\n　　第二十条本政策中所称“以上”“不超过”“不低于”均含本数。本政策具体应用问题由海口市商务局负责解释。\r\n　　第二十一条本政策有效期五年,自公布之日起30日后施行。\r\n\r\n三亚市人民政府关于印发《三亚市促进总部经济发展暂行办法》的通知\r\n \r\n各区人民政府，各管委会，市政府直属各单位：\r\n《三亚市促进总部经济发展暂行办法》已经七届市委常委会第77次会议和七届市政府第28次常务会议审议通过，现印发给你们，请遵照执行。\r\n \r\n \r\n三亚市人民政府\r\n2018年6月7日\r\n（此件主动公开）\r\n\r\n三亚市促进总部经济发展暂行办法\r\n \r\n第一章  总则\r\n \r\n    第一条  为全面贯彻落实《中共中央 国务院关于支持海南全面深化改革开放的指导意见》（中发〔2018〕12号）和《海南省人民政府办公厅关于促进总部经济发展的工作意见》（琼府办〔2018〕37号），加快推进自由贸易区（港）建设，加快三亚经济结构转型升级和构建现代化经济体系，鼓励内外资企业和国际组织（机构）在三亚设立总部，加强各类总部聚集，促进总部经济发展，现结合三亚实际，制定本办法。\r\n    第二条  本办法所称总部企业包括新落户总部企业和现有总部企业。新落户总部是指2018年1月1日（含）以后在三亚市设立或迁入三亚市的跨国公司地区总部、综合型（区域型）总部、高成长型总部、国际组织（机构）地区总部。现有总部是指2018年1月1日以前在三亚市范围内设立且存续至今的跨国公司地区总部、综合型（区域型）总部、高成长型总部、国际组织（机构）地区总部。 \r\n    第三条  本办法适用于在三亚市范围内设立，工商注册和税务登记地在三亚市并取得海南省促进总部经济发展联席会议依据《海南省总部企业认定管理办法》颁发认定证书的总部企业。自《海南省总部企业认定管理办法》出台后，海南省内总部企业重新变更注册地在三亚市的，不纳入本办法扶持对象，不享受本扶持政策。\r\n \r\n第二章  政策支持条款\r\n \r\n    第四条  开办补助  经初次认定的新落户跨国公司地区总部、综合型（区域型）总部、高成长型总部实际到位注册资本在5000万元以内的部分，按1%给予补助；超过5000万元至2亿元的部分，按2%给予补助；超过2亿元的部分，按3%给予补助，总部企业落户开办补助资金累计最高不超过2000万元。经初次认定的新落户国际组织（机构）地区总部给予补助200万元。开办补助分五年支付，每年支付20%。\r\n   第五条  经营贡献奖励\r\n   （一）基础贡献奖励\r\n    经初次认定的新落户总部企业，自认定当年起5年内按照每年对三亚地方财力贡献（不含个人所得税及与房地产相关的财力贡献，下同）给予奖励支持，前3年按70%给予奖励支持，后2年按40%给予奖励。\r\n经初次认定的现有总部企业，自认定当年起5年内按照每年对三亚地方财力贡献的环比增量部分给予60%奖励支持。\r\n   （二）上台阶贡献奖励\r\n    对认定为旅游业、现代服务业等第三产业的经初次认定的总部企业，享受本扶持政策期间，每年实际对三亚地方财力贡献2000万元—4000万元，在享受基础贡献奖励基础上，奖励标准提高3个百分点；每年实际对三亚地方财力贡献4000万元—8000万元，在享受基础贡献奖励基础上，奖励标准提高5个百分点；每年实际对三亚地方财力贡献8000万元以上，在享受基础贡献奖励基础上，奖励标准提高8个百分点。\r\n   对认定为高新技术产业等第二产业的经初次认定的总部企业，享受本扶持政策期间，每年实际对三亚地方财力贡献3000万元—5000万元，在享受基础贡献奖励基础上，奖励标准提高3个百分点；每年实际对三亚地方财力贡献5000万元—10000万元，在享受基础贡献奖励基础上，奖励标准提高5个百分点；每年实际对三亚地方财力贡献10000万元以上，在享受基础贡献奖励基础上，奖励标准提高8个百分点。\r\n    对认定为热带特色高效农业等第一产业的经初次认定的总部企业，享受本扶持政策期间，每年实际对三亚地方财力贡献1000万元—3000万元，在享受基础贡献奖励基础上，奖励标准提高3个百分点；每年实际对三亚地方财力贡献3000万元—5000万元，在享受基础贡献奖励基础上，奖励标准提高5个百分点；每年实际对三亚地方财力贡献5000万元以上，在享受基础贡献奖励基础上，奖励标准提高8个百分点。\r\n   （三）增量贡献奖励\r\n    经初次认定的总部企业自认定当年起5年内连续2年经营形成的对三亚地方财力贡献呈增长且比上年度增长率不低于30%，给予企业对三亚地方财力贡献增量的30%奖励，增量奖励每年最高不超过2000万元。\r\n    第六条  管理人员奖励  对经初次认定的总部企业的高管、认定为三亚市高层次人才的总部企业人员在前5年中每年根据其对三亚地方财力贡献给予奖励，前3年按60%给予奖励，后2年按40%给予奖励。\r\n    总部企业享受三亚市相关人才服务政策，包括高层次人才落户、医疗、子女教育、人事档案管理、职称评定、社会保障等。\r\n    第七条  办公用房租房补贴  在三亚市无自有产权办公用房的，经初次认定的总部企业租用商务写字楼用于自用办公用房的，自获得认定资格之日起根据办公用房租赁合同金额（若实际租赁价格高于房屋租金市场指导价的，则按市场指导价计算租房补贴）给予租金补贴不超过5年，前3年补贴年度租金的50%，后2年补贴年度租金的30%，每年补贴金额最高不超过120万元。\r\n    第八条  购房补贴  在三亚市无自有产权办公用房的，经初次认定的总部企业自获得认定资格之日起5年内购置总部自用办公用房的，按照购房合同金额（若实际购买价格高于市场指导价的，则按市场指导价计算购房补贴）的8%给予补贴，在其取得房屋产权证后分五年支付，每年支付20%，累计补贴金额最高不超过2000万元。\r\n    购房补贴、办公用房租房补贴可以同时申请，但获得的累计办公用房补贴资金不超过最高一项补贴。享受补贴期间，自用办公用房不得对外出售、出租或改变用途，因特殊原因必须对外出售、出租或改变用途，总部企业已领取的办公用房补贴资金应予退还。\r\n    第九条  培育企业发展奖励  对经认定的总部企业首次被评为世界企业500强的，给予一次性2000万元奖励，首次被评为中国企业500强的，给予一次性500万元奖励，首次被评为中国民营企业500强的，给予一次性200万元奖励。\r\n    第十条  集聚区奖励  对形成总部经济集聚的园区运营管理机构，根据园区内企业形成的三亚地方财力贡献予以一定比例奖励。\r\n    第十一条  绿色服务  在市政务中心设立总部企业绿色服务窗口，经认定的总部企业需要办理行政审批手续的，凭认定文件可享受全程代办和优先服务。\r\n    第十二条  特别支持  对新重点引进对三亚市经济社会发展具有重大带动作用的企业，可按“一事一议”给予政策支持。\r\n \r\n第三章  组织实施\r\n \r\n    第十三条  建立三亚市促进总部经济发展联席会议（以下简称“联席会”）制度，统筹全市总部经济发展工作，负责研究解决工作推进中的重大问题和重大事项。联席会办公室（以下简称“市联席办”）设在市商务会展局，承担联席会议日常工作。\r\n    第十四条  总部企业政策兑现流程：奖补资金每年申报和审核拨付一次。市联席办每年负责组织政策兑现工作，经认定的总部，需准备下列材料：\r\n    1.总部企业认定申请表；\r\n    2.公司营业执照、纳税证明材料、法定代表人身份证、股东信息证明、验资报告；\r\n    3.总部承诺提供全部材料真实性及违反承诺应承担的法律责任的承诺函；\r\n    4.省联席办颁发的总部认定证书； \r\n    5.申请扶持种类、额度及相关证明材料；\r\n    6.主要股东或申请企业经审计的上年度财务报告；\r\n    以上材料一式叁份，附电子版光盘，报送市联席办。由市联席办作出审核意见上报联席会议审议，审议通过后由市联席办负责组织实施。\r\n    第十五条  企业隐瞒真实情况或提供虚假材料获得资格认定和奖补的，除按照规定取消总部企业资格和终止享受优惠政策外，责令其退回奖补所得，将其列入市信用信息共享平台“黑名单”。\r\n    第十六条  享受本办法支持政策的总部企业须书面承诺自享受三亚市总部企业奖补资金之日起，10年内工商注册地和税务登记地不迁离三亚市，如搬离或更改的，应全额退还已按本办法享受到的奖补资金。\r\n    第十七条  本办法与三亚市其他同类型优惠支持政策，总部企业可按就高原则申请享受，但不得重复享受。本办法的扶持政策每个总部企业最多享受5年。\r\n    第十八条  总部企业（国际组织（机构）地区总部除外）年度获得的市财政奖补资金总额，最高不超过总部企业当年对三亚地方财力贡献和对省级财力贡献省级奖励三亚部分的总额，超过部分可结转到享受政策年度期间内再相应予以拨付。\r\n \r\n第四章  附则\r\n \r\n    第十九条  本办法中所称“以内”“不超过”“不低于”均含本数，数值区间中的前一个不含本数、后一个含本数。\r\n    第二十条  本办法由市商务会展局负责解释。\r\n    第二十一条  《三亚市培育促进总部经济发展暂行规定》（三府〔2011〕131号）和《三亚市促进海棠湾总部经济和现代服务业发展优惠政策暂行办法》（三府〔2013〕140号）自本办法施行之日起废止。\r\n    第二十二条  本办法自颁发之日起施行。\r\n\r\n\r\n三亚市人民政府关于印发《三亚市市级高新技术企业认定\r\n管理及扶持办法》的通知\r\n\r\n各区人民政府，各管委会，市政府直属各单位：\r\n《三亚市市级高新技术企业认定管理及扶持办法》已经七届市政府第79次常务会议审议通过，现印发给你们，请认真组织实施。\r\n\r\n\r\n三亚市人民政府    \r\n                                        2020年1月3日\r\n\r\n三亚市市级高新技术企业认定管理及扶持办法\r\n\r\n第一章 总则\r\n第一条 为深入实施创新驱动发展战略，增强科技型中小微企业核心竞争力，推进我市高新技术产业发展，加强高新技术企业培育工作，根据《中共海南省委海南省人民政府关于加快科技创新的实施意见》（琼发〔2017〕12号）要求，结合《高新技术企业认定管理办法》（国科发火〔2016〕32号）、《高新技术企业认定管理工作指引》（国科发火〔2016〕195号），制定本办法。\r\n第二条 本办法所称的市级高新技术企业是指：在《国家重点支持的高新技术领域》内，持续进行研究开发与技术成果转化，形成企业核心自主知识产权，并以此为基础开展经营活动，在三亚市注册的居民企业。\r\n第三条 市级高新技术企业认定管理工作应遵循突出企业主体、鼓励技术创新、实施动态管理、坚持公平公正的原则。\r\n第四条 通过认定的市级高新技术企业，其资格自颁发证书之日起有效，有效期为三年。已被认定为高新技术企业或被纳入海南省高新技术企业培育库的企业，不再认定为市级高新技术企业。海南省外的高新技术企业在三亚市注册企业可以根据条件被认定为市级高新技术企业。\r\n第五条 三亚市科技工业信息化局、三亚市财政局、国家税务总局三亚市税务局组成全市市级高新技术企业认定管理工作领导小组（以下称“领导小组”），领导小组负责全市市级高新技术企业的认定、管理和监督工作。领导小组下设办公室，由三亚市科技工业信息化局、三亚市财政局、国家税务总局三亚市税务局相关人员组成，办公室设在三亚市科技工业信息化局。\r\n第二章 认定条件与程序\r\n第六条 认定为市级高新技术企业须同时满足以下条件：\r\n（一）在三亚市注册的居民企业；\r\n（二）企业通过自主研发、受让、受赠、并购等方式，获得对其主要产品（服务）在技术上发挥核心支持作用的知识产权的所有权；\r\n（三）对企业主要产品（服务）发挥核心支持作用的技术属于《国家重点支持的高新技术领域》规定的范围，符合三亚市重点产业发展政策导向；\r\n（四）企业从事研发和相关技术创新活动的科技人员占企业当年职工总数的比例不低于10%，近一个会计年度缴交社会保险或个人所得税超过3个月（含）的职工不少于3人；\r\n（五）企业近三个会计年度（实际经营期不满三年的按实际经营时间计算，下同）的研究开发费用总额占同期销售收入总额的比例符合如下要求：\r\n1.最近一年销售收入小于3000万元（含）的企业，比例不低于4%；\r\n2.最近一年销售收入在3000万元以上的企业，比例不低于3%；\r\n其中，企业在中国境内发生的研究开发费用总额占全部研究开发费用总额的比例不低于60%；\r\n（六）近一年高新技术产品（服务）收入占企业同期总收入的比例不低于50%；\r\n（七）根据《高新技术企业认定管理工作指引》中企业创新能力评价标准进行评价，综合得分为50分以上（含50分）的企业。\r\n（八）企业申请认定前一年内未发生重大安全、重大质量事故或严重环境违法行为。\r\n第七条 市级高新技术企业认定程序如下：\r\n（一）企业申请\r\n企业对照本办法进行自我评价。认为符合认定条件的,向领导小组提出认定申请。申请时提交下列材料：\r\n1.三亚市市级高新技术企业认定申请书、企业工商注册地和税务登记地自被认定之日起5年内不迁离三亚的承诺书；\r\n2.证明企业依法成立的相关注册登记证件;\r\n3.知识产权相关材料、科研项目立项证明、科技成果转化、研究开发的组织管理等相关材料；\r\n4.企业高新技术产品（服务）的关键技术和技术指标、生产批文、认证认可和相关资质证书、产品质量检验报告等相关材料；\r\n5.企业职工和科技人员情况说明材料(含缴交的社会保险或个人所得税等证明材料)；\r\n6.经具有资质的中介机构出具的企业近三个会计年度研究开发费用和近一个会计年度高新技术产品（服务）收入专项审计或鉴证报告，并附研究开发活动说明材料；\r\n7.经具有资质的中介机构鉴证的企业近三个会计年度财务会计报告（包括会计报表、会计报表附注和财务情况说明书）；\r\n8.近三个会计年度企业所得税年度纳税申报表。\r\n（二）专家评审\r\n专家组对企业申报材料进行评审，提出评审意见。\r\n1.专家条件\r\n（1）具有中华人民共和国公民资格，并在中国大陆境内居住和工作。\r\n（2）技术专家应具有高级技术职称，并具有《国家重点支持的高新技术领域》内相关专业背景和实践经验，对该技术领域的发展及市场状况有较全面的了解。财务专家应具有相关高级技术职称，或具有注册会计师或税务师资格且从事财税工作6年以上。\r\n（3）具有良好的职业道德，坚持原则，办事公正。\r\n（4）了解国家科技、经济及产业政策，熟悉高新技术企业认定工作有关要求。\r\n2.专家库及专家选取办法\r\n（1）领导小组建立专家库（包括技术专家和财务专家），实行专家聘任制和动态管理，备选专家应不少于评审专家的3倍。\r\n（2）领导小组根据企业主营产品（服务）的核心技术所属技术领域随机抽取专家，组成专家组，并指定1名技术专家担任专家组组长，开展认定评审工作。\r\n（三）审查认定\r\n领导小组结合专家组评审意见，对申请企业进行综合审查，提出认定意见并将认定企业在“三亚市人民政府网”公示不少于10个工作日，无异议的，予以备案，并在“三亚市人民政府网”公告，由领导小组颁发“三亚市市级高新技术企业证书”；有异议的，由领导小组进行核实处理。\r\n第三章 监督管理\r\n第八条 对已认定的市级高新技术企业，在日常管理过程中发现其不符合认定条件的，由领导小组进行复核。复核后确认不符合认定条件的，取消其市级高新技术企业资格。\r\n第九条 市级高新技术企业发生更名或与认定条件有关的重大变化（如分立、合并、重组以及经营业务发生变化等），应在三个月内向领导小组报告。经领导小组审核符合认定条件的，其市级高新技术企业资格不变，对于企业更名的，重新核发认定证书，编号与有效期不变；不符合认定条件的，自更名或条件变化年度起取消其市级高新技术企业资格。\r\n第十条 已认定的市级高新技术企业，有下列行为之一的，由领导小组取消其市级高新技术企业资格：\r\n（一）在申请认定过程中存在严重弄虚作假行为的；\r\n（二）发生重大安全事故、重大质量事故、严重环境违法行为或有严重失信行为的；\r\n（三）未按第九条要求报告有关重大变化情况的；\r\n（四）连续6个月未报送企业生产经营统计数据的。\r\n第十一条 企业在申报过程中存在弄虚作假行为的，一经查实，由领导小组追缴其获得的奖励资金。\r\n第十二条 享受本办法的企业须书面承诺自认定之日起5年内工商注册地和税务登记地不迁离三亚市，如搬离或更改的，全额退还其所获得的奖励资金。\r\n第四章 扶持措施\r\n第十三条 鼓励市级高新技术企业加大研发投入，根据企业上一年度享受研发费用税前加计扣除政策的研发经费数额，对企业给予资金奖励。奖励额度按上一年度研发经费数额的30%给予补助，不超过该企业上一年度对三亚形成的地方财力贡献（不含契税、土地增值税及与房地产相关的财力），最高不超过50万元。本条与三亚市其他同类型优惠扶持政策，企业可按就高原则申请享受，但不得重复享受,每家企业最多可享受此政策三年。\r\n第十四条 首次被认定为市级高新技术企业的，给予一次性10万元奖励；对市级高新技术企业通过高新技术企业认定的，给予一次性40万元奖励。\r\n第十五条 已被认定为高新技术企业或被纳入海南省高新技术企业培育库的企业，在其有效期内可以申请享受本办法第十三条的政策；直接被认定为高新技术企业（含已被认定或重新被认定且在有效期内的企业）给予一次性50万元奖励；对于省外整体迁入我市的高新技术企业，在其高新技术企业资格有效期内完成迁移的，给予一次性50万元奖励。\r\n第十六条 鼓励科技服务机构对企业申报高新技术企业进行服务，鼓励孵化器和众创空间培育和引进高新技术企业，根据上一年度服务、培育和引进高新技术企业的数量，按5万元/家的标准，给予科技服务机构、孵化器和众创空间一次性奖励；企业自行申报成功的，给予5万元一次性奖励。\r\n第五章 附则\r\n第十七条 本办法由三亚市科技工业信息化局、三亚市财政局、国家税务总局三亚市税务局负责解释。\r\n第十八条 本办法自2020年2月7日起施行，有效期三年。', NULL, NULL, NULL, 1, '2021-09-23 01:37:47', '2021-09-23 01:37:47', 0);
INSERT INTO `policy` VALUES (8, '海南省人民政府关于印发《海南省促进\r\n知识产权发展的若干规定(修订)》的通知', '2020-04-10 00:45:20', '琼府〔2020〕25号', '自贸港政策', '各市、县、自治县人民政府，省政府直属各单位：\r\n现将《海南省促进知识产权发展的若干规定（修订）》印发给你们，请认真贯彻执行。\r\n海南省人民政府\r\n2020年4月10日\r\n\r\n海南省促进知识产权发展的若干规定\r\n（修订）\r\n\r\n第一条  为有效促进知识产权创造、运用、保护、管理和服务，以知识产权发展促进海南自由贸易试验区和中国特色自由贸易港建设，根据《中共中央 国务院关于支持海南全面深化改革开放的指导意见》和《国务院关于新形势下加快知识产权强国建设的若干意见》精神，结合我省实际，制定本规定。\r\n第二条  本规定适用于海南省辖区内的企事业单位、高等院校、科研机构、中介服务机构以及其他社会组织和个人，个别条款有特别说明的除外。本规定所列资助、奖励项目均为后补助性质,所有项目均指上一年度完成项目。\r\n第三条  鼓励发明创造，对以本省地址获得国内授权的发明专利，每件给予0.8万元资助。\r\n第四条  通过专利合作条约（PCT）途径和巴黎公约途径提出的国外专利申请，在完成国际阶段审查并进入国家(地区)公布的，每件给予1万元资助；获得国外授权的专利，按欧洲、美国、日本每件给予6万元资助，其他国家（地区）每件给予3万元资助。\r\n第五条  通过马德里体系提出的国际商标申请，在完成国际阶段审查并在世界知识产权组织（WIPO）国际商标公告上公布的，每件给予1万元资助。\r\n第六条  鼓励地理标志保护和运用，对获批的地理标志保护产品或地理标志商标，每件给予10万元资助。\r\n第七条  扶持植物新品种的培育，鼓励植物新品种的推广应用。对获得国家业务主管部门授予的植物新品种权，由省业务主管部门负责核审，给予每件10万元资助。\r\n第八条  鼓励我省企业和相关单位将技术转化为国际标准和国家标准及行业标准。对专利技术转化为国际标准的，每项给予10万元奖励；对专利技术转化为国家标准和行业标准的，每项分别给予5万元和3万元奖励。\r\n第九条  鼓励金融机构、信用担保机构为知识产权转化运用提供质押贷款、担保等服务。具体补助、补偿的标准和适用范围参照《海南省知识产权质押融资管理办法》执行。\r\n第十条  鼓励探索知识产权证券化，对试点成功发行的知识产权证券，每单给予不高于50万元奖励；对牵头组织单位给予不高于10万元奖励。本条适用于在海南省知识产权管理部门指导下，进行知识产权证券化探索的知识产权权利人和牵头单位以及其他社会组织和个人。\r\n第十一条  对获得中国专利金奖、银奖、优秀奖的专利权人，分别给予60万元、40万元和30万元奖励。对获得海南省专利奖金奖、优秀奖的专利权人，分别给予15万元、10万元奖励。同一年因同一项目既获得中国专利奖，又获得海南省专利奖的，不重复奖励。\r\n第十二条  对获得中国商标金奖的企业给予50万元奖励。对获得驰名商标的企业给予30万元奖励。\r\n第十三条  国家知识产权局认定的知识产权优势企业，且该单位有效发明专利达到3件以上的，给予30万元奖励；认定的知识产权示范企业，且该单位有效发明专利达到5件以上的，给予50万元奖励。\r\n第十四条 首次通过《企业知识产权管理规范》(GB/T29490-2013)《高等学校知识产权管理规范》（GB/T33251-2016）或者《科研组织知识产权管理规范》（GB/T33250-2016）国家标准认证的企业、高等学校、科研机构，针对实际发生的认证费用给予资助，每家资助不超过5万元。\r\n第十五条  鼓励中小学普及知识产权教育，对列入国家知识产权教育试点、示范的学校，分别给予15万元、20万元经费支持；对列入省知识产权教育试点、示范的学校，分别给予10万元、15万元奖励。资金用于普及和支持知识产权教育、奖励师生发明创造。\r\n第十六条  省知识产权管理部门根据全省知识产权工作需要，对知识产权课题研究和制度创新给予资助和奖励。本条适用于国内企事业单位、高等院校、科研机构、中介服务机构。\r\n第十七条  本规定由海南省知识产权局负责解释。\r\n第十八条  本规定自2020年5月1日起施行，有效期5年。本规定施行前的相关规范性文件与本规定有冲突的,以本规定为准。', NULL, NULL, NULL, 1, '2021-09-23 01:37:47', '2021-09-23 01:37:47', 0);
INSERT INTO `policy` VALUES (9, '海南省人民政府办公厅关于促进总部经济发展的工作意见', '2018-05-19 00:46:14', '琼府办〔2018〕37号', '自贸港政策', '各市、县、自治县人民政府，省政府直属各单位：\r\n为贯彻落实《中共中央 国务院关于支持海南全面深化改革开放的指导意见》(中发〔2018〕12号)要求，吸引总部企业集聚，促进总部经济发展，加快我省经济结构转型升级和构建现代化经济体系，现提出以下工作意见。\r\n一、明确发展目标。积极引进跨国企业、国内大型企业集团等总部企业在我省落户、集聚和发展，鼓励我省现有总部企业做大做强做优，培育我省现有企业发展升级为总部企业。2018年全省总部经济全面起步，2020年总部经济基本成形，2025年总部经济基本成势。\r\n二、确定重点区域。积极推进我省总部基地建设，将我省发展总部经济的重点区域布局在海口市、三亚市，根据全省总体规划，大力支持海口市、三亚市规划和建设总部基地，引导总部企业集聚发展。\r\n三、加强财力保障。省财政对海口市、三亚市建设总部基地和总部企业自建自用办公楼宇的土地出让金省级财政集中部分，按照专项转移支付方式拨付海口市、三亚市;省财政对新落户总部企业地方财力(指企业纳税额地方留成部分)贡献和现有总部企业新增地方财力贡献的省级财政留成部分，按照“前三年100%、后两年50%”标准奖励海口市、三亚市。其他市县引进新落户总部企业，报海南省促进总部经济发展联席会议(以下简称联席会议)审定后，可按上述财力保障标准执行。对在本省范围内重新变更注册地的总部企业，不纳入省财政对市县的总部经济奖补范围;省财政按照“前三年100%、后两年50%”标准，将总部企业地方财力贡献的市县财政留成部分从迁入市县拨付迁出市县。\r\n四、出台扶持政策。省有关部门出台海南省总部企业认定管理办法，海口市、三亚市依据管理办法对符合条件的总部企业实施认定，报联席会议办公室备案。海口市、三亚市分别出台促进总部经济发展的扶持政策和操作办法，对符合条件的总部企业及其人才给予补助和奖励，上述扶持政策经联席会议审核，报省政府备案后印发执行。\r\n五、加强招商推介。省有关部门、海口市和三亚市要加大我省总部经济优惠政策的宣传推介力度，着力引进跨国企业、国内大型企业集团、运营中心、结算中心等总部企业;积极引进境内外知名的会计、法律、管理咨询、培训等专业服务机构，为总部企业提供服务。\r\n六、落实人才政策。对符合我省高层次人才认定条件的总部企业高级管理人员、专业人才，其本人及其配偶、未成年子女可按有关规定享受出入境、居留、落户、社会保险、医疗保障、人才安居、入园入学、就业等方面的便利政策。\r\n七、优化政务服务。省有关部门、海口市和三亚市要通过体制机制创新推动总部经济发展，完善促进总部经济发展的服务保障机制，制定总部经济统计制度、总部经济评价考核制度等，搭建总部企业管理服务信息平台，实施规范高效的管理和服务;省有关部门、海口市和三亚市负责制定促进总部经济发展的具体便利化措施，为总部企业开展便利化管理服务。\r\n八、建立工作机制。建立海南省促进总部经济发展联席会议制度，统筹全省总部经济发展工作。联席会议第一召集人为常务副省长，召集人为分管副省长，成员由省有关部门、海口市政府和三亚市政府负责人组成，负责研究工作推进中的重大问题和重大事项;联席会议办公室设在省商务厅，负责联席会议的组织协调、总部企业备案管理等日常工作。省财政对联席会议成员单位开展总部经济发展工作给予经费保障。\r\n\r\n海南省人民政府办公厅\r\n                                           2018年5月19日', NULL, NULL, NULL, 1, '2021-09-23 01:37:47', '2021-09-23 01:37:47', 0);
INSERT INTO `policy` VALUES (10, '关于《海口市关于加快高新技术产业发展的若干措施》的政策解读', '2020-11-06 00:47:42', '海府规〔2020〕9号', '奖励政策', '一、政策背景\r\n\r\n习近平总书记“4·13”重要讲话、中央12号文件和海南省自由贸易港实施总体方案均明确将高新技术产业列为我省发展的三大主导产业之一，提出大力发展高新技术产业。高新技术企业（以下简称“高企”）是高新技术产业发展的重要力量和创新主体。高企数量比例已经纳入省委对各市县高质量发展的核心考核指标，2020年省里下达我市的任务指标为新增高企186家，总量达到600家，比2019年指标增加45%，发展任务较重，需要加大培育力度。\r\n\r\n我市高新技术产业规模仍然较小、结构不平衡、基础较弱，应把握住自贸港建设聚焦发展高新技术产业的契机，在自贸港政策的总体框架下完善我市高新技术产业发展政策，以财政杠杆撬动企业加大创新投入，促进产业发展。\r\n\r\n二、制定的主要依据和参考政策\r\n\r\n（一）海南省：《海南省促进高新技术产业发展的若干规定》：经认定的高新技术企业，一次性给予50万元奖励，奖励资金专项用于企业技术创新。\r\n\r\n（二）海口市：《海口市人民政府关于鼓励科技创新的若干政策》（海府规〔2019〕1号）：对首次通过认定的高新技术企业给予20万元奖励；对再次通过认定的高新技术企业给予10万元奖励；对省外整体迁入我市的高新技术企业，在其高新技术企业资格有效期内完成迁移的，一次性给予50万元的研发资金补贴。\r\n\r\n（三）海口高新区：《海口国家高新区高新技术企业奖励暂行规定》：符合奖励条件的企业将一次性给予30万元奖励，奖励资金将专项用于企业技术创新。\r\n\r\n（四）三亚市：直接被认定为高新技术企业给予一次性50万元奖励；对于省外整体迁入我市的高新技术企业，在其高新技术企业资格有效期内完成迁移的，给予一次性50万元奖励。\r\n\r\n（五）三亚市崖州湾科技城：高企搬迁奖励资100万元，高企首次认定奖励50万元。\r\n\r\n（六）北京市怀柔区：对首次获得国家高新技术企业认定的和区外新迁入的国家高新技术企业给予30万元的奖励。\r\n\r\n（七）石家庄市：首次认定奖励：20万；重新认定奖励：10万。\r\n\r\n（八）石家庄高新区：对首次通过高企认定的企业，一次性给予30万元补助；对重新通过高企认定的企业（2008年以来曾经通过高企认定的），一次性给予5万元补助。\r\n\r\n（九）济南市：首次通过认定的高新技术企业补助资金最高10万元。\r\n\r\n    三、修改情况    \r\n\r\n市科工信局认真研究，对政策进行了修改并征求意见。根据9月24日市政府专题会审议意见，并对2019年、2020-2022年高企财政奖补资金的使用效益做了评估测算。2020年10月23日，《措施》经十六届市政府第130次常务会议审议通过。\r\n\r\n    四、主要内容\r\n\r\n    本政策共13条。奖补内容集中在第五条至第十条。\r\n\r\n包括：首次认定和再次认定高企奖励（第五条），进入高企培育库奖励（第六条），高企整体迁入奖励（第七条），高企上市融资奖励（第八条），五个重点产业高质量发展奖励（第九条），以及科技中介机构奖励（第十条）。\r\n\r\n    五、主要政策考虑\r\n\r\n（一）统筹财力与扶持力度关系。奖励方式及额度参考了国内19个省市及我省、三亚等市县的通行做法，以财政资金奖励或补贴方式，对认定、引进、上市高企以及重点产业高质量发展进行支持。设定各项奖励政策，有关奖励条目设置高限，并进行测算，基本在我市财力承担范围内。\r\n\r\n（二）支持的五个重点产业领域与国家新基建战略部署、海南自贸港建设总体产业布局相契合，是我市高新技术产业发展的优势和侧重点，以固定资产投资、财政贡献成长性、技术改造、中央及省财配套、业务发展等方式给予事后奖补，利于培育我市高新技术产业特色，优化产业结构，形成特色产业集聚。\r\n\r\n    （三）奖补科技中介服务机构有利于弥补企业在高企认定工作中的技术短板，发挥科技中介在高企培育、招商、服务等方面的资源和技术优势，完善我市高新技术产业服务体系。\r\n\r\n', NULL, NULL, NULL, 1, '2021-09-23 01:37:47', '2021-09-23 01:37:47', 0);
INSERT INTO `policy` VALUES (11, '海南省高层次人才认定流程', NULL, NULL, '人才认定政策', '海南省高层次人才认定坚持公开、公平、公正原则，坚持品德、知识、能力和业绩兼顾原则，坚持业内认可、市场认可、社会认可原则。依其业绩和贡献不同，划分为大师级人才、杰出人才、领军人才、拔尖人才、其他类高层次人才5个层次。\r\n\r\n一、认定对象\r\n\r\n高层次人才的认定对象不受国籍、户籍限制。\r\n\r\n高层次人才认定对象为在我省全职工作的人才（含中央驻琼单位和总部企业人才），年龄一般在60周岁以下。退休返聘符合杰出人才、领军人才认定标准的可以放宽至65周岁，符合大师级人才认定标准的可以放宽至70周岁。急需紧缺等特殊人才，可以适当放宽年龄限制。\r\n\r\n公务员及参照公务员法管理机关（单位）工作人员不列入认定对象（国家另有规定的除外）。\r\n\r\n二、认定程序\r\n\r\n高层次人才认定申请常年分批受理。\r\n\r\n（一）个人申报。个人向所在单位提出认定申请，提交有关证明材料，并对照认定标准，选择认定层次，填写《海南省高层次人才认定申报表》。\r\n\r\n（二）单位推荐。申报人所在单位对申报人各项条件进行审核，对符合条件的申报材料作出推荐意见（推荐意见应对申请人的遵纪守法、职业道德、工作能力和业绩情况等作出评价），报送省人才服务中心。\r\n\r\n（三）审核认定。省人才服务中心根据《海南省高层次人才认定办法》《海南省高层次人才分类标准（2019年）》等文件对单位申报的材料进行审核认定。\r\n\r\n（四）备案和发证。省人才服务中心对认定人员名单进行登记备案，颁发相应的《海南省高层次人才证书》。\r\n\r\n三、认定方式\r\n\r\n（一）网上申报。申报人所在单位登陆“海南政务服务网”（https://wssp.hainan.gov.cn/），选择“法人注册”。注册成功后，选择“人才事项服务”，找到对应领域的高层次人才认定选项，并点击“在线申办”，按要求上传材料进行申报。\r\n\r\n（二）窗口申报。申报人所在单位对申报人各项条件进行审核，符合条件的在申报表中作出推荐意见，报送省级人才服务“一站式”窗口。其中会计、林业行业的需要经省级行业主管部门审核认定后，报送省级人才服务“一站式”窗口。\r\n\r\n四、申报材料\r\n\r\n（一）《海南省高层次人才认定申报表》（封面需加盖申报单位公章，A4纸双面打印，一式三份）；\r\n\r\n（二）身份证明复印件；\r\n\r\n（三）劳动合同和任职文件复印件；\r\n\r\n（四）与认定层级和标准相对应的具体佐证材料；\r\n\r\n（五）海南省内单位提供社会保险缴纳记录单，驻琼单位提供在海南缴纳个人所得税清单和社会保险缴纳记录单；\r\n\r\n（六）近期2寸免冠白底证件照（JPG格式的电子照片）；\r\n\r\n五、认定有关要求\r\n\r\n（一）高层次人才认定不设名额限制；\r\n\r\n（二）高层次人才除应当具备认定标准规定的条件外，还应当同时具备各以下条件：1.遵纪守法；2.有良好的职业道德，严谨的工作作风；3.业绩显著，贡献突出；\r\n\r\n（三）高层次人才作出认定后，可以按规定享受相应的激励保障待遇；\r\n\r\n（四）高层次人才认定周期为5年，5年后应当在到期前1个月按照简化程序重新进行认定。简化程序为：由所在单位统一申报，登记备案并颁发相应的《海南省高层次人才证书》。没有继续认定的，不再享受相关激励保障待遇。\r\n\r\n（五）单位或者个人协助申报人弄虚作假，提供虚假证明或者作出虚假审核意见的，将列入诚信黑名单，并在全省通报批评。\r\n\r\n六、认定受理窗口\r\n\r\n受理单位：省人才服务中心\r\n\r\n受理地址：海南省海口市国兴大道9号海南省政务服务中心1楼人才服务窗口\r\n\r\n受理时间：周一至周五上午08:00-12:00 下午14:30-17:30', NULL, NULL, NULL, 1, '2021-09-23 01:37:47', '2021-09-23 01:37:47', 0);
INSERT INTO `policy` VALUES (12, '2021年省重点研发计划项目 （高新技术、现代农业、社会发展方向） 申报指南的通知', '2021-02-20 01:44:24', '琼科〔2021〕43号', '项目申报政策', '各有关单位：\r\n\r\n根据省政府重点工作部署和科技工作计划安排，按省重点研发计划组织管理相关要求，现将《2021年省重点研发计划项目（高新技术、现代农业、社会发展方向）申报指南》予以发布。请根据指南要求组织申报工作,现就有关事项通知如下。\r\n\r\n一、申报范围及要求\r\n\r\n详见附件《2021年海南省重点研发计划项目（高新技术、现代农业、社会发展方向）申报指南》，2021年省重点研发计划软科学和科技合作方向的申报指南另行发布。\r\n\r\n二、在线申报\r\n\r\n网上申报，申报材料通过海南省科技业务综合管理系统（http://218.77.186.200/egrantweb/index）网上填报。申报流程为：\r\n\r\n1.注册帐号。首次申报省级科技计划项目的单位，需登陆海南省科技业务综合管理系统，点击“注册”，按照提示完成注册流程。每个单位只能注册一个“单位管理员”帐号（“单位管理员”帐号不能直接申报项目），“单位管理员”帐号可以创建本单位“项目申报人”帐号，本单位的“项目申报人”帐号由单位管理员统一管理。（已在本系统注册的单位或人员可以直接使用原账号登陆，不需要重新注册。）\r\n\r\n2.预申报。项目申报人登陆系统，在线提交不超过2000字的《海南省重点研发计划项目预申报书》，详细说明申报项目的目标和指标，简要说明创新思路、技术路线和研究基础，确认无误后提交至本单位管理员进行审核，申报单位管理员审核申报材料后，在管理系统内提交至省科技厅。预申报采取通讯评审的方式，遴选出进入会议评审的申报项目，通知项目申报人再提交详细的正式申报书。\r\n\r\n3.正式申报。项目申报人在接到正式申报通知后，登陆系统在线填写《海南省重点研发计划项目申报书》，在附件栏上传相关材料，确认无误后提交至本单位管理员进行审核，申报单位管理员审核申报材料后，在管理系统内提交至省科技厅。正式申报采取会议评审的方式遴选拟立项项目。\r\n\r\n三、注意事项\r\n\r\n（一）本年度实行无纸化申报，申报人填写预申报书、申报书前，应仔细阅读有关填写说明，并按要求认真填写，务必完整、准确、真实；如因工作需要提交纸质材料，由科技厅另行通知。\r\n\r\n（二）申报人在管理系统中填写申请书并扫描上传加盖公章的申报书封面页、审核意见页和承诺书。承诺项目申报单位上报的材料和数据真实、合法、有效，并具备开展项目实施的科研基础条件、科研人员实力和财务配套基础。\r\n\r\n（三）申报人未按要求上传相关材料的，一律不予受理。\r\n\r\n（四）项目单位和项目负责人在申报过程中如有弄虚作假等有违科研诚信的行为，将被纳入社会信用系统。\r\n\r\n（五）获得立项的项目将在省科技厅门户网站进行公示，未立项的项目不再另行通知。\r\n\r\n四、时间要求\r\n\r\n网上预申报时间为40天，截止时间为2021年3月31日24:00，届时申报系统将自动关闭。请各单位提前做好项目申报工作，避免集中造成拥堵。正式申报时间20天，起始时间另行通知。\r\n\r\n五、申报咨询电话\r\n\r\n申报指南各支持方向业务性问题咨询：\r\n\r\n高新技术方向：65323068；\r\n\r\n现代农业方向：65342626；\r\n\r\n社会发展方向：66290357；\r\n\r\n申报系统技术咨询：65347994；65389015。\r\n\r\n附件:2021年省重点研发计划项目（高新技术、现代农业、社会发展方向）申报指南\r\n\r\n海南省科学技术厅\r\n\r\n2021年2月18日\r\n\r\n（此件主动公开）', NULL, NULL, NULL, 1, '2021-09-23 01:37:47', '2021-09-23 01:37:47', 0);
INSERT INTO `policy` VALUES (13, '关于申报2021年海南省基础与应用基础研究计划（省自然科学基金）项目的通知', '2021-01-26 01:48:46', '琼科{2021}31号', '项目申报政策', '海南省科学技术厅关于申报\r\n\r\n2021年海南省基础与应用基础研究计划\r\n\r\n（省自然科学基金）项目的通知\r\n\r\n各高等院校、科研院所及有关事业单位：\r\n\r\n为做好2021年海南省基础与应用基础研究计划（省自然科学基金）项目申报工作，现将有关事项通知如下：\r\n\r\n一、申报范围及要求\r\n\r\n2021年海南省基础与应用基础研究计划（省自然科学基金）项目申报范围及要求详见申报指南（附件1）。\r\n\r\n二、申报流程\r\n\r\n登陆海南省科技业务综合管理系统（http://218.77.186.200）网上填报。申报流程如下：\r\n\r\n（一）注册帐号。首次申报省级科技计划项目的单位，需登陆海南省科技业务综合管理系统，点击“注册”，按照提示完成注册流程。每个单位只能注册一个“单位管理员”帐号（“单位管理员”帐号不能直接申报项目），“单位管理员”帐号可以创建本单位“项目申报人”帐号，本单位的“项目申报人”帐号由单位管理员统一管理（已在本系统注册的单位或人员可以直接使用原账号登陆，不需要重新注册）。\r\n\r\n（二）网上填写。项目申报人登陆系统后在线填写《海南省自然科学基金项目申请书》，确认无误后在线提交至本单位管理员进行审核，相关佐证材料通过附件上传。\r\n\r\n（三）在线审核。申报单位管理员审核申报材料，确认无误后，提交至省科技厅（同时管理系统自动生成正式PDF申请书）。\r\n\r\n三、申报材料\r\n\r\n（一）申报人需仔细阅读填写说明，并按要求认真填写，务必完整、准确、有效。\r\n\r\n（二）申报单位按照2021年海南省基础与应用基础研究计划（省自然科学基金）申报限项清单（详见附件2）要求进行遴选推荐，并在管理系统中上传单位推荐函，不接受个人单独申报。\r\n\r\n（三）本年度实施无纸化受理，申报人在管理系统中填写申请书并上传相关佐证材料；承诺书与推荐意见表生成PDF文档，需要项目负责人和主要成员签名并加盖单位公章（合作研究单位均需盖章）后作为附件上传管理系统。\r\n\r\n（四）申报人未按要求上传佐证材料的、上传的承诺书与推荐意见表中申报人和项目组成员未签字的、申报单位和合作研究单位未盖章的，以及依托单位未在管理系统中上传单位推荐函的，一律不予受理。\r\n\r\n四、时间要求\r\n\r\n（一）网上申报截止时间为2021年3月22日17:00，届时申报系统将自动关闭。\r\n\r\n（二）由于报送时间相对集中，请申报人和申报单位提前做好项目申报工作，避免网络拥堵。\r\n\r\n五、咨询联系方式\r\n\r\n（一）申报项目咨询电话\r\n\r\n联 系 人：王飞、崔晓东\r\n\r\n联系电话：65343316、65329135\r\n\r\n（二）申报系统技术问题咨询电话系统技术服务人员电话：65389015\r\n\r\n附件：1.2021年海南省基础与应用基础研究计划（省自然科学基金）项目申报指南\r\n\r\n      2.2021年海南省基础与应用基础研究计划（省自然科学基金）申报限项清单\r\n\r\n\r\n\r\n海南省科学技术厅\r\n\r\n2021年1月26日', NULL, NULL, NULL, 1, '2021-09-23 01:37:47', '2021-09-23 01:37:47', 0);
INSERT INTO `policy` VALUES (14, '关于海南自由贸易港自用生产设备“零关税”政策的通知', '2021-03-04 00:34:26', '财关税〔2021〕7号', '自贸港政策', '海南省财政厅、海口海关、国家税务总局海南省税务局：\r\n　　为贯彻《海南自由贸易港建设总体方案》，经国务院同意，现将海南自由贸易港自用生产设备“零关税”政策通知如下：\r\n　　一、全岛封关运作前，对海南自由贸易港注册登记并具有独立法人资格的企业进口自用的生产设备，除法律法规和相关规定明确不予免税、国家规定禁止进口的商品，以及本通知所附《海南自由贸易港“零关税”自用生产设备负面清单》所列设备外，免征关税、进口环节增值税和消费税。\r\n　　二、本通知所称生产设备，是指基础设施建设、加工制造、研发设计、检测维修、物流仓储、医疗服务、文体旅游等生产经营活动所需的设备，包括《中华人民共和国进出口税则》第八十四、八十五和九十章中除家用电器及设备零件、部件、附件、元器件外的其他商品。\r\n　　三、符合第一条规定条件的企业名单以及从事附件涵盖行业的企业名单，由海南省发展改革、工业和信息化等主管部门会同海南省财政厅、海口海关、国家税务总局海南省税务局确定，动态调整，并函告海口海关。\r\n　　四、《海南自由贸易港“零关税”自用生产设备负面清单》详见附件。清单内容由财政部、海关总署、税务总局会同相关部门，根据海南自由贸易港实际需要和监管条件进行动态调整。\r\n　　五、《进口不予免税的重大技术装备和产品目录》、《外商投资项目不予免税的进口商品目录》以及《国内投资项目不予免税的进口商品目录》，暂不适用于海南自由贸易港自用生产设备“零关税”政策。符合本政策规定条件的企业，进口上述三个目录内的设备，可免征关税、进口环节增值税和消费税。\r\n　　六、为便于执行，财政部、海关总署将会同有关部门另行明确第二条中家用电器及设备零件、部件、附件、元器件商品范围。\r\n　　七、“零关税”生产设备限海南自由贸易港符合政策规定条件的企业在海南自由贸易港内自用，并接受海关监管。因企业破产等原因，确需转让的，转让前应征得海关同意并办理相关手续。其中，转让给不符合政策规定条件主体的，还应按规定补缴进口相关税款。转让“零关税”生产设备，照章征收国内环节增值税、消费税。\r\n　　八、企业进口“零关税”自用生产设备，自愿缴纳进口环节增值税和消费税的，可在报关时提出申请。\r\n　　九、海南省相关部门应通过信息化等手段加强监管、防控风险、及时查处违规行为，确保生产设备“零关税”政策平稳运行，并加强省内相关部门信息互联互通，共享符合政策条件的企业、“零关税”生产设备的监管等信息。\r\n　　十、本通知自公布之日起实施。', NULL, NULL, NULL, 1, '2021-09-23 01:37:47', '2021-09-23 01:37:47', 0);
INSERT INTO `policy` VALUES (15, '关于海南自由贸易港鼓励类产业企业实质性运营有关问题的公告', '2021-03-04 08:00:00', NULL, '奖励政策', '<p>为贯彻落实《海南自由贸易港建设总体方案》，促进海南自由贸易港鼓励类产业企业发展，根据《财政部 国家税务总局关于海南自由贸易港企业所得税优惠政策的通知》（财税〔2020〕31号）、《国家税务总局海南省税务局关于海南自由贸易港企业所得税优惠政策有关问题的公告》（国家税务总局海南省税务局公告2020年第4号）规定，现就海南自由贸易港（以下简称“自贸港”）鼓励类产业企业实质性运营有关问题公告如下：</p><p>一、本公告适用于注册在自贸港的居民企业、居民企业设立在自贸港的分支机构以及非居民企业设立在自贸港的机构、场所。</p><p>二、注册在自贸港的居民企业，从事鼓励类产业项目，并且在自贸港之外未设立分支机构的，其生产经营、人员、账务、资产等在自贸港，属于在自贸港实质性运营。</p><p>对于仅在自贸港注册登记，其生产经营、人员、账务、资产等任一项不在自贸港的居民企业，不属于在自贸港实质性运营，不得享受自贸港企业所得税优惠政策。</p><p>三、注册在自贸港的居民企业，从事鼓励类产业项目，在自贸港之外设立分支机构的，该居民企业对各分支机构的生产经营、人员、账务、资产等实施实质性全面管理和控制，属于在自贸港实质性运营。</p><p>四、注册在自贸港之外的居民企业在自贸港设立分支机构的，或者非居民企业在自贸港设立机构、场所的，该分支机构或机构、场所具备生产经营职能，并具备与其生产经营职能相匹配的营业收入、职工薪酬和资产总额，属于在自贸港实质性运营。</p><p>五、注册在自贸港的居民企业，其在自贸港之外设立分支机构的，或者注册在自贸港之外的居民企业，其在自贸港设立分支机构的，应严格按照《国家税务总局关于印发&lt;跨地区经营汇总纳税企业所得税征收管理办法&gt;的公告》（国家税务总局公告2012年第57号）的规定，计算总机构及各分支机构应纳税所得额和税款，并按规定缴纳企业所得税。</p><p>六、设立在自贸港的非居民企业机构、场所符合规定条件汇总缴纳企业所得税的，应严格按照《国家税务总局 财政部 中国人民银行关于非居民企业机构场所汇总缴纳企业所得税有关问题的公告》（国家税务总局公告2019年第12号）的规定，计算应纳税所得额和税款，并按规定缴纳企业所得税。</p><p>七、符合实质性运营并享受自贸港鼓励类产业企业所得税优惠政策的企业，应当在完成年度汇算清缴后，按照《国家税务总局海南省税务局关于海南自由贸易港企业所得税优惠政策有关问题的公告》（国家税务总局海南省税务局公告2020年第4号）的规定，归集整理留存相关资料，以备税务机关核查。</p><p>八、企业享受税收优惠政策，应执行查账征收方式征收企业所得税</p><p>九、本公告自2020年1月1日起至2024年12月31日执行。</p><p>特此公告。</p><p><br></p><p>国家税务总局海南省税务局</p><p>海南省财政厅 </p><p>海南省市场监督管理局 </p><p>2021年3月5日</p>', NULL, NULL, NULL, 1, '2021-09-22 08:00:00', '2021-09-22 08:00:00', 0);
INSERT INTO `policy` VALUES (16, '海南省开展合格境内有限合伙人（QDLP）\r\n境外投资试点工作暂行办法', '2021-04-07 08:00:00', NULL, '自贸港政策', '<p>第一章  总  则</p><p>第一条  为积极推进海南自由贸易港建设，促进金融业对外开放，规范开展合格境内有限合伙人境外投资试点工作，根据有关法律、法规，制定本暂行办法。</p><p>第二条  本办法所称的合格境内有限合伙人，是指符合本办法第四章规定的条件，以自有资金认购本办法规定的试点基金的境内自然人、机构投资者或本办法规定的其他投资者。</p><p>本办法所称的试点基金管理企业是指经试点相关单位共同认定、注册在海南省并实际经营的，以发起设立试点基金并受托管理其境外投资业务为主要经营业务的企业，且符合本办法第二章规定。</p><p>本办法所称的试点基金是指由试点基金管理企业依法在海南省发起、以合格境内有限合伙人参与投资设立的、以基金财产按照本办法规定进行境外投资，且符合本办法第三章规定的基金。</p><p>第三条  试点基金管理企业发起设立试点基金，运用试点基金的基金财产对外投资，应符合相关法律、法规和本办法的规定，维护投资者的合法权益。</p><p>第四条  本试点工作在省政府直接领导下，省金融监管部门牵头，相关单位根据职责共同参与。试点相关单位包括但不限于省金融监管部门、外汇管理部门、省市场监管部门、证券监管部门等。省金融监管部门承担试点工作日常事务，负责试点申请资料及其他相关文件的受理，组织试点相关单位审核申请材料，为企业批复试点资格并授予试点额度；外汇管理部门负责本办法所涉跨境资金管理事宜；省市场监管部门负责试点基金管理企业及试点基金的登记注册工作；证券监管部门负责对试点基金管理企业和试点基金的登记备案工作进行指导，并对通过中国证券投资基金业协会登记备案的试点基金管理企业和试点基金业务活动进行监督管理；省发改部门和省商务部门负责对试点基金的投资标的与投资区域是否为敏感类进行指导；其他相关单位根据实际需要配合做好相关工作。</p><p>第五条  试点工作在国家有关部门指导下开展，首批试点企业名单由省政府牵头认定，后续的试点企业名单由省金融监管部门组织外汇管理部门、省市场监管部门和证券监管部门通过会议认定。</p><p>第六条  省金融监管部门应会同试点相关单位共同制定和落实各项政策措施，推进试点工作，协调解决试点过程中的有关问题。</p><p><br></p><p>第二章  试点基金管理企业</p><p>第七条  本办法规定的试点基金管理企业包括内资试点基金管理企业和外商投资试点基金管理企业。外商投资试点基金管理企业，是指按照本办法规定由境外自然人或机构等参与投资设立的试点基金管理企业。</p><p>第八条  试点基金管理企业可从事如下业务：</p><p>（一）发起设立试点基金；</p><p>（二）受托管理试点基金的投资业务并提供相关服务；</p><p>（三）依法开展投资咨询业务。</p><p>第九条  试点基金管理企业可以采用公司制、合伙制等组织形式。</p><p>第十条  试点基金管理企业应符合下列条件：</p><p>（一）试点基金管理企业的注册资本应不低于人民币500万元或等值外币，出资方式仅限于货币，出资应按照公司章程/合伙协议的约定或在取得试点资格之日起2年内（以孰早者为准）全部缴足；</p><p>（二）具备至少1名5年以上以及2名3年以上境外投资管理经验和相关专业资质的主要投资管理人员；主要投资管理人员在最近5年内无违规记录或尚在处理的经济纠纷诉讼案件；</p><p>（三）试点基金管理企业的控股股东、实际控制人或执行事务合伙人中任一主体或上述任一主体的关联实体应具备下列条件：经所在地监管机构批准从事投资管理业务或资产管理业务,具备所在地监管机构颁发的许可证件的金融企业，或具有良好投资业绩且管理基金规模不低于1亿元人民币（或等值外币）的基金管理企业；</p><p>（四）试点基金管理企业的控股股东、实际控制人或执行事务合伙人中任一主体或上述任一主体的关联实体满足净资产应不低于1000万元人民币或等值外币，资产质量良好，在境内外资产管理行业从业3年以上，且具有规范的内部治理结构和健全的内部控制制度，最近1年未受所在地监管机构的重大处罚，无重大事项正在接受司法部门、监管机构的立案调查；</p><p>（五）存续经营的境内试点基金管理企业，应已在中国证券投资基金业协会登记为私募基金管理人，且已在中国证券投资基金业协会完成至少一只私募基金的备案；</p><p>（六）按审慎性原则要求的其他条件。</p><p><br></p><p>第三章  试点基金</p><p>第十一条  试点基金可以采用公司型、合伙型或契约型等形式。</p><p>第十二条  试点基金应满足下列条件：</p><p>（一）认缴出资金额/初始募集规模应不低于人民币3000万元（或等值外币），出资方式仅限于货币形式；</p><p>（二）试点基金的投资者应符合本办法第四章规定，且投资者人数符合法律法规相关规定。</p><p>第十三条  试点基金境外投资应按境外投资相关法律、法规及规范性文件的规定办理，如需履行境外投资备案或核准手续的，应按照相关法律法规的规定办理。试点基金可以基金财产开展如下投资业务：</p><p>（一）境外非上市企业的股权和债券；</p><p>（二）境外上市企业非公开发行和交易的股票和债券；</p><p>（三）境外证券市场（包括境外证券市场交易的金融工具等）；</p><p>（四）境外股权投资基金和证券投资基金；</p><p>（五）境外大宗商品、金融衍生品；</p><p>（六）经国家有关部门批准的其他领域。</p><p><br></p><p>第四章  合格境内有限合伙人适当性管理</p><p>第十四条  试点基金的合格境内有限合伙人是指具备相应风险识别能力和风险承担能力，投资于单只试点基金的金额不低于100万元人民币或等值外币的境内自然人、机构投资者或本办法规定的其他投资者，且符合以下标准：</p><p>（一）净资产不低于1000万元人民币的法人单位；</p><p>（二）金融资产不低于300 万元或者最近三年个人年均收入不低于50 万元的个人。</p><p>前款所称金融资产包括银行存款、股票、债券、基金份额、资产管理计划、银行理财产品、信托计划、保险产品、期货权益等。</p><p>第十五条  下列投资者可视为合格境内有限合伙人：</p><p>（一）社会保障基金、企业年金等养老基金，慈善基金等社会公益基金；</p><p>（二）依法备案的资产管理产品；</p><p>（三）投资于所管理基金的基金管理人及其从业人员；</p><p>（四）中国证券监督管理委员会规定的其他投资者。</p><p>以合伙企业、契约等形式，通过汇集投资者资金直接或者间接投资于试点基金的，试点基金管理企业应当穿透核查最终投资者是否为合格境内有限合伙人，并合并计算投资者人数。但是，符合本条第（一）（二）（四）项规定的投资者投资试点基金的，不再穿透核查最终投资者是否为合格境内有限合伙人和合并计算投资者人数。合格境内有限合伙人应当确保投资资金来源合法，不得非法汇集他人资金投资试点基金。</p><p>第十六条  试点基金管理企业应当切实履行合格境内有限合伙人适当性管理职责，了解客户的身份、财产与收入状况、投资经验、风险偏好、投资目标等相关信息，有针对性地进行风险揭示、客户培训、投资者教育等工作，引导客户在充分了解境外投资市场特性的基础上参与境外投资。</p><p>试点基金管理企业应当建立健全合格境内有限合伙人适当性管理的具体业务制度和操作指引，并通过多种形式和渠道向客户告知适当性管理的具体要求，做好解释和宣传工作。</p><p>试点基金管理企业应当妥善保管客户适当性管理的全部记录，并依法对客户信息承担保密义务；应当指定专人受理客户投诉，妥善处理与客户的矛盾与纠纷，认真记录有关情况，并将客户投诉及处理情况向省金融监管部门报告。</p><p>第十七条  试点基金管理企业和试点基金不得向合格境内有限合伙人承诺保本保收益。合格境内有限合伙人应签署风险揭示书。试点基金管理企业和试点基金应当向合格投资者募集，合格投资者累计不得超过法定人数；不得向合格投资者之外的单位和个人募集资金，不得向不特定对象宣传推介。</p><p><br></p><p>第五章  设立流程</p><p>第十八条  省金融监管部门收取首批试点基金管理企业及试点基金的全部申请材料，组织外汇管理、省市场监管、证券监管、发改和商务等部门共同审核，对其专业程度、私募投资履历、海外投资策略和拟投资项目的实际需要等进行综合评估，提出首批试点企业名单及首次试点额度建议。省金融监管部门将首批试点企业名单及首次试点额度建议报省政府同意后，向申请人出具同意开展首批试点、给予试点额度的书面意见。</p><p>非首批试点基金管理企业或非首次试点额度的申请，省金融监管部门收取全部申请材料，组织外汇管理、省市场监管、证券监管、发改和商务等部门共同审核，根据其专业程度、私募投资履历、海外投资策略和拟投资项目的实际需要等决定是否给予试点资格和额度，由省金融监管部门向申请人出具同意开展试点、给予试点额度的书面意见。</p><p>第十九条  申请成为试点基金管理企业，申请人应提交下列材料：</p><p>（一）试点申请书（模板见附件1）；</p><p>（二）授权委托书（如需）；</p><p>（三）存续经营的试点基金管理企业或其控股股东、实际控制人或执行事务合伙人营业执照/登记注册证明或其他身份证明文件；</p><p>（四）公司章程/合伙协议或草案；</p><p>（五）内部控制制度，包括会计制度、内部审计制度、风险控制制度、信息公开制度等；</p><p>（六）存续经营的境内基金管理企业，应提交在中国证券投资基金业协会私募基金管理人登记记录以及其管理基金在中国证券投资基金业协会的备案记录；</p><p>（七）申请人最近1年未受所在地监管机构的重大处罚且无重大事项正在接受司法部门、监管机构立案调查的承诺函；</p><p>（八）法定代表人或执行事务合伙人（委派代表）及高级管理人员的人员情况表、简历、专业资质证书以及从业证明；</p><p>（九）试点基金管理企业或其控股股东、实际控制人、执行事务合伙人中任一主体或上述任一主体的关联实体须提供上一年度审计报告以及境内外资产管理从业背景介绍，以及金融许可文件、既往投资业绩、基金管理规模的证明材料；</p><p>（十）拟设立试点基金的项目计划及总规模；</p><p>（十一）省金融监管部门和其他试点相关单位按照审慎性原则要求的其他文件。</p><p>第二十条  申请成为试点基金，申请人应提交如下材料：</p><p>（一）计划说明书/募集说明书/推介材料；</p><p>（二）试点基金的公司章程/合伙协议/基金合同或草案；</p><p>（三）拟申请试点基金的委托管理协议或草案（如有）；</p><p>（四）合格境内有限合伙人为机构投资者的，须提交该机构上一年度审计报告；合格境内有限合伙人为自然人投资者的，须提供近3年收入证明、金融资产证明材料或金融净资产承诺函，确保符合本办法的要求；所有合格境内有限合伙人的投资明细、出资凭证（如有）以及风险揭示书；</p><p>（五）试点基金如委托行政管理人负责基金的后台行政管理，须提交行政管理人的营业执照、业务资质证明，最近3年未受到监管机构重大处罚且无重大事项正在接受调查的承诺函，以及基金与行政管理人签署的意向性文件，行政管理人熟悉境外基金行政管理业务的专职人员情况表、简历，内部稽核监控制度和风险控制制度；</p><p>（六）认缴承诺书；</p><p>（七）省金融监管部门和其他试点相关单位按照审慎性原则要求的其他文件。</p><p>第二十一条  试点基金管理企业及试点基金的申请资料须提供正本1份、副本6份，申请资料正本须加盖公章。有关试点基金行政管理人（如有）的证明资料，须同时加盖公章。</p><p>第二十二条  试点基金管理企业和试点基金取得获准试点书面意见后，应凭获准试点书面意见到省市场监管部门办理登记注册，并尽快到中国证券投资基金业协会办理登记备案手续。</p><p>第二十三条  新设试点基金管理企业及试点基金应在注册设立后30个自然日内向省金融监管部门报送试点基金管理企业及试点基金的营业执照、公司章程/合伙协议、委托管理协议、托管协议、境内托管人与境外资产托管人签署的代理协议（如有），并抄送外汇管理部门和证券监管部门。资本金缴足后30个自然日内提供实际缴付注册资本金凭证。</p><p>第二十四条  试点基金管理企业应按照国家法律法规及规范性文件的要求开展资金募集活动，在试点相关单位批准的额度范围内在境内托管人处办理资金相关业务，可以按照公司章程/合伙协议/基金合同的约定进行利润分配或清算，投资收益和资本变动收入应按有关跨境资金管理规定及时汇回境内。</p><p><br></p><p>第六章  购付汇及对外投资流程</p><p>第二十五条  试点基金管理企业应委托一家在海南省设有分支机构的商业银行或具有基金托管资质并符合一定条件的金融机构作为试点基金的境内托管人。境内托管银行应符合下列条件：</p><p>（一）有外汇指定银行资格、证券投资基金托管资格和经营人民币业务资格；</p><p>（二）总部法人最近1个会计年度末实收资本不少于30亿元人民币或等值外币；</p><p>（三）有足够熟悉境内外托管业务的专职人员；</p><p>（四）具备安全托管资产的条件；</p><p>（五）具备安全、高效的清算能力；</p><p>（六）有完善的内部稽核监控制度和风险控制制度；</p><p>（七）最近3年内未受到监管机构的重大处罚，无重大事项正在接受司法部门、监管机构的立案调查；</p><p>（八）最近3年无重大违反外汇及跨境人民币业务管理规定的行为；</p><p>（九）试点相关单位要求的其他条件。</p><p>第二十六条  试点基金的境内托管人应履行的职责包括但不限于：</p><p>（一）须根据募集资金情况，为试点基金开设相应专用账户，对试点基金托管户内资金进行安全托管；</p><p>（二）办理试点基金的有关跨境收支、结售汇业务，严格遵守国际收支申报、银行结售汇统计等外汇管理要求，报送结售汇统计报表并完整保存与申报有关的纸质单据备查；</p><p>（三）境内托管人在业务机制和流程上保证自有资金及托管的其他资产与试点基金的资产完全隔离；</p><p>（四）按照境内外有关法律法规、托管协议的约定办理试点基金资产的清算、交割事宜；</p><p>（五）依法监督试点基金管理企业的投资运作，确保基金按照有关法律法规、投资管理协议约定的投资目标和限制进行管理；如发现投资指令或资金汇出汇入违法、违规，应及时向外汇管理部门汇报，并抄送省金融监管部门、省市场监管部门和证券监管部门；</p><p>（六）保存合格境内有限合伙人的跨境资金汇出、汇入、兑换、资金往来、委托及成交记录等相关资料，保存的时间应不少于20年；</p><p>（七）试点相关单位根据审慎监管原则规定的其他职责。</p><p>第二十七条  试点基金管理企业在取得试点资格以及对外投资额度后，应持获准试点书面意见到外汇管理部门办理外汇登记。试点基金管理企业办理外汇登记应提交如下材料：</p><p>（一）申请书（包括但不限于试点基金管理企业基本情况、拟发起试点基金情况、投资计划等）；</p><p>（二）省金融监管部门出具的同意开展试点、给予试点额度的书面意见；</p><p>（三）营业执照（如有）；</p><p>（四）中国证券投资基金业协会的登记或备案情况（如有）；</p><p>（五）如投资行为需履行境外投资备案或核准手续的，提交境外投资主管部门出具的项目核准文件或备案通知书等相关书面意见。</p><p>第二十八条  试点基金管理企业可凭开展业务相关证明文件开立业务托管资金专用账户。试点基金管理企业开设的涉及试点业务的账户均应纳入托管，并应授权境内托管人对托管资金专用账户进行托管运营与监督。境内托管人作为独立第三方实时监控资金使用情况。试点基金管理企业开立托管资金专用账户，应提交加盖相关主体公章的如下材料并提交原件以供核查：</p><p>（一）试点相关单位出具的同意开展试点、给予试点额度的书面意见；</p><p>（二）试点基金管理企业及试点基金营业执照；</p><p>（三）法定代表人或执行事务合伙人（委派代表）的身份证明文件；</p><p>（四）办理完成外汇登记的证明资料；</p><p>（五）境内托管人要求的其他文件。</p><p>第二十九条 托管资金专用账户的收入范围包括：从境内投资者募集的外汇（含人民币购汇资金）及人民币资金；对外投资赎回款和清算、转股、减资款；利润、分红、利息以及其他经常项下收入；国家外汇管理局允许的其他收入。托管资金专用账户的支出范围包括：划至境外进行规定范围内投资；结汇或直接划至境内有限合伙人账户（或募集结算资金专用账户）；支付相关税费；国家外汇管理局允许的其他支出。</p><p>第三十条  试点基金管理企业募集境内合格有限合伙人资金，可在购汇后或直接以人民币形式通过托管资金专用账户进行境外投资。</p><p>第三十一条  试点基金管理企业发生增资、减资或股东/合伙人变更等重大事项时，须获得试点相关单位批准。试点基金管理企业对外投资额度发生调整时，在获得试点相关单位书面意见后，应到外汇管理部门办理外汇变更登记手续。试点基金管理企业发起成立的所有试点基金清盘后，试点基金管理企业应到外汇管理部门申请办理注销登记。</p><p>第三十二条  境内托管人应在办理资金汇出前审核试点基金的投资范围。如投资行为不需履行境外投资备案或核准手续的，按照试点相关单位出具的书面意见，在试点基金额度限额内，履行托管协议约定进行跨境资金汇划；如投资行为需履行境外投资备案或核准手续的，还应审核境外投资主管部门出具的项目核准文件或备案通知书等相关书面材料，按单笔项目投资规模进行跨境资金汇划。</p><p>第三十三条  境内托管人应加强内控管理，对于保管的境外投资资金分账管理、独立核算，保证与托管人的自有资金及其他托管资金完全隔离。并应保证托管账户内资金安全，依法监督试点基金管理企业的投资运作，执行试点基金管理企业的指令，及时办理清算、交割事宜。境内托管人应按季度编制《海南省合格境内有限合伙人（QDLP）境外投资业务情况表》（模板见附件2），并于每季度结束后10个工作日内报送外汇管理部门，并抄送省金融监管部门。</p><p>第三十四条  基金份额的申购、赎回价格依据申购、赎回日基金份额净值加、减有关费用计算，并由试点基金管理企业或行政管理人审核后出具。</p><p>第三十五条  试点基金收到的投资本金和收益，须得到试点基金管理企业或行政管理人审核确定。已实现的投资收益和本金，应汇至境内托管人的专用账户。</p><p>第七章  行政管理</p><p>第三十六条  试点基金管理企业可自行管理或委托符合本条规定条件的境内企业作为行政事务管理人，负责试点基金的后台行政管理。被委托的行政事务管理人应具备下列条件：</p><p>（一）具备从事基金服务业务的相关资质；</p><p>（二）配备专门从事基金行政管理业务的部门或团队，并有足够熟悉境外基金行政管理业务的专职人员；</p><p>（三）有完善的内部稽核监控制度和风险控制制度；</p><p>（四）最近3年未受到监管机构的重大处罚，无重大事项正在接受司法部门、监管机构的立案调查。</p><p>第三十七条  试点基金管理企业或行政事务管理人应履行的职责包括但不限于：</p><p>（一）依照试点基金的估值政策和流程计算基金的资产净值和投资收益情况，并定期向合格境内有限合伙人发布；</p><p>（二）维护试点基金的财务账簿和记录，并可提供完整的试点基金执行的交易记录；</p><p>（三）维护与试点基金投资、退出及交易有关的支持基金的资产净值计算的所有文件；</p><p>（四）提供与权益的发行、转移和赎回有关的登记及过户代理服务并执行相关操作；</p><p>（五）依照有关反洗钱政策和程序，核实试点基金投资者的身份；</p><p>（六）及时向省金融监管部门、外汇管理部门、省市场监管部门和证券监管部门报送信息。</p><p>第八章  企业额度、投资管理</p><p>第三十八条  对外投资额度实行余额管理。试点基金管理企业发起的所有试点基金本、外币对外投资净汇出（不含股息、税费、利润等经常项目收支）之和不得超过该试点基金管理企业获批的投资额度。试点基金管理企业及试点基金对外投资涉及的资金汇出，应在试点额度内在托管人处办理，并须遵循按需购汇、额度管理和风险提示的原则。</p><p>第三十九条  试点基金管理企业可发起成立多只试点基金。除另有规定外，试点基金管理企业可在其设立的各基金之间灵活调剂单只试点基金对外投资额度，各单只试点基金对外投资额度之和不得超过经试点相关单位批准的试点基金管理企业对外投资额度。</p><p>第四十条  单个试点基金管理企业的额度申请和单个投资项目额度无限制。如无特殊原因，试点基金管理企业在获取试点资格和额度11个月内未使用额度的，省金融监管部门应告知对于一年内未使用额度的试点基金管理企业，省金融监管部门有权取消其试点资格并收回全部试点额度，如需开展业务，需要重新申请试点资格和试点额度。因日后续约或追加投资导致基金获批额度不足的，试点基金管理企业应重新申请追加额度。</p><p>第四十一条  试点基金管理企业应按照相关法律法规、本办法及相关协议的约定，运用所募集的资金投资于境外，不得使用本试点额度在中国境内进行投资。</p><p>第九章  信息披露</p><p>第四十二条  试点基金管理企业、境内托管人、行政事务管理人等信息披露义务人应按照相关法律法规、规范性文件和本办法规定，以及与合格境内有限合伙人的相关约定在基金募集、运作的全过程履行信息披露义务。</p><p>第四十三条  试点基金管理企业可以人民币、美元等主要币种计价并披露试点基金资产净值等相关信息。涉及币种之间转换的，应披露汇率数据来源，并保持一致性和延续性。如出现改变，应同步予以披露并说明改变的理由。人民币对主要外汇的汇率应以报告期末最后一个估值日中国人民银行或其授权机构公布的人民币汇率中间价为准。</p><p>第四十四条  试点基金管理企业应按照以下原则披露投资事项：</p><p>（一）应在募集说明书中详细说明投资策略以及该项策略使用的金融工具，并对相关金融工具进行介绍；</p><p>（二）如投资境外基金的，应披露试点基金与境外基金之间的费率安排；</p><p>（三）如参与融资融券、回购交易，应在募集说明书中按照有关规定进行披露，并应明确披露所用杠杆比率；</p><p>（四）在募集说明书中应对投资境外市场可能产生的下列风险进行披露：境外市场风险、政府管制风险、流动性风险、汇率风险、利率风险、衍生品风险、操作风险、会计核算风险、税务风险、交易结算风险、法律风险等，披露的内容应包括以上风险的定义、特征、可能发生的后果等；</p><p>（五）应按照有关规定对代理投票的方针、程序、文档保管进行披露。</p><p>第四十五条  向合格境内有限合伙人提供的信息披露文件应采用中文文本，同时采用外文文本的，应保证两种文本内容一致。两种文本发生歧义时，以中文文本为准。</p><p>第十章  监督管理</p><p>第四十六条  试点基金管理企业和试点基金在完成登记备案后，省市场监管部门应将其商事主体登记信息实时推送到省信息共享交换平台，试点相关单位应根据需求通过省信息共享交换平台获取省市场监管部门相关数据。</p><p>第四十七条  试点相关单位根据各自职责负责试点基金管理企业和试点基金的监督管理。探索开展事中事后监管，运用区块链等金融科技手段，加强对基金的风险管理。同时将其商事主体及时纳入监管范围加强监管，并做好数据安全和保密工作。</p><p>第四十八条  试点基金管理企业应于每个自然年结束后的20个工作日内向省金融监管部门报送上年度试点基金的资金变动、结售汇情况和境外投资情况报告。</p><p>取得试点资格的试点基金管理企业，应在投资运作过程中发生下列事项后15个工作日内及时向省金融监管部门书面报告：</p><p>（一）修改合同、章程或合伙协议等重要文件；</p><p>（二）高级管理人员、主要投资管理人员的变更；</p><p>（三）解散或清算；</p><p>（四）省金融监管部门要求的其他事项。</p><p>第四十九条  试点基金管理企业应在每季度结束后10个工作日内，向外汇管理部门及省金融监管部门报告相关投资产品信息（模板见附件3），包括：</p><p>（一）资金汇出入、购结汇情况；</p><p>（二）基本投资情况，包括：投资品种、基金净值、资金投向、境内募集资金来源情况等信息。</p><p>第五十条  境内托管人和行政事务管理人应及时向省金融监管部门报告试点基金资产托管相关的重大事项和试点基金管理企业违法违规事项。违法违规事项逾期未改正的，省金融监管部门有权会同试点相关管理部门取消其试点资格、收回试点额度，并按相关规定进行处罚。</p><p>第五十一条  试点基金管理企业应按期向省金融监管部门提供季度、年度报告。季度报告包括但不限于认缴规模、实缴规模、投资者情况、投资情况、退出情况、基金净值以及购汇、结汇、账户资金变动等；年度报告包括但不限于上年度试点基金的资金变动、结售汇情况、境外投资情况报告、重大事项变更、审计报告等情况。</p><p>第五十二条  试点基金管理企业和试点基金违反本办法规定的，省金融监管部门应会同有关管理部门进行调查，情况属实的，责令其限期整改；逾期未改正的，省金融监管部门应向社会公告，并会同相关部门依法进行查处；构成犯罪的，移交司法部门依法追究刑事责任。</p><p><br></p><p>第十一章  附  则</p><p>第五十三条  本办法在海南省范围内适用，由省金融监管部门负责解释。省金融监管部门会同其他试点相关单位可根据海南开展合格境内有限合伙人境外投资试点工作的实施进展情况，对相关规定进行适时调整。</p><p>第五十四条  本办法自发布之日起实施。</p>', NULL, NULL, NULL, 1, '2021-09-22 08:00:00', '2021-09-22 08:00:00', 0);
INSERT INTO `policy` VALUES (17, '国务院关于同意在天津、上海、海南、重庆开展服务业扩大开放综合试点的批复', '2021-04-08 08:00:00', '国函〔2021〕37号', '自贸港政策', '<p>天津市、上海市、海南省、重庆市人民政府，商务部：</p><p><br></p><p>你们关于开展服务业扩大开放综合试点的请示收悉。现批复如下：</p><p><br></p><p>一、同意在天津市、上海市、海南省、重庆市（以下称四省市）开展服务业扩大开放综合试点，试点期为自批复之日起3年。原则同意四省市服务业扩大开放综合试点总体方案，请认真组织实施。</p><p><br></p><p>二、试点要以习近平新时代中国特色社会主义思想为指导，全面贯彻党的十九大和十九届二中、三中、四中、五中全会精神，统筹推进“五位一体”总体布局，协调推进“四个全面”战略布局，按照党中央、国务院决策部署，立足新发展阶段、贯彻新发展理念、构建新发展格局，以推动高质量发展为主题，以深化供给侧结构性改革为主线，以改革创新为根本动力，以满足人民日益增长的美好生活需要为根本目的，紧紧围绕本地区发展定位，进一步推进服务业改革开放，加快发展现代服务业，塑造国际合作和竞争新优势，促进建设更高水平开放型经济新体制，为加快构建新发展格局作出贡献。</p><p><br></p><p>三、四省市人民政府要加强对服务业扩大开放综合试点工作的组织领导，在风险可控的前提下，精心组织，大胆实践，服务国家重大战略，开展差异化探索，在加快发展现代产业体系、建设更高水平开放型经济新体制等方面取得更多可复制可推广的经验，为全国服务业的开放发展、创新发展发挥示范带动作用。</p><p><br></p><p>四、国务院有关部门要按照职责分工，积极支持四省市开展服务业扩大开放综合试点。商务部要会同有关部门加强指导和协调推进，组织开展成效评估，确保各项改革开放措施落实到位。</p><p><br></p><p>五、需要暂时调整实施相关行政法规、国务院文件和经国务院批准的部门规章的部分规定的，按规定程序办理。国务院有关部门相应调整本部门制定的规章和规范性文件。试点中的重大问题，四省市人民政府和商务部要及时向国务院请示报告。</p><p><br></p><p>国务院</p><p>2021年4月9日</p><p><br></p><p>（此件公开发布）</p>', NULL, NULL, NULL, 1, '2021-09-22 08:00:00', '2021-09-22 08:00:00', 0);
INSERT INTO `policy` VALUES (18, '关于推进海南自由贸易港贸易自由化便利化若干措施的通知', '2021-04-22 08:00:00', '商自贸发〔2021〕58号', '自贸港政策', '<p>海南省人民政府：</p><p><br></p><p>　　支持海南逐步探索、稳步推进中国特色自由贸易港建设，分步骤、分阶段建立自由贸易港政策和制度体系，是习近平总书记亲自谋划、亲自部署、亲自推动的改革开放重大举措，是党中央着眼国内国际两个大局，深入研究、统筹考虑、科学谋划作出的战略决策。为深入贯彻习近平总书记关于海南自由贸易港建设的重要指示批示精神，细化落实《海南自由贸易港建设总体方案》部署要求，加快推进海南自由贸易港贸易自由化便利化，高质量高标准实现2025年分阶段发展目标，经国务院同意，现就有关事项通知如下：</p><p>　　</p><p>图片</p><p><br></p><p>一、货物贸易方面</p><p><br></p><p><br></p><p><br></p><p><br></p><p>　　1.在洋浦保税港区内先行试点经“一线”进出口原油和成品油，不实行企业资格和数量管理，进出“二线”按进出口规定管理。(责任单位：商务部牵头，发展改革委、海关总署、能源局、海南省参加)</p><p><br></p><p>　　2.在洋浦保税港区内先行试点经“一线”进口食糖不纳入关税配额总量管理，进出“二线”按现行规定管理。从境外进入海南自由贸易港的上述商品由海南省商务厅在年底前向商务部报备。(责任单位：商务部牵头，发展改革委、海关总署、海南省参加)</p><p><br></p><p>　　3.将海南省省内国际航行船舶保税加油许可权下放海南省人民政府，经批准的保税油加注企业可在海南省省内为国际航行船舶及以洋浦港作为中转港从事内外贸同船运输的境内船舶加注保税油。(责任单位：商务部牵头，财政部、交通运输部、海关总署参加)</p><p><br></p><p>　　4.在实施“一线”放开、“二线”管住的区域，进入“一线”原则上取消自动进口许可管理，由海南自由贸易港在做好统计监管的前提下自行管理，进入“二线”按现行进口规定管理。(责任单位：商务部牵头，海关总署参加)</p><p><br></p><p>　　5.在实施“一线”放开、“二线”管住的区域，进入“一线”取消机电进口许可管理措施，由海南自由贸易港在安全环保的前提下自行管理，进入“二线”按现行进口规定管理。(责任单位：商务部牵头，海关总署参加)</p><p><br></p><p>　　6.将海南自由贸易港纳入开展二手车出口业务的地区范围。(责任单位：商务部)</p><p><br></p><p>　　7.支持海南自由贸易港内企业开展新型离岸国际贸易，支持建立和发展全球和区域贸易网络，打造全球性或区域性新型离岸国际贸易中心。(责任单位：商务部牵头，外汇局参加)</p><p><br></p><p>　　8.支持海南自由贸易港开展与货物贸易相关的产品、管理和服务业务认证机构资质审批试点。对在海南自由贸易港注册的认证机构，申请从事国家统一推行的认证项目的认证业务的，优化审批服务；申请从事其他领域的认证业务的，实行告知承诺制。(责任单位：市场监管总局)</p><p><br></p><p>　　9.提升进出口商品质量安全风险预警和快速反应监管能力，完善重点敏感进出口商品监管，建立医院、市场、应急、消防、消费者投诉等产品伤害信息收集网络，对存在较高风险的进口商品进行预警和快速处置。海关对海南自由贸易港进出商品依据风险水平采取适当的合格评定方式，提高法定检验便利性。(责任单位：商务部、卫生健康委、应急部、海关总署、市场监管总局按职责分工负责)</p><p><br></p><p>　　10.加强海关监管模式创新，建立跨部门的植物隔离苗圃监管考核互认机制，优先开展中转基地动植物种质资源检疫准入和疫情监管工作，实施海关总署审批和授权海口海关审批的层级审批模式。(责任单位：海关总署牵头，农业农村部、林草局参加)</p><p><br></p><p>　　11.支持海南自由贸易港参与制定具有行业引领作用的推荐性国家标准，支持海南自由贸易港制定满足地方自然条件、风俗习惯的地方标准及满足市场和创新需要的团体标准。(责任单位：市场监管总局)</p><p><br></p><p>　　12.在海南自由贸易港建立应对贸易摩擦工作站，开展与开放市场环境相匹配的产业安全预警体系建设工作。(责任单位：商务部)</p><p><br></p><p>　　13.结合海南自由贸易港实际需求，建立与自由贸易港开放型经济相适应的贸易调整援助机制，以促进海南自由贸易港内产业调整与竞争力提升。(责任单位：商务部牵头，财政部参加)</p><p>　　</p><p>图片</p><p><br></p><p>二、服务贸易方面</p><p><br></p><p><br></p><p><br></p><p><br></p><p><br></p><p>　　14.允许外国机构在海南自由贸易港独立举办除冠名“中国”“中华”“全国”“国家”等字样以外的涉外经济技术展。外国机构独立举办或合作主办的涉外经济技术展行政许可委托海南省商务厅实施并开展有效监管。(责任单位：商务部牵头，海南省参加)</p><p><br></p><p>　　15.在海南自由贸易港技术进出口经营活动中不需办理对外贸易经营者备案登记，扩大技术进出口经营者资格范围。(责任单位：商务部)</p><p><br></p><p>　　16.支持海南自由贸易港建立国际文化艺术品鉴定、评估、仲裁规则和标准体系。支持海南自由贸易港打造成为国际文化艺术品拍卖中心，探索取消设立拍卖企业审核许可，建立健全事中事后监管体制。海南自由贸易港内拍卖企业从事文物拍卖活动，按相关法律法规执行。(责任单位：商务部、文化和旅游部、司法部按职责分工负责)</p><p><br></p><p>　　17.探索在海南自由贸易港注册登记且仅在海南自由贸易港从事商业特许经营活动的特许人，可不进行商业特许经营备案，加强事中事后监管。(责任单位：商务部牵头，司法部、市场监管总局参加)</p><p><br></p><p>　　18.在海南自由贸易港推进服务贸易创新发展试点，重点推进服务贸易管理体制、促进机制、发展模式、监管制度等方面的改革、开放、便利举措在海南自由贸易港先行先试。(责任单位：商务部)</p><p><br></p><p>　　19.支持海南自由贸易港积极发展数字贸易。支持建设好海南生态软件园国家数字服务出口基地，集聚创新资源和企业。(责任单位：商务部、中央网信办牵头，工业和信息化部参加)</p><p><br></p><p>　　20.建立技术进出口安全管理部省合作快速响应通道，协助海南自由贸易港对禁止类和限制类技术进出口进行科学管控，防范安全风险。(责任单位：商务部)</p><p><br></p><p>　　21.在海南自由贸易港现代服务业、旅游业等重点领域率先规范影响服务贸易自由便利的国内规制。(责任单位：商务部牵头，市场监管总局、各服务行业主管部门、海南省参加)</p><p><br></p><p>　　22.支持海南自由贸易港建设区域性国际会展中心。办好中国国际消费品博览会，支持海南自由贸易港打造具有国际影响力的展会。(责任单位：海南省、商务部)</p><p><br></p><p>　　23.支持海南自由贸易港创建国家文化出口基地，创新发展对外文化贸易。(责任单位：商务部牵头，中央宣传部、文化和旅游部、广电总局参加)</p><p><br></p><p>　　24.在海南自由贸易港建设国家对外文化贸易基地，促进动漫游戏、电子竞技、影视制作、旅游演艺、创意设计、版权交易等重点文化服务贸易发展。(责任单位：文化和旅游部牵头，中央宣传部、商务部、广电总局参加)</p><p><br></p><p>　　25.开展投资促进活动，推动有发展潜力的国家文化出口重点企业和重点项目落户海南自由贸易港。(责任单位：商务部、中央宣传部、文化和旅游部、广电总局按职责分工负责)</p><p><br></p><p>　　26.鼓励海南自由贸易港创新服务贸易国际合作模式。支持海南省市两级与外国建立地方政府间服务贸易国际合作机制，支持海南自由贸易港举办各类服务贸易国际合作活动。(责任单位：商务部)</p><p><br></p><p>　　27.以适当方式向已签署服务贸易合作备忘录国家推介海南自由贸易港服务贸易重点领域(如旅行、运输、电信、计算机和信息服务、知识产权等)和有关重点项目；在对外协商新签服务贸易国际合作协议时，积极支持海南自由贸易港服务贸易发展需求。(责任单位：商务部)</p><p><br></p><p>　　28.进一步完善国际服务贸易统计监测制度，加强对海南跨境服务贸易运行情况的监测和分析。(责任单位：商务部牵头，人民银行、统计局、外汇局、海南省参加)</p><p><br></p><p>　　商务部要会同有关部门在推进海南全面深化改革开放领导小组统筹下，认真落实好各项任务，按照职责分工全力支持、指导和帮助海南省开展各项工作。海南省要切实履行主体责任，细化任务分解，一级一级抓好落实，加快推进贸易自由化便利化，严格遵守中央关于生态环境保护的各项要求，切实做好风险防控，推动海南自由贸易港建设不断取得新成效。上述措施凡涉及调整现行法律或行政法规的，按规定程序办理。</p><p><br></p><p><br></p><p><br></p><p>商务部  中央宣传部  中央网信办</p><p>发展改革委  工业和信息化部  司法部</p><p>财政部  交通运输部  农业农村部</p><p>文化和旅游部  卫生健康委  应急部</p><p>人民银行  海关总署  市场监管总局</p><p>广电总局  统计局  能源局</p><p>林草局  外汇局</p><p>2021年4月19日</p>', NULL, NULL, NULL, 1, '2021-09-22 08:00:00', '2021-09-22 08:00:00', 0);
INSERT INTO `policy` VALUES (19, '【三亚】三亚市市级高新技术企业认定管理及扶持办法', '2020-02-06 08:00:00', NULL, '奖励政策', '<p>　第一章 总则</p><p><br></p><p>　　第一条 为深入实施创新驱动发展战略，增强科技型中小微企业核心竞争力，推进我市高新技术产业发展，加强高新技术企业培育工作，根据《中共海南省委海南省人民政府关于加快科技创新的实施意见》(琼发〔2017〕12号)要求，结合《高新技术企业认定管理办法》(国科发火〔2016〕32号)、《高新技术企业认定管理工作指引》(国科发火〔2016〕195号)，制定本办法。</p><p><br></p><p>　　第二条 本办法所称的市级高新技术企业是指：在《国家重点支持的高新技术领域》内，持续进行研究开发与技术成果转化，形成企业核心自主知识产权，并以此为基础开展经营活动，在三亚市注册的居民企业。</p><p><br></p><p>　　第三条 市级高新技术企业认定管理工作应遵循突出企业主体、鼓励技术创新、实施动态管理、坚持公平公正的原则。</p><p><br></p><p>　　第四条 通过认定的市级高新技术企业，其资格自颁发证书之日起有效，有效期为三年。已被认定为高新技术企业或被纳入海南省高新技术企业培育库的企业，不再认定为市级高新技术企业。海南省外的高新技术企业在三亚市注册企业可以根据条件被认定为市级高新技术企业。</p><p><br></p><p>　　第五条 三亚市科技工业信息化局、三亚市财政局、国家税务总局三亚市税务局组成全市市级高新技术企业认定管理工作领导小组(以下称“领导小组”)，领导小组负责全市市级高新技术企业的认定、管理和监督工作。领导小组下设办公室，由三亚市科技工业信息化局、三亚市财政局、国家税务总局三亚市税务局相关人员组成，办公室设在三亚市科技工业信息化局。</p><p><br></p><p>　　第二章 认定条件与程序</p><p><br></p><p>　　第六条 认定为市级高新技术企业须同时满足以下条件：</p><p><br></p><p>　　(一)在三亚市注册的居民企业;</p><p><br></p><p>　　(二)企业通过自主研发、受让、受赠、并购等方式，获得对其主要产品(服务)在技术上发挥核心支持作用的知识产权的所有权;</p><p><br></p><p>　　(三)对企业主要产品(服务)发挥核心支持作用的技术属于《国家重点支持的高新技术领域》规定的范围，符合三亚市重点产业发展政策导向;</p><p><br></p><p>　　(四)企业从事研发和相关技术创新活动的科技人员占企业当年职工总数的比例不低于10%，近一个会计年度缴交社会保险或个人所得税超过3个月(含)的职工不少于3人;</p><p><br></p><p>　　(五)企业近三个会计年度(实际经营期不满三年的按实际经营时间计算，下同)的研究开发费用总额占同期销售收入总额的比例符合如下要求：</p><p><br></p><p>　　1.最近一年销售收入小于3000万元(含)的企业，比例不低于4%;</p><p><br></p><p>　　2.最近一年销售收入在3000万元以上的企业，比例不低于3%;</p><p><br></p><p>　　其中，企业在中国境内发生的研究开发费用总额占全部研究开发费用总额的比例不低于60%;</p><p><br></p><p>　　(六)近一年高新技术产品(服务)收入占企业同期总收入的比例不低于50%;</p><p><br></p><p>　　(七)根据《高新技术企业认定管理工作指引》中企业创新能力评价标准进行评价，综合得分为50分以上(含50分)的企业。</p><p><br></p><p>　　(八)企业申请认定前一年内未发生重大安全、重大质量事故或严重环境违法行为。</p><p><br></p><p>　　第七条 市级高新技术企业认定程序如下：</p><p><br></p><p>　　(一)企业申请</p><p><br></p><p>　　企业对照本办法进行自我评价。认为符合认定条件的,向领导小组提出认定申请。申请时提交下列材料：</p><p><br></p><p>　　1.三亚市市级高新技术企业认定申请书、企业工商注册地和税务登记地自被认定之日起5年内不迁离三亚的承诺书;</p><p><br></p><p>　　2.证明企业依法成立的相关注册登记证件;</p><p><br></p><p>　　3.知识产权相关材料、科研项目立项证明、科技成果转化、研究开发的组织管理等相关材料;</p><p><br></p><p>　　4.企业高新技术产品(服务)的关键技术和技术指标、生产批文、认证认可和相关资质证书、产品质量检验报告等相关材料;</p><p><br></p><p>　　5.企业职工和科技人员情况说明材料(含缴交的社会保险或个人所得税等证明材料);</p><p><br></p><p>　　6.经具有资质的中介机构出具的企业近三个会计年度研究开发费用和近一个会计年度高新技术产品(服务)收入专项审计或鉴证报告，并附研究开发活动说明材料;</p><p><br></p><p>　　7.经具有资质的中介机构鉴证的企业近三个会计年度财务会计报告(包括会计报表、会计报表附注和财务情况说明书);</p><p><br></p><p>　　8.近三个会计年度企业所得税年度纳税申报表。</p><p><br></p><p>　　(二)专家评审</p><p><br></p><p>　　专家组对企业申报材料进行评审，提出评审意见。</p><p><br></p><p>　　1.专家条件</p><p><br></p><p>　　(1)具有中华人民共和国公民资格，并在中国大陆境内居住和工作。</p><p><br></p><p>　　(2)技术专家应具有高级技术职称，并具有《国家重点支持的高新技术领域》内相关专业背景和实践经验，对该技术领域的发展及市场状况有较全面的了解。财务专家应具有相关高级技术职称，或具有注册会计师或税务师资格且从事财税工作6年以上。</p><p><br></p><p>　　(3)具有良好的职业道德，坚持原则，办事公正。</p><p><br></p><p>　　(4)了解国家科技、经济及产业政策，熟悉高新技术企业认定工作有关要求。</p><p><br></p><p>　　2.专家库及专家选取办法</p><p><br></p><p>　　(1)领导小组建立专家库(包括技术专家和财务专家)，实行专家聘任制和动态管理，备选专家应不少于评审专家的3倍。</p><p><br></p><p>　　(2)领导小组根据企业主营产品(服务)的核心技术所属技术领域随机抽取专家，组成专家组，并指定1名技术专家担任专家组组长，开展认定评审工作。</p><p><br></p><p>　　(三)审查认定</p><p><br></p><p>　　领导小组结合专家组评审意见，对申请企业进行综合审查，提出认定意见并将认定企业在“三亚市人民政府网”公示不少于10个工作日，无异议的，予以备案，并在“三亚市人民政府网”公告，由领导小组颁发“三亚市市级高新技术企业证书”;有异议的，由领导小组进行核实处理。</p><p><br></p><p>　　第三章 监督管理</p><p><br></p><p>　　第八条 对已认定的市级高新技术企业，在日常管理过程中发现其不符合认定条件的，由领导小组进行复核。复核后确认不符合认定条件的，取消其市级高新技术企业资格。</p><p><br></p><p>　　第九条 市级高新技术企业发生更名或与认定条件有关的重大变化(如分立、合并、重组以及经营业务发生变化等)，应在三个月内向领导小组报告。经领导小组审核符合认定条件的，其市级高新技术企业资格不变，对于企业更名的，重新核发认定证书，编号与有效期不变;不符合认定条件的，自更名或条件变化年度起取消其市级高新技术企业资格。</p><p><br></p><p>　　第十条 已认定的市级高新技术企业，有下列行为之一的，由领导小组取消其市级高新技术企业资格：</p><p><br></p><p>　　(一)在申请认定过程中存在严重弄虚作假行为的;</p><p><br></p><p>　　(二)发生重大安全事故、重大质量事故、严重环境违法行为或有严重失信行为的;</p><p><br></p><p>　　(三)未按第九条要求报告有关重大变化情况的;</p><p><br></p><p>　　(四)连续6个月未报送企业生产经营统计数据的。</p><p><br></p><p>　　第十一条 企业在申报过程中存在弄虚作假行为的，一经查实，由领导小组追缴其获得的奖励资金。</p><p><br></p><p>　　第十二条 享受本办法的企业须书面承诺自认定之日起5年内工商注册地和税务登记地不迁离三亚市，如搬离或更改的，全额退还其所获得的奖励资金。</p><p><br></p><p>　　第四章 扶持措施</p><p><br></p><p>　　第十三条 鼓励市级高新技术企业加大研发投入，根据企业上一年度享受研发费用税前加计扣除政策的研发经费数额，对企业给予资金奖励。奖励额度按上一年度研发经费数额的30%给予补助，不超过该企业上一年度对三亚形成的地方财力贡献(不含契税、土地增值税及与房地产相关的财力)，最高不超过50万元。本条与三亚市其他同类型优惠扶持政策，企业可按就高原则申请享受，但不得重复享受,每家企业最多可享受此政策三年。</p><p><br></p><p>　　第十四条 首次被认定为市级高新技术企业的，给予一次性10万元奖励;对市级高新技术企业通过高新技术企业认定的，给予一次性40万元奖励。</p><p><br></p><p>　　第十五条 已被认定为高新技术企业或被纳入海南省高新技术企业培育库的企业，在其有效期内可以申请享受本办法第十三条的政策;直接被认定为高新技术企业(含已被认定或重新被认定且在有效期内的企业)给予一次性50万元奖励;对于省外整体迁入我市的高新技术企业，在其高新技术企业资格有效期内完成迁移的，给予一次性50万元奖励。</p><p><br></p><p>　　第十六条 鼓励科技服务机构对企业申报高新技术企业进行服务，鼓励孵化器和众创空间培育和引进高新技术企业，根据上一年度服务、培育和引进高新技术企业的数量，按5万元/家的标准，给予科技服务机构、孵化器和众创空间一次性奖励;企业自行申报成功的，给予5万元一次性奖励。</p><p><br></p><p>　　第五章 附则</p><p><br></p><p>　　第十七条 本办法由三亚市科技工业信息化局、三亚市财政局、国家税务总局三亚市税务局负责解释。</p><p><br></p><p>　　第十八条 本办法自2020年2月7日起施行，有效期三年。</p>', NULL, NULL, NULL, 1, '2021-09-22 08:00:00', '2021-09-22 08:00:00', 0);
INSERT INTO `policy` VALUES (20, '【海口】海口市人民政府关于鼓励科技创新的若干政策', '2020-06-30 08:00:00', NULL, '奖励政策', '<p>各区人民政府，市政府直属有关单位：</p><p><br></p><p>　　《海口市人民政府关于鼓励科技创新的若干政策》及实施细则已经十六届市政府第 67 次常务会议审议通过，现印发给你们，请认真组织实施。</p><p><br></p><p>　　</p><p><br></p><p> </p><p><br></p><p>海口市人民政府</p><p><br></p><p>　　2019年7月19日</p><p><br></p><p>　　</p><p><br></p><p> </p><p><br></p><p>      （此件主动公开）</p><p><br></p><p> </p><p><br></p><p> </p><p><br></p><p>      详见附件</p>', NULL, NULL, 'http://www.haikou.gov.cn/xxgk/szfbjxxgk/zcfg/szfxzgfxwj/201912/P020191227544847146743.pdf', 1, '2021-09-22 08:00:00', '2021-09-22 08:00:00', 0);
INSERT INTO `policy` VALUES (21, '【琼海】琼海市引进和培育高新技术企业二十条优惠措施', '2020-01-26 08:00:00', NULL, '奖励政策', '<p>为推动我市产业结构优化和转型升级，扶持培育高新技术企业，促进我市高新技术产业发展壮大，助力海南自由贸易（区）港建设，根据《中共海南省委 海南省人民政府关于加快科技创新的实施意见》（琼发〔2017〕12号）精神，结合我市实际，特制定本措施。</p><p><br></p><p>一、 落户政策</p><p><br></p><p>（一）引进奖励。国家高新技术企业在认定有效期内将注册地迁入本市且迁入后年产值达1000万元（含1000万元）以上的，一次性奖励50万元。整体迁入我市的国家高新技术企业，在其资格有效期内完成迁移，且投产后3年内销售收入总额超过1亿元，给予一次性奖励200万元。部分迁入或有效期内的高新技术企业在我市设立分支机构，具有独立法人且年产值达500万元（含500万元）以上的，给予一次性奖励30万元。对于贡献特别突出的可采用“一事一议”方式给予奖励。</p><p><br></p><p>（二）培育扶持。建立高新技术企业培育库，培育期3年。进入培育库的企业给予一次性10万元培育扶持资金。省外高新技术企业在我市设立的具有独立法人资格的企业，直接入库扶持。</p><p><br></p><p>（三）认定支持。对于首次通过认定的国家高新技术企业，给予30万元的研发资金补贴，再次通过认定的给予10万元的研发资金补贴。认定为省高新技术产品的在获得省级补贴（20万元）的基础上，一次性给予10万元的研发资金补贴，同一企业市级财政补贴金额不超过50万元，用于企业技术攻关、新产品研发和标准研制，提高企业自主创新能力。</p><p><br></p><p>（四）研发机构补贴。国内外著名科研院所、大学在我市设立的科研机构，整建制设立且经省科技厅认定，在省补贴（最高不超过2000万元）的基础上按50%给予一次性补贴，最高不超过500万元;设立分支机构，给予一次性补贴，最高不超过200万元。经省认定授予“海南省院士工作站”的企业，给予一次性奖励资金20万元。</p><p><br></p><p>（五）创新载体补贴。鼓励社会力量投资建设或管理运营科技企业孵化器、众创空间等科技创新载体，积极支持和孵化高新技术企业。对科技企业孵化器和众创空间的运营经费，按照其获得省级支持额度的20%给予配套资金补贴支持，每年度最高不超过30万元。科技企业孵化器、众创空间以及科技服务机构每成功培育孵化或引进1家高新技术企业，给予一次性奖励10万元。</p><p><br></p><p>二、财税政策</p><p><br></p><p>（六）研发经费支持。经国家认定的高新技术企业用于自主研发的R&amp;D经费（研究和试验发展）按国家统计口径，年度投入超过100万元的，经核定后按实际投入的10%给予研发资金支持，每一年度最高不超过100万元，支持期限3年。进入培育库企业三年培育期内按国家统计口径用于R&amp;D的经费，采用事后奖补方式，经核定后，每年按实际投入额度的20%给予支持，每一年度最高不超过50万元。</p><p><br></p><p>（七）企业增值税财政奖励。新引进的高新技术企业（有效期内），自纳税年度起，企业纳税后，比照其增值税的市级财政贡献额，按第一年70%、第二年50%、第三年30%的比例给予财政奖励。</p><p><br></p><p>（八）企业所得税财政奖励。首次认定或新引进的高新技术企业（有效期内），自纳税年度起，企业纳税后，比照其企业所得税的市级财政贡献额，按第一年70%、第二年50%、第三年30%的比例给予财政奖励。</p><p><br></p><p>（九）固定资产投资扶持。高新技术企业新增固定资产投资额（不含土地成本）超过2000万元的项目，项目竣工后按实际完成固定资产投资额的3%一次性给予扶持，同一家企业最高不超过500万元。</p><p><br></p><p>（十）科研项目扶持。设立科技专项资金，鼓励开展科技研发和成果转化活动。对上年度获得国家、省科技计划立项的单位，按其获得资金支持的30%，分别给予最高不超过200万元、100万元的配套支持，同一企业有多个立项的，最高不超过300万元。列入市科技计划项目支持的，每个项目给予不超过50万元的扶持。对于科技含量高，重点扶持的项目经市政府批准后可以提高资助比例金额。</p><p><br></p><p>三、金融政策</p><p><br></p><p>（十一）股权融资扶持。市政府单独发起或联合设立政府性引导基金，其基金优先对引进和培育的高新技术企业予以股权投资支持，单个企业最高不超过1000万元。在博鳌基金开放创新基地注册的基金或其他金融机构，按基金实际投资我市高新技术企业或入库培育企业总投资额1%给予一次性奖励，投资期不低于1年，奖励金额最高600万元。</p><p><br></p><p>（十二）债务融资支持。对认定的高新技术企业，向银行取得流动资金贷款的，按照全国银行间同业拆借中心公布的贷款市场报价利率实际发生利息额的50%比例补助，单个企业年贴息额不超过30万元，贴息期限三年；全市年贴息总额最高500万元，补完为止。</p><p><br></p><p>（十三）上市或挂牌扶持。经认定的我市高新技术企业在境内外证券交易市场完成上市的，给予一次性奖励100万元；在“新三板”市场完成挂牌的，给予一次性奖励10万元。</p><p><br></p><p>四、土地和用房政策</p><p><br></p><p>（十四）供地扶持。对高新技术企业所需产业用地优先供应，原则上以土地成本价供给。经省级以上科技部门认定为新型研发机构的，其专门科研用地符合划拨用地目录的非经营性项目可采取划拨供地；经省招商工作联席会议审议通过的具有重大产业带动作用的经营性产业用地，采取招拍挂出让的，出让底价可以在参照工业用地基准地价及相应的土地用途修正系数进行价格评估后“一事一议”确定。</p><p><br></p><p>（十五）用地奖励。对引进的高新技术企业具有带动性、技术国际领先或国内首创的项目，项目竣工正式投产后，可享受“一事一议”的重点项目开工节点奖励政策，按土地购置款的一定比例给予奖励，总金额最高不超过1000万元。</p><p><br></p><p>（十六）厂房和办公用房租金扶持。对新引进的高新技术企业租赁厂房或办公场所的，按我市实际市场房屋租赁每平米价格50%，补贴期限为3年，每个企业累计最高补助不超过50万元。</p><p><br></p><p>五、 人才政策</p><p><br></p><p>（十七）个人所得税财政奖励。首次认定或新引进的高新技术企业自认定或引进的当年起三个自然年度内年工薪收入20万元（含20万元）以上员工，按其缴纳工资薪金个人所得税（年度汇算清缴后）市级财政贡献额的70%给予财政奖励。</p><p><br></p><p>（十八）住房或租房补贴。在我市从事高新技术企业高层管理和研发工作的人员，符合我省引进人才规定且落户在我市的，按引进人才购房政策在市内购买商品房和领取购房补贴。如无意购房的，可以享受租房补贴，补贴由市财政承担。住房租赁补贴累计发放不超过36个月，每季度集中受理和发放一次。补贴指导标准为：高层管理人员（硕士生或具有中级职称或年工薪20万元以上）1200元/月，从事研究研发人员（全日制本科毕业生）500元/月。</p><p><br></p><p>（十九）子女教育倾斜。优质学位向高新技术企业高层管理人员的子女倾斜，按“一事一议”原则进行合理安排。</p><p><br></p><p>六、 其他规定</p><p><br></p><p>（二十）享受本措施的企业为在我市注册的高新技术企业、科技型企业和新型研发机构等，企业自享受本措施年度起，须承诺在本市经营并纳税三年以上，凡经营期未满三年而撤资、迁出本市的企业，其享受的相关扶持资金予以全额追回。</p><p><br></p><p>将本措施纳入全国信用信息共享平台（海南）管理，对违反规定、弄虚作假骗取奖励和补贴的单位和个人，除追回奖励或支持补贴资金外，依法依规追究责任，并列入诚信“黑名单”，三年内不得申请我市各类财政奖励和扶持资金。</p><p><br></p><p>本措施自印发之日起实施，有效期三年，与现有琼海市优惠政策按“从优不重复”原则衔接。本措施是基于现行财税体制和相关政策研究制定，如遇国家自贸港等重大政策调整，则措施内容亦做调整，本措施由市科工信局会同相关部门负责解释。</p>', NULL, NULL, NULL, 1, '2021-09-22 08:00:00', '2021-09-22 08:00:00', 0);
INSERT INTO `policy` VALUES (22, NULL, NULL, NULL, '高企认定指南', '{\r\n  \"applyCondition\": \"　（一）企业申请认定时须注册成立一年以上；\\n　　（二）企业通过自主研发、受让、受赠、并购等方式，获得对其主要产品（服务）在技术上发挥核心支持作用的知识产权的所有权；\\n　　（三）对企业主要产品（服务）发挥核心支持作用的技术属于《国家重点支持的高新技术领域》规定的范围；\\n　　（四）企业从事研发和相关技术创新活动的科技人员占企业当年职工总数的比例不低于10%；\\n　　（五）企业近三个会计年度（实际经营期不满三年的按实际经营时间计算，下同）的研究开发费用总额占同期销售收入总额的比例符合如下要求：\\n　　1. 最近一年销售收入小于5,000万元（含）的企业，比例不低于5%；\\n　　2. 最近一年销售收入在5,000万元至2亿元（含）的企业，比例不低于4%；\\n　　3. 最近一年销售收入在2亿元以上的企业，比例不低于3%。\\n　　其中，企业在中国境内发生的研究开发费用总额占全部研究开发费用总额的比例不低于60%；\\n　　（六）近一年高新技术产品（服务）收入占企业同期总收入的比例不低于60%；\\n　　（七）企业创新能力评价应达到相应要求；\\n　　（八）企业申请认定前一年内未发生重大安全、重大质量事故或严重环境违法行为。\",\r\n  \"applyMaterial\": \"\\n　企业登录“高新技术企业认定管理工作网”，按要求填写《高新技术企业认定申请书》，通过网络系统提交至认定机构，并向认定机构提交下列书面材料：\\n　　（一）《高新技术企业认定申请书》（在线打印并签名、加盖企业公章）；\\n　　（二）证明企业依法成立的《营业执照》等相关注册登记证件的复印件；\\n　　（三）知识产权相关材料（知识产权证书及反映技术水平的证明材料、参与制定标准情况等）、科研项目立项证明（已验收或结题项目需附验收或结题报告）、科技成果转化（总体情况与转化形式、应用成效的逐项说明）、研究开发组织管理（总体情况与四项指标符合情况的具体说明）等相关材料；\\n　　（四）企业高新技术产品（服务）的关键技术和技术指标的具体说明，相关的生产批文、认证认可和资质证书、产品质量检验报告等材料；\\n　　（五）企业职工和科技人员情况说明材料，包括在职、兼职和临时聘用人员人数、人员学历结构、科技人员名单及其工作岗位等；\\n　　（六）经具有资质并符合本《工作指引》相关条件的中介机构出具的企业近三个会计年度（实际年限不足三年的按实际经营年限，下同）研究开发费用、近一个会计年度高新技术产品（服务）收入专项审计或鉴证报告，并附研究开发活动说明材料；\\n　　（七）经具有资质的中介机构鉴证的企业近三个会计年度的财务会计报告（包括会计报表、会计报表附注和财务情况说明书）；\\n　　（八）近三个会计年度企业所得税年度纳税申报表（包括主表及附表）。\",\r\n  \"authProcess\": \"     （一）企业申请\\n　　企业对照本办法进行自我评价。认为符合认定条件的在“高新技术企业认定管理工作网”注册登记，向认定机构提出认定申请。申请时提交下列材料：\\n　　（二）专家评审\\n　　认定机构应在符合评审要求的专家中，随机抽取组成专家组。专家组对企业申报材料进行评审，提出评审意见。\\n　　（三）审查认定\\n　　认定机构结合专家组评审意见，对申请企业进行综合审查，提出认定意见并报领导小组办公室。认定企业由领导小组办公室在“高新技术企业认定管理工作网”公示10个工作日，无异议的，予以备案，并在“高新技术企业认定管理工作网”公告，由认定机构向企业颁发统一印制的“高新技术企业证书”；有异议的，由认定机构进行核实处理。\\n　　（四）企业年报\\n　　企业获得高新技术企业资格后，应每年5月底前在“高新技术企业认定管理工作网”填报上一年度知识产权、科技人员、研发费用、经营收入等年度发展情况报表。 \",\r\n  \"phone\": \"65300226/65333525 \"\r\n}', NULL, NULL, NULL, 1, '2021-09-23 01:37:47', '2021-09-23 01:37:47', 0);
INSERT INTO `policy` VALUES (23, '海南省科学技术厅关于发布省重点研发计划项目库入库项目申报指南的通知', '2021-07-16 15:35:42', '琼科〔2021〕171号', '项目申报政策', '各有关单位：\r\n\r\n根据省政府重点工作部署和科技工作计划安排，按照省重点研发计划组织管理相关要求，现将《省重点研发计划项目库入库项目申报指南》予以发布，请根据指南要求组织入库项目申报工作,现就有关事项通知如下。\r\n\r\n一、申报范围\r\n\r\n（一）构建自由贸易港现代产业技术体系\r\n\r\n围绕海南自由贸易港现代产业体系发展需要，聚焦数字经济、石油化工新材料、现代生物医药三大战略性新兴产业，南繁、深海、航天三大未来产业，清洁能源、节能环保、高端食品加工三大优势产业以及现代服务业、旅游业、热带特色高效农业、智慧海南发展需求，强化应用基础研究和科技成果转化，加快提升产业化水平，增强海南的经济创新力和竞争力。\r\n\r\n（二）面向人民生命健康和可持续发展提供技术支撑\r\n\r\n面向保障人民生命健康和促进可持续发展的迫切需求，加大人口健康、生态环保、公共安全和社会治理等领域核心关键技术攻关和转化应用的力度，为支撑海南国家生态文明试验区建设，促进人与自然和谐发展，全面提升人民生活品质提供技术支撑。\r\n\r\n（三）本项目库不含软科学和国际合作方向项目。\r\n\r\n二、申报方式\r\n\r\n项目申报实行常态化和集中申报相结合的方式。“海南省科技业务综合管理系统”常年开放接受在线申报。为保持“十四五”期间科技计划实施及科技资源配置的连续性，此次发布的申报指南有效期至“十四五”末。省科技厅将结合省委、省政府年度重点工作和应急任务，适时另行发布集中申报通知。\r\n\r\n2022年是启用项目库申报指南的第一年，请各相关申报单位尽快组织申报。原则上省科技厅将在每年3月份和9月份组织项目评审立项工作。连续两次参加立项评审未获得立项的项目，如果不修改完善，将被移出项目库。\r\n\r\n三、申报要求\r\n\r\n（一）项目申报实行无纸化申报。项目申报人登陆系统在线填写《海南省重点研发计划项目申报书》，在附件栏上传相关材料，经申报单位管理员审核后，提交至省科技厅，即为入库项目。\r\n\r\n（二）入库后的项目可随时撤回或修改完善，经申报单位管理员审核后，重新提交至省科技厅。\r\n\r\n（三）进入立项评审程序的项目，经批准立项后，即为出库项目。项目出库后，申报单位可随时组织继续申报。\r\n\r\n（四）作为项目负责人，入库项目中申报实行公开竞争方式的省级科技计划研发类项目不能超过1项。\r\n\r\n（五）已承担2项以上（含2项）实行公开竞争方式的省级科技计划研发类项目的项目负责人，在项目未验收前不得申报入库项目。\r\n\r\n（六）企业单位入库的项目中，牵头申报实行公开竞争方式的省级科技计划研发类项目不得超过1项。高新技术企业牵头申报不受限项限制。\r\n\r\n四、注意事项\r\n\r\n（一）申报人填写申报书前，应仔细阅读有关填写说明，并按要求认真填写，务必完整、准确、真实。\r\n\r\n（二）申报人在管理系统中填写申报书并扫描上传加盖公章的申报书封面页、审核意见页和承诺书。承诺项目申报单位上报的材料和数据真实、合法、有效，并具备开展项目实施的科研基础条件、科研人员实力和财务配套基础。\r\n\r\n（三）申报人未按要求上传相关材料的，立项评审时不予受理。\r\n\r\n（四）项目单位和项目负责人在申报过程中如有弄虚作假等有违科研诚信的行为，将被纳入社会信用系统。\r\n\r\n（五）出库项目将在省科技厅门户网站进行公示。\r\n\r\n（六）鼓励企业牵头或产学研联合申报。每年省重点研发计划立项的项目中，在确保项目质量前提下，原则上企业牵头或产学研联合申报的项目原则上占比不低于40%。\r\n\r\n（七）高新技术方向支持高新技术企业技术创新，鼓励产学研联合申报。由企业牵头申报的应为高新技术企业或本领域具有技术优势的企业；由高校、科研院所牵头申报的，如果不与高新技术企业或本领域具有技术优势的企业联合申报，评审时不予受理。\r\n\r\n（八）事业单位申报（含合作单位），按不低于省财政资助金额的1:1配套（事业单位配套资金可由合作企业出资）；企业单位申报（含合作单位），按不低于省财政资助金额的1:2配套。\r\n\r\n（九）鼓励项目单位先行投入项目研发，可追溯确认前期预研和筹备的经费投入，作为项目单位配套经费确定项目预算，追溯期从项目立项之日起至项目申报之日止，最长不超过6个月。\r\n\r\n（十）项目经费（含配套资金）按照“专款专用，单独核算”的原则进行管理和使用。配套资金原则上为项目单位自有货币资金，不能以其他各级财政专项资金作为省级科技计划项目配套资金。配套资金应足额到位，保障项目顺利实施，开支范围要与项目科研活动相关，并符合国家政策，合理支出。项目验收时，配套资金支出不足任务书约定80%的，按验收“不通过”处理。\r\n\r\n五、申报咨询电话\r\n\r\n申报系统技术咨询：65347994；65389015。\r\n\r\n附件:省重点研发计划项目库入库项目申报指南\r\n\r\n海南省科学技术厅\r\n\r\n2021年7月14日', 'http://dost.hainan.gov.cn/xxgk/xxgkzl/xxgkml/202107/t20210716_3014376.html', NULL, '/static/defaultImage/1.png', 1, '2021-07-16 15:35:42', '2021-07-16 15:35:42', 0);
INSERT INTO `policy` VALUES (28, '海南国际离岸创新创业试验区建设工作指引', '2021-02-17 08:00:00', '琼科规【２０２１】１号', '科技创新政策', NULL, 'http://dost.hainan.gov.cn/xxgk/xxgkzl/xxgkml/202102/t20210218_2935270.html', NULL, 'undefined', 1, NULL, NULL, 0);
INSERT INTO `policy` VALUES (29, '海南省整体迁入高新技术企业奖励细则的通知', '2021-08-12 08:00:00', '琼科规【２０２１】５号', '科技创新政策', NULL, NULL, NULL, '/static/defaultImage/1.png', 1, NULL, NULL, 0);
INSERT INTO `policy` VALUES (30, '海南省高新技术企业研发经费增量奖励细则的通知', '2021-08-14 08:00:00', '琼科规【２０２１】６号', '科技创新政策', NULL, NULL, NULL, '/static/defaultImage/1.png', 1, NULL, NULL, 0);
INSERT INTO `policy` VALUES (31, '海南省省级产业创新服务综合体认定管理办法（试行）的通知', '2021-09-03 08:00:00', '琼科规【２０２１】８号', '科技创新政策', NULL, NULL, NULL, '/static/defaultImage/1.png', 1, NULL, NULL, 0);
INSERT INTO `policy` VALUES (32, '海南省科技型中小企业认定管理暂行办法的通知', '2021-09-19 08:00:00', '琼科规【２０２１】９号', '科技创新政策', NULL, NULL, NULL, '/static/defaultImage/1.png', 1, NULL, NULL, 0);
INSERT INTO `policy` VALUES (33, '海南省企业研发机构认证和备案管理办法', '2021-09-22 08:00:00', '琼科规【２０２１】１０号', '科技创新政策', NULL, NULL, NULL, '/static/defaultImage/1.png', 1, NULL, NULL, 0);
INSERT INTO `policy` VALUES (34, '海南省企业科技特派员制度实施方案的通知', '2021-09-30 08:00:00', '琼科【２０２１】２５６号', '科技创新政策', NULL, NULL, NULL, '/static/defaultImage/1.png', 1, NULL, NULL, 0);
INSERT INTO `policy` VALUES (35, '海南省科技信贷风险补偿管理暂行办法的通知', '2020-11-20 08:00:00', '琼科规【２０２０】１４号', '金融政策', NULL, NULL, NULL, '/static/defaultImage/1.png', 1, NULL, NULL, 0);
INSERT INTO `policy` VALUES (36, '海南省科技成果转化投资基金完成首批项目投资', '2021-12-17 08:00:00', NULL, '金融政策', '<p class=\"ql-align-justify\">		11	月	26	日，海南省科技成果转化投资基金已完成首单对有趣科技、罗格科技	2	家公司合计	400	万元股权投资，同步带动其他社会金融资本跟投、跟贷投资	4100	万元，标志着海南省科技成果转化投资基金首批项目投资落地，其中有趣科技已落地海南省三亚市崖州湾科技城。</p><p class=\"ql-align-justify\">	海南省科技成果转化投资基金是经海南省政府批准设立的政府引导性基金，该基金由海南省科技厅发起，由鲲腾(海南)股权投资基金管理有限公司、银河源汇投资有限公司、广州简达网络技术有限公司、广州市久邦数码科技有限公司以及政府出资代表海南金融控股股份有限公司5家机构共同出资，基金总规模2亿元，其中，省财政出资4000万元，其他4家机构合计出资1.6亿元。通过设立科技成果转化投资基金，发挥财政资金引导作用，吸引并撬动社会资本加大对我省科技成果转化的投入，助力科技成果转化产业化，实现海南省科技成果、技术、产业和资本的有效配置。</p><p class=\"ql-align-justify\">	据了解，有趣科技是一家SaaS远程连接解决方案提供商，凭借自主创新打造的ToDesk远程控制软件，自公测以来为千万用户提供了专业成熟的远程控制服务，为多个国内外知名企业实现部署大型IT管理架构，最新数据显示，ToDesk的注册用户数达到了近1800万，目前为国内远程控制软件的TOP2。随着全球疫情对生活方式的改变和5G的到来，远程办公行业市场规模将以16.4%的年复合增长率保持增长趋势，市场潜力巨大。</p><p class=\"ql-align-justify\">	罗格科技是国内领先的税务科技服务及解决方案提供商。经过几年的发展，罗格科技已经成为集技术创新、商业应用、理论研究三大功能于一身的创新型综合服务企业。罗格科技基于对于税务大数据的独特业务解读能力，创建了税收大数据量化分析和动态风险/信用评估技术体系，数字经济涉税综合服务云运营和电子发票产品运营体系，在税务科技领域深耕细作，在税务大数据、国际税收、数字经济税收等专业领域处于国内领先地位;通过承接国家税务总局、省级税务局的税务数据科学服务、信息化规划设计等生产和科研项目，从战略高度掌握核心资源和技术创新制高点，逐步构筑起税务科技创新成果转换的行业壁垒。</p><p class=\"ql-align-justify\">	鲲腾资本管理合伙人武嘉表示，“在海南省科技厅的科技金融支持体系下，海南省科技成果转化投资基金投出了第一批投资项目，鲲腾资本将继续发挥股权投资基金对科技型企业的支持作用，促进技术创新和科技成果转化，支持科技成果产业化投资，引导社会资本支持科技成果产业化，打通科技成果转化“最后一公里”。</p><p><br></p>', 'http://dost.hainan.gov.cn/kjxw/gzdt/202112/t20211217_3114560.html', NULL, NULL, 1, NULL, NULL, 0);
INSERT INTO `policy` VALUES (38, '高企认定指南', '2022-01-19 08:00:00', NULL, '认定指南', '<p><strong>一、申请条件</strong></p><p><strong>  </strong>（一）企业申请认定时须注册成立一年以上　　</p><p>  （二）企业通过自主研发、受让、受赠、并购等方式，获得对其主要产品（服务）在技术上发挥核心支持作用的知识产权的所有权；　</p><p>  （三）对企业主要产品（服务）发挥核心支持作用的技术属于《国家重点支持的高新技术领域》规定的范围；</p><p>  （四）企业从事研发和相关技术创新活动的科技人员占企业当年职工总数的比例不低于10%；　</p><p>  （五）企业近三个会计年度（实际经营期不满三年的按实际经营时间计算，下同）的研究开发费用总额占同期销售收入总额的比例符合如下要求：</p><p>1. 最近一年销售收入小于5,000万元（含）的企业，比例不低于5%；</p><p>2. 最近一年销售收入在5,000万元至2亿元（含）的企业，比例不低于4%；　</p><p>3. 最近一年销售收入在2亿元以上的企业，比例不低于3%。其中，企业在中国境内发生的研究开发费用总额占全部研究开发费用总额的比例不低于60%；</p><p>  （六）近一年高新技术产品（服务）收入占企业同期总收入的比例不低于60%；　　</p><p>  （七）企业创新能力评价应达到相应要求；　</p><p>  （八）企业申请认定前一年内未发生重大安全、重大质量事故或严重环境违法行为</p><p><br></p><p><strong>二、申请材料目录</strong></p><p><strong>    </strong>企业登录“高新技术企业认定管理工作网”，按要求填写《高新技术企业认定申请书》，通过网络系统提交至认定机构，并向认定机构提交下列书面材料：</p><p>（一）《高新技术企业认定申请书》（在线打印并签名、加盖企业公章）；</p><p>（二）证明企业依法成立的《营业执照》等相关注册登记证件的复印件；</p><p>（三）知识产权相关材料（知识产权证书及反映技术水平的证明材料、参与制定标准情况等）、科研项目立项证明（已验收或结题项目需附验收或结题报告）、科技成果转化（总体情况与转化形式、应用成效的逐项说明）、研究开发组织管理（总体情况与四项指标符合情况的具体说明）等相关材料；</p><p>（四）企业高新技术产品（服务）的关键技术和技术指标的具体说明，相关的生产批文、认证认可和资质证书、产品质量检验报告等材料；</p><p>（五）企业职工和科技人员情况说明材料，包括在职、兼职和临时聘用人员人数、人员学历结构、科技人员名单及其工作岗位等；</p><p>（六）经具有资质并符合本《工作指引》相关条件的中介机构出具的企业近三个会计年度（实际年限不足三年的按实际经营年限，下同）研究开发费用、近一个会计年度高新技术产品（服务）收入专项审计或鉴证报告，并附研究开发活动说明材料；</p><p>（七）经具有资质的中介机构鉴证的企业近三个会计年度的财务会计报告（包括会计报表、会计报表附注和财务情况说明书）；</p><p>（八）近三个会计年度企业所得税年度纳税申报表（包括主表及附表）。</p><p><br></p><p><strong>三、认定管理流程</strong></p><p>（一）企业申请</p><p>企业对照本办法进行自我评价。认为符合认定条件的在“高新技术企业认定管理工作网”注册登记，向认定机构提出认定申请。申请时提交下列材料：</p><p>（二）专家评审</p><p>认定机构应在符合评审要求的专家中，随机抽取组成专家组。专家组对企业申报材料进行评审，提出评审意见。\\n　　（三）审查认定</p><p>认定机构结合专家组评审意见，对申请企业进行综合审查，提出认定意见并报领导小组办公室。认定企业由领导小组办公室在“高新技术企业认定管理工作网”公示10个工作日，无异议的，予以备案，并在“高新技术企业认定管理工作网”公告，由认定机构向企业颁发统一印制的“高新技术企业证书”；有异议的，由认定机构进行核实处理。</p><p>（四）企业年报</p><p>企业获得高新技术企业资格后，应每年5月底前在“高新技术企业认定管理工作网”填报上一年度知识产权、科技人员、研发费用、经营收入等年度发展情况报表。</p><p><br></p><p><strong>四、联系电话</strong></p><p><span class=\"ql-cursor\">﻿</span>65300226/65333525</p>', NULL, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `policy` VALUES (39, '海南省科学技术厅 海南省财政厅关于印发《海南省高新技术企业发展专项和经费管理暂行办法》的通知', '2022-01-30 08:00:00', '琼科规〔2022〕3号', '科技创新政策', '<p>各有关单位：</p><p>	为贯彻落实《海南省科技计划体系优化改革方案》（琼科〔2021〕250号），规范海南省高新技术企业发展专项和经费管理，省科技厅会同省财政厅制定了《海南省高新技术企业发展专项和经费管理暂行办法》。现予印发，请遵照执行。</p><p>	附件：《海南省高新技术企业发展专项和经费管理暂行办法》</p><p class=\"ql-align-right\">	海南省科学技术厅 海南省财政厅</p><p class=\"ql-align-right\">	2022年1月24日</p><p>	（此件主动公开）</p><p>	</p><ul><li>附件：	<a href=\"http://dost.hainan.gov.cn/xxgk/xxgkzl/xxgkml/202201/P020220130530030710902.pdf\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"color: rgb(0, 85, 142);\">海南省科学技术厅海南省财政厅关于印发《海南省高新技术企业发展专项和经费管理暂行</a></li></ul>', 'http://dost.hainan.gov.cn/xxgk/xxgkzl/xxgkml/202201/t20220130_3138017.html', NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `policy` VALUES (40, '海南省科学技术厅关于发布海南省重点研发项目入库申报指南（2022版）的通知', '2022-01-28 08:00:00', '琼科〔2022〕25号', '项目申报政策', '<p>各有关单位：</p><p>	根据《海南省科技计划体系优化改革方案》（琼科〔2021〕250号），海南省重大科技计划、省重点研发计划整合并入省重点研发专项。按照《海南省重点研发专项和经费管理暂行办法》（琼科规〔2021〕18号），省科技厅重新组织编制了《海南省重点研发项目入库申报指南（2022版）》，现予以发布。请根据指南要求组织入库项目申报工作,现就有关事项通知如下：</p><p>	一、申报范围</p><p>	详见附件《海南省重点研发项目入库申报指南（2022版）》。</p><p>	二、申报方式</p><p>	（一）项目申报实行常态化和集中申报相结合的方式。“海南省科技业务综合管理系统”常年开放接受在线申报。为保持“十四五”期间科技计划实施及科技资源配置的连续性，指南有效期原则上至“十四五”末。省科技厅将结合省委、省政府年度重点工作，适时另行发布集中申报通知。</p><p>	（二）请各有关单位尽快组织填报。原则上省科技厅将分别在每年3月份和8月份组织项目评审立项工作。连续两次参加立项评审未获得立项的项目，将被移出项目库。</p><p>	（三）项目单位登录海南省科技业务综合管理系统——新系统入口（http://202.100.247.126/egrantweb/）网上填报。申报流程为：</p><p>	1.注册帐号。首次申报省级科技项目的单位，需登陆海南省科技业务综合管理系统，点击“注册”，按照提示完成注册流程。每个单位只能注册一个“单位管理员”帐号（“单位管理员”帐号不能直接申报项目），“单位管理员”帐号可以创建本单位“项目申报人”帐号，本单位的“项目申报人”帐号由单位管理员统一管理。已在本系统注册的单位或人员可以直接使用原账号登陆，不需要重新注册。</p><p>	2.在线填写。项目申报人登录系统后按支持方向（高新技术、社会发展、现代农业）在线填写《海南省重点研发项目申报书》，并在附件栏上传相关材料，确认无误后在线提交至本单位管理员进行审核。</p><p>	3.在线审核。申报单位管理员审核申报材料，确认无误后，在管理系统内提交省科技厅，即为入库项目。</p><p>	4.项目修改。入库后的项目申报人可随时撤回或修改完善，经申报单位管理员审核后，重新提交至省科技厅。</p><p>	5.项目出库。进入评审程序的项目，经批准立项后，即为出库项目。项目出库后，申报单位可按要求随时组织继续申报。</p><p>	三、注意事项</p><p>	（一）项目申报实行无纸化申报。申报人填写申报书前，应仔细阅读有关填写说明，并按要求认真填写，务必完整、准确、真实。</p><p>	（二）申报人在管理系统中填写申报书并扫描上传加盖公章的申报书封面页和承诺书。承诺项目申报单位上报的材料、配套资金和数据真实、合法、有效，对申报材料的真实性、合法性、合规性负责，并具备开展项目实施的科研基础条件、科研人员实力和财务基础。</p><p>	（三）申报人未按要求上传相关材料的，形式审查时不予受理。</p><p>	（四）申报单位和申报人在申报过程中如有弄虚作假等有违科研诚信的行为，将被纳入社会信用系统。</p><p>	（五）省科技厅或委托专业机构将按照一定比例对拟立项项目申报材料的真实性进行核查。</p><p>	（六）获得立项的项目将在省科技厅门户网站进行公示。</p><p>	（七）鉴于2022年1月1日后启用新版申报系统，目前已按照《海南省科学技术厅关于发布省重点研发计划项目库入库项目申报指南的通知》（琼科〔2021〕171号）提交入库未立项的项目，请按照本通知要求修改后，重新申报入库。</p><p>	四、申报咨询电话</p><p>	申报系统技术咨询：65347994、65389015；</p><p>	业务咨询：</p><p>	高新技术方向：65323068；</p><p>	现代农业方向：65342626；</p><p>	社会发展方向：66290357。</p><p>	附件:海南省重点研发项目入库申报指南（2022版）</p><p class=\"ql-align-right\">	海南省科学技术厅</p><p class=\"ql-align-right\">	2022年1月27日</p><p>	（此件主动公开）</p><p>	</p><ul><li>附件：	<a href=\"http://dost.hainan.gov.cn/xxgk/xxgkzl/xxgkml/202201/P020220128307902798712.doc\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"color: rgb(0, 85, 142);\">海南省重点研发项目入库申报指南（2022版）.doc</a></li></ul>', 'http://dost.hainan.gov.cn/xxgk/xxgkzl/xxgkml/202201/t20220128_3135998.html', NULL, NULL, NULL, NULL, NULL, 0);

-- ----------------------------
-- Table structure for school_info
-- ----------------------------
DROP TABLE IF EXISTS `school_info`;
CREATE TABLE `school_info`  (
  `school_id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名称',
  `website` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '网址',
  `location` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '位置（省市县）',
  `address` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '详细地址',
  `code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '统一社会信用代码',
  `telephone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '固定电话',
  `email` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `contact_id` bigint NULL DEFAULT NULL COMMENT '联系人id',
  `image_url` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '学校图片',
  `examine_image` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '审核所需资料',
  `user_id` bigint NULL DEFAULT NULL COMMENT '用户id',
  `status` tinyint NULL DEFAULT NULL COMMENT '审核状态 [1：正在审核，2：审核通过，3：审核失败]',
  PRIMARY KEY (`school_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '学校信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of school_info
-- ----------------------------
INSERT INTO `school_info` VALUES (1, '海南大学', 'www.hainanu.edu.cn', '海南省海口市美兰区', '海口市人民大道58号', '12460000428200732M', '16689563558', 'school_info1@example.com', 1, '/static/defaultImage/1.png', NULL, 4, 2);
INSERT INTO `school_info` VALUES (2, '海南师范大学', 'http://www.hainnu.edu.cn/', '海南省海口市琼山区', '海口市琼山区龙昆南路99号', '12460000428202332D', NULL, NULL, NULL, '/static/defaultImage/1.png', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for service_product
-- ----------------------------
DROP TABLE IF EXISTS `service_product`;
CREATE TABLE `service_product`  (
  `service_product_id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '产品名称',
  `publish_time` datetime NULL DEFAULT NULL COMMENT '发布时间',
  `description` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '产品描述',
  `service_type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '服务类型',
  `image` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '详情图片',
  `contact_id` bigint NULL DEFAULT NULL COMMENT '联系人id',
  `service_institution_id` bigint NULL DEFAULT NULL COMMENT '服务机构id',
  PRIMARY KEY (`service_product_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '服务产品' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of service_product
-- ----------------------------
INSERT INTO `service_product` VALUES (1, '高新技术企业认定', '2021-03-25 14:50:31', '高新技术企业是指通过科学技术或者科学发明在新领域中的发展，或者在原有领域中革新似的运作。在界定高新技术产业范围的基础上，对于高新技术企业的概念问题可以从2016 年国家修订印发的《高新技术企业认定管理办法》来加以界定。因此，在我国，高新技术企业一般是指在国家颁布的《国家重点支持的', '认证评估', '/static/defaultImage/1.png', 12, 2);
INSERT INTO `service_product` VALUES (3, '政策法规咨询', '2021-03-25 14:55:00', '我们会根据企业所处的发展阶段提供相应的咨询方案，为企业在市场拓展，招标、投标，融资上市提供基础的硬件需求。', '科技咨询', '/static/defaultImage/1.png', 15, 2);

-- ----------------------------
-- Table structure for service_type_index
-- ----------------------------
DROP TABLE IF EXISTS `service_type_index`;
CREATE TABLE `service_type_index`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '服务类型检索' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of service_type_index
-- ----------------------------
INSERT INTO `service_type_index` VALUES (1, '研究开发');
INSERT INTO `service_type_index` VALUES (2, '技术转移');
INSERT INTO `service_type_index` VALUES (3, '创业孵化');
INSERT INTO `service_type_index` VALUES (4, '认证评估');
INSERT INTO `service_type_index` VALUES (5, '知识产权');
INSERT INTO `service_type_index` VALUES (6, '科技咨询');
INSERT INTO `service_type_index` VALUES (7, '科技经融');
INSERT INTO `service_type_index` VALUES (8, '综合科技服务');

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `config_id` int NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '参数配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2021-09-22 09:15:22', '', NULL, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` VALUES (2, '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', '2021-09-22 09:15:22', '', NULL, '初始化密码 123456');
INSERT INTO `sys_config` VALUES (3, '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 'admin', '2021-09-22 09:15:22', '', NULL, '深色主题theme-dark，浅色主题theme-light');
INSERT INTO `sys_config` VALUES (4, '账号自助-验证码开关', 'sys.account.captchaOnOff', 'true', 'Y', 'admin', '2021-09-22 09:15:22', '', NULL, '是否开启验证码功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (5, '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'false', 'Y', 'admin', '2021-09-22 09:15:22', '', NULL, '是否开启注册用户功能（true开启，false关闭）');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `dept_id` bigint NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父部门id',
  `ancestors` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `leader` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 201 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '部门表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (100, 0, '0', '琼州生物科技有限公司', 0, 'admin', '18740765604', 'sys_dept100@example.com', '0', '0', 'admin', '2021-09-22 09:15:01', 'admin', '2021-11-01 16:25:58');
INSERT INTO `sys_dept` VALUES (101, 100, '0,100', '天涯智能装备有限公司', 1, 'admin', '18877547430', 'sys_dept101@example.com', '0', '0', 'admin', '2021-09-22 09:15:01', 'admin', '2021-12-16 07:21:16');
INSERT INTO `sys_dept` VALUES (102, 100, '0,100', '启明科技有限公司', 2, 'admin', '18848466599', 'sys_dept102@example.com', '0', '2', 'admin', '2021-09-22 09:15:01', '', NULL);
INSERT INTO `sys_dept` VALUES (103, 101, '0,100,101', '琼州科技有限公司', 1, 'admin', '15118825173', 'sys_dept103@example.com', '0', '0', 'admin', '2021-09-22 09:15:01', '', NULL);
INSERT INTO `sys_dept` VALUES (104, 101, '0,100,101', '椰城科技有限公司', 2, 'admin', '15933301643', 'sys_dept104@example.com', '0', '2', 'admin', '2021-09-22 09:15:01', '', NULL);
INSERT INTO `sys_dept` VALUES (105, 101, '0,100,101', '琼州科技有限公司', 3, 'admin', '18309857558', 'sys_dept105@example.com', '0', '0', 'admin', '2021-09-22 09:15:01', '', NULL);
INSERT INTO `sys_dept` VALUES (106, 101, '0,100,101', '南繁智能装备有限公司', 4, 'admin', '13978776877', 'sys_dept106@example.com', '0', '2', 'admin', '2021-09-22 09:15:01', '', NULL);
INSERT INTO `sys_dept` VALUES (107, 101, '0,100,101', '海科信息技术有限公司', 5, 'admin', '13558303448', 'sys_dept107@example.com', '0', '2', 'admin', '2021-09-22 09:15:01', '', NULL);
INSERT INTO `sys_dept` VALUES (108, 102, '0,100,102', '启明智能装备有限公司', 1, 'admin', '13941954805', 'sys_dept108@example.com', '0', '2', 'admin', '2021-09-22 09:15:01', '', NULL);
INSERT INTO `sys_dept` VALUES (109, 102, '0,100,102', '博鳌科技有限公司', 2, 'admin', '13749775042', 'sys_dept109@example.com', '0', '2', 'admin', '2021-09-22 09:15:01', '', NULL);
INSERT INTO `sys_dept` VALUES (200, 100, '0,100', '恒远生物科技有限公司', 0, 'admin', '13936352663', 'sys_dept200@example.com', '0', '0', 'admin', '2021-11-01 16:27:28', '', NULL);

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data`  (
  `dict_code` bigint NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int NULL DEFAULT 0 COMMENT '字典排序',
  `dict_label` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '字典数据表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES (1, 1, '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2021-09-22 09:15:18', '', NULL, '性别男');
INSERT INTO `sys_dict_data` VALUES (2, 2, '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2021-09-22 09:15:18', '', NULL, '性别女');
INSERT INTO `sys_dict_data` VALUES (3, 3, '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2021-09-22 09:15:19', '', NULL, '性别未知');
INSERT INTO `sys_dict_data` VALUES (4, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2021-09-22 09:15:19', '', NULL, '显示菜单');
INSERT INTO `sys_dict_data` VALUES (5, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2021-09-22 09:15:19', '', NULL, '隐藏菜单');
INSERT INTO `sys_dict_data` VALUES (6, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2021-09-22 09:15:19', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (7, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2021-09-22 09:15:19', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (8, 1, '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2021-09-22 09:15:19', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (9, 2, '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2021-09-22 09:15:20', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (10, 1, '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2021-09-22 09:15:20', '', NULL, '默认分组');
INSERT INTO `sys_dict_data` VALUES (11, 2, '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2021-09-22 09:15:20', '', NULL, '系统分组');
INSERT INTO `sys_dict_data` VALUES (12, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2021-09-22 09:15:20', '', NULL, '系统默认是');
INSERT INTO `sys_dict_data` VALUES (13, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2021-09-22 09:15:20', '', NULL, '系统默认否');
INSERT INTO `sys_dict_data` VALUES (14, 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2021-09-22 09:15:20', '', NULL, '通知');
INSERT INTO `sys_dict_data` VALUES (15, 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2021-09-22 09:15:20', '', NULL, '公告');
INSERT INTO `sys_dict_data` VALUES (16, 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2021-09-22 09:15:20', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (17, 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2021-09-22 09:15:20', '', NULL, '关闭状态');
INSERT INTO `sys_dict_data` VALUES (18, 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2021-09-22 09:15:20', '', NULL, '新增操作');
INSERT INTO `sys_dict_data` VALUES (19, 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2021-09-22 09:15:21', '', NULL, '修改操作');
INSERT INTO `sys_dict_data` VALUES (20, 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2021-09-22 09:15:21', '', NULL, '删除操作');
INSERT INTO `sys_dict_data` VALUES (21, 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2021-09-22 09:15:21', '', NULL, '授权操作');
INSERT INTO `sys_dict_data` VALUES (22, 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2021-09-22 09:15:21', '', NULL, '导出操作');
INSERT INTO `sys_dict_data` VALUES (23, 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2021-09-22 09:15:21', '', NULL, '导入操作');
INSERT INTO `sys_dict_data` VALUES (24, 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2021-09-22 09:15:21', '', NULL, '强退操作');
INSERT INTO `sys_dict_data` VALUES (25, 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2021-09-22 09:15:21', '', NULL, '生成操作');
INSERT INTO `sys_dict_data` VALUES (26, 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2021-09-22 09:15:21', '', NULL, '清空操作');
INSERT INTO `sys_dict_data` VALUES (27, 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2021-09-22 09:15:21', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (28, 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2021-09-22 09:15:21', '', NULL, '停用状态');

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
  `dict_id` bigint NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE INDEX `dict_type`(`dict_type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '字典类型表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES (1, '用户性别', 'sys_user_sex', '0', 'admin', '2021-09-22 09:15:17', '', NULL, '用户性别列表');
INSERT INTO `sys_dict_type` VALUES (2, '菜单状态', 'sys_show_hide', '0', 'admin', '2021-09-22 09:15:17', '', NULL, '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES (3, '系统开关', 'sys_normal_disable', '0', 'admin', '2021-09-22 09:15:18', '', NULL, '系统开关列表');
INSERT INTO `sys_dict_type` VALUES (4, '任务状态', 'sys_job_status', '0', 'admin', '2021-09-22 09:15:18', '', NULL, '任务状态列表');
INSERT INTO `sys_dict_type` VALUES (5, '任务分组', 'sys_job_group', '0', 'admin', '2021-09-22 09:15:18', '', NULL, '任务分组列表');
INSERT INTO `sys_dict_type` VALUES (6, '系统是否', 'sys_yes_no', '0', 'admin', '2021-09-22 09:15:18', '', NULL, '系统是否列表');
INSERT INTO `sys_dict_type` VALUES (7, '通知类型', 'sys_notice_type', '0', 'admin', '2021-09-22 09:15:18', '', NULL, '通知类型列表');
INSERT INTO `sys_dict_type` VALUES (8, '通知状态', 'sys_notice_status', '0', 'admin', '2021-09-22 09:15:18', '', NULL, '通知状态列表');
INSERT INTO `sys_dict_type` VALUES (9, '操作类型', 'sys_oper_type', '0', 'admin', '2021-09-22 09:15:18', '', NULL, '操作类型列表');
INSERT INTO `sys_dict_type` VALUES (10, '系统状态', 'sys_common_status', '0', 'admin', '2021-09-22 09:15:18', '', NULL, '登录状态列表');

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job`  (
  `job_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '定时任务调度表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job
-- ----------------------------
INSERT INTO `sys_job` VALUES (1, '系统默认（无参）', 'DEFAULT', 'ryTask.ryNoParams', '0/10 * * * * ?', '3', '1', '1', 'admin', '2021-09-22 09:15:23', '', NULL, '');
INSERT INTO `sys_job` VALUES (2, '系统默认（有参）', 'DEFAULT', 'ryTask.ryParams(\'ry\')', '0/15 * * * * ?', '3', '1', '1', 'admin', '2021-09-22 09:15:23', '', NULL, '');
INSERT INTO `sys_job` VALUES (3, '系统默认（多参）', 'DEFAULT', 'ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)', '0/20 * * * * ?', '3', '1', '1', 'admin', '2021-09-22 09:15:23', '', NULL, '');

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log`  (
  `job_log_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '日志信息',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '异常信息',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '定时任务调度日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor`  (
  `info_id` bigint NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '操作系统',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '提示消息',
  `login_time` datetime NULL DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 364 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统访问记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
INSERT INTO `sys_logininfor` VALUES (100, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2021-09-30 11:22:23');
INSERT INTO `sys_logininfor` VALUES (101, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2021-09-30 11:23:03');
INSERT INTO `sys_logininfor` VALUES (102, 'ty', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '验证码错误', '2021-09-30 11:23:10');
INSERT INTO `sys_logininfor` VALUES (103, 'ty', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '用户不存在/密码错误', '2021-09-30 11:23:14');
INSERT INTO `sys_logininfor` VALUES (104, 'ty', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2021-09-30 11:23:22');
INSERT INTO `sys_logininfor` VALUES (105, 'ty', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2021-09-30 11:23:35');
INSERT INTO `sys_logininfor` VALUES (106, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '用户不存在/密码错误', '2021-09-30 11:23:46');
INSERT INTO `sys_logininfor` VALUES (107, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '用户不存在/密码错误', '2021-09-30 11:23:57');
INSERT INTO `sys_logininfor` VALUES (108, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '用户不存在/密码错误', '2021-09-30 11:24:11');
INSERT INTO `sys_logininfor` VALUES (109, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '验证码错误', '2021-09-30 11:24:33');
INSERT INTO `sys_logininfor` VALUES (110, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '用户不存在/密码错误', '2021-09-30 11:24:37');
INSERT INTO `sys_logininfor` VALUES (111, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '用户不存在/密码错误', '2021-09-30 11:26:05');
INSERT INTO `sys_logininfor` VALUES (112, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '用户不存在/密码错误', '2021-09-30 11:30:32');
INSERT INTO `sys_logininfor` VALUES (113, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2021-09-30 11:30:44');
INSERT INTO `sys_logininfor` VALUES (114, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2021-09-30 11:38:20');
INSERT INTO `sys_logininfor` VALUES (115, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '验证码错误', '2021-09-30 12:14:34');
INSERT INTO `sys_logininfor` VALUES (116, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2021-09-30 12:14:38');
INSERT INTO `sys_logininfor` VALUES (117, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2021-09-30 12:41:02');
INSERT INTO `sys_logininfor` VALUES (118, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2021-09-30 12:54:50');
INSERT INTO `sys_logininfor` VALUES (119, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2021-09-30 13:53:06');
INSERT INTO `sys_logininfor` VALUES (120, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2021-10-01 04:49:02');
INSERT INTO `sys_logininfor` VALUES (121, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '验证码错误', '2021-10-01 05:21:57');
INSERT INTO `sys_logininfor` VALUES (122, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2021-10-01 05:22:02');
INSERT INTO `sys_logininfor` VALUES (123, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2021-10-01 05:29:57');
INSERT INTO `sys_logininfor` VALUES (124, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '验证码已失效', '2021-11-01 15:23:08');
INSERT INTO `sys_logininfor` VALUES (125, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '验证码错误', '2021-11-01 15:23:11');
INSERT INTO `sys_logininfor` VALUES (126, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2021-11-01 15:23:19');
INSERT INTO `sys_logininfor` VALUES (127, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2021-11-01 16:19:31');
INSERT INTO `sys_logininfor` VALUES (128, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2021-11-01 17:06:15');
INSERT INTO `sys_logininfor` VALUES (129, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2021-11-01 17:50:54');
INSERT INTO `sys_logininfor` VALUES (130, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2021-11-01 18:27:49');
INSERT INTO `sys_logininfor` VALUES (131, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '验证码错误', '2021-11-01 18:28:08');
INSERT INTO `sys_logininfor` VALUES (132, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2021-11-01 18:28:16');
INSERT INTO `sys_logininfor` VALUES (133, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2021-11-01 18:28:53');
INSERT INTO `sys_logininfor` VALUES (134, 'sta', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2021-11-01 18:29:04');
INSERT INTO `sys_logininfor` VALUES (135, 'sta', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2021-11-01 18:41:20');
INSERT INTO `sys_logininfor` VALUES (136, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2021-11-02 02:30:41');
INSERT INTO `sys_logininfor` VALUES (137, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2021-11-02 03:11:42');
INSERT INTO `sys_logininfor` VALUES (138, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2021-11-02 04:27:40');
INSERT INTO `sys_logininfor` VALUES (139, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2021-11-02 04:47:15');
INSERT INTO `sys_logininfor` VALUES (140, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2021-11-02 07:27:03');
INSERT INTO `sys_logininfor` VALUES (141, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2021-11-02 07:27:15');
INSERT INTO `sys_logininfor` VALUES (142, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2021-11-02 07:31:35');
INSERT INTO `sys_logininfor` VALUES (143, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '验证码错误', '2021-11-02 07:34:11');
INSERT INTO `sys_logininfor` VALUES (144, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '验证码错误', '2021-11-02 07:34:14');
INSERT INTO `sys_logininfor` VALUES (145, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2021-11-02 07:34:25');
INSERT INTO `sys_logininfor` VALUES (146, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2021-11-02 12:08:55');
INSERT INTO `sys_logininfor` VALUES (147, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2021-11-02 12:12:41');
INSERT INTO `sys_logininfor` VALUES (148, 'sto', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '登录用户：sto 不存在', '2021-11-02 12:12:52');
INSERT INTO `sys_logininfor` VALUES (149, 'sta', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '验证码错误', '2021-11-02 12:12:58');
INSERT INTO `sys_logininfor` VALUES (150, 'sta', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2021-11-02 12:13:02');
INSERT INTO `sys_logininfor` VALUES (151, 'sta', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2021-11-02 12:14:02');
INSERT INTO `sys_logininfor` VALUES (152, 'sta', '127.0.0.1', '内网IP', 'Chrome 8', 'Windows 7', '0', '登录成功', '2021-11-02 12:15:12');
INSERT INTO `sys_logininfor` VALUES (153, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2021-11-02 12:19:42');
INSERT INTO `sys_logininfor` VALUES (154, 'sta', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2021-11-02 12:27:17');
INSERT INTO `sys_logininfor` VALUES (155, 'sta', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2021-11-02 12:30:59');
INSERT INTO `sys_logininfor` VALUES (156, 'sta', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2021-11-02 12:31:23');
INSERT INTO `sys_logininfor` VALUES (157, 'sta', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '用户不存在/密码错误', '2021-11-02 12:31:29');
INSERT INTO `sys_logininfor` VALUES (158, 'sta', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '验证码错误', '2021-11-02 12:31:32');
INSERT INTO `sys_logininfor` VALUES (159, 'sta', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2021-11-02 12:31:35');
INSERT INTO `sys_logininfor` VALUES (160, 'sta', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2021-11-02 12:33:50');
INSERT INTO `sys_logininfor` VALUES (161, 'sta', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2021-11-02 12:34:16');
INSERT INTO `sys_logininfor` VALUES (162, 'sta', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2021-11-02 12:38:18');
INSERT INTO `sys_logininfor` VALUES (163, 'sta', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2021-11-02 12:38:33');
INSERT INTO `sys_logininfor` VALUES (164, 'sta', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2021-11-02 12:42:04');
INSERT INTO `sys_logininfor` VALUES (165, 'sta', '127.0.0.1', '内网IP', 'Chrome', 'Linux', '0', '登录成功', '2021-11-03 02:14:48');
INSERT INTO `sys_logininfor` VALUES (166, 'admin', '127.0.0.1', '内网IP', 'Firefox 8', 'Windows 10', '0', '登录成功', '2021-11-03 16:36:27');
INSERT INTO `sys_logininfor` VALUES (167, 'admin', '127.0.0.1', '内网IP', 'Firefox 8', 'Windows 10', '0', '退出成功', '2021-11-03 16:37:07');
INSERT INTO `sys_logininfor` VALUES (168, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2021-11-03 16:43:13');
INSERT INTO `sys_logininfor` VALUES (169, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2021-11-03 16:44:34');
INSERT INTO `sys_logininfor` VALUES (170, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2021-11-04 11:06:13');
INSERT INTO `sys_logininfor` VALUES (171, 'sta', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2021-12-16 07:11:35');
INSERT INTO `sys_logininfor` VALUES (172, 'sta', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2021-12-16 07:14:08');
INSERT INTO `sys_logininfor` VALUES (173, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '验证码错误', '2021-12-16 07:14:21');
INSERT INTO `sys_logininfor` VALUES (174, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '用户不存在/密码错误', '2021-12-16 07:14:43');
INSERT INTO `sys_logininfor` VALUES (175, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '验证码错误', '2021-12-16 07:16:17');
INSERT INTO `sys_logininfor` VALUES (176, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '用户不存在/密码错误', '2021-12-16 07:16:43');
INSERT INTO `sys_logininfor` VALUES (177, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2021-12-16 07:17:05');
INSERT INTO `sys_logininfor` VALUES (178, 'sta', '127.0.0.1', '内网IP', 'Chrome 8', 'Linux', '1', '验证码错误', '2021-12-20 11:46:46');
INSERT INTO `sys_logininfor` VALUES (179, 'sta', '127.0.0.1', '内网IP', 'Chrome 8', 'Linux', '1', '验证码错误', '2021-12-20 11:47:02');
INSERT INTO `sys_logininfor` VALUES (180, 'sta', '127.0.0.1', '内网IP', 'Chrome 8', 'Linux', '1', '验证码错误', '2021-12-20 11:47:23');
INSERT INTO `sys_logininfor` VALUES (181, 'sta', '127.0.0.1', '内网IP', 'Chrome 8', 'Linux', '0', '登录成功', '2021-12-20 11:47:35');
INSERT INTO `sys_logininfor` VALUES (182, 'sta', '127.0.0.1', '内网IP', 'Chrome 8', 'Linux', '1', '验证码错误', '2021-12-24 00:56:53');
INSERT INTO `sys_logininfor` VALUES (183, 'sta', '127.0.0.1', '内网IP', 'Chrome 8', 'Linux', '1', '验证码错误', '2021-12-24 00:56:59');
INSERT INTO `sys_logininfor` VALUES (184, 'sta', '127.0.0.1', '内网IP', 'Chrome 8', 'Linux', '1', '验证码错误', '2021-12-24 00:57:08');
INSERT INTO `sys_logininfor` VALUES (185, 'sta', '127.0.0.1', '内网IP', 'Chrome 8', 'Linux', '0', '登录成功', '2021-12-24 00:57:17');
INSERT INTO `sys_logininfor` VALUES (186, 'sta', '127.0.0.1', '内网IP', 'Chrome 8', 'Linux', '0', '登录成功', '2021-12-24 01:35:56');
INSERT INTO `sys_logininfor` VALUES (187, 'sta', '127.0.0.1', '内网IP', 'Chrome 8', 'Linux', '0', '退出成功', '2021-12-24 02:18:21');
INSERT INTO `sys_logininfor` VALUES (188, 'sta', '127.0.0.1', '内网IP', 'Chrome 8', 'Linux', '0', '登录成功', '2021-12-27 00:55:40');
INSERT INTO `sys_logininfor` VALUES (189, 'sta', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2021-12-27 01:10:59');
INSERT INTO `sys_logininfor` VALUES (190, 'sta', '127.0.0.1', '内网IP', 'Apple WebKit', 'Mac OS X (iPhone)', '0', '登录成功', '2021-12-28 02:17:02');
INSERT INTO `sys_logininfor` VALUES (191, 'sta', '127.0.0.1', '内网IP', 'Apple WebKit', 'Mac OS X (iPhone)', '0', '退出成功', '2021-12-28 02:20:17');
INSERT INTO `sys_logininfor` VALUES (192, 'admin', '127.0.0.1', '内网IP', 'Apple WebKit', 'Mac OS X (iPhone)', '0', '登录成功', '2021-12-28 02:20:29');
INSERT INTO `sys_logininfor` VALUES (193, 'sta', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2021-12-28 06:31:53');
INSERT INTO `sys_logininfor` VALUES (194, 'sta', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2021-12-29 05:13:42');
INSERT INTO `sys_logininfor` VALUES (195, 'sta', '127.0.0.1', '内网IP', 'Chrome 8', 'Linux', '1', '验证码已失效', '2021-12-29 07:08:49');
INSERT INTO `sys_logininfor` VALUES (196, 'sta', '127.0.0.1', '内网IP', 'Chrome 8', 'Linux', '1', '验证码错误', '2021-12-29 07:09:00');
INSERT INTO `sys_logininfor` VALUES (197, 'sta', '127.0.0.1', '内网IP', 'Chrome 8', 'Linux', '1', '验证码错误', '2021-12-29 07:09:06');
INSERT INTO `sys_logininfor` VALUES (198, 'sta', '127.0.0.1', '内网IP', 'Chrome 8', 'Linux', '1', '验证码错误', '2021-12-29 07:09:13');
INSERT INTO `sys_logininfor` VALUES (199, 'sta', '127.0.0.1', '内网IP', 'Chrome 8', 'Linux', '1', '验证码错误', '2021-12-29 07:09:14');
INSERT INTO `sys_logininfor` VALUES (200, 'sta', '127.0.0.1', '内网IP', 'Chrome 8', 'Linux', '1', '验证码错误', '2021-12-29 07:09:14');
INSERT INTO `sys_logininfor` VALUES (201, 'sta', '127.0.0.1', '内网IP', 'Chrome 8', 'Linux', '1', '验证码错误', '2021-12-29 07:09:14');
INSERT INTO `sys_logininfor` VALUES (202, 'sta', '127.0.0.1', '内网IP', 'Chrome 8', 'Linux', '1', '验证码错误', '2021-12-29 07:09:20');
INSERT INTO `sys_logininfor` VALUES (203, 'sta', '127.0.0.1', '内网IP', 'Chrome 8', 'Linux', '1', '验证码错误', '2021-12-29 07:09:27');
INSERT INTO `sys_logininfor` VALUES (204, 'sta', '127.0.0.1', '内网IP', 'Chrome 8', 'Linux', '1', '验证码错误', '2021-12-29 07:09:36');
INSERT INTO `sys_logininfor` VALUES (205, 'sta', '127.0.0.1', '内网IP', 'Chrome 8', 'Linux', '1', '验证码错误', '2021-12-29 07:09:40');
INSERT INTO `sys_logininfor` VALUES (206, 'sta', '127.0.0.1', '内网IP', 'Chrome 8', 'Linux', '1', '验证码错误', '2021-12-29 07:09:52');
INSERT INTO `sys_logininfor` VALUES (207, 'sta', '127.0.0.1', '内网IP', 'Chrome 8', 'Linux', '1', '验证码错误', '2021-12-29 07:10:11');
INSERT INTO `sys_logininfor` VALUES (208, 'sta', '127.0.0.1', '内网IP', 'Chrome 8', 'Linux', '1', '验证码错误', '2021-12-29 07:10:25');
INSERT INTO `sys_logininfor` VALUES (209, 'sta', '127.0.0.1', '内网IP', 'Chrome 8', 'Linux', '1', '验证码错误', '2021-12-29 07:10:30');
INSERT INTO `sys_logininfor` VALUES (210, 'sta', '127.0.0.1', '内网IP', 'Chrome 8', 'Linux', '1', '验证码错误', '2021-12-29 07:10:36');
INSERT INTO `sys_logininfor` VALUES (211, 'sta', '127.0.0.1', '内网IP', 'Chrome 8', 'Linux', '1', '验证码错误', '2021-12-29 07:10:44');
INSERT INTO `sys_logininfor` VALUES (212, 'sta', '127.0.0.1', '内网IP', 'Chrome 8', 'Linux', '1', '验证码错误', '2021-12-29 07:10:58');
INSERT INTO `sys_logininfor` VALUES (213, 'sta', '127.0.0.1', '内网IP', 'Chrome 8', 'Linux', '1', '验证码错误', '2021-12-29 07:11:04');
INSERT INTO `sys_logininfor` VALUES (214, 'sta', '127.0.0.1', '内网IP', 'Chrome 8', 'Linux', '1', '验证码错误', '2021-12-29 07:11:20');
INSERT INTO `sys_logininfor` VALUES (215, 'sta', '127.0.0.1', '内网IP', 'Chrome 8', 'Linux', '1', '验证码错误', '2021-12-29 07:11:52');
INSERT INTO `sys_logininfor` VALUES (216, 'sta', '127.0.0.1', '内网IP', 'Chrome 8', 'Linux', '0', '登录成功', '2021-12-29 07:12:31');
INSERT INTO `sys_logininfor` VALUES (217, 'sta', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2021-12-29 13:07:33');
INSERT INTO `sys_logininfor` VALUES (218, 'sta', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2021-12-29 13:19:33');
INSERT INTO `sys_logininfor` VALUES (219, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2022-01-01 16:30:04');
INSERT INTO `sys_logininfor` VALUES (220, 'admin', '127.0.0.1', '内网IP', 'Apple WebKit', 'Mac OS X (iPhone)', '0', '登录成功', '2022-01-01 16:35:42');
INSERT INTO `sys_logininfor` VALUES (221, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2022-01-04 01:47:57');
INSERT INTO `sys_logininfor` VALUES (222, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2022-01-04 01:49:33');
INSERT INTO `sys_logininfor` VALUES (223, 'sta', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2022-01-04 01:49:43');
INSERT INTO `sys_logininfor` VALUES (224, 'sta', '127.0.0.1', '内网IP', 'Chrome 8', 'Linux', '1', '验证码错误', '2022-01-04 02:57:16');
INSERT INTO `sys_logininfor` VALUES (225, 'sta', '127.0.0.1', '内网IP', 'Chrome 8', 'Linux', '0', '登录成功', '2022-01-04 02:57:28');
INSERT INTO `sys_logininfor` VALUES (226, 'sta', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2022-01-04 04:21:26');
INSERT INTO `sys_logininfor` VALUES (227, 'sta', '127.0.0.1', '内网IP', 'Chrome 8', 'Linux', '0', '登录成功', '2022-01-04 08:25:55');
INSERT INTO `sys_logininfor` VALUES (228, 'sta', '127.0.0.1', '内网IP', 'Chrome 8', 'Linux', '0', '登录成功', '2022-01-05 00:33:09');
INSERT INTO `sys_logininfor` VALUES (229, 'sta', '127.0.0.1', '内网IP', 'Chrome 8', 'Linux', '0', '登录成功', '2022-01-06 00:57:12');
INSERT INTO `sys_logininfor` VALUES (230, 'sta', '127.0.0.1', '内网IP', 'Chrome 8', 'Linux', '0', '登录成功', '2022-01-06 07:17:24');
INSERT INTO `sys_logininfor` VALUES (231, 'sta', '127.0.0.1', '内网IP', 'Chrome 8', 'Linux', '0', '登录成功', '2022-01-10 01:32:25');
INSERT INTO `sys_logininfor` VALUES (232, 'sta', '127.0.0.1', '内网IP', 'Chrome 8', 'Linux', '0', '登录成功', '2022-01-12 01:12:02');
INSERT INTO `sys_logininfor` VALUES (233, 'sta', '127.0.0.1', '内网IP', 'Chrome 8', 'Linux', '1', '验证码错误', '2022-01-14 03:13:49');
INSERT INTO `sys_logininfor` VALUES (234, 'sta', '127.0.0.1', '内网IP', 'Chrome 8', 'Linux', '0', '登录成功', '2022-01-14 03:13:54');
INSERT INTO `sys_logininfor` VALUES (235, 'sta', '127.0.0.1', '内网IP', 'Chrome 8', 'Linux', '1', '验证码错误', '2022-01-17 00:34:08');
INSERT INTO `sys_logininfor` VALUES (236, 'sta', '127.0.0.1', '内网IP', 'Chrome 8', 'Linux', '0', '登录成功', '2022-01-17 00:34:15');
INSERT INTO `sys_logininfor` VALUES (237, 'sta', '127.0.0.1', '内网IP', 'Chrome 8', 'Linux', '0', '登录成功', '2022-01-17 03:19:23');
INSERT INTO `sys_logininfor` VALUES (238, 'sta', '127.0.0.1', '内网IP', 'Chrome 8', 'Linux', '0', '登录成功', '2022-01-17 03:33:09');
INSERT INTO `sys_logininfor` VALUES (239, 'sta', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '验证码已失效', '2022-01-17 03:40:50');
INSERT INTO `sys_logininfor` VALUES (240, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '用户不存在/密码错误', '2022-01-17 11:59:16');
INSERT INTO `sys_logininfor` VALUES (241, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '用户不存在/密码错误', '2022-01-17 11:59:23');
INSERT INTO `sys_logininfor` VALUES (242, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2022-01-17 11:59:31');
INSERT INTO `sys_logininfor` VALUES (243, 'admin', '127.0.0.1', '内网IP', 'Chrome 8', 'Windows 7', '0', '登录成功', '2022-01-17 17:09:50');
INSERT INTO `sys_logininfor` VALUES (244, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2022-01-17 17:11:08');
INSERT INTO `sys_logininfor` VALUES (245, 'sta', '127.0.0.1', '内网IP', 'Chrome 8', 'Linux', '0', '登录成功', '2022-01-18 07:23:21');
INSERT INTO `sys_logininfor` VALUES (246, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2022-01-18 10:34:49');
INSERT INTO `sys_logininfor` VALUES (247, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2022-01-18 10:49:00');
INSERT INTO `sys_logininfor` VALUES (248, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2022-01-18 17:38:34');
INSERT INTO `sys_logininfor` VALUES (249, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2022-01-18 17:42:51');
INSERT INTO `sys_logininfor` VALUES (250, 'sta', '127.0.0.1', '内网IP', 'Chrome 8', 'Linux', '0', '登录成功', '2022-01-19 09:37:13');
INSERT INTO `sys_logininfor` VALUES (251, 'sta', '127.0.0.1', '内网IP', 'Chrome 8', 'Linux', '0', '登录成功', '2022-01-20 00:37:40');
INSERT INTO `sys_logininfor` VALUES (252, 'sta', '127.0.0.1', '内网IP', 'Chrome 8', 'Linux', '0', '登录成功', '2022-01-24 01:32:37');
INSERT INTO `sys_logininfor` VALUES (253, 'sta', '127.0.0.1', '内网IP', 'Chrome 8', 'Linux', '0', '登录成功', '2022-01-25 06:35:59');
INSERT INTO `sys_logininfor` VALUES (254, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2022-01-26 01:44:25');
INSERT INTO `sys_logininfor` VALUES (255, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2022-01-26 01:44:44');
INSERT INTO `sys_logininfor` VALUES (256, 'sta', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2022-01-26 01:44:55');
INSERT INTO `sys_logininfor` VALUES (257, 'sta', '127.0.0.1', '内网IP', 'Chrome 8', 'Linux', '0', '登录成功', '2022-02-08 01:51:16');
INSERT INTO `sys_logininfor` VALUES (258, 'sta', '127.0.0.1', '内网IP', 'Chrome 8', 'Linux', '0', '登录成功', '2022-02-16 01:58:57');
INSERT INTO `sys_logininfor` VALUES (259, 'sta', '127.0.0.1', '内网IP', 'Chrome 8', 'Linux', '0', '登录成功', '2022-02-16 02:19:52');
INSERT INTO `sys_logininfor` VALUES (260, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2022-02-16 09:08:50');
INSERT INTO `sys_logininfor` VALUES (261, 'sta', '127.0.0.1', '内网IP', 'Chrome 8', 'Linux', '0', '登录成功', '2022-02-17 00:37:59');
INSERT INTO `sys_logininfor` VALUES (262, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2022-02-17 11:47:36');
INSERT INTO `sys_logininfor` VALUES (263, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2022-02-17 12:10:02');
INSERT INTO `sys_logininfor` VALUES (264, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '验证码错误', '2022-02-17 12:10:31');
INSERT INTO `sys_logininfor` VALUES (265, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2022-02-17 12:10:38');
INSERT INTO `sys_logininfor` VALUES (266, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '用户不存在/密码错误', '2022-02-17 12:31:04');
INSERT INTO `sys_logininfor` VALUES (267, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2022-02-17 12:31:16');
INSERT INTO `sys_logininfor` VALUES (268, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2022-02-17 12:57:15');
INSERT INTO `sys_logininfor` VALUES (269, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2022-02-17 13:36:23');
INSERT INTO `sys_logininfor` VALUES (270, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2022-02-17 13:38:08');
INSERT INTO `sys_logininfor` VALUES (271, 'sta', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2022-02-17 13:38:16');
INSERT INTO `sys_logininfor` VALUES (272, 'sta', '127.0.0.1', '内网IP', 'Chrome 8', 'Linux', '0', '登录成功', '2022-02-18 00:33:06');
INSERT INTO `sys_logininfor` VALUES (273, 'sta', '127.0.0.1', '内网IP', 'Chrome 8', 'Linux', '0', '登录成功', '2022-02-18 00:56:47');
INSERT INTO `sys_logininfor` VALUES (274, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2022-02-18 03:03:41');
INSERT INTO `sys_logininfor` VALUES (275, 'sta', '127.0.0.1', '内网IP', 'Chrome 8', 'Linux', '0', '登录成功', '2022-02-18 03:29:28');
INSERT INTO `sys_logininfor` VALUES (276, 'sta', '127.0.0.1', '内网IP', 'Chrome 8', 'Linux', '0', '登录成功', '2022-02-21 00:45:54');
INSERT INTO `sys_logininfor` VALUES (277, 'sta', '127.0.0.1', '内网IP', 'Chrome 8', 'Windows 10', '0', '登录成功', '2022-02-21 01:09:43');
INSERT INTO `sys_logininfor` VALUES (278, 'sta', '127.0.0.1', '内网IP', 'Chrome 8', 'Linux', '0', '登录成功', '2022-02-22 01:26:58');
INSERT INTO `sys_logininfor` VALUES (279, 'sta', '127.0.0.1', '内网IP', 'Chrome 8', 'Linux', '0', '登录成功', '2022-03-01 00:51:34');
INSERT INTO `sys_logininfor` VALUES (280, 'sta', '127.0.0.1', '内网IP', 'Chrome 8', 'Linux', '0', '登录成功', '2022-03-01 01:12:20');
INSERT INTO `sys_logininfor` VALUES (281, 'admin', '127.0.0.1', '内网IP', 'Firefox 9', 'Windows 10', '0', '登录成功', '2022-03-06 08:39:06');
INSERT INTO `sys_logininfor` VALUES (282, 'admin', '127.0.0.1', '内网IP', 'Firefox 9', 'Windows 10', '1', '用户不存在/密码错误', '2022-03-06 09:22:19');
INSERT INTO `sys_logininfor` VALUES (283, 'admin', '127.0.0.1', '内网IP', 'Firefox 9', 'Windows 10', '0', '登录成功', '2022-03-06 09:22:25');
INSERT INTO `sys_logininfor` VALUES (284, 'admin', '127.0.0.1', '内网IP', 'Firefox 9', 'Windows 10', '0', '登录成功', '2022-03-06 09:29:42');
INSERT INTO `sys_logininfor` VALUES (285, 'admin', '127.0.0.1', '内网IP', 'Firefox 9', 'Windows 10', '0', '登录成功', '2022-03-19 05:44:19');
INSERT INTO `sys_logininfor` VALUES (286, 'admin', '127.0.0.1', '内网IP', 'Firefox 9', 'Windows 10', '0', '退出成功', '2022-03-19 05:47:16');
INSERT INTO `sys_logininfor` VALUES (287, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '验证码已失效', '2022-03-30 15:33:34');
INSERT INTO `sys_logininfor` VALUES (288, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2022-03-30 15:33:37');
INSERT INTO `sys_logininfor` VALUES (289, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-04-10 10:14:25');
INSERT INTO `sys_logininfor` VALUES (290, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-04-10 11:07:17');
INSERT INTO `sys_logininfor` VALUES (291, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-04-10 12:36:00');
INSERT INTO `sys_logininfor` VALUES (292, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-04-17 06:17:42');
INSERT INTO `sys_logininfor` VALUES (293, 'admin', '127.0.0.1', '内网IP', 'Firefox 9', 'Windows 10', '0', '登录成功', '2022-04-21 12:15:54');
INSERT INTO `sys_logininfor` VALUES (294, 'sta', '127.0.0.1', '内网IP', 'Chrome 8', 'Linux', '0', '登录成功', '2022-04-25 00:39:33');
INSERT INTO `sys_logininfor` VALUES (295, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-04-26 12:20:13');
INSERT INTO `sys_logininfor` VALUES (296, '13016213932', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '验证码错误', '2022-05-15 02:31:27');
INSERT INTO `sys_logininfor` VALUES (297, '13016213932', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '登录用户：13016213932 不存在', '2022-05-15 02:31:38');
INSERT INTO `sys_logininfor` VALUES (298, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-05-25 06:08:43');
INSERT INTO `sys_logininfor` VALUES (299, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-05-25 06:11:31');
INSERT INTO `sys_logininfor` VALUES (300, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-05-25 06:11:35');
INSERT INTO `sys_logininfor` VALUES (301, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '用户不存在/密码错误', '2022-05-28 05:47:24');
INSERT INTO `sys_logininfor` VALUES (302, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '用户不存在/密码错误', '2022-05-28 05:48:20');
INSERT INTO `sys_logininfor` VALUES (303, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '用户不存在/密码错误', '2022-05-28 05:48:28');
INSERT INTO `sys_logininfor` VALUES (304, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '验证码已失效', '2022-05-28 05:52:49');
INSERT INTO `sys_logininfor` VALUES (305, 'ry', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '验证码错误', '2022-05-28 05:53:43');
INSERT INTO `sys_logininfor` VALUES (306, 'ry', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '对不起，您的账号：ry 已被删除', '2022-05-28 05:53:48');
INSERT INTO `sys_logininfor` VALUES (307, 'ry', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '用户不存在/密码错误', '2022-05-28 05:54:45');
INSERT INTO `sys_logininfor` VALUES (308, 'ry', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '用户不存在/密码错误', '2022-05-28 05:55:00');
INSERT INTO `sys_logininfor` VALUES (309, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '用户不存在/密码错误', '2022-05-28 05:55:53');
INSERT INTO `sys_logininfor` VALUES (310, 'adminx', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '验证码错误', '2022-05-28 05:56:01');
INSERT INTO `sys_logininfor` VALUES (311, 'adminx', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '登录用户：adminx 不存在', '2022-05-28 05:56:07');
INSERT INTO `sys_logininfor` VALUES (312, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '验证码错误', '2022-05-28 05:56:13');
INSERT INTO `sys_logininfor` VALUES (313, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '用户不存在/密码错误', '2022-05-28 05:56:19');
INSERT INTO `sys_logininfor` VALUES (314, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '用户不存在/密码错误', '2022-05-28 06:01:51');
INSERT INTO `sys_logininfor` VALUES (315, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '验证码错误', '2022-05-28 06:01:57');
INSERT INTO `sys_logininfor` VALUES (316, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '用户不存在/密码错误', '2022-05-28 06:02:02');
INSERT INTO `sys_logininfor` VALUES (317, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '用户不存在/密码错误', '2022-05-28 06:02:29');
INSERT INTO `sys_logininfor` VALUES (318, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '验证码已失效', '2022-05-28 06:05:35');
INSERT INTO `sys_logininfor` VALUES (319, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '用户不存在/密码错误', '2022-05-29 05:04:49');
INSERT INTO `sys_logininfor` VALUES (320, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '验证码错误', '2022-05-29 05:05:01');
INSERT INTO `sys_logininfor` VALUES (321, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '验证码错误', '2022-05-29 05:07:58');
INSERT INTO `sys_logininfor` VALUES (322, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '验证码已失效', '2022-05-29 05:11:21');
INSERT INTO `sys_logininfor` VALUES (323, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '用户不存在/密码错误', '2022-05-29 05:12:39');
INSERT INTO `sys_logininfor` VALUES (324, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-05-29 05:14:07');
INSERT INTO `sys_logininfor` VALUES (325, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-05-29 05:14:16');
INSERT INTO `sys_logininfor` VALUES (326, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '验证码错误', '2022-05-29 05:14:18');
INSERT INTO `sys_logininfor` VALUES (327, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '验证码错误', '2022-05-29 05:14:19');
INSERT INTO `sys_logininfor` VALUES (328, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-05-29 05:14:24');
INSERT INTO `sys_logininfor` VALUES (329, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-05-29 05:22:04');
INSERT INTO `sys_logininfor` VALUES (330, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '验证码错误', '2022-05-29 05:22:54');
INSERT INTO `sys_logininfor` VALUES (331, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-05-29 05:23:01');
INSERT INTO `sys_logininfor` VALUES (332, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '用户不存在/密码错误', '2022-05-29 05:23:45');
INSERT INTO `sys_logininfor` VALUES (333, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-05-29 05:25:16');
INSERT INTO `sys_logininfor` VALUES (334, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-05-29 05:25:23');
INSERT INTO `sys_logininfor` VALUES (335, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-05-29 05:26:01');
INSERT INTO `sys_logininfor` VALUES (336, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-05-29 05:38:53');
INSERT INTO `sys_logininfor` VALUES (337, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-05-29 05:39:21');
INSERT INTO `sys_logininfor` VALUES (338, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-05-29 05:40:40');
INSERT INTO `sys_logininfor` VALUES (339, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-05-29 05:55:58');
INSERT INTO `sys_logininfor` VALUES (340, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '验证码已失效', '2022-05-29 05:56:44');
INSERT INTO `sys_logininfor` VALUES (341, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-05-29 05:56:49');
INSERT INTO `sys_logininfor` VALUES (342, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-05-29 05:58:12');
INSERT INTO `sys_logininfor` VALUES (343, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-05-29 05:58:30');
INSERT INTO `sys_logininfor` VALUES (344, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-05-29 06:00:29');
INSERT INTO `sys_logininfor` VALUES (345, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '验证码已失效', '2022-05-31 02:53:30');
INSERT INTO `sys_logininfor` VALUES (346, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-05-31 02:53:35');
INSERT INTO `sys_logininfor` VALUES (347, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-05-31 03:57:07');
INSERT INTO `sys_logininfor` VALUES (348, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-05-31 04:00:56');
INSERT INTO `sys_logininfor` VALUES (349, 'root', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '登录用户：root 不存在', '2022-05-31 04:01:23');
INSERT INTO `sys_logininfor` VALUES (350, 'root', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '验证码错误', '2022-05-31 04:01:39');
INSERT INTO `sys_logininfor` VALUES (351, 'root', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '登录用户：root 不存在', '2022-05-31 04:01:45');
INSERT INTO `sys_logininfor` VALUES (352, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '用户不存在/密码错误', '2022-05-31 04:01:59');
INSERT INTO `sys_logininfor` VALUES (353, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-05-31 04:02:07');
INSERT INTO `sys_logininfor` VALUES (354, 'root', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '验证码错误', '2022-05-31 07:35:05');
INSERT INTO `sys_logininfor` VALUES (355, 'root', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '登录用户：root 不存在', '2022-05-31 07:35:15');
INSERT INTO `sys_logininfor` VALUES (356, 'root', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '登录用户：root 不存在', '2022-05-31 07:36:00');
INSERT INTO `sys_logininfor` VALUES (357, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '用户不存在/密码错误', '2022-05-31 07:37:04');
INSERT INTO `sys_logininfor` VALUES (358, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '验证码已失效', '2022-05-31 07:46:06');
INSERT INTO `sys_logininfor` VALUES (359, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-05-31 07:46:12');
INSERT INTO `sys_logininfor` VALUES (360, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-05-31 08:01:34');
INSERT INTO `sys_logininfor` VALUES (361, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-05-31 08:05:37');
INSERT INTO `sys_logininfor` VALUES (362, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-05-31 09:29:28');
INSERT INTO `sys_logininfor` VALUES (363, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-06-02 02:13:46');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` bigint NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '菜单名称',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父菜单ID',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `path` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '路由参数',
  `is_frame` int NULL DEFAULT 1 COMMENT '是否为外链（0是 1否）',
  `is_cache` int NULL DEFAULT 0 COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2131 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '菜单权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', 0, 1, 'system', NULL, '', 1, 0, 'M', '0', '0', '', 'system', 'admin', '2021-09-22 09:15:03', '', NULL, '系统管理目录');
INSERT INTO `sys_menu` VALUES (2, '系统监控', 0, 2, 'monitor', NULL, '', 1, 0, 'M', '0', '0', '', 'monitor', 'admin', '2021-09-22 09:15:03', '', NULL, '系统监控目录');
INSERT INTO `sys_menu` VALUES (3, '系统工具', 0, 3, 'tool', NULL, '', 1, 0, 'M', '0', '0', '', 'tool', 'admin', '2021-09-22 09:15:03', '', NULL, '系统工具目录');
INSERT INTO `sys_menu` VALUES (4, '若依官网', 0, 4, 'http://ruoyi.vip', NULL, '', 0, 0, 'M', '0', '0', '', 'guide', 'admin', '2021-09-22 09:15:03', '', NULL, '若依官网地址');
INSERT INTO `sys_menu` VALUES (100, '用户管理', 1, 1, 'user', 'system/user/index', '', 1, 0, 'C', '0', '0', 'system:user:list', 'user', 'admin', '2021-09-22 09:15:03', '', NULL, '用户管理菜单');
INSERT INTO `sys_menu` VALUES (101, '角色管理', 1, 2, 'role', 'system/role/index', '', 1, 0, 'C', '0', '0', 'system:role:list', 'peoples', 'admin', '2021-09-22 09:15:03', '', NULL, '角色管理菜单');
INSERT INTO `sys_menu` VALUES (102, '菜单管理', 1, 3, 'menu', 'system/menu/index', '', 1, 0, 'C', '0', '0', 'system:menu:list', 'tree-table', 'admin', '2021-09-22 09:15:04', '', NULL, '菜单管理菜单');
INSERT INTO `sys_menu` VALUES (103, '部门管理', 1, 4, 'dept', 'system/dept/index', '', 1, 0, 'C', '0', '0', 'system:dept:list', 'tree', 'admin', '2021-09-22 09:15:04', '', NULL, '部门管理菜单');
INSERT INTO `sys_menu` VALUES (104, '岗位管理', 1, 5, 'post', 'system/post/index', '', 1, 0, 'C', '0', '0', 'system:post:list', 'post', 'admin', '2021-09-22 09:15:04', '', NULL, '岗位管理菜单');
INSERT INTO `sys_menu` VALUES (105, '字典管理', 1, 6, 'dict', 'system/dict/index', '', 1, 0, 'C', '0', '0', 'system:dict:list', 'dict', 'admin', '2021-09-22 09:15:04', '', NULL, '字典管理菜单');
INSERT INTO `sys_menu` VALUES (106, '参数设置', 1, 7, 'config', 'system/config/index', '', 1, 0, 'C', '0', '0', 'system:config:list', 'edit', 'admin', '2021-09-22 09:15:04', '', NULL, '参数设置菜单');
INSERT INTO `sys_menu` VALUES (107, '通知公告', 1, 8, 'notice', 'system/notice/index', '', 1, 0, 'C', '0', '0', 'system:notice:list', 'message', 'admin', '2021-09-22 09:15:04', '', NULL, '通知公告菜单');
INSERT INTO `sys_menu` VALUES (108, '日志管理', 1, 9, 'log', '', '', 1, 0, 'M', '0', '0', '', 'log', 'admin', '2021-09-22 09:15:04', '', NULL, '日志管理菜单');
INSERT INTO `sys_menu` VALUES (109, '在线用户', 2, 1, 'online', 'monitor/online/index', '', 1, 0, 'C', '0', '0', 'monitor:online:list', 'online', 'admin', '2021-09-22 09:15:04', '', NULL, '在线用户菜单');
INSERT INTO `sys_menu` VALUES (110, '定时任务', 2, 2, 'job', 'monitor/job/index', '', 1, 0, 'C', '0', '0', 'monitor:job:list', 'job', 'admin', '2021-09-22 09:15:04', '', NULL, '定时任务菜单');
INSERT INTO `sys_menu` VALUES (111, '数据监控', 2, 3, 'druid', 'monitor/druid/index', '', 1, 0, 'C', '0', '0', 'monitor:druid:list', 'druid', 'admin', '2021-09-22 09:15:04', '', NULL, '数据监控菜单');
INSERT INTO `sys_menu` VALUES (112, '服务监控', 2, 4, 'server', 'monitor/server/index', '', 1, 0, 'C', '0', '0', 'monitor:server:list', 'server', 'admin', '2021-09-22 09:15:04', '', NULL, '服务监控菜单');
INSERT INTO `sys_menu` VALUES (113, '缓存监控', 2, 5, 'cache', 'monitor/cache/index', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis', 'admin', '2021-09-22 09:15:04', '', NULL, '缓存监控菜单');
INSERT INTO `sys_menu` VALUES (114, '表单构建', 3, 1, 'build', 'tool/build/index', '', 1, 0, 'C', '0', '0', 'tool:build:list', 'build', 'admin', '2021-09-22 09:15:04', '', NULL, '表单构建菜单');
INSERT INTO `sys_menu` VALUES (115, '代码生成', 3, 2, 'gen', 'tool/gen/index', '', 1, 0, 'C', '0', '0', 'tool:gen:list', 'code', 'admin', '2021-09-22 09:15:05', '', NULL, '代码生成菜单');
INSERT INTO `sys_menu` VALUES (116, '系统接口', 3, 3, 'swagger', 'tool/swagger/index', '', 1, 0, 'C', '0', '0', 'tool:swagger:list', 'swagger', 'admin', '2021-09-22 09:15:05', '', NULL, '系统接口菜单');
INSERT INTO `sys_menu` VALUES (500, '操作日志', 108, 1, 'operlog', 'monitor/operlog/index', '', 1, 0, 'C', '0', '0', 'monitor:operlog:list', 'form', 'admin', '2021-09-22 09:15:05', '', NULL, '操作日志菜单');
INSERT INTO `sys_menu` VALUES (501, '登录日志', 108, 2, 'logininfor', 'monitor/logininfor/index', '', 1, 0, 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', 'admin', '2021-09-22 09:15:05', '', NULL, '登录日志菜单');
INSERT INTO `sys_menu` VALUES (1001, '用户查询', 100, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:user:query', '#', 'admin', '2021-09-22 09:15:05', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1002, '用户新增', 100, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:user:add', '#', 'admin', '2021-09-22 09:15:05', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1003, '用户修改', 100, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', 'admin', '2021-09-22 09:15:05', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1004, '用户删除', 100, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', 'admin', '2021-09-22 09:15:05', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1005, '用户导出', 100, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:user:export', '#', 'admin', '2021-09-22 09:15:05', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1006, '用户导入', 100, 6, '', '', '', 1, 0, 'F', '0', '0', 'system:user:import', '#', 'admin', '2021-09-22 09:15:05', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1007, '重置密码', 100, 7, '', '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', 'admin', '2021-09-22 09:15:05', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1008, '角色查询', 101, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:role:query', '#', 'admin', '2021-09-22 09:15:05', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1009, '角色新增', 101, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:role:add', '#', 'admin', '2021-09-22 09:15:05', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1010, '角色修改', 101, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', 'admin', '2021-09-22 09:15:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1011, '角色删除', 101, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', 'admin', '2021-09-22 09:15:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1012, '角色导出', 101, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:role:export', '#', 'admin', '2021-09-22 09:15:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1013, '菜单查询', 102, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', 'admin', '2021-09-22 09:15:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1014, '菜单新增', 102, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', 'admin', '2021-09-22 09:15:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1015, '菜单修改', 102, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', 'admin', '2021-09-22 09:15:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1016, '菜单删除', 102, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', 'admin', '2021-09-22 09:15:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1017, '部门查询', 103, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:query', '#', 'admin', '2021-09-22 09:15:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1018, '部门新增', 103, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:add', '#', 'admin', '2021-09-22 09:15:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1019, '部门修改', 103, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:edit', '#', 'admin', '2021-09-22 09:15:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1020, '部门删除', 103, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:remove', '#', 'admin', '2021-09-22 09:15:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1021, '岗位查询', 104, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:post:query', '#', 'admin', '2021-09-22 09:15:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1022, '岗位新增', 104, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:post:add', '#', 'admin', '2021-09-22 09:15:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1023, '岗位修改', 104, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:post:edit', '#', 'admin', '2021-09-22 09:15:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1024, '岗位删除', 104, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:post:remove', '#', 'admin', '2021-09-22 09:15:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1025, '岗位导出', 104, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:post:export', '#', 'admin', '2021-09-22 09:15:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1026, '字典查询', 105, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:query', '#', 'admin', '2021-09-22 09:15:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1027, '字典新增', 105, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:add', '#', 'admin', '2021-09-22 09:15:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1028, '字典修改', 105, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:edit', '#', 'admin', '2021-09-22 09:15:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1029, '字典删除', 105, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:remove', '#', 'admin', '2021-09-22 09:15:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1030, '字典导出', 105, 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:export', '#', 'admin', '2021-09-22 09:15:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1031, '参数查询', 106, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:query', '#', 'admin', '2021-09-22 09:15:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1032, '参数新增', 106, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:add', '#', 'admin', '2021-09-22 09:15:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1033, '参数修改', 106, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:edit', '#', 'admin', '2021-09-22 09:15:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1034, '参数删除', 106, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:remove', '#', 'admin', '2021-09-22 09:15:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1035, '参数导出', 106, 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:export', '#', 'admin', '2021-09-22 09:15:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1036, '公告查询', 107, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:query', '#', 'admin', '2021-09-22 09:15:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1037, '公告新增', 107, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:add', '#', 'admin', '2021-09-22 09:15:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1038, '公告修改', 107, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:edit', '#', 'admin', '2021-09-22 09:15:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1039, '公告删除', 107, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:remove', '#', 'admin', '2021-09-22 09:15:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1040, '操作查询', 500, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:query', '#', 'admin', '2021-09-22 09:15:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1041, '操作删除', 500, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:remove', '#', 'admin', '2021-09-22 09:15:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1042, '日志导出', 500, 4, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:export', '#', 'admin', '2021-09-22 09:15:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1043, '登录查询', 501, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:query', '#', 'admin', '2021-09-22 09:15:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1044, '登录删除', 501, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:remove', '#', 'admin', '2021-09-22 09:15:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1045, '日志导出', 501, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:export', '#', 'admin', '2021-09-22 09:15:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1046, '在线查询', 109, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:query', '#', 'admin', '2021-09-22 09:15:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1047, '批量强退', 109, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:batchLogout', '#', 'admin', '2021-09-22 09:15:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1048, '单条强退', 109, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:forceLogout', '#', 'admin', '2021-09-22 09:15:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1049, '任务查询', 110, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:query', '#', 'admin', '2021-09-22 09:15:09', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1050, '任务新增', 110, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:add', '#', 'admin', '2021-09-22 09:15:09', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1051, '任务修改', 110, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:edit', '#', 'admin', '2021-09-22 09:15:09', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1052, '任务删除', 110, 4, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:remove', '#', 'admin', '2021-09-22 09:15:09', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1053, '状态修改', 110, 5, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:changeStatus', '#', 'admin', '2021-09-22 09:15:09', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1054, '任务导出', 110, 7, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:export', '#', 'admin', '2021-09-22 09:15:09', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1055, '生成查询', 115, 1, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:query', '#', 'admin', '2021-09-22 09:15:09', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1056, '生成修改', 115, 2, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:edit', '#', 'admin', '2021-09-22 09:15:09', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1057, '生成删除', 115, 3, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:remove', '#', 'admin', '2021-09-22 09:15:09', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1058, '导入代码', 115, 2, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:import', '#', 'admin', '2021-09-22 09:15:09', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1059, '预览代码', 115, 4, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:preview', '#', 'admin', '2021-09-22 09:15:09', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1060, '生成代码', 115, 5, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:code', '#', 'admin', '2021-09-22 09:15:09', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2015, '企业信息', 2099, 1, 'businessInfo', 'data/businessInfo/index', NULL, 1, 1, 'C', '0', '0', 'data:businessInfo:list', '#', 'admin', '2021-09-30 12:20:28', '', NULL, '企业信息菜单');
INSERT INTO `sys_menu` VALUES (2016, '企业信息查询', 2015, 1, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:businessInfo:query', '#', 'admin', '2021-09-30 12:20:28', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2017, '企业信息新增', 2015, 2, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:businessInfo:add', '#', 'admin', '2021-09-30 12:20:28', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2018, '企业信息修改', 2015, 3, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:businessInfo:edit', '#', 'admin', '2021-09-30 12:20:28', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2019, '企业信息删除', 2015, 4, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:businessInfo:remove', '#', 'admin', '2021-09-30 12:20:28', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2020, '企业信息导出', 2015, 5, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:businessInfo:export', '#', 'admin', '2021-09-30 12:20:28', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2021, '金融产品', 2099, 1, 'financialProduct', 'data/financialProduct/index', NULL, 1, 1, 'C', '0', '0', 'data:financialProduct:list', '#', 'admin', '2021-09-30 12:21:07', '', NULL, '金融产品菜单');
INSERT INTO `sys_menu` VALUES (2022, '金融产品查询', 2021, 1, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:financialProduct:query', '#', 'admin', '2021-09-30 12:21:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2023, '金融产品新增', 2021, 2, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:financialProduct:add', '#', 'admin', '2021-09-30 12:21:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2024, '金融产品修改', 2021, 3, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:financialProduct:edit', '#', 'admin', '2021-09-30 12:21:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2025, '金融产品删除', 2021, 4, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:financialProduct:remove', '#', 'admin', '2021-09-30 12:21:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2026, '金融产品导出', 2021, 5, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:financialProduct:export', '#', 'admin', '2021-09-30 12:21:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2027, '融资需求', 2099, 1, 'financingNeed', 'data/financingNeed/index', NULL, 1, 1, 'C', '0', '0', 'data:financingNeed:list', '#', 'admin', '2021-09-30 12:21:50', '', NULL, '融资需求菜单');
INSERT INTO `sys_menu` VALUES (2028, '融资需求查询', 2027, 1, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:financingNeed:query', '#', 'admin', '2021-09-30 12:21:50', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2029, '融资需求新增', 2027, 2, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:financingNeed:add', '#', 'admin', '2021-09-30 12:21:50', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2030, '融资需求修改', 2027, 3, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:financingNeed:edit', '#', 'admin', '2021-09-30 12:21:50', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2031, '融资需求删除', 2027, 4, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:financingNeed:remove', '#', 'admin', '2021-09-30 12:21:50', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2032, '融资需求导出', 2027, 5, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:financingNeed:export', '#', 'admin', '2021-09-30 12:21:50', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2033, '科技园区', 2099, 1, 'park', 'data/park/index', NULL, 1, 1, 'C', '0', '0', 'data:park:list', '#', 'admin', '2021-09-30 12:22:05', '', NULL, '科技园区菜单');
INSERT INTO `sys_menu` VALUES (2034, '科技园区查询', 2033, 1, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:park:query', '#', 'admin', '2021-09-30 12:22:05', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2035, '科技园区新增', 2033, 2, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:park:add', '#', 'admin', '2021-09-30 12:22:05', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2036, '科技园区修改', 2033, 3, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:park:edit', '#', 'admin', '2021-09-30 12:22:05', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2037, '科技园区删除', 2033, 4, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:park:remove', '#', 'admin', '2021-09-30 12:22:05', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2038, '科技园区导出', 2033, 5, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:park:export', '#', 'admin', '2021-09-30 12:22:05', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2039, '政策', 2099, 1, 'policy', 'data/policy/index', NULL, 1, 1, 'C', '0', '0', 'data:policy:list', 'documentation', 'admin', '2021-09-30 12:22:25', 'admin', '2021-11-02 07:15:31', '政策菜单');
INSERT INTO `sys_menu` VALUES (2040, '政策查询', 2039, 1, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:policy:query', '#', 'admin', '2021-09-30 12:22:25', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2041, '政策新增', 2039, 2, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:policy:add', '#', 'admin', '2021-09-30 12:22:25', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2042, '政策修改', 2039, 3, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:policy:edit', '#', 'admin', '2021-09-30 12:22:25', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2043, '政策删除', 2039, 4, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:policy:remove', '#', 'admin', '2021-09-30 12:22:25', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2044, '政策导出', 2039, 5, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:policy:export', '#', 'admin', '2021-09-30 12:22:25', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2045, '人才需求', 2099, 1, 'talentNeed', 'data/talentNeed/index', NULL, 1, 1, 'C', '0', '0', 'data:talentNeed:list', '#', 'admin', '2021-09-30 12:22:40', '', NULL, '人才需求菜单');
INSERT INTO `sys_menu` VALUES (2046, '人才需求查询', 2045, 1, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:talentNeed:query', '#', 'admin', '2021-09-30 12:22:40', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2047, '人才需求新增', 2045, 2, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:talentNeed:add', '#', 'admin', '2021-09-30 12:22:40', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2048, '人才需求修改', 2045, 3, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:talentNeed:edit', '#', 'admin', '2021-09-30 12:22:40', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2049, '人才需求删除', 2045, 4, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:talentNeed:remove', '#', 'admin', '2021-09-30 12:22:40', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2050, '人才需求导出', 2045, 5, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:talentNeed:export', '#', 'admin', '2021-09-30 12:22:40', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2051, '人才供应', 2099, 1, 'talentSupply', 'data/talentSupply/index', NULL, 1, 1, 'C', '0', '0', 'data:talentSupply:list', '#', 'admin', '2021-09-30 12:22:55', '', NULL, '人才供应菜单');
INSERT INTO `sys_menu` VALUES (2052, '人才供应查询', 2051, 1, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:talentSupply:query', '#', 'admin', '2021-09-30 12:22:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2053, '人才供应新增', 2051, 2, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:talentSupply:add', '#', 'admin', '2021-09-30 12:22:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2054, '人才供应修改', 2051, 3, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:talentSupply:edit', '#', 'admin', '2021-09-30 12:22:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2055, '人才供应删除', 2051, 4, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:talentSupply:remove', '#', 'admin', '2021-09-30 12:22:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2056, '人才供应导出', 2051, 5, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:talentSupply:export', '#', 'admin', '2021-09-30 12:22:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2057, '技术成果', 2099, 1, 'technologyAchievement', 'data/technologyAchievement/index', NULL, 1, 1, 'C', '0', '0', 'data:technologyAchievement:list', '#', 'admin', '2021-09-30 12:23:14', '', NULL, '技术成果菜单');
INSERT INTO `sys_menu` VALUES (2058, '技术成果查询', 2057, 1, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:technologyAchievement:query', '#', 'admin', '2021-09-30 12:23:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2059, '技术成果新增', 2057, 2, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:technologyAchievement:add', '#', 'admin', '2021-09-30 12:23:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2060, '技术成果修改', 2057, 3, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:technologyAchievement:edit', '#', 'admin', '2021-09-30 12:23:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2061, '技术成果删除', 2057, 4, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:technologyAchievement:remove', '#', 'admin', '2021-09-30 12:23:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2062, '技术成果导出', 2057, 5, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:technologyAchievement:export', '#', 'admin', '2021-09-30 12:23:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2063, '技术需求', 2099, 1, 'technologyNeed', 'data/technologyNeed/index', NULL, 1, 1, 'C', '0', '0', 'data:technologyNeed:list', '#', 'admin', '2021-09-30 12:23:32', '', NULL, '技术需求菜单');
INSERT INTO `sys_menu` VALUES (2064, '技术需求查询', 2063, 1, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:technologyNeed:query', '#', 'admin', '2021-09-30 12:23:32', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2065, '技术需求新增', 2063, 2, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:technologyNeed:add', '#', 'admin', '2021-09-30 12:23:32', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2066, '技术需求修改', 2063, 3, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:technologyNeed:edit', '#', 'admin', '2021-09-30 12:23:32', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2067, '技术需求删除', 2063, 4, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:technologyNeed:remove', '#', 'admin', '2021-09-30 12:23:32', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2068, '技术需求导出', 2063, 5, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:technologyNeed:export', '#', 'admin', '2021-09-30 12:23:32', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2069, '用户', 2099, 1, 'user', 'data/user/index', NULL, 1, 1, 'C', '0', '0', 'data:user:list', '#', 'admin', '2021-09-30 12:23:49', '', NULL, '用户菜单');
INSERT INTO `sys_menu` VALUES (2070, '用户查询', 2069, 1, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:user:query', '#', 'admin', '2021-09-30 12:23:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2071, '用户新增', 2069, 2, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:user:add', '#', 'admin', '2021-09-30 12:23:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2072, '用户修改', 2069, 3, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:user:edit', '#', 'admin', '2021-09-30 12:23:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2073, '用户删除', 2069, 4, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:user:remove', '#', 'admin', '2021-09-30 12:23:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2074, '用户导出', 2069, 5, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:user:export', '#', 'admin', '2021-09-30 12:23:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2075, '索引', 2099, 1, 'allIndex', 'data/allIndex/index', NULL, 1, 1, 'C', '0', '0', 'data:allIndex:list', '#', 'admin', '2021-09-30 12:27:43', '', NULL, '索引菜单');
INSERT INTO `sys_menu` VALUES (2076, '索引查询', 2075, 1, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:allIndex:query', '#', 'admin', '2021-09-30 12:27:43', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2077, '索引新增', 2075, 2, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:allIndex:add', '#', 'admin', '2021-09-30 12:27:43', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2078, '索引修改', 2075, 3, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:allIndex:edit', '#', 'admin', '2021-09-30 12:27:43', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2079, '索引删除', 2075, 4, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:allIndex:remove', '#', 'admin', '2021-09-30 12:27:43', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2080, '索引导出', 2075, 5, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:allIndex:export', '#', 'admin', '2021-09-30 12:27:43', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2081, '咨询', 2099, 1, 'consultation', 'data/consultation/index', NULL, 1, 1, 'C', '0', '0', 'data:consultation:list', '#', 'admin', '2021-09-30 12:28:11', '', NULL, '咨询菜单');
INSERT INTO `sys_menu` VALUES (2082, '咨询查询', 2081, 1, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:consultation:query', '#', 'admin', '2021-09-30 12:28:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2083, '咨询新增', 2081, 2, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:consultation:add', '#', 'admin', '2021-09-30 12:28:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2084, '咨询修改', 2081, 3, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:consultation:edit', '#', 'admin', '2021-09-30 12:28:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2085, '咨询删除', 2081, 4, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:consultation:remove', '#', 'admin', '2021-09-30 12:28:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2086, '咨询导出', 2081, 5, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:consultation:export', '#', 'admin', '2021-09-30 12:28:11', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2087, '学校信息', 2099, 1, 'schoolInfo', 'data/schoolInfo/index', NULL, 1, 1, 'C', '0', '0', 'data:schoolInfo:list', '#', 'admin', '2021-09-30 12:28:21', '', NULL, '学校信息菜单');
INSERT INTO `sys_menu` VALUES (2088, '学校信息查询', 2087, 1, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:schoolInfo:query', '#', 'admin', '2021-09-30 12:28:21', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2089, '学校信息新增', 2087, 2, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:schoolInfo:add', '#', 'admin', '2021-09-30 12:28:21', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2090, '学校信息修改', 2087, 3, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:schoolInfo:edit', '#', 'admin', '2021-09-30 12:28:21', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2091, '学校信息删除', 2087, 4, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:schoolInfo:remove', '#', 'admin', '2021-09-30 12:28:21', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2092, '学校信息导出', 2087, 5, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:schoolInfo:export', '#', 'admin', '2021-09-30 12:28:21', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2093, '服务产品', 2099, 1, 'serviceProduct', 'data/serviceProduct/index', NULL, 1, 1, 'C', '0', '0', 'data:serviceProduct:list', '#', 'admin', '2021-09-30 12:28:32', '', NULL, '服务产品菜单');
INSERT INTO `sys_menu` VALUES (2094, '服务产品查询', 2093, 1, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:serviceProduct:query', '#', 'admin', '2021-09-30 12:28:32', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2095, '服务产品新增', 2093, 2, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:serviceProduct:add', '#', 'admin', '2021-09-30 12:28:32', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2096, '服务产品修改', 2093, 3, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:serviceProduct:edit', '#', 'admin', '2021-09-30 12:28:32', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2097, '服务产品删除', 2093, 4, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:serviceProduct:remove', '#', 'admin', '2021-09-30 12:28:32', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2098, '服务产品导出', 2093, 5, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:serviceProduct:export', '#', 'admin', '2021-09-30 12:28:32', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2099, '数据管理', 0, 1, 'data', NULL, '', 1, 1, 'M', '0', '0', '', 'build', 'admin', '2021-09-22 09:15:03', 'admin', '2021-11-02 07:14:13', '数据管理目录');
INSERT INTO `sys_menu` VALUES (2101, '科技金融', 2099, 1, 'financingPolicy', 'data/policy/financingPolicy/index', NULL, 1, 1, 'C', '0', '0', 'data:finacingPolicy:list', 'money', 'admin', NULL, 'admin', '2022-01-18 10:36:36', '金融政策菜单');
INSERT INTO `sys_menu` VALUES (2102, '金融政策查询', 2101, 1, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:finacingPolicy:query', '#', 'admin', '2021-09-30 12:28:32', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2103, '金融政策新增', 2101, 2, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:finacingPolicy:add', '#', 'admin', '2021-09-30 12:28:32', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2104, '金融政策修改', 2101, 3, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:finacingPolicy:edit', '#', 'admin', '2021-09-30 12:28:32', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2105, '金融政策删除', 2101, 4, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:finacingPolicy:remove', '#', 'admin', '2021-09-30 12:28:32', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2106, '金融政策导出', 2101, 5, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:finacingPolicy:export', '#', 'admin', '2021-09-30 12:28:32', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2107, '科技项目', 2099, 1, 'projectDeclare', 'data/policy/projectDeclare/index', NULL, 1, 1, 'C', '0', '0', 'data:projectDeclare:list', 'tab', 'admin', NULL, 'admin', '2022-01-18 10:37:17', '项目申报菜单');
INSERT INTO `sys_menu` VALUES (2108, '项目申报查询', 2107, 1, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:projectDeclare:query', '#', 'admin', '2021-09-30 12:28:32', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2109, '项目申报新增', 2107, 2, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:projectDeclare:add', '#', 'admin', '2021-09-30 12:28:32', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2110, '项目申报修改', 2107, 3, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:projectDeclare:edit', '#', 'admin', '2021-09-30 12:28:32', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2111, '项目申报删除', 2107, 4, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:projectDeclare:remove', '#', 'admin', '2021-09-30 12:28:32', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2112, '项目申报导出', 2107, 5, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:projectDeclare:export', '#', 'admin', '2021-09-30 12:28:32', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2113, '高企奖励', 2099, 1, 'rewardPolicy', 'data/policy/rewardPolicy/index', NULL, 1, 1, 'C', '0', '0', 'data:rewardProject:list', 'rate', 'admin', NULL, 'admin', '2022-01-18 10:37:29', '奖励政策菜单');
INSERT INTO `sys_menu` VALUES (2114, '奖励政策查询', 2113, 1, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:rewardProject:query', '#', 'admin', '2021-09-30 12:28:32', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2115, '奖励政策新增', 2113, 2, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:rewardProject:add', '#', 'admin', '2021-09-30 12:28:32', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2116, '奖励政策修改', 2113, 3, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:rewardProject:edit', '#', 'admin', '2021-09-30 12:28:32', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2117, '奖励政策删除', 2113, 4, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:rewardProject:remove', '#', 'admin', '2021-09-30 12:28:32', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2118, '奖励政策导出', 2113, 5, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:rewardProject:export', '#', 'admin', '2021-09-30 12:28:32', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2119, '高企认定', 2099, 1, 'identifyGuide', 'data/policy/identifyGuide/index', NULL, 1, 1, 'C', '0', '0', 'data:identifyGuide:list', 'nested', 'admin', NULL, 'admin', '2022-01-18 10:37:39', '认定指南菜单');
INSERT INTO `sys_menu` VALUES (2120, '认定指南查询', 2119, 1, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:identifyGuide:query', '#', 'admin', '2021-09-30 12:28:32', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2121, '认定指南新增', 2119, 2, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:identifyGuide:add', '#', 'admin', '2021-09-30 12:28:32', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2122, '认定指南修改', 2119, 3, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:identifyGuide:edit', '#', 'admin', '2021-09-30 12:28:32', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2123, '认定指南删除', 2119, 4, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:identifyGuide:remove', '#', 'admin', '2021-09-30 12:28:32', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2124, '认定指南导出', 2119, 5, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:identifyGuide:export', '#', 'admin', '2021-09-30 12:28:32', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2125, '新闻', 2099, 1, 'news', 'data/news/index', NULL, 1, 1, 'C', '0', '0', 'data:news:list', '#', 'admin', NULL, '', NULL, '新闻菜单');
INSERT INTO `sys_menu` VALUES (2126, '新闻查询', 2125, 1, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:news:query', '#', 'admin', '2021-09-30 12:28:32', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2127, '新闻新增', 2125, 2, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:news:add', '#', 'admin', '2021-09-30 12:28:32', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2128, '新闻修改', 2125, 3, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:news:edit', '#', 'admin', '2021-09-30 12:28:32', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2129, '新闻删除', 2125, 4, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:news:remove', '#', 'admin', '2021-09-30 12:28:32', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2130, '新闻导出', 2125, 5, '#', '', NULL, 1, 1, 'F', '0', '0', 'data:news:export', '#', 'admin', '2021-09-30 12:28:32', '', NULL, '');

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice`  (
  `notice_id` int NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '公告标题',
  `notice_type` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob NULL COMMENT '公告内容',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '通知公告表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
INSERT INTO `sys_notice` VALUES (1, '温馨提醒：2018-07-01 若依新版本发布啦', '2', 0xE696B0E78988E69CACE58685E5AEB9, '0', 'admin', '2021-09-22 09:15:23', '', NULL, '管理员');
INSERT INTO `sys_notice` VALUES (2, '维护通知：2018-07-01 若依系统凌晨维护', '1', 0xE7BBB4E68AA4E58685E5AEB9, '0', 'admin', '2021-09-22 09:15:23', '', NULL, '管理员');

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log`  (
  `oper_id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '模块标题',
  `business_type` int NULL DEFAULT 0 COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '请求方式',
  `operator_type` int NULL DEFAULT 0 COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '返回参数',
  `status` int NULL DEFAULT 0 COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime NULL DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`oper_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 220 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '操作日志记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
INSERT INTO `sys_oper_log` VALUES (100, '用户管理', 1, 'com.ruoyi.web.controller.system.SysUserController.add()', 'POST', 1, 'admin', NULL, '/system/user', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2021-09-30 11:22:58');
INSERT INTO `sys_oper_log` VALUES (101, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', NULL, '/tool/gen/importTable', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2021-09-30 11:39:50');
INSERT INTO `sys_oper_log` VALUES (102, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', NULL, '/tool/gen/importTable', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2021-09-30 11:40:24');
INSERT INTO `sys_oper_log` VALUES (103, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', NULL, '/tool/gen/importTable', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2021-09-30 11:41:08');
INSERT INTO `sys_oper_log` VALUES (104, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', NULL, '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2021-09-30 11:41:27');
INSERT INTO `sys_oper_log` VALUES (105, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', NULL, '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2021-09-30 11:41:35');
INSERT INTO `sys_oper_log` VALUES (106, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', NULL, '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2021-09-30 11:59:19');
INSERT INTO `sys_oper_log` VALUES (107, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', NULL, '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2021-09-30 11:59:25');
INSERT INTO `sys_oper_log` VALUES (108, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', NULL, '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2021-09-30 12:01:57');
INSERT INTO `sys_oper_log` VALUES (109, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', NULL, '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2021-09-30 12:02:01');
INSERT INTO `sys_oper_log` VALUES (110, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', NULL, '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2021-09-30 12:10:49');
INSERT INTO `sys_oper_log` VALUES (111, '代码生成', 3, 'com.ruoyi.generator.controller.GenController.remove()', 'DELETE', 1, 'admin', NULL, '/tool/gen/1,2,3,4,5,6,7,8,9,10', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2021-09-30 12:12:09');
INSERT INTO `sys_oper_log` VALUES (112, '代码生成', 3, 'com.ruoyi.generator.controller.GenController.remove()', 'DELETE', 1, 'admin', NULL, '/tool/gen/11,12,13,14', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2021-09-30 12:12:13');
INSERT INTO `sys_oper_log` VALUES (113, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', NULL, '/tool/gen/importTable', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2021-09-30 12:12:40');
INSERT INTO `sys_oper_log` VALUES (114, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', NULL, '/tool/gen/importTable', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2021-09-30 12:12:44');
INSERT INTO `sys_oper_log` VALUES (115, '代码生成', 3, 'com.ruoyi.generator.controller.GenController.remove()', 'DELETE', 1, 'admin', NULL, '/tool/gen/15,16,17,18,19,20,21,22,23,24', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2021-09-30 12:12:52');
INSERT INTO `sys_oper_log` VALUES (116, '代码生成', 3, 'com.ruoyi.generator.controller.GenController.remove()', 'DELETE', 1, 'admin', NULL, '/tool/gen/25,26,27,28', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2021-09-30 12:12:56');
INSERT INTO `sys_oper_log` VALUES (117, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', NULL, '/tool/gen/importTable', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2021-09-30 12:13:16');
INSERT INTO `sys_oper_log` VALUES (118, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', NULL, '/tool/gen/importTable', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2021-09-30 12:13:19');
INSERT INTO `sys_oper_log` VALUES (119, '代码生成', 3, 'com.ruoyi.generator.controller.GenController.remove()', 'DELETE', 1, 'admin', NULL, '/tool/gen/29,30,31,32,33,34,35,36,37,38', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2021-09-30 12:13:35');
INSERT INTO `sys_oper_log` VALUES (120, '代码生成', 3, 'com.ruoyi.generator.controller.GenController.remove()', 'DELETE', 1, 'admin', NULL, '/tool/gen/39,40,41,42', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2021-09-30 12:13:54');
INSERT INTO `sys_oper_log` VALUES (121, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', NULL, '/tool/gen/importTable', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2021-09-30 12:15:33');
INSERT INTO `sys_oper_log` VALUES (122, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', NULL, '/tool/gen/importTable', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2021-09-30 12:16:23');
INSERT INTO `sys_oper_log` VALUES (123, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', NULL, '/tool/gen/importTable', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2021-09-30 12:16:35');
INSERT INTO `sys_oper_log` VALUES (124, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', NULL, '/tool/gen/importTable', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2021-09-30 12:16:45');
INSERT INTO `sys_oper_log` VALUES (125, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', NULL, '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2021-09-30 12:16:50');
INSERT INTO `sys_oper_log` VALUES (126, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', NULL, '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2021-09-30 12:16:57');
INSERT INTO `sys_oper_log` VALUES (127, '政策', 3, 'com.ruoyi.data.controller.PolicyController.remove()', 'DELETE', 1, 'admin', NULL, '/data/policy/24', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2021-11-01 15:35:09');
INSERT INTO `sys_oper_log` VALUES (128, '角色管理', 1, 'com.ruoyi.web.controller.system.SysRoleController.add()', 'POST', 1, 'admin', NULL, '/system/role', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2021-11-01 16:21:43');
INSERT INTO `sys_oper_log` VALUES (129, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', NULL, '/system/dept', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2021-11-01 16:25:58');
INSERT INTO `sys_oper_log` VALUES (130, '部门管理', 3, 'com.ruoyi.web.controller.system.SysDeptController.remove()', 'DELETE', 1, 'admin', NULL, '/system/dept/101', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2021-11-01 16:26:04');
INSERT INTO `sys_oper_log` VALUES (131, '部门管理', 3, 'com.ruoyi.web.controller.system.SysDeptController.remove()', 'DELETE', 1, 'admin', NULL, '/system/dept/103', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2021-11-01 16:26:07');
INSERT INTO `sys_oper_log` VALUES (132, '部门管理', 3, 'com.ruoyi.web.controller.system.SysDeptController.remove()', 'DELETE', 1, 'admin', NULL, '/system/dept/103', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2021-11-01 16:26:11');
INSERT INTO `sys_oper_log` VALUES (133, '部门管理', 3, 'com.ruoyi.web.controller.system.SysDeptController.remove()', 'DELETE', 1, 'admin', NULL, '/system/dept/104', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2021-11-01 16:26:14');
INSERT INTO `sys_oper_log` VALUES (134, '部门管理', 3, 'com.ruoyi.web.controller.system.SysDeptController.remove()', 'DELETE', 1, 'admin', NULL, '/system/dept/105', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2021-11-01 16:26:17');
INSERT INTO `sys_oper_log` VALUES (135, '部门管理', 3, 'com.ruoyi.web.controller.system.SysDeptController.remove()', 'DELETE', 1, 'admin', NULL, '/system/dept/106', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2021-11-01 16:26:19');
INSERT INTO `sys_oper_log` VALUES (136, '部门管理', 3, 'com.ruoyi.web.controller.system.SysDeptController.remove()', 'DELETE', 1, 'admin', NULL, '/system/dept/102', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2021-11-01 16:26:21');
INSERT INTO `sys_oper_log` VALUES (137, '部门管理', 3, 'com.ruoyi.web.controller.system.SysDeptController.remove()', 'DELETE', 1, 'admin', NULL, '/system/dept/108', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2021-11-01 16:26:23');
INSERT INTO `sys_oper_log` VALUES (138, '部门管理', 3, 'com.ruoyi.web.controller.system.SysDeptController.remove()', 'DELETE', 1, 'admin', NULL, '/system/dept/109', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2021-11-01 16:26:25');
INSERT INTO `sys_oper_log` VALUES (139, '部门管理', 3, 'com.ruoyi.web.controller.system.SysDeptController.remove()', 'DELETE', 1, 'admin', NULL, '/system/dept/102', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2021-11-01 16:26:27');
INSERT INTO `sys_oper_log` VALUES (140, '部门管理', 3, 'com.ruoyi.web.controller.system.SysDeptController.remove()', 'DELETE', 1, 'admin', NULL, '/system/dept/107', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2021-11-01 16:26:29');
INSERT INTO `sys_oper_log` VALUES (141, '部门管理', 1, 'com.ruoyi.web.controller.system.SysDeptController.add()', 'POST', 1, 'admin', NULL, '/system/dept', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2021-11-01 16:27:28');
INSERT INTO `sys_oper_log` VALUES (142, '用户管理', 1, 'com.ruoyi.web.controller.system.SysUserController.add()', 'POST', 1, 'admin', NULL, '/system/user', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2021-11-01 16:29:21');
INSERT INTO `sys_oper_log` VALUES (143, '政策', 2, 'com.ruoyi.data.controller.PolicyController.edit()', 'PUT', 1, 'admin', NULL, '/data/policy', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2021-11-01 18:07:44');
INSERT INTO `sys_oper_log` VALUES (144, '政策', 2, 'com.ruoyi.data.controller.PolicyController.edit()', 'PUT', 1, 'admin', NULL, '/data/policy', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2021-11-01 18:08:16');
INSERT INTO `sys_oper_log` VALUES (145, '政策', 1, 'com.ruoyi.data.controller.PolicyController.add()', 'POST', 1, 'admin', NULL, '/data/policy', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2021-11-01 18:20:45');
INSERT INTO `sys_oper_log` VALUES (146, '政策', 3, 'com.ruoyi.data.controller.PolicyController.remove()', 'DELETE', 1, 'admin', NULL, '/data/policy/25', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2021-11-01 18:20:55');
INSERT INTO `sys_oper_log` VALUES (147, '政策', 2, 'com.ruoyi.data.controller.PolicyController.edit()', 'PUT', 1, 'sta', NULL, '/data/policy', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2021-11-01 18:29:39');
INSERT INTO `sys_oper_log` VALUES (148, '政策', 2, 'com.ruoyi.data.controller.PolicyController.edit()', 'PUT', 1, 'sta', NULL, '/data/policy', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2021-11-01 18:29:49');
INSERT INTO `sys_oper_log` VALUES (149, '政策', 2, 'com.ruoyi.data.controller.PolicyController.edit()', 'PUT', 1, 'admin', NULL, '/data/policy', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2021-11-02 03:31:14');
INSERT INTO `sys_oper_log` VALUES (150, '政策', 1, 'com.ruoyi.data.controller.PolicyController.add()', 'POST', 1, 'admin', NULL, '/data/policy', '127.0.0.1', '内网IP', NULL, NULL, 1, 'nested exception is org.apache.ibatis.reflection.ReflectionException: There is no getter for property named \'image\' in \'class com.ruoyi.data.domain.Policy\'', '2021-11-02 05:42:06');
INSERT INTO `sys_oper_log` VALUES (151, '政策', 1, 'com.ruoyi.data.controller.PolicyController.add()', 'POST', 1, 'admin', NULL, '/data/policy', '127.0.0.1', '内网IP', NULL, NULL, 1, 'nested exception is org.apache.ibatis.reflection.ReflectionException: There is no getter for property named \'image\' in \'class com.ruoyi.data.domain.Policy\'', '2021-11-02 05:42:11');
INSERT INTO `sys_oper_log` VALUES (152, '政策', 1, 'com.ruoyi.data.controller.PolicyController.add()', 'POST', 1, 'admin', NULL, '/data/policy', '127.0.0.1', '内网IP', NULL, NULL, 1, 'nested exception is org.apache.ibatis.reflection.ReflectionException: There is no getter for property named \'image\' in \'class com.ruoyi.data.domain.Policy\'', '2021-11-02 05:43:49');
INSERT INTO `sys_oper_log` VALUES (153, '政策', 1, 'com.ruoyi.data.controller.PolicyController.add()', 'POST', 1, 'admin', NULL, '/data/policy', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2021-11-02 05:47:35');
INSERT INTO `sys_oper_log` VALUES (154, '政策', 2, 'com.ruoyi.data.controller.PolicyController.edit()', 'PUT', 1, 'admin', NULL, '/data/policy', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2021-11-02 05:53:11');
INSERT INTO `sys_oper_log` VALUES (155, '政策', 2, 'com.ruoyi.data.controller.PolicyController.edit()', 'PUT', 1, 'admin', NULL, '/data/policy', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2021-11-02 06:03:05');
INSERT INTO `sys_oper_log` VALUES (156, '政策', 2, 'com.ruoyi.data.controller.PolicyController.edit()', 'PUT', 1, 'admin', NULL, '/data/policy', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2021-11-02 06:07:29');
INSERT INTO `sys_oper_log` VALUES (157, '政策', 2, 'com.ruoyi.data.controller.PolicyController.edit()', 'PUT', 1, 'admin', NULL, '/data/policy', '127.0.0.1', '内网IP', NULL, NULL, 1, '\r\n### Error updating database.  Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'addition\' at row 1\r\n### The error may exist in file [C:\\Users\\ASUS\\Desktop\\若依\\app-background\\ruoyi-system\\target\\classes\\mapper\\data\\PolicyMapper.xml]\r\n### The error may involve com.ruoyi.data.mapper.PolicyMapper.updatePolicy-Inline\r\n### The error occurred while setting parameters\r\n### SQL: update policy          SET title = ?,                                       category = ?,             content = ?,                          addition = ?,                                                    deleted = ?          where policy_id = ?\r\n### Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'addition\' at row 1\n; Data truncation: Data too long for column \'addition\' at row 1; nested exception is com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'addition\' at row 1', '2021-11-02 06:28:50');
INSERT INTO `sys_oper_log` VALUES (158, '政策', 2, 'com.ruoyi.data.controller.PolicyController.edit()', 'PUT', 1, 'admin', NULL, '/data/policy', '127.0.0.1', '内网IP', NULL, NULL, 1, '\r\n### Error updating database.  Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'addition\' at row 1\r\n### The error may exist in file [C:\\Users\\ASUS\\Desktop\\若依\\app-background\\ruoyi-system\\target\\classes\\mapper\\data\\PolicyMapper.xml]\r\n### The error may involve com.ruoyi.data.mapper.PolicyMapper.updatePolicy-Inline\r\n### The error occurred while setting parameters\r\n### SQL: update policy          SET title = ?,                                       category = ?,             content = ?,                          addition = ?,                                                    deleted = ?          where policy_id = ?\r\n### Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'addition\' at row 1\n; Data truncation: Data too long for column \'addition\' at row 1; nested exception is com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'addition\' at row 1', '2021-11-02 06:30:44');
INSERT INTO `sys_oper_log` VALUES (159, '政策', 2, 'com.ruoyi.data.controller.PolicyController.edit()', 'PUT', 1, 'admin', NULL, '/data/policy', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2021-11-02 06:39:13');
INSERT INTO `sys_oper_log` VALUES (160, '政策', 3, 'com.ruoyi.data.controller.PolicyController.remove()', 'DELETE', 1, 'admin', NULL, '/data/policy/26', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2021-11-02 06:47:16');
INSERT INTO `sys_oper_log` VALUES (161, '政策', 1, 'com.ruoyi.data.controller.PolicyController.add()', 'POST', 1, 'admin', NULL, '/data/policy', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2021-11-02 06:47:23');
INSERT INTO `sys_oper_log` VALUES (162, '政策', 2, 'com.ruoyi.data.controller.PolicyController.edit()', 'PUT', 1, 'admin', NULL, '/data/policy', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2021-11-02 06:48:17');
INSERT INTO `sys_oper_log` VALUES (163, '政策', 3, 'com.ruoyi.data.controller.PolicyController.remove()', 'DELETE', 1, 'admin', NULL, '/data/policy/27', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2021-11-02 06:48:55');
INSERT INTO `sys_oper_log` VALUES (164, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2021-11-02 07:14:13');
INSERT INTO `sys_oper_log` VALUES (165, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2021-11-02 07:15:31');
INSERT INTO `sys_oper_log` VALUES (166, '政策', 2, 'com.ruoyi.data.controller.PolicyController.edit()', 'PUT', 1, 'sta', NULL, '/data/policy', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2021-11-02 12:13:23');
INSERT INTO `sys_oper_log` VALUES (167, '政策', 2, 'com.ruoyi.data.controller.PolicyController.edit()', 'PUT', 1, 'sta', NULL, '/data/policy', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2021-11-02 12:13:40');
INSERT INTO `sys_oper_log` VALUES (168, '用户管理', 3, 'com.ruoyi.web.controller.system.SysUserController.remove()', 'DELETE', 1, 'admin', NULL, '/system/user/2', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2021-12-16 07:18:04');
INSERT INTO `sys_oper_log` VALUES (169, '用户管理', 3, 'com.ruoyi.web.controller.system.SysUserController.remove()', 'DELETE', 1, 'admin', NULL, '/system/user/100', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2021-12-16 07:18:07');
INSERT INTO `sys_oper_log` VALUES (170, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', NULL, '/system/dept', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2021-12-16 07:21:17');
INSERT INTO `sys_oper_log` VALUES (171, '政策', 1, 'com.ruoyi.data.controller.PolicyController.add()', 'POST', 1, 'sta', NULL, '/data/policy', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2021-12-24 01:47:50');
INSERT INTO `sys_oper_log` VALUES (172, '政策', 1, 'com.ruoyi.data.controller.PolicyController.add()', 'POST', 1, 'sta', NULL, '/data/policy', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2021-12-24 01:57:21');
INSERT INTO `sys_oper_log` VALUES (173, '政策', 1, 'com.ruoyi.data.controller.PolicyController.add()', 'POST', 1, 'sta', NULL, '/data/policy', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2021-12-24 01:59:28');
INSERT INTO `sys_oper_log` VALUES (174, '政策', 1, 'com.ruoyi.data.controller.PolicyController.add()', 'POST', 1, 'sta', NULL, '/data/policy', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2021-12-24 02:03:18');
INSERT INTO `sys_oper_log` VALUES (175, '政策', 1, 'com.ruoyi.data.controller.PolicyController.add()', 'POST', 1, 'sta', NULL, '/data/policy', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2021-12-24 02:05:40');
INSERT INTO `sys_oper_log` VALUES (176, '政策', 1, 'com.ruoyi.data.controller.PolicyController.add()', 'POST', 1, 'sta', NULL, '/data/policy', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2021-12-24 02:08:12');
INSERT INTO `sys_oper_log` VALUES (177, '政策', 1, 'com.ruoyi.data.controller.PolicyController.add()', 'POST', 1, 'sta', NULL, '/data/policy', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2021-12-24 02:10:06');
INSERT INTO `sys_oper_log` VALUES (178, '政策', 1, 'com.ruoyi.data.controller.PolicyController.add()', 'POST', 1, 'sta', NULL, '/data/policy', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2021-12-27 01:14:38');
INSERT INTO `sys_oper_log` VALUES (179, '政策', 1, 'com.ruoyi.data.controller.PolicyController.add()', 'POST', 1, 'sta', NULL, '/data/policy', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2021-12-27 01:18:26');
INSERT INTO `sys_oper_log` VALUES (180, '政策', 2, 'com.ruoyi.data.controller.PolicyController.edit()', 'PUT', 1, 'sta', NULL, '/data/policy', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2021-12-29 13:19:48');
INSERT INTO `sys_oper_log` VALUES (181, '政策', 2, 'com.ruoyi.data.controller.PolicyController.edit()', 'PUT', 1, 'sta', NULL, '/data/policy', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2021-12-29 13:20:43');
INSERT INTO `sys_oper_log` VALUES (182, '政策', 2, 'com.ruoyi.data.controller.PolicyController.edit()', 'PUT', 1, 'sta', NULL, '/data/policy', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2021-12-29 13:21:13');
INSERT INTO `sys_oper_log` VALUES (183, '政策', 2, 'com.ruoyi.data.controller.PolicyController.edit()', 'PUT', 1, 'sta', NULL, '/data/policy', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2021-12-29 13:21:16');
INSERT INTO `sys_oper_log` VALUES (184, '政策', 2, 'com.ruoyi.data.controller.PolicyController.edit()', 'PUT', 1, 'sta', NULL, '/data/policy', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2021-12-29 13:21:21');
INSERT INTO `sys_oper_log` VALUES (185, '政策', 2, 'com.ruoyi.data.controller.PolicyController.edit()', 'PUT', 1, 'sta', NULL, '/data/policy', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2021-12-29 13:21:26');
INSERT INTO `sys_oper_log` VALUES (186, '政策', 2, 'com.ruoyi.data.controller.PolicyController.edit()', 'PUT', 1, 'sta', NULL, '/data/policy', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2021-12-29 13:21:29');
INSERT INTO `sys_oper_log` VALUES (187, '政策', 2, 'com.ruoyi.data.controller.PolicyController.edit()', 'PUT', 1, 'sta', NULL, '/data/policy', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2021-12-29 13:21:34');
INSERT INTO `sys_oper_log` VALUES (188, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', NULL, '/system/role', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2022-01-04 01:48:49');
INSERT INTO `sys_oper_log` VALUES (189, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2022-01-18 10:36:36');
INSERT INTO `sys_oper_log` VALUES (190, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2022-01-18 10:37:17');
INSERT INTO `sys_oper_log` VALUES (191, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2022-01-18 10:37:29');
INSERT INTO `sys_oper_log` VALUES (192, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2022-01-18 10:37:39');
INSERT INTO `sys_oper_log` VALUES (193, '政策', 1, 'com.ruoyi.data.controller.PolicyController.add()', 'POST', 1, 'admin', NULL, '/data/policy', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2022-01-18 11:09:22');
INSERT INTO `sys_oper_log` VALUES (194, '政策', 3, 'com.ruoyi.data.controller.PolicyController.remove()', 'DELETE', 1, 'admin', NULL, '/data/policy/37', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2022-01-18 11:09:26');
INSERT INTO `sys_oper_log` VALUES (195, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', NULL, '/system/role', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2022-01-18 11:15:57');
INSERT INTO `sys_oper_log` VALUES (196, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', NULL, '/system/role', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2022-01-18 11:16:10');
INSERT INTO `sys_oper_log` VALUES (197, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', NULL, '/system/role', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2022-01-18 11:16:20');
INSERT INTO `sys_oper_log` VALUES (198, '政策', 1, 'com.ruoyi.data.controller.PolicyController.add()', 'POST', 1, 'admin', NULL, '/data/policy', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2022-01-18 18:04:24');
INSERT INTO `sys_oper_log` VALUES (199, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', NULL, '/tool/gen/importTable', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2022-02-17 11:48:39');
INSERT INTO `sys_oper_log` VALUES (200, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', NULL, '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2022-02-17 11:48:51');
INSERT INTO `sys_oper_log` VALUES (201, '新闻', 1, 'com.ruoyi.data.controller.NewsController.add()', 'POST', 1, 'admin', NULL, '/data/news', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2022-02-17 12:46:02');
INSERT INTO `sys_oper_log` VALUES (202, '新闻', 2, 'com.ruoyi.data.controller.NewsController.edit()', 'PUT', 1, 'admin', NULL, '/data/news', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2022-02-17 12:50:45');
INSERT INTO `sys_oper_log` VALUES (203, '新闻', 3, 'com.ruoyi.data.controller.NewsController.remove()', 'DELETE', 1, 'admin', NULL, '/data/news/6', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2022-02-17 12:51:13');
INSERT INTO `sys_oper_log` VALUES (204, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', NULL, '/system/role', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2022-02-17 13:38:00');
INSERT INTO `sys_oper_log` VALUES (205, '新闻', 1, 'com.ruoyi.data.controller.NewsController.add()', 'POST', 1, 'sta', NULL, '/data/news', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2022-02-17 13:38:38');
INSERT INTO `sys_oper_log` VALUES (206, '新闻', 3, 'com.ruoyi.data.controller.NewsController.remove()', 'DELETE', 1, 'sta', NULL, '/data/news/7', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2022-02-17 13:38:52');
INSERT INTO `sys_oper_log` VALUES (207, '新闻', 1, 'com.ruoyi.data.controller.NewsController.add()', 'POST', 1, 'sta', NULL, '/data/news', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2022-02-18 01:05:05');
INSERT INTO `sys_oper_log` VALUES (208, '新闻', 1, 'com.ruoyi.data.controller.NewsController.add()', 'POST', 1, 'sta', NULL, '/data/news', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2022-02-18 01:16:11');
INSERT INTO `sys_oper_log` VALUES (209, '新闻', 1, 'com.ruoyi.data.controller.NewsController.add()', 'POST', 1, 'sta', NULL, '/data/news', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2022-02-18 01:17:29');
INSERT INTO `sys_oper_log` VALUES (210, '新闻', 2, 'com.ruoyi.data.controller.NewsController.edit()', 'PUT', 1, 'admin', NULL, '/data/news', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2022-02-18 03:19:30');
INSERT INTO `sys_oper_log` VALUES (211, '新闻', 2, 'com.ruoyi.data.controller.NewsController.edit()', 'PUT', 1, 'admin', NULL, '/data/news', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2022-02-18 03:19:36');
INSERT INTO `sys_oper_log` VALUES (212, '新闻', 3, 'com.ruoyi.data.controller.NewsController.remove()', 'DELETE', 1, 'sta', NULL, '/data/news/10', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2022-02-18 03:29:44');
INSERT INTO `sys_oper_log` VALUES (213, '新闻', 1, 'com.ruoyi.data.controller.NewsController.add()', 'POST', 1, 'sta', NULL, '/data/news', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2022-02-22 01:29:50');
INSERT INTO `sys_oper_log` VALUES (214, '政策', 1, 'com.ruoyi.data.controller.PolicyController.add()', 'POST', 1, 'sta', NULL, '/data/policy', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2022-02-22 01:46:13');
INSERT INTO `sys_oper_log` VALUES (215, '政策', 1, 'com.ruoyi.data.controller.PolicyController.add()', 'POST', 1, 'sta', NULL, '/data/policy', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2022-02-22 01:47:50');
INSERT INTO `sys_oper_log` VALUES (216, '新闻', 1, 'com.ruoyi.data.controller.NewsController.add()', 'POST', 1, 'sta', NULL, '/data/news', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2022-02-22 01:50:24');
INSERT INTO `sys_oper_log` VALUES (217, '新闻', 1, 'com.ruoyi.data.controller.NewsController.add()', 'POST', 1, 'sta', NULL, '/data/news', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2022-02-22 01:56:00');
INSERT INTO `sys_oper_log` VALUES (218, '政策', 1, 'com.ruoyi.data.controller.PolicyController.add()', 'POST', 1, 'sta', NULL, '/data/policy', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2022-03-01 01:11:06');
INSERT INTO `sys_oper_log` VALUES (219, '政策', 3, 'com.ruoyi.data.controller.PolicyController.remove()', 'DELETE', 1, 'sta', NULL, '/data/policy/41', '127.0.0.1', '内网IP', NULL, NULL, 0, NULL, '2022-03-01 01:22:54');

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post`  (
  `post_id` bigint NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '岗位名称',
  `post_sort` int NOT NULL COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '岗位信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_post
-- ----------------------------
INSERT INTO `sys_post` VALUES (1, 'ceo', '董事长', 1, '0', 'admin', '2021-09-22 09:15:02', '', NULL, '');
INSERT INTO `sys_post` VALUES (2, 'se', '项目经理', 2, '0', 'admin', '2021-09-22 09:15:02', '', NULL, '');
INSERT INTO `sys_post` VALUES (3, 'hr', '人力资源', 3, '0', 'admin', '2021-09-22 09:15:02', '', NULL, '');
INSERT INTO `sys_post` VALUES (4, 'user', '普通员工', 4, '0', 'admin', '2021-09-22 09:15:02', '', NULL, '');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色权限字符串',
  `role_sort` int NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '部门树选择项是否关联显示',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 101 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 'admin', 1, '1', 1, 1, '0', '0', 'admin', '2021-09-22 09:15:03', '', NULL, '超级管理员');
INSERT INTO `sys_role` VALUES (2, '普通角色', 'common', 2, '2', 1, 1, '0', '0', 'admin', '2021-09-22 09:15:03', '', NULL, '普通角色');
INSERT INTO `sys_role` VALUES (100, '科技厅', 'STA', 0, '1', 1, 1, '0', '0', 'admin', '2021-11-01 16:21:43', 'admin', '2022-02-17 13:38:00', NULL);

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `dept_id` bigint NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`, `dept_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色和部门关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
INSERT INTO `sys_role_dept` VALUES (2, 100);
INSERT INTO `sys_role_dept` VALUES (2, 101);
INSERT INTO `sys_role_dept` VALUES (2, 105);

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (2, 1);
INSERT INTO `sys_role_menu` VALUES (2, 2);
INSERT INTO `sys_role_menu` VALUES (2, 3);
INSERT INTO `sys_role_menu` VALUES (2, 4);
INSERT INTO `sys_role_menu` VALUES (2, 100);
INSERT INTO `sys_role_menu` VALUES (2, 101);
INSERT INTO `sys_role_menu` VALUES (2, 102);
INSERT INTO `sys_role_menu` VALUES (2, 103);
INSERT INTO `sys_role_menu` VALUES (2, 104);
INSERT INTO `sys_role_menu` VALUES (2, 105);
INSERT INTO `sys_role_menu` VALUES (2, 106);
INSERT INTO `sys_role_menu` VALUES (2, 107);
INSERT INTO `sys_role_menu` VALUES (2, 108);
INSERT INTO `sys_role_menu` VALUES (2, 109);
INSERT INTO `sys_role_menu` VALUES (2, 110);
INSERT INTO `sys_role_menu` VALUES (2, 111);
INSERT INTO `sys_role_menu` VALUES (2, 112);
INSERT INTO `sys_role_menu` VALUES (2, 113);
INSERT INTO `sys_role_menu` VALUES (2, 114);
INSERT INTO `sys_role_menu` VALUES (2, 115);
INSERT INTO `sys_role_menu` VALUES (2, 116);
INSERT INTO `sys_role_menu` VALUES (2, 500);
INSERT INTO `sys_role_menu` VALUES (2, 501);
INSERT INTO `sys_role_menu` VALUES (2, 1000);
INSERT INTO `sys_role_menu` VALUES (2, 1001);
INSERT INTO `sys_role_menu` VALUES (2, 1002);
INSERT INTO `sys_role_menu` VALUES (2, 1003);
INSERT INTO `sys_role_menu` VALUES (2, 1004);
INSERT INTO `sys_role_menu` VALUES (2, 1005);
INSERT INTO `sys_role_menu` VALUES (2, 1006);
INSERT INTO `sys_role_menu` VALUES (2, 1007);
INSERT INTO `sys_role_menu` VALUES (2, 1008);
INSERT INTO `sys_role_menu` VALUES (2, 1009);
INSERT INTO `sys_role_menu` VALUES (2, 1010);
INSERT INTO `sys_role_menu` VALUES (2, 1011);
INSERT INTO `sys_role_menu` VALUES (2, 1012);
INSERT INTO `sys_role_menu` VALUES (2, 1013);
INSERT INTO `sys_role_menu` VALUES (2, 1014);
INSERT INTO `sys_role_menu` VALUES (2, 1015);
INSERT INTO `sys_role_menu` VALUES (2, 1016);
INSERT INTO `sys_role_menu` VALUES (2, 1017);
INSERT INTO `sys_role_menu` VALUES (2, 1018);
INSERT INTO `sys_role_menu` VALUES (2, 1019);
INSERT INTO `sys_role_menu` VALUES (2, 1020);
INSERT INTO `sys_role_menu` VALUES (2, 1021);
INSERT INTO `sys_role_menu` VALUES (2, 1022);
INSERT INTO `sys_role_menu` VALUES (2, 1023);
INSERT INTO `sys_role_menu` VALUES (2, 1024);
INSERT INTO `sys_role_menu` VALUES (2, 1025);
INSERT INTO `sys_role_menu` VALUES (2, 1026);
INSERT INTO `sys_role_menu` VALUES (2, 1027);
INSERT INTO `sys_role_menu` VALUES (2, 1028);
INSERT INTO `sys_role_menu` VALUES (2, 1029);
INSERT INTO `sys_role_menu` VALUES (2, 1030);
INSERT INTO `sys_role_menu` VALUES (2, 1031);
INSERT INTO `sys_role_menu` VALUES (2, 1032);
INSERT INTO `sys_role_menu` VALUES (2, 1033);
INSERT INTO `sys_role_menu` VALUES (2, 1034);
INSERT INTO `sys_role_menu` VALUES (2, 1035);
INSERT INTO `sys_role_menu` VALUES (2, 1036);
INSERT INTO `sys_role_menu` VALUES (2, 1037);
INSERT INTO `sys_role_menu` VALUES (2, 1038);
INSERT INTO `sys_role_menu` VALUES (2, 1039);
INSERT INTO `sys_role_menu` VALUES (2, 1040);
INSERT INTO `sys_role_menu` VALUES (2, 1041);
INSERT INTO `sys_role_menu` VALUES (2, 1042);
INSERT INTO `sys_role_menu` VALUES (2, 1043);
INSERT INTO `sys_role_menu` VALUES (2, 1044);
INSERT INTO `sys_role_menu` VALUES (2, 1045);
INSERT INTO `sys_role_menu` VALUES (2, 1046);
INSERT INTO `sys_role_menu` VALUES (2, 1047);
INSERT INTO `sys_role_menu` VALUES (2, 1048);
INSERT INTO `sys_role_menu` VALUES (2, 1049);
INSERT INTO `sys_role_menu` VALUES (2, 1050);
INSERT INTO `sys_role_menu` VALUES (2, 1051);
INSERT INTO `sys_role_menu` VALUES (2, 1052);
INSERT INTO `sys_role_menu` VALUES (2, 1053);
INSERT INTO `sys_role_menu` VALUES (2, 1054);
INSERT INTO `sys_role_menu` VALUES (2, 1055);
INSERT INTO `sys_role_menu` VALUES (2, 1056);
INSERT INTO `sys_role_menu` VALUES (2, 1057);
INSERT INTO `sys_role_menu` VALUES (2, 1058);
INSERT INTO `sys_role_menu` VALUES (2, 1059);
INSERT INTO `sys_role_menu` VALUES (2, 1060);
INSERT INTO `sys_role_menu` VALUES (100, 2033);
INSERT INTO `sys_role_menu` VALUES (100, 2034);
INSERT INTO `sys_role_menu` VALUES (100, 2035);
INSERT INTO `sys_role_menu` VALUES (100, 2036);
INSERT INTO `sys_role_menu` VALUES (100, 2037);
INSERT INTO `sys_role_menu` VALUES (100, 2038);
INSERT INTO `sys_role_menu` VALUES (100, 2039);
INSERT INTO `sys_role_menu` VALUES (100, 2040);
INSERT INTO `sys_role_menu` VALUES (100, 2041);
INSERT INTO `sys_role_menu` VALUES (100, 2042);
INSERT INTO `sys_role_menu` VALUES (100, 2043);
INSERT INTO `sys_role_menu` VALUES (100, 2044);
INSERT INTO `sys_role_menu` VALUES (100, 2057);
INSERT INTO `sys_role_menu` VALUES (100, 2058);
INSERT INTO `sys_role_menu` VALUES (100, 2059);
INSERT INTO `sys_role_menu` VALUES (100, 2060);
INSERT INTO `sys_role_menu` VALUES (100, 2061);
INSERT INTO `sys_role_menu` VALUES (100, 2062);
INSERT INTO `sys_role_menu` VALUES (100, 2063);
INSERT INTO `sys_role_menu` VALUES (100, 2064);
INSERT INTO `sys_role_menu` VALUES (100, 2065);
INSERT INTO `sys_role_menu` VALUES (100, 2066);
INSERT INTO `sys_role_menu` VALUES (100, 2067);
INSERT INTO `sys_role_menu` VALUES (100, 2068);
INSERT INTO `sys_role_menu` VALUES (100, 2081);
INSERT INTO `sys_role_menu` VALUES (100, 2082);
INSERT INTO `sys_role_menu` VALUES (100, 2083);
INSERT INTO `sys_role_menu` VALUES (100, 2084);
INSERT INTO `sys_role_menu` VALUES (100, 2085);
INSERT INTO `sys_role_menu` VALUES (100, 2086);
INSERT INTO `sys_role_menu` VALUES (100, 2099);
INSERT INTO `sys_role_menu` VALUES (100, 2101);
INSERT INTO `sys_role_menu` VALUES (100, 2102);
INSERT INTO `sys_role_menu` VALUES (100, 2103);
INSERT INTO `sys_role_menu` VALUES (100, 2104);
INSERT INTO `sys_role_menu` VALUES (100, 2105);
INSERT INTO `sys_role_menu` VALUES (100, 2106);
INSERT INTO `sys_role_menu` VALUES (100, 2107);
INSERT INTO `sys_role_menu` VALUES (100, 2108);
INSERT INTO `sys_role_menu` VALUES (100, 2109);
INSERT INTO `sys_role_menu` VALUES (100, 2110);
INSERT INTO `sys_role_menu` VALUES (100, 2111);
INSERT INTO `sys_role_menu` VALUES (100, 2112);
INSERT INTO `sys_role_menu` VALUES (100, 2113);
INSERT INTO `sys_role_menu` VALUES (100, 2114);
INSERT INTO `sys_role_menu` VALUES (100, 2115);
INSERT INTO `sys_role_menu` VALUES (100, 2116);
INSERT INTO `sys_role_menu` VALUES (100, 2117);
INSERT INTO `sys_role_menu` VALUES (100, 2118);
INSERT INTO `sys_role_menu` VALUES (100, 2119);
INSERT INTO `sys_role_menu` VALUES (100, 2120);
INSERT INTO `sys_role_menu` VALUES (100, 2121);
INSERT INTO `sys_role_menu` VALUES (100, 2122);
INSERT INTO `sys_role_menu` VALUES (100, 2123);
INSERT INTO `sys_role_menu` VALUES (100, 2124);
INSERT INTO `sys_role_menu` VALUES (100, 2125);
INSERT INTO `sys_role_menu` VALUES (100, 2126);
INSERT INTO `sys_role_menu` VALUES (100, 2127);
INSERT INTO `sys_role_menu` VALUES (100, 2128);
INSERT INTO `sys_role_menu` VALUES (100, 2129);
INSERT INTO `sys_role_menu` VALUES (100, 2130);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint NULL DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '手机号码',
  `sex` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '密码',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime NULL DEFAULT NULL COMMENT '最后登录时间',
  `create_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 102 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 103, 'admin', '系统管理员', '00', 'sys_user1@example.com', '13621439684', '1', NULL, '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2022-06-02 10:13:46', 'admin', '2021-09-22 09:15:02', 'admin', '2022-06-02 02:13:46', NULL);
INSERT INTO `sys_user` VALUES (2, 105, 'ry', '演示用户002', '00', 'sys_user2@example.com', '15917136158', '1', NULL, '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2021-09-22 09:15:02', 'admin', '2021-09-22 09:15:02', 'admin', NULL, NULL);
INSERT INTO `sys_user` VALUES (100, NULL, 'ty', '演示用户100', '00', 'sys_user100@example.com', '15010345068', '0', NULL, '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2021-09-30 19:23:17', 'admin', '2021-09-30 11:22:57', 'admin', '2021-09-30 11:23:22', NULL);
INSERT INTO `sys_user` VALUES (101, 200, 'sta', '演示用户101', '00', 'sys_user101@example.com', '15890852404', '0', NULL, '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2022-04-25 08:39:34', 'admin', '2021-11-01 16:29:21', 'admin', '2022-04-25 00:39:33', NULL);

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `post_id` bigint NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`, `post_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户与岗位关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
INSERT INTO `sys_user_post` VALUES (1, 1);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户和角色关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1);
INSERT INTO `sys_user_role` VALUES (101, 100);

-- ----------------------------
-- Table structure for talent_need
-- ----------------------------
DROP TABLE IF EXISTS `talent_need`;
CREATE TABLE `talent_need`  (
  `talent_need_id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `position` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '职位工作',
  `publish_time` datetime NULL DEFAULT NULL COMMENT '发布时间',
  `location` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '位置（省市县）',
  `address` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '详细地址',
  `contact_id` bigint NULL DEFAULT NULL COMMENT '联系人id',
  `job` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '工作内容',
  `demand` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '职位要求',
  `image` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '详情图片',
  `education` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '学历',
  `user_id` bigint NULL DEFAULT NULL,
  `gmt_create` datetime NULL DEFAULT NULL,
  `gmt_modified` datetime NULL DEFAULT NULL,
  `deleted` tinyint NULL DEFAULT NULL,
  PRIMARY KEY (`talent_need_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '人才需求' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of talent_need
-- ----------------------------
INSERT INTO `talent_need` VALUES (1, 'Java后端开发', '2021-03-25 11:23:43', '海南省-海口市-美兰区', '西安市雁塔区滨海大道125号', 1, '完成业务需求开发，编写接口文档', '精通Java\n熟悉Spring，SpringBoot\n熟悉Mybatis', '/static/defaultImage/1.png', '本科', NULL, '2021-10-18 17:24:04', '2021-10-18 17:24:14', 0);
INSERT INTO `talent_need` VALUES (2, 'Android开发工程师', '2021-03-25 13:49:14', '海南省-海口市-美兰区', '北京市朝阳区解放路69号', 5, '和后端、SRE、质量工程师，PM，设计师们一起，不断优化，达到业界领先的性能和用户体验。', '1.热爱移动（前端）开发，对使用自己代码直接服务亿万用户着迷；或者是技术极客，对写出完美代码有执着者；\n\n2.具备扎实的计算机基础，包括算法、数据结构、计算机网络，编译原理，操作系统等领域基础知识；\n\n3.熟悉某个移动平台（如iOS/Android）的平台工作机制、体系架构，掌握该平台的开发语言（如Objective-C/Swift/Java/Kotlin），并熟练使用相关的开发平台；\n\n4.掌握至少一门其他开发语言（如C/C++/Go/Rust/Java/Python/Ruby/JavaScript/Dart等），并有一定的实践经验。', '/static/defaultImage/1.png', '本科', NULL, '2021-10-18 17:24:08', '2021-10-18 17:24:16', 0);
INSERT INTO `talent_need` VALUES (3, '嵌入式开发', '2021-03-25 13:51:15', '海南省-海口市-美兰区', '成都市锦江区高新一路150号', 6, '负责3D相机的驱动、嵌入式应用程序的开发、测试等工作。', '1. 编程基本功扎实，熟练掌握C++，会使用Git，CMake等工具\n\n2. 能够顺畅地读写英文论文和文档。\n\n3. 自我驱动，追求工作的成就感和价值。\n\n4. 具有良好的团队合作能力和沟通能力。', '/static/defaultImage/1.png', '硕士', NULL, '2021-10-18 17:24:11', '2021-10-18 17:24:19', 0);

-- ----------------------------
-- Table structure for talent_supply
-- ----------------------------
DROP TABLE IF EXISTS `talent_supply`;
CREATE TABLE `talent_supply`  (
  `talent_supply_id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `publish_time` datetime NULL DEFAULT NULL COMMENT '发布时间',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '姓名',
  `image` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '照片',
  `age` int NULL DEFAULT NULL COMMENT '年龄',
  `profession` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '专业',
  `gender` tinyint NULL DEFAULT NULL COMMENT '性别 [1:男，2：女]',
  `job` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '求职意向',
  `contact_id` bigint NULL DEFAULT NULL COMMENT '联系人id',
  `skill` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '专业技能',
  `experience` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '个人经历',
  `enter_date` date NULL DEFAULT NULL COMMENT '入学时间',
  `graduate_date` date NULL DEFAULT NULL COMMENT '毕业时间',
  `school_id` bigint NULL DEFAULT NULL COMMENT '学校id',
  `resume_url` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '上传简历',
  PRIMARY KEY (`talent_supply_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '人才供应' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of talent_supply
-- ----------------------------
INSERT INTO `talent_supply` VALUES (1, '2021-03-20 00:07:14', '周国', '/static/defaultImage/1.png', 21, '计算机技术与科学', 1, '大师级人才', 2, '　1.诺贝尔奖获得者(物理、化学、生理或医学、文学、经济学奖);\r\n\r\n　　2.沃尔夫奖获得者、菲尔兹奖获得者;\r\n\r\n　　3.普利兹克奖获得者;\r\n\r\n　　4.图灵奖获得者;\r\n\r\n　　5.国家最高科学技术奖获得者;\r\n\r\n　　6.中国科学院院士、中国工程院院士;\r\n\r\n　　7.美国、日本、德国、法国、英国、意大利、加拿大、瑞典、丹麦、挪威、芬兰、比利时、瑞士、奥地利、荷兰、澳大利亚、新西兰、俄罗斯、新加坡、韩国、西班牙、印度、乌克兰、以色列最高学术权威机构会员;\r\n\r\n　　8.专业技术一级岗位人才。', '蓝桥杯天梯赛第一名', NULL, '2022-07-01', 1, NULL);
INSERT INTO `talent_supply` VALUES (2, '2021-03-25 09:21:31', '朱磊', '/static/defaultImage/1.png', 21, '软件工程', 1, '杰出人才', 3, '　(一)担任以下项目计划职务、入选以下人才计划、获得下列资助、年收入或纳税达到以下标准之一者(不含子计划、子项目)：\r\n\r\n　　1.国家重点研发计划或原国家“863 计划”领域专家组组长、副组长(项目首席科学家);\r\n\r\n　　2.原国家“973 计划”项目首席科学家;\r\n\r\n　　3.国家面向 2030 重大科技计划或国家科技重大专项总体组技术总师、副总师，项目负责人;\r\n\r\n　　4.原国家科技支撑(攻关)计划项目负责人;\r\n\r\n　　5.国家自然科学基金重大研究计划项目负责人;\r\n\r\n　　6.国家自然科学基金“国家杰出青年科学基金(含外籍)”、“创新研究群体科学基金”项目负责人;\r\n\r\n　　7.国家重点实验室、国家技术创新中心、国家研究中心、国家临床医学研究中心、国家工程实验室、国家工程技术研究中心、国家工程研究中心、国家地方联合工程研究中心主任;\r\n\r\n　　8.中国社会科学院学部委员、荣誉学部委员;\r\n\r\n　　9.国家社会科学基金重大项目首席专家;\r\n\r\n　　10.中央引进海外高层次人才“千人计划”人选;\r\n\r\n　　11.“国家高层次人才特殊支持计划”杰出人才;\r\n\r\n　　12.教育部“长江学者奖励计划”特聘教授;\r\n\r\n　　13.中央直接联系掌握专家;\r\n\r\n　　14.国家百千万人才工程国家级人选(国家有突出贡献的中青年专家);\r\n\r\n　　15.近 5 年世界 500 强企业或年营收 1000 亿元人民币及以上知名企业总部的首席执行官、首席技术官或技术研发总负责人、首席财务官;\r\n\r\n　　16.在上海交通大学高等教育研究院《世界大学学术排名》或泰晤士报《全球顶尖大学排名榜》排名前 200 的世界知名大学担任过教授;\r\n\r\n　　17.近 3 年在海南每年纳税额达到 1 亿人民币以上企业的法定代表人;\r\n\r\n　　18.近 3 年每年缴纳个人所得税达到 200 万人民币以上的人才(非企业法定代表人代表，并至少已在海南缴纳 1 年个人所得税);\r\n\r\n　　19.世界著名音乐、美术、艺术、设计等院校校长、副校长及教授;\r\n\r\n　　20. 担任世界著名乐团首席指挥和声部演奏员;\r\n\r\n　　21. 财政部全国会计领军人才培养工程特殊支持计划、会计名家培养工程人选(已毕业)。\r\n\r\n　　(二)获得以下奖项(称号)之一，并在海南从事相关工作者：\r\n\r\n　　1.国家科学技术奖(含国家自然科学奖、国家技术发明奖和国家科技进步奖)一等奖(第一、第二完成人)、二等奖(第一完成人);\r\n\r\n　　2.国家社会科学基金项目优秀成果特别荣誉奖、专著类一等奖(第一完成人);\r\n\r\n　　3.中国高校人文社会科学研究优秀成果奖特等奖(第一完成人);\r\n\r\n　　4 国家级教学成果奖特等奖(第一完成人);\r\n\r\n　　5.孙冶方经济科学奖著作奖、论文奖(第一完成人);\r\n\r\n　　6.茅盾文学奖;\r\n\r\n　　7.鲁迅文学奖;\r\n\r\n　　8.全国中青年德艺双馨文艺工作者(获奖时间为近 10 年内);\r\n\r\n　　9.长江韬奋奖;\r\n\r\n　　10.梁思成建筑奖;\r\n\r\n　　11.全国工程勘察设计大师;\r\n\r\n　　12.全国杰出专业技术人才;\r\n\r\n　　13.中国专利金奖(须为专利发明人及设计人);\r\n\r\n　　14.中华技能大奖;\r\n\r\n　　15.十佳全国优秀科技工作者;\r\n\r\n　　16.中国青年科学家奖;\r\n\r\n　　17.中国青年科技奖;\r\n\r\n　　18.白求恩奖章;\r\n\r\n　　19.奥运会金牌、银牌(含运动员及单项总教练、主教练;获奖时间为近 5 年内);\r\n\r\n　　20.国医大师;\r\n\r\n　　21.奥斯卡电影金像奖、柏林国际电影节金熊奖、威尼斯电影节圣马克金狮奖、戛纳电影节金棕榈奖(获奖时间为近 10年内);\r\n\r\n　　22.全国十佳农民;\r\n\r\n　　23.中国科协求是杰出青年成果转化奖\r\n\r\n　　24.中国青年女科学家奖;\r\n\r\n　　25.全国创新争先奖(奖章获得者);\r\n\r\n　　26.省部级科学技术奖特等奖(第一完成人);\r\n\r\n　　27.海南省杰出人才奖。', '在校期间曾获得三好学生，二等奖学金等荣誉', NULL, '2022-06-25', 1, NULL);
INSERT INTO `talent_supply` VALUES (3, '2021-04-01 01:15:45', '李芳磊', '/static/defaultImage/1.png', 22, '软件工程', 2, '领军人才', 19, '(一)担任以下项目计划职务、入选以下人才计划、获得下列资助、年收入或纳税达到以下标准之一者(不含子计划、子项目、子课题)：\r\n\r\n　　1.国家重点研发计划或原国家“863 计划”领域主题专家组成员，课题组负责人;\r\n\r\n　　2.原国家“973 计划”项目首席科学家助理，承担研究任务的项目专家组成员，课题组负责人;\r\n\r\n　　3.国家面向 2030 重大科技计划或国家科技重大专项课题负责人;\r\n\r\n　　4.原国家科技支撑(攻关)计划项目课题负责人;\r\n\r\n　　5.国家自然科学基金重点项目、优秀青年科学基金项目负责人;\r\n\r\n　　6.国家软科学研究计划重大项目第一负责人;\r\n\r\n　　7.国家重点实验室、国家技术创新中心，国家研究中心、国家临床医学研究中心、国家工程实验室，国家工程技术研究中心，国家工程研究中心副主任前 2名和国家地方联合工程研究中心第一副主任;\r\n\r\n　　8.国家现代农业产业技术体系首席专家;\r\n\r\n　　9.“国家高层次人才特殊支持计划”领军人才、青年拔尖人才;\r\n\r\n　　10.中央引进海外高层次人才“青年千人计划”人选;\r\n\r\n　　11.国务院批准的享受政府特殊津贴人员;\r\n\r\n　　12.文化名家暨‘四个一批’人才;\r\n\r\n　　13.教育部“长江学者奖励计划”青年学者项目人选;\r\n\r\n　　14.中科院“百人计划”人选;\r\n\r\n　　15.国家知识产权局“百千万知识产权人才工程”百名高层次人才培养人选;\r\n\r\n　　16.全国会计领军人才、国际化高端会计人才(已毕业);\r\n\r\n　　17.专业技术二级岗位人才、博士生导师(持续受聘 3 年以上);\r\n\r\n　　18.海南省委联系服务重点专家;\r\n\r\n　　19.海南省“百人专项”人选;\r\n\r\n　　20.海南省“南海名家”人选;\r\n\r\n　　21.省部级重点实验室、省部级工程实验室、省部级工程研究中心、省部级工程技术研究中心、省部级临床医学研究中心主任(以上平台均已通过验收);\r\n\r\n　　22.国家高新技术企业法定代表人;\r\n\r\n　　23.近 5 年世界 500 强企业或年营收 1000 亿元人民币及以上知名企业总部部门经理、副经理以及一级分公司总经理、副总经理;\r\n\r\n　　24.在上海交通大学高等教育研究院《世界大学学术排名》或泰晤士报《全球顶尖大学排名榜》排名前 200 的世界知名大学担任过副教授;\r\n\r\n　　25.近 3 年在海南每年纳税额达到 5000 万人民币以上企业的法定代表人;\r\n\r\n　　26.近 3 年每年缴纳个人所得税达到 100 万人民币以上的人才(非企业法定代表人，并至少已在海南缴纳 1 年个人所得税)。\r\n\r\n　　(二)获得以下奖项(称号)之一，并在海南从事相关工作者：\r\n\r\n　　1.全国农牧渔业丰收奖一等奖(第一完成人);\r\n\r\n　　2.神农中华农业科技奖一等奖(第一完成人);\r\n\r\n　　3.国家社会科学基金项目优秀成果专著类一等奖(第二完成人)、二等奖(第一完成人);\r\n\r\n　　4.中国高校人文社会科学研究优秀成果奖特等奖(第二完成人)、一等奖(第一完成人);\r\n\r\n　　5.国家级教学成果奖特等奖(第二完成人)、一等奖(第一完成人);\r\n\r\n　　6.詹天佑奖;\r\n\r\n　　7.国家级普通高等学校教学名师奖;\r\n\r\n　　8.全国模范教师;\r\n\r\n　　9.全国精神文明建设“五个一工程”奖单项奖(须为个人获得且排名第 1);\r\n\r\n　　10.中国文化艺术政府奖“文华奖”单项奖(文华剧作奖、文华导演奖、文华编导奖、文华音乐创作奖、文华舞台美术奖、文华表演奖)最高等级奖第 1名(获奖时间为近 5 年内);\r\n\r\n　　11.中国电影“华表奖”、中国电影“金鸡奖”、大众电影“百花奖”、中国电视剧“飞天奖”，中国广播电视节目奖(以上奖项须为个人获得且排名第1;获奖时间为近5年内);\r\n\r\n　　12.中国新闻奖特别奖、一等奖(第一完成人;获奖时间为近 5 年内);\r\n\r\n　　13.华夏建设科学技术奖特等奖、一等奖(第一完成人);\r\n\r\n　　14.国家友谊奖;\r\n\r\n　　15.全国技术能手;\r\n\r\n　　16.中国工艺美术大师;\r\n\r\n　　17.中国青年创业奖;\r\n\r\n　　18.全国农村优秀人才;\r\n\r\n　　19.奥运会铜牌，世界锦标赛、世界杯赛前 3 名，亚运会、全运会冠军(含运动员及单项总教练、主教练;获奖时间为近 5 年内);\r\n\r\n　　20.全国农业科研杰出人才;\r\n\r\n　　21.中华农业英才奖;\r\n\r\n　　22.全国名中医;\r\n\r\n　　23.全国创新争先奖(奖状获得者);\r\n\r\n　　24.亚洲建筑师协会建筑奖;\r\n\r\n　　25.全国资产评估行业领军人才;\r\n\r\n　　26.格莱美音乐奖、英国水星音乐奖、美国乡村音乐协会大奖、全球音乐电视台亚洲音乐大奖获得者，以及肖邦国际钢琴比赛、克里夫兰国际钢琴比赛、英国广播公司卡迪夫国际声乐比赛、国际青年歌剧比赛等国际著名艺术赛事奖项获得者;\r\n\r\n　　27.世界著名音乐、美术、艺术、设计等院校副教授，世界小姐、世界先生、环球小姐等国际著名时尚、选美赛事奖项获得者;\r\n\r\n　　28.省部级科学技术奖特等奖(第二完成人)、一等奖(第一完成人);\r\n\r\n　　29.省部级哲学社会科学优秀成果奖一等奖(第一完成人);\r\n\r\n　　30. 海南省有突出贡献高级技师。', '毕业于海南大学，在校期间担任学生会宣传部部长，工作认真负责', NULL, '2022-06-01', 1, NULL);
INSERT INTO `talent_supply` VALUES (4, NULL, NULL, NULL, NULL, NULL, NULL, '拔尖人才', NULL, '　　(一)担任以下项目计划职务、入选以下人才计划、获得下列资助、年收入或纳税达到以下标准之一者(不含子计划、子项目、子课题)：\r\n\r\n　　1.国家重点研发计划或原国家“863 计划”课题组第二负责人;\r\n\r\n　　2.原国家“973 计划”课题组第二负责人;\r\n\r\n　　3.国家面向 2030 重大科技计划或国家科技重大专项课题第二负责人;\r\n\r\n　　4.原国家科技支撑(攻关)计划项目课题第二负责人;\r\n\r\n　　5.国家自然科学基金面上项目、国家社科基金项目负责人;\r\n\r\n　　6.国家软科学研究计划面上项目第一负责人;\r\n\r\n　　7.教育部“新世纪优秀人才支持计划”人选;\r\n\r\n　　8.国家级非物质文化遗产传承人;\r\n\r\n　　9 国家卫生健康委(含原卫生部、原国家卫生计生委)有突出贡献中青年专家;\r\n\r\n　　10.专业技术三级岗位人才、硕士生导师(持续受聘 3 年以上);\r\n\r\n　　11.博士后(取得国家项目资助或奖励，已出站 2 年，并从事专业技术工作) ;\r\n\r\n　　12.海南省“南海英才”、“南海工匠”人选;\r\n\r\n　　13.海南省有突出贡献的优秀专家;\r\n\r\n　　14.省级特级教师;\r\n\r\n　　15.“515 人才工程”第一层次人选;\r\n\r\n　　16.高等院校、科研院所、医疗机构、文体领域中的省级以上学科学术和技术带头人;\r\n\r\n　　17.海南省内注册的高新技术企业设立的省级以上研发机构的法定代表人;\r\n\r\n　　18.近 3 年在海南每年纳税额达到 2500 万人民币以上企业的法定代表人;\r\n\r\n　　19.近 3 年每年缴纳个人所得税达到 50 万人民币以上的人才(非企业法定代表人代表，并至少已在海南缴纳 1 年个人所得税);\r\n\r\n　　20.海南省委联系服务重点专家后备人选。\r\n\r\n　　(二)获得以下奖项(称号)之一，并在海南从事相关工作者：\r\n\r\n　　1.全国农牧渔业丰收奖二等奖(第一完成人);\r\n\r\n　　2.神农中华农业科技奖二等奖(第一完成人);\r\n\r\n　　3.全国优秀科技工作者;\r\n\r\n　　4.杰出青年农业科学家;\r\n\r\n　　5.中国侨界贡献奖;\r\n\r\n　　6.国家级教学成果奖一等奖(第二完成人)、二等奖(第一完成人);\r\n\r\n　　7.中国文化艺术政府奖“群星奖”(作品类，须为主创、主演人员且排名第 1;获奖时间为近 10 年内);\r\n\r\n　　8.文联奖(须为个人获得且排名第 1，含子项 12个：中国戏剧奖、中国美术奖、中国音乐金钟奖、中国曲艺牡丹奖、中国舞蹈荷花奖、中国摄影金像奖、中国书法兰亭奖、中国民间文艺山花奖、中国杂技金菊奖、中国电视金鹰奖等10 个奖项的最高等级奖;获奖时间为近 10 年内);\r\n\r\n　　9.华夏建设科学技术奖二等奖(第一完成人);\r\n\r\n　　10.获得党中央、国务院、中央军委名义表彰奖励的先进个人;\r\n\r\n　　11.中国高校人文社会科学研究优秀成果奖一等奖(第二完成人)、二等奖(第一完成人)\r\n\r\n　　12.范长江新闻奖;\r\n\r\n　　13.获得网络安全优秀人才奖;\r\n\r\n　　14.省科学技术奖二等奖(第一完成人)\r\n\r\n　　15.省部级哲学社会科学优秀成果奖一等奖(第二完成人)和二等奖(第一完成人);\r\n\r\n　　16.海南省优秀科技创新创业人才奖;\r\n\r\n　　17.海南省椰岛友谊奖;\r\n\r\n　　18.海南省有突出贡献技师;\r\n\r\n　　19.海南省优秀社会工作人才奖;\r\n\r\n　　20.海南省十大专利发明人;\r\n\r\n　　21.全国优秀教师;\r\n\r\n　　22.省级普通高等学校教学名师奖;\r\n\r\n　　23.省级模范教师;\r\n\r\n　　24.省级各类领军人才培养项目第一层次人选;\r\n\r\n　　25.亚洲锦标赛冠军，亚运会、全运会银牌、铜牌(含运动员及单项总教练、主教练;获奖时间为近 5 年内);\r\n\r\n　　26. 国际注册会计师、金融分析师、精算师、建筑师。\r\n\r\n　　五、其他类高层次人才\r\n\r\n　　(一)入选以下计划者：\r\n\r\n　　1.海南省“南海乡土人才”人选;\r\n\r\n　　2.“515 人才工程”第二层次人选;\r\n\r\n　　3.海南省各类领军人才培养项目第二层次人选。\r\n\r\n　　(二)获得以下奖项(称号)之一，并在海南从事相关工作者：\r\n\r\n　　1.海南省椰岛纪念奖;\r\n\r\n　　2.海南省青年科技奖;\r\n\r\n　　3. 海南省优秀科技工作者;\r\n\r\n　　4.海南省技术能手奖;\r\n\r\n　　5.海南省优秀农村实用人才奖;\r\n\r\n　　6.海南省少数民族和贫困地区人才贡献奖;\r\n\r\n　　7.海南省华侨华人人才突出贡献奖;\r\n\r\n　　8.海南文化艺术政府奖“文华奖”单项奖获得者;\r\n\r\n　　9.海南省远志奖获得者;\r\n\r\n　　10.海南省优秀教师;\r\n\r\n　　11.海南省中小学十佳校长;\r\n\r\n　　12.海南省中小学十佳班主任或全国优秀班主任(省教育部门推荐);\r\n\r\n　　13. 获得省级党委和政府名义表彰奖励的先进个人;\r\n\r\n　　14.海南省工艺美术大师;\r\n\r\n　　(三)取得高级职称者。\r\n\r\n　　(四)取得高级技师资格者。\r\n\r\n　　(五)取得博士学位者。\r\n\r\n　　(六)注册会计师。\r\n\r\n　　(七)近 3 年在海南每年纳税额达到 500 万人民币以上企业的法定代表人。\r\n\r\n　　(八)近 3 年每年缴纳个人所得税达到 10 万人民币以上的人才(非企业法定代表人，并至少已在海南缴纳 1 年个人所得税)。\r\n\r\n　　(九)海南自由贸易试验区和中国特色自由贸易港建设急需紧缺人才。', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `talent_supply` VALUES (5, NULL, NULL, NULL, NULL, NULL, NULL, '海南省高层次人才认定流程', NULL, '', NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for technology_achievement
-- ----------------------------
DROP TABLE IF EXISTS `technology_achievement`;
CREATE TABLE `technology_achievement`  (
  `technology_achievement_id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标题',
  `publish_time` datetime NULL DEFAULT NULL COMMENT '发布时间',
  `category` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '分类',
  `website` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '网址',
  `description` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `field` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '行业领域',
  `image` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '详情图片',
  `contact_id` bigint NULL DEFAULT NULL COMMENT '联系人id',
  `publisher_type` tinyint NULL DEFAULT NULL COMMENT '发布者类型 [1：高新企业，3：学校]',
  `publisher_id` bigint NULL DEFAULT NULL COMMENT '企业或者学校id，根据发布者类型判断',
  `contact_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '作者的姓名/id',
  `contact_phone` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '作者的电话',
  `contact_email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '作者的邮箱',
  PRIMARY KEY (`technology_achievement_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '技术成果' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of technology_achievement
-- ----------------------------
INSERT INTO `technology_achievement` VALUES (1, '中国灵芝及其他真菌研究', '2021-03-25 09:38:53', '其他', 'https://www.tech110.net/portal.php?mod=view&aid=143562', '本成果任务来源于两项国家自然基金资助项目', '生物与新医药技术领域', '/static/defaultImage/1.png', 4, 3, 1, '谢娟', '13782530597', 'technology_achievement1@example.com');
INSERT INTO `technology_achievement` VALUES (2, '高品质卵白蛋白的开发及其在3D打印功能食品中应用技术的研究', '2021-03-25 14:53:28', '科研', 'https://www.haust.edu.cn/', '项目通过对鸡蛋卵白蛋白采用酶解和糖基化协同改性的工艺及其特性进行研究，研发出高品质的改性卵白蛋白制品；同时探明其应用于3D打印的关键技术和参数，为指导其生产应用奠定基础；同时为功能性蛋清粉的开发提供生产参考和科学理论依据。因此，该项研究不仅大大提高了禽蛋产品的附加值，经济效益显著', '新材料', '/static/defaultImage/1.png', 14, 1, 1, '褚红伟', '13627528458', 'technology_achievement2@example.com');
INSERT INTO `technology_achievement` VALUES (3, '工业副产石膏制纤维石膏板工艺技术及装备', '2021-03-25 15:01:12', '产品', 'http://www.lvjoe.com', '该项目针对石膏材料耐水性差以及纤维石膏板生产装备生产效率低、自动化程度不高等的问题，研究开发了石膏材料耐水改性工艺技术和全自动纤维石膏板生产装备。具体研究内容是：（1）利用硬石膏、锰渣、水泥作为耐水改性材料，研究开发石膏建材耐水改性工艺技术，提高石膏制品耐水性能，实现了多种固废的', '先进制造业', '/static/defaultImage/1.png', 17, 1, 1, '张敏辰', '18795020949', 'technology_achievement3@example.com');
INSERT INTO `technology_achievement` VALUES (4, '棘冠海星毒素分布及性质分析研究', '2021-09-29 20:12:19', '科研', NULL, '对棘冠海星体内毒素分布及性质分析，研究不同加工方式对其体内神经毒素的消除影响，探寻可食性加工技术。研究棘冠海星体内生物活性成分，为开发海洋药物及功能制品提供理论基础。本研究对新型海洋生物资源开发、保护海南珊瑚生态系统具有重要的意义。', '生物与新医药技术领域', '/static/defaultImage/1.png', 20, NULL, 1, '赵洋', '18227027385', NULL);
INSERT INTO `technology_achievement` VALUES (5, '基于3D打印的海南特色水产肌肉结构重组技术研究', '2021-09-29 21:01:34', '科研', NULL, '精准研制适合3D打印水产蛋白重组原料体系；打印层稳定结合基础上的即时固化特性及固定化技术研发；基于细胞学特性，研究3D打印食品营养吸收特性。充分发挥海南优质海洋资源的优势、克服体量不足，满足个性化定制、食疗替代药补，实施高端制造。', '食品加工', '/static/defaultImage/1.png', 20, NULL, NULL, '钱洋霞', '13546257638', NULL);
INSERT INTO `technology_achievement` VALUES (6, '金鲳鱼乳糜化精深加工技术研究', '2021-09-29 21:03:28', '科研', NULL, '以金鲳鱼营养和消化特性为着眼点进行技术攻关，解决鱼肉蛋白质受热变性质地硬化缺陷，突破海洋鱼类加工技术瓶颈。针对儿童、少年、孕产妇、老年人、有吞咽困难的特殊人群等对营养及口感需求，开发高营养及适口性的海洋健康新产品，丰富海洋食品加工产品形式。', '食品加工', '/static/defaultImage/1.png', 20, NULL, NULL, '严涛怡', '13820024262', NULL);
INSERT INTO `technology_achievement` VALUES (7, '高效油水分离技术及装备', '2021-09-29 21:18:16', '产品', NULL, '1.成果来源：国家自然科学基金；\r\n2.技术情况：基于新材料的高效油水分离装备，实现油水混合物高效分离；\r\n3.成效：具有完全自主知识产权的材料制备及配套装备制造工艺，实现含油废水中油相的高效回收，达到节约不可再生能源、保护生态环境的节能减排目标。\r\n\r\n有现成演示装备以及应用案例可以参观考察。', '新材料', '/static/defaultImage/1.png', 21, NULL, NULL, '孔静', '13828449883', NULL);
INSERT INTO `technology_achievement` VALUES (8, '高油酸花生规模化种植', '2021-09-29 21:22:28', '品种', NULL, '1.成果来源：海南省国际合作项目，Mars食品国际合作项目等。\r\n2.技术情况：高油酸花生琼花生1号、琼花2号、琼花3号、琼花4号和琼花5号均为高油酸花生品种，已获得农业部品种登记；油酸含量>75%,和橄榄油品质相当，除具有普通花生油香味外，高油酸含量可降低低密度脂蛋白而不改变高密度脂蛋白的含量，是更健康的花生油，货架期是普通花生油的3倍以上，尤其适合烹饪煎炸等；已建立高油酸花生分子标记辅助选择的育种体系，比传统育种时间节省1倍以上。\r\n3.成效：种植成本和普通花生相当，高油酸花生油平均售价比普通花生高20元/升，经济效益显著；显著降低低密度脂蛋白表达谱，社会效益显著。\r\n4.知识产权无争议。', '农业', '/static/defaultImage/1.png', 22, NULL, NULL, '秦国', '18866586454', NULL);

-- ----------------------------
-- Table structure for technology_need
-- ----------------------------
DROP TABLE IF EXISTS `technology_need`;
CREATE TABLE `technology_need`  (
  `technology_need_id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标题',
  `publish_time` datetime NULL DEFAULT NULL COMMENT '发布时间',
  `description` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `category` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '分类',
  `field` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '行业领域',
  `image` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '详情图片',
  `contact_id` bigint NULL DEFAULT NULL COMMENT '联系人id',
  `business_id` bigint NULL DEFAULT NULL COMMENT '企业id',
  `contact_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '联系人姓名',
  `contact_phone` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '联系人电话',
  `contact_email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '联系人邮箱',
  PRIMARY KEY (`technology_need_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '技术需求' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of technology_need
-- ----------------------------
INSERT INTO `technology_need` VALUES (1, '高温金属纤维毡纤维丝的制备及金属粉末喷涂制金属膜工艺', '2021-03-25 14:04:27', '高温金属纤维毡是由金属纤维丝多层压制烧结而形成的制密的金属纤维毡，金属纤维丝制备工艺相对复杂，需要用铜裹钢丝煅烧、拉丝、酸溶解铜、再次重复此过程，在此过程中有大量废水产生，在处理废水过程中需要较高的费用，导致制备成本较高，市场应用普及率较低。同时另一种金属粉末喷涂制金属膜工艺制备', '高温金属制造工艺', '资源与环境', '/static/defaultImage/1.png', 7, 1, '钱红明', '18225850986', 'technology_need1@example.com');
INSERT INTO `technology_need` VALUES (2, '无针射流流体力学分析', '2021-03-25 14:11:38', '研究通过无针注射器注射药物进入机体后药物的注射深度、扩散分布以及吸收过程的数据曲线。', '机械制药', '生物医药', '/static/defaultImage/1.png', 8, 1, '孔平敏', '15813620127', 'technology_need2@example.com');
INSERT INTO `technology_need` VALUES (3, '家禽疫苗生产技术的需求', '2021-03-25 14:13:23', '现有的家禽疫苗存在生产成本高、操作繁琐、辅助设备多、过程可控性差、产品毒价不高等诸多问题。\n降低成本、操作简化、过程可控性提升、产品毒价提高', '疫苗生产', '生物医药', '/static/defaultImage/1.png', 9, 1, '吕明辰', '18778942379', 'technology_need3@example.com');

-- ----------------------------
-- Table structure for time_index
-- ----------------------------
DROP TABLE IF EXISTS `time_index`;
CREATE TABLE `time_index`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '时间检索' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of time_index
-- ----------------------------
INSERT INTO `time_index` VALUES (1, '一个月内');
INSERT INTO `time_index` VALUES (2, '三个月内');
INSERT INTO `time_index` VALUES (3, '六个月内');
INSERT INTO `time_index` VALUES (4, '一年内');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `username` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '昵称',
  `password` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码',
  `real_name` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '真实姓名',
  `gender` tinyint NULL DEFAULT NULL COMMENT '性别 [1:男，2：女]',
  `location` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '位置（省市县）',
  `address` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '地址',
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机号',
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电子邮箱',
  `type` tinyint NULL DEFAULT 0 COMMENT '用户类型（0:未认定用户，1：高新企业，2：科技主管部门，3：学校，4：金融机构，5：服务机构）',
  `status` tinyint NULL DEFAULT 0 COMMENT '审核状态（0:未认定，1：正在审核，2：审核通过）',
  `token` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'token',
  `gmt_create` datetime NULL DEFAULT NULL,
  `gmt_modified` datetime NULL DEFAULT NULL,
  `deleted` tinyint NULL DEFAULT 0,
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, NULL, 'e10adc3949ba59abbe56e057f20f883e', NULL, NULL, NULL, NULL, '18867831813', NULL, 0, 0, NULL, '2021-09-15 17:07:07', '2021-09-14 08:55:49', 0);
INSERT INTO `user` VALUES (2, NULL, 'e10adc3949ba59abbe56e057f20f883e', NULL, NULL, NULL, NULL, '13519478910', NULL, 1, 2, NULL, '2021-09-07 17:07:13', '2021-09-14 08:55:49', 0);
INSERT INTO `user` VALUES (3, NULL, 'e10adc3949ba59abbe56e057f20f883e', NULL, NULL, NULL, NULL, '15164120531', NULL, 2, 2, NULL, '2021-09-01 17:07:18', '2022-03-14 14:19:52', 0);
INSERT INTO `user` VALUES (4, NULL, 'e10adc3949ba59abbe56e057f20f883e', NULL, NULL, NULL, NULL, '18765100873', NULL, 3, 2, NULL, '2021-09-08 17:07:21', '2021-09-14 08:55:49', 0);
INSERT INTO `user` VALUES (5, NULL, 'e10adc3949ba59abbe56e057f20f883e', NULL, NULL, NULL, NULL, '13560616203', NULL, 4, 2, NULL, '2021-09-08 17:07:24', '2021-09-14 08:55:49', 0);
INSERT INTO `user` VALUES (6, NULL, 'e10adc3949ba59abbe56e057f20f883e', NULL, NULL, NULL, NULL, '15178018927', NULL, 5, 2, NULL, '2021-09-08 17:07:28', '2021-09-14 08:55:49', 0);
INSERT INTO `user` VALUES (7, NULL, 'e10adc3949ba59abbe56e057f20f883e', NULL, NULL, NULL, NULL, '15197647776', NULL, 0, 0, NULL, '2021-09-08 17:07:31', '2021-11-06 05:33:48', 0);
INSERT INTO `user` VALUES (8, NULL, 'e10adc3949ba59abbe56e057f20f883e', NULL, NULL, NULL, NULL, '18275729551', NULL, 0, 0, NULL, '2021-09-08 17:07:34', '2021-09-14 08:55:49', 0);
INSERT INTO `user` VALUES (9, NULL, 'e10adc3949ba59abbe56e057f20f883e', NULL, NULL, NULL, NULL, '13773919436', NULL, 0, 0, NULL, '2021-09-08 17:07:37', '2021-09-14 08:55:49', 0);
INSERT INTO `user` VALUES (10, NULL, 'e10adc3949ba59abbe56e057f20f883e', NULL, NULL, NULL, NULL, '18851868202', NULL, 0, 0, NULL, '2021-09-08 17:07:40', '2021-09-14 08:55:49', 0);
INSERT INTO `user` VALUES (11, NULL, 'e10adc3949ba59abbe56e057f20f883e', NULL, NULL, NULL, NULL, '15857201485', NULL, 0, 0, NULL, '2021-09-08 17:07:44', '2021-09-14 08:55:49', 0);
INSERT INTO `user` VALUES (12, NULL, 'e10adc3949ba59abbe56e057f20f883e', NULL, NULL, NULL, NULL, '13911987881', NULL, 0, 0, NULL, '2021-09-08 17:07:47', '2021-09-14 08:55:49', 0);
INSERT INTO `user` VALUES (13, NULL, 'e10adc3949ba59abbe56e057f20f883e', NULL, NULL, NULL, NULL, '18892670457', NULL, 0, 0, NULL, '2021-09-08 17:07:50', '2021-09-14 08:55:49', 0);
INSERT INTO `user` VALUES (14, NULL, 'e10adc3949ba59abbe56e057f20f883e', NULL, NULL, NULL, NULL, '15919704595', NULL, 0, 0, NULL, '2021-09-08 17:07:53', '2021-09-14 08:55:49', 0);
INSERT INTO `user` VALUES (15, NULL, 'e10adc3949ba59abbe56e057f20f883e', NULL, NULL, NULL, NULL, '15999373251', NULL, 0, 0, NULL, '2021-09-08 17:07:56', '2021-09-14 08:55:49', 0);
INSERT INTO `user` VALUES (16, NULL, 'e10adc3949ba59abbe56e057f20f883e', NULL, NULL, NULL, NULL, '13992132160', NULL, 0, 0, NULL, '2021-09-08 17:07:59', '2021-09-14 08:55:49', 0);
INSERT INTO `user` VALUES (17, NULL, 'e10adc3949ba59abbe56e057f20f883e', NULL, NULL, NULL, NULL, '13501569018', NULL, 0, 0, NULL, '2021-09-08 17:08:02', '2021-09-14 08:55:49', 0);
INSERT INTO `user` VALUES (18, NULL, 'e10adc3949ba59abbe56e057f20f883e', NULL, NULL, NULL, NULL, '13741699746', NULL, 0, 0, NULL, '2021-09-08 17:08:05', '2021-09-14 08:55:49', 0);
INSERT INTO `user` VALUES (19, NULL, 'e10adc3949ba59abbe56e057f20f883e', NULL, NULL, NULL, NULL, '15839294739', NULL, 0, 0, NULL, '2021-09-08 17:08:08', '2021-09-14 08:55:49', 0);
INSERT INTO `user` VALUES (20, NULL, 'e10adc3949ba59abbe56e057f20f883e', NULL, NULL, NULL, NULL, '13964722612', NULL, 0, 0, NULL, '2021-09-08 17:08:11', '2021-09-14 08:55:49', 0);
INSERT INTO `user` VALUES (21, NULL, 'e10adc3949ba59abbe56e057f20f883e', NULL, NULL, NULL, NULL, '13669748484', NULL, 0, 0, NULL, '2021-09-08 17:08:14', '2021-09-14 08:55:49', 0);
INSERT INTO `user` VALUES (22, NULL, 'e10adc3949ba59abbe56e057f20f883e', NULL, NULL, NULL, NULL, '13529739202', NULL, 0, 0, NULL, '2021-09-08 17:08:18', '2021-09-14 08:55:49', 0);
INSERT INTO `user` VALUES (23, NULL, 'e10adc3949ba59abbe56e057f20f883e', NULL, NULL, NULL, NULL, '13879316998', NULL, 0, 0, NULL, '2021-09-08 17:08:21', '2022-02-09 19:43:02', 0);
INSERT INTO `user` VALUES (24, NULL, 'e10adc3949ba59abbe56e057f20f883e', NULL, NULL, NULL, NULL, '13829701028', NULL, 1, 0, NULL, '2021-09-14 17:30:55', '2021-09-14 17:30:55', 0);

SET FOREIGN_KEY_CHECKS = 1;
