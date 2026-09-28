create table con_type_index
(
    id bigint auto_increment,
    name varchar(20) null comment '名称',
    constraint con_type_index_pk
        primary key (id)
)
    comment '咨询问题类型检索';