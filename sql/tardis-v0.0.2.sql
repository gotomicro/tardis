-- 网关数据库
CREATE DATABASE tardis_admin;
USE tardis_admin;

-- 区域配置表，全局配置
CREATE TABLE `tardis_region` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `name` varchar(64) NOT NULL DEFAULT '' COMMENT '区域名称，字母驼峰命名，不能有其他字符，不可修改',
  `desc` varchar(128) NOT NULL DEFAULT '' COMMENT '简短描述',
  `status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '状态，0：未启用；1：启用',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '添加时间',
  `creator` varchar(32) NOT NULL DEFAULT '' COMMENT '创建者',
  `modify_time` int(11) NOT NULL DEFAULT '0' COMMENT '修改时间',
  `modifier` varchar(32) NOT NULL DEFAULT '' COMMENT '修改者',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_name` (`name`),
  KEY `idx_time_creator` (`create_time`,`creator`),
  KEY `idx_time_modifier` (`modify_time`,`modifier`)
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8 COMMENT='区域配置表';

-- 应用配置表
CREATE TABLE `tardis_app` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `region` varchar(32) NOT NULL DEFAULT '' COMMENT '区域',
  `name` varchar(64) NOT NULL DEFAULT '' COMMENT '应用名称，字母驼峰命名，不能有其他字符，不可修改',
  `desc` varchar(128) NOT NULL DEFAULT '' COMMENT '简短描述',
  `auth_type` varchar(16) NOT NULL DEFAULT '' COMMENT '应用的认证类型，如：cas、oauth2等',
  `cookie_name` varchar(64) NOT NULL DEFAULT '' COMMENT '原始请求cookie名称',
  `status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '状态，0：未启用；1：启用',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '添加时间',
  `creator` varchar(32) NOT NULL DEFAULT '' COMMENT '创建者',
  `modify_time` int(11) NOT NULL DEFAULT '0' COMMENT '修改时间',
  `modifier` varchar(32) NOT NULL DEFAULT '' COMMENT '修改者',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_region_name` (`region`,`name`),
  KEY `idx_time_creator` (`create_time`,`creator`),
  KEY `idx_time_modifier` (`modify_time`,`modifier`)
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8 COMMENT='应用配置表';

-- 入口配置表
CREATE TABLE `tardis_entrypoint` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `region` varchar(32) NOT NULL DEFAULT '' COMMENT '区域',
  `name` varchar(64) NOT NULL DEFAULT '' COMMENT '入口名称，字母驼峰命名，不能有其他字符，不可修改',
  `desc` varchar(128) NOT NULL DEFAULT '' COMMENT '简短描述',
  `address` varchar(64) NOT NULL DEFAULT '' COMMENT '入口地址，如：":80"、":1704/udp"',
  `status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '状态，0：未启用；1：启用',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '添加时间',
  `creator` varchar(32) NOT NULL DEFAULT '' COMMENT '创建者',
  `modify_time` int(11) NOT NULL DEFAULT '0' COMMENT '修改时间',
  `modifier` varchar(32) NOT NULL DEFAULT '' COMMENT '修改者',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_region_name` (`region`,`name`),
  KEY `idx_time_creator` (`create_time`,`creator`),
  KEY `idx_time_modifier` (`modify_time`,`modifier`)
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8 COMMENT='入口配置表';

-- 路由配置表
CREATE TABLE `tardis_router` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `region` varchar(32) NOT NULL DEFAULT '' COMMENT '区域',
  `name` varchar(64) NOT NULL DEFAULT '' COMMENT '路由名称，字母驼峰命名，不能有其他字符',
  `app` varchar(64) NOT NULL DEFAULT '' COMMENT '应用名称',
  `desc` varchar(128) NOT NULL DEFAULT '' COMMENT '简短描述',
  `rule` varchar (256) NOT NULL DEFAULT '' COMMENT '路由规则，如：Host(`tardis.io`) && Path(`/`)',
  `service` varchar(64) NOT NULL DEFAULT '' COMMENT '服务',
  `proto` varchar(16) NOT NULL DEFAULT 'http' COMMENT '应用使用的协议，如：tcp、http、grpc，初始默认为http',
  `status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '状态，0：未启用；1：启用',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '添加时间',
  `creator` varchar(32) NOT NULL DEFAULT '' COMMENT '创建者',
  `modify_time` int(11) NOT NULL DEFAULT '0' COMMENT '修改时间',
  `modifier` varchar(32) NOT NULL DEFAULT '' COMMENT '修改者',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_region_name` (`region`,`name`),
  KEY `idx_app` (`app`),
  KEY `idx_time_creator` (`create_time`,`creator`),
  KEY `idx_time_modifier` (`modify_time`,`modifier`)
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8 COMMENT='路由配置表';

