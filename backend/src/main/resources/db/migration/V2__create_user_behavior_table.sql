-- 用户行为表
CREATE TABLE `user_behavior` (
  `behavior_id` bigint NOT NULL AUTO_INCREMENT COMMENT '行为ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `target_type` tinyint NOT NULL COMMENT '目标类型 [1:岗位, 2:简历]',
  `target_id` bigint NOT NULL COMMENT '目标ID(岗位ID或简历ID)',
  `action_type` tinyint NOT NULL COMMENT '操作类型 [0:撤销, 1:喜欢, 2:不喜欢]',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`behavior_id`),
  KEY `idx_user_target` (`user_id`, `target_type`, `target_id`),
  KEY `idx_user_action` (`user_id`, `action_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='用户行为表'; 