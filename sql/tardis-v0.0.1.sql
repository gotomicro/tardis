-- 网关数据库
CREATE DATABASE tardis_admin;
USE tardis_admin;

-- 配置快照，用于回滚配置
CREATE TABLE `tardis_config_snapshot` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `region` varchar(32) NOT NULL DEFAULT '' COMMENT '区域',
  `version` varchar(32) NOT NULL DEFAULT '' COMMENT '版本，区域内唯一',
  `config_format` varchar(32) NOT NULL DEFAULT 'json' COMMENT '配置格式，如：json、toml、yaml',
  `config` text COMMENT '配置数据',
  `target` varchar(32) NOT NULL DEFAULT 'k8s' COMMENT '目标类型，如：k8s、consul、etcd等',
  `target_format` varchar(32) NOT NULL DEFAULT 'k8s' COMMENT '目标格式，如：json、toml、yaml、kv等',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '添加时间',
  `creator` varchar(32) NOT NULL DEFAULT '' COMMENT '创建者',
  `publish_time` int(11) NOT NULL DEFAULT '0' COMMENT '发布时间',
  `publisher` varchar(32) NOT NULL DEFAULT '' COMMENT '发布者',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_region_version` (`region`,`version`),
  KEY `idx_time_creator` (`create_time`,`creator`),
  KEY `idx_time_publisher` (`publish_time`,`publisher`)
) ENGINE=InnoDB AUTO_INCREMENT=313 DEFAULT CHARSET=utf8 COMMENT='配置快照表';