-- 路由关联表
CREATE TABLE `tardis_router_relation` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `region` varchar(32) NOT NULL DEFAULT '' COMMENT '区域',
  `router` varchar(32) NOT NULL DEFAULT '' COMMENT '路由名称，字母驼峰命名，不能有其他字符',
  `relation_type` varchar(32) NOT NULL DEFAULT '' COMMENT '关联类型，如：plugin、entrypoint',
  `relation_name` varchar(32) NOT NULL DEFAULT '' COMMENT '关联名称，字母驼峰命名，不能有其他字符',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '添加时间',
  `creator` varchar(32) NOT NULL DEFAULT '' COMMENT '创建者',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_relation` (`region`,`router`,`relation_type`,`relation_name`),
  KEY `idx_time_creator` (`create_time`,`creator`),
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8 COMMENT='路由关联表';

CREATE TABLE `tardis_service` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `region` varchar(32) NOT NULL DEFAULT '' COMMENT '区域',
  `name` varchar(32) NOT NULL DEFAULT '' COMMENT '服务名称，字母驼峰命名，不能有其他字符',
  `desc` varchar(128) NOT NULL DEFAULT '' COMMENT '简短描述',
  `discovery` varchar(16) NOT NULL DEFAULT 'k8s' COMMENT '服务发现类型，如: host、consul、k8s等',
  `service` varchar(64) NOT NULL DEFAULT '' COMMENT '服务注册名称，如：tardis-admin',
  `proto` varchar(16) NOT NULL DEFAULT 'http' COMMENT '服务所用的协议，如：tcp、http、grpc',
  `status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '状态，0：未启用；1：启用',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '添加时间',
  `creator` varchar(32) NOT NULL DEFAULT '' COMMENT '创建者',
  `modify_time` int(11) NOT NULL DEFAULT '0' COMMENT '修改时间',
  `modifier` varchar(32) NOT NULL DEFAULT '' COMMENT '修改者',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_region_name` (`region`,`name`),
  UNIQUE KEY `uk_type_service_proto` (`discovery_type`,`service_name`,`proto`),
  KEY `idx_time_creator` (`create_time`,`creator`),
  KEY `idx_time_modifier` (`modify_time`,`modifier`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8 COMMENT='服务配置表';

-- 插件配置表
CREATE TABLE `tardis_plugin` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `region` varchar(32) NOT NULL DEFAULT '' COMMENT '区域',
  `name` varchar(32) NOT NULL DEFAULT '' COMMENT '插件名称，字母驼峰命名，不能有其他字符',
  `desc` varchar(128) NOT NULL DEFAULT '' COMMENT '简短描述',
  `type` varchar(32) NOT NULL DEFAULT '' COMMENT '插件类型',
  `config_format` varchar(32) NOT NULL DEFAULT 'json' COMMENT '数据格式',
  `config` text COMMENT '配置数据',
  `status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '状态，0：未启用；1：启用',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '添加时间',
  `creator` varchar(32) NOT NULL DEFAULT '' COMMENT '创建者',
  `modify_time` int(11) NOT NULL DEFAULT '0' COMMENT '修改时间',
  `modifier` varchar(32) NOT NULL DEFAULT '' COMMENT '修改者',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_region_name` (`region`,`name`),
  KEY `idx_type` (`type`,`status`),
  KEY `idx_time_creator` (`create_time`,`creator`),
  KEY `idx_time_modifier` (`modify_time`,`modifier`),
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8 COMMENT='插件配置表';

-- 域名和区域配置表，用于管理域名和机房的对应关系，全局配置，所有区域一样
CREATE TABLE `tardis_domain` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `domain` varchar(64) NOT NULL DEFAULT '' COMMENT '域名，唯一，可更改',
  `region` varchar(32) NOT NULL DEFAULT '' COMMENT '区域，如：cn-east、hk、us-east',
  `desc` varchar(256) NOT NULL DEFAULT '' COMMENT '描述',
  `status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '状态，0：未启用；1：启用',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '添加时间',
  `creator` varchar(32) NOT NULL DEFAULT '' COMMENT '创建者',
  `modify_time` int(11) NOT NULL DEFAULT '0' COMMENT '修改时间',
  `modifier` varchar(32) NOT NULL DEFAULT '' COMMENT '修改者',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_domain` (`domain`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COMMENT='域名和区域管理表';

-- 系统配置表
CREATE TABLE `tardis_system_config` (
  `id` int(11) unsigned AUTO_INCREMENT NOT NULL COMMENT '自增ID',
  `region` varchar(32) NOT NULL DEFAULT '' COMMENT '区域',
  `conf_group` varchar(16) NOT NULL DEFAULT '' COMMENT '配置组',
  `conf_key` varchar(64) DEFAULT NULL COMMENT '配置名称',
  `conf_val` varchar(256) DEFAULT NULL COMMENT '配置值',
  `desc` varchar(100) DEFAULT NULL COMMENT '描述',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '添加时间',
  `creator` varchar(32) NOT NULL DEFAULT '' COMMENT '创建者',
  `modify_time` int(11) NOT NULL DEFAULT '0' COMMENT '修改时间',
  `modifier` varchar(32) NOT NULL DEFAULT '' COMMENT '修改者',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_region_group_key` (`region`, `conf_group`, `conf_key`),
  KEY `idx_time_creator` (`create_time`,`creator`),
  KEY `idx_time_modifier` (`modify_time`,`modifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统配置表,用于保存各种系统配置，如:系统功能开关、当前配置版本等';

-- 系统日志，用于记录其他表内容变更、配置变更
CREATE TABLE `tardis_system_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `region` varchar(32) NOT NULL DEFAULT '' COMMENT '区域',
  `type` varchar(32) NOT NULL DEFAULT '' COMMENT '日志类型',
  `event` varchar(32) NOT NULL DEFAULT '' COMMENT '事件类型',
  `log` text COMMENT '日志内容，数据格式json',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '添加时间',
  `creator` varchar(32) NOT NULL DEFAULT '' COMMENT '创建者',
  PRIMARY KEY (`id`),
  KEY `idx_type` (`type`),
  KEY `idx_time_creator` (`create_time`,`creator`)
) ENGINE=InnoDB AUTO_INCREMENT=768 DEFAULT CHARSET=utf8 COMMENT='系统日志表';

