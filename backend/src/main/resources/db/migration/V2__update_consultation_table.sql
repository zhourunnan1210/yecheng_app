alter table consultation
    add parent_id bigint default 0 not null comment '回复信息对应的咨询信息的id（咨询信息的parent_id为0）
';

alter table consultation
    add publish_time datetime default now() not null comment '发布时间';

alter table consultation
    add is_read tinyint default 0 not null comment '是否已读（0：未读 1：已读）';
