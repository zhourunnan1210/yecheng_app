drop table if exists user;
create table user
(
    user_id bigint auto_increment comment '用户id',
    username varchar(10) null comment '昵称',
    password varchar(100) null comment '密码',
    real_name varchar(10) null comment '真实姓名',
    gender tinyint null comment '性别 [1:男，2：女]',
    location varchar(20) null comment '位置（省市县）',
    address varchar(100) null comment '地址',
    phone varchar(11) null comment '手机号',
    email varchar(50) null comment '电子邮箱',
    type tinyint default 0 null comment '用户类型（0:未认定用户，1：高新企业，2：科技主管部门，3：学校，4：金融机构，5：服务机构）',
    status tinyint default 0 null comment '审核状态（0:未认定，1：正在审核，2：审核通过）',
    token varchar(50) null comment 'token',
    constraint user_pk
        primary key (user_id)
)
    comment '用户';

drop table if exists business_info;
create table business_info
(
    business_id bigint auto_increment comment 'id',
    name varchar(50) null comment '名称',
    corporate varchar(10) null comment '法人',
    type tinyint null comment '类型（1：有效期高企，2：培育库入库企业，3：当年申报企业）',
    manege_scope varchar(20) null comment '经营范围',
    introduction varchar(1000) null comment '简介',
    found_date date null comment '成立日期',
    manege_deadline date null comment '经营期限',
    website varchar(100) null comment '网址',
    email varchar(100) null comment '邮箱',
    capital varchar(20) null comment '注册资本',
    location varchar(20) null comment '位置（省市县）',
    address varchar(100) null comment '详细地址',
    code varchar(100) null comment '统一社会信用代码',
    telephone varchar(30) null comment '固定电话',
    contact_id bigint null comment '联系人id',
    reg_office varchar(100) null comment '登记机关',
    examine_date date null comment '核准日期',
    image_url varchar(200) null comment '公司图片',
    examine_image varchar(1000) null comment '审核所需资料',
    user_id bigint null comment '用户id',
    status tinyint null comment '审核状态 [1：正在审核，2：审核通过，3：审核失败]',
    constraint business_info_pk
        primary key (business_id)
)
    comment '企业信息';

drop table if exists school_info;
create table school_info
(
    school_id bigint auto_increment comment 'id',
    name varchar(50) null comment '名称',
    website varchar(100) null comment '网址',
    location varchar(20) null comment '位置（省市县）',
    address varchar(100) null comment '详细地址',
    code varchar(100) null comment '统一社会信用代码',
    telephone varchar(11) null comment '固定电话',
    email varchar(100) null comment '邮箱',
    contact_id bigint null comment '联系人id',
    image_url varchar(200) null comment '学校图片',
    examine_image varchar(1000) null comment '审核所需资料',
    user_id bigint null comment '用户id',
    status tinyint null comment '审核状态 [1：正在审核，2：审核通过，3：审核失败]',
    constraint school_info_pk
        primary key (school_id)
)
    comment '学校信息';

drop table if exists department_info;
create table department_info
(
    department_id bigint auto_increment comment 'id',
    name varchar(50) null comment '名称',
    website varchar(100) null comment '网址',
    location varchar(20) null comment '位置（省市县）',
    address varchar(100) null comment '详细地址',
    code varchar(100) null comment '统一社会信用代码',
    telephone varchar(11) null comment '固定电话',
    email varchar(100) null comment '邮箱',
    contact_id bigint null comment '联系人id',
    image_url varchar(200) null comment '部门图片',
    examine_image varchar(1000) null comment '审核所需资料',
    user_id bigint null comment '用户id',
    status tinyint null comment '审核状态 [1：正在审核，2：审核通过，3：审核失败]',
    constraint department_info_pk
        primary key (department_id)
)
    comment '科技主管部门信息';

drop table if exists financial_institution_info;
create table financial_institution_info
(
    financial_institution_id bigint auto_increment comment 'id',
    name varchar(50) null comment '名称',
    corporate varchar(10) null comment '法人',
    manege_scope varchar(20) null comment '经营范围',
    introduction varchar(1000) null comment '简介',
    found_date date null comment '成立日期',
    manege_deadline date null comment '经营期限',
    website varchar(100) null comment '网址',
    email varchar(100) null comment '邮箱',
    capital varchar(20) null comment '注册资本',
    location varchar(20) null comment '位置（省市县）',
    address varchar(100) null comment '详细地址',
    code varchar(100) null comment '统一社会信用代码',
    telephone varchar(11) null comment '固定电话',
    contact_id bigint null comment '联系人id',
    reg_office varchar(100) null comment '登记机关',
    examine_date date null comment '核准日期',
    image_url varchar(200) null comment '机构图片',
    examine_image varchar(1000) null comment '审核所需资料',
    user_id bigint null comment '用户id',
    status tinyint null comment '审核状态 [1：正在审核，2：审核通过，3：审核失败]',
    invest_type varchar(20) null comment '投资类型',
    invest_method varchar(20) null comment '投资方式',
    invest_money varchar(20) null comment '投资金额',
    invest_field varchar(20) null comment '投资领域',
    invest_introduction varchar(1000) null comment '投资说明',
    success_case varchar(1000) null comment '投资成功案例',
    constraint financial_institution_info_pk
        primary key (financial_institution_id)
)
    comment '金融机构';

drop table if exists service_institution_info;
create table service_institution_info
(
    service_institution_id bigint auto_increment comment 'id',
    name varchar(50) null comment '名称',
    corporate varchar(10) null comment '法人',
    manege_scope varchar(20) null comment '经营范围',
    introduction varchar(1000) null comment '简介',
    found_date date null comment '成立日期',
    manege_deadline date null comment '经营期限',
    website varchar(100) null comment '网址',
    email varchar(100) null comment '邮箱',
    capital varchar(20) null comment '注册资本',
    location varchar(20) null comment '位置（省市县）',
    address varchar(100) null comment '详细地址',
    code varchar(100) null comment '统一社会信用代码',
    telephone varchar(11) null comment '固定电话',
    contact_id bigint null comment '联系人id',
    reg_office varchar(100) null comment '登记机关',
    examine_date date null comment '核准日期',
    image_url varchar(200) null comment '机构图片',
    examine_image varchar(1000) null comment '审核所需资料',
    user_id bigint null comment '用户id',
    status tinyint null comment '审核状态 [1：正在审核，2：审核通过，3：审核失败]',
    service_type varchar(20) null comment '服务类型',
    success_case varchar(1000) null comment '服务成功案例',
    constraint service_institution_info_pk
        primary key (service_institution_id)
)
    comment '服务机构';

drop table if exists talent_supply;
create table talent_supply
(
    talent_supply_id bigint auto_increment comment 'id',
    publish_time datetime null comment '发布时间',
    name varchar(50) null comment '姓名',
    image varchar(200) null comment '照片',
    age int null comment '年龄',
    profession varchar(20) null comment '专业',
    gender tinyint null comment '性别 [1:男，2：女]',
    job varchar(20) null comment '求职意向',
    contact_id bigint null comment '联系人id',
    skill varchar(1000) null comment '专业技能',
    experience varchar(1000) null comment '个人经历',
    enter_date date null comment '入学时间',
    graduate_date date null comment '毕业时间',
    school_id bigint null comment '学校id',
    resume_url varchar(200) null comment '上传简历',
    constraint talent_supply_pk
        primary key (talent_supply_id)
)
    comment '人才供应';

drop table if exists talent_need;
create table talent_need
(
    talent_need_id bigint auto_increment comment 'id',
    position varchar(50) null comment '职位工作',
    publish_time datetime null comment '发布时间',
    location varchar(20) null comment '位置（省市县）',
    address varchar(100) null comment '详细地址',
    contact_id bigint null comment '联系人id',
    job varchar(1000) null comment '工作内容',
    demand varchar(1000) null comment '职位要求',
    image varchar(200) null comment '详情图片',
    business_id bigint null comment '企业id',
    education varchar(100) null comment '学历',
    constraint talent_need_pk
        primary key (talent_need_id)
)
    comment '人才需求';

drop table if exists technology_need;
create table technology_need
(
    technology_need_id bigint auto_increment comment 'id',
    title varchar(50) null comment '标题',
    publish_time datetime null comment '发布时间',
    description varchar(1000) null comment '描述',
    category varchar(20) null comment '分类',
    field varchar(20) null comment '行业领域',
    image varchar(1000) null comment '详情图片',
    contact_id bigint null comment '联系人id',
    business_id bigint null comment '企业id',
    education varchar(20) null comment '学历',
    constraint technology_need_pk
        primary key (technology_need_id)
)
    comment '技术需求';

drop table if exists technology_achievement;
create table technology_achievement
(
    technology_achievement_id bigint auto_increment comment 'id',
    title varchar(50) null comment '标题',
    publish_time datetime null comment '发布时间',
    category varchar(20) null comment '分类',
    website varchar(100) null comment '网址',
    description varchar(1000) null comment '描述',
    field varchar(20) null comment '行业领域',
    image varchar(1000) null comment '详情图片',
    contact_id bigint null comment '联系人id',
    publisher_type tinyint null comment '发布者类型 [1：高新企业，3：学校]',
    publisher_id bigint null comment '企业或者学校id，根据发布者类型判断',
    constraint technology_achievement_pk
        primary key (technology_achievement_id)
)
    comment '技术成果';

drop table if exists financing_need;
create table financing_need
(
    financing_need_id bigint auto_increment comment 'id',
    title varchar(50) null comment '项目名称',
    publish_time datetime null comment '发布时间',
    project_description varchar(1000) null comment '项目描述',
    field varchar(20) null comment '行业领域',
    project_image varchar(1000) null comment '项目详情图片',
    team_introduction varchar(1000) null comment '团队介绍',
    financing_introduction varchar(1000) null comment '融资介绍',
    financing_money varchar(20) null comment '融资金额',
    financing_method varchar(20) null comment '融资方式',
    financing_phase varchar(20) null comment '融资阶段',
    contact_id bigint null comment '联系人id',
    business_id bigint null comment '企业id',
    constraint financing_need_pk
        primary key (financing_need_id)
)
    comment '融资需求';

drop table if exists financial_product;
create table financial_product
(
    financial_product_id bigint auto_increment comment 'id',
    title varchar(50) null comment '产品名称',
    publish_time datetime null comment '发布时间',
    description varchar(1000) null comment '产品描述',
    image varchar(1000) null comment '详情图片',
    rate varchar(20) null comment '利率范围 （1%-2%）',
    loan_money varchar(20) null comment '担保额度',
    ensure_method varchar(20) null comment '担保方式',
    loan_deadline varchar(20) null comment '贷款期限',
    apply_condition varchar(1000) null comment '申请条件',
    contact_id bigint null comment '联系人id',
    financial_institution_id bigint null comment '金融机构id',
    constraint financial_product_pk
        primary key (financial_product_id)
)
    comment '金融产品';

drop table if exists service_product;
create table service_product
(
    service_product_id bigint auto_increment comment 'id',
    title varchar(50) null comment '产品名称',
    publish_time datetime null comment '发布时间',
    description varchar(1000) null comment '产品描述',
    service_type varchar(20) null comment '服务类型',
    image varchar(1000) null comment '详情图片',
    contact_id bigint null comment '联系人id',
    service_institution_id bigint null comment '服务机构id',
    constraint service_product_pk
        primary key (service_product_id)
)
    comment '服务产品';

drop table if exists policy;
create table policy
(
    policy_id bigint auto_increment comment 'id',
    title varchar(50) null comment '标题',
    publish_time datetime null comment '发布时间',
    number varchar(50) null comment '文号',
    category varchar(20) null comment '分类',
    content text null comment '内容',
    link varchar(200) null comment '链接',
    image varchar(1000) null comment '详情图片',
    addition varchar(200) null comment '附件',
    department_id bigint null comment '科技主管部门id',
    constraint policy_pk
        primary key (policy_id)
)
    comment '政策';

drop table if exists policy_analyse;
create table policy_analyse
(
    policy_analyse_id bigint auto_increment comment 'id',
    title varchar(50) null comment '标题',
    publish_time datetime null comment '发布时间',
    category varchar(20) null comment '分类',
    introduction varchar(200) null comment '简介',
    video varchar(200) null comment '视频',
    link varchar(200) null comment '链接',
    department_id bigint null comment '科技主管部门id',
    constraint policy_analyse_pk
        primary key (policy_analyse_id)
)
    comment '政策解读';

drop table if exists business_idea;
create table business_idea
(
    business_idea_id bigint auto_increment comment 'id',
    title varchar(50) null comment '标题',
    publish_time datetime null comment '发布时间',
    content varchar(1000) null comment '意见内容',
    business_id bigint null comment '企业id',
    constraint business_idea_pk
        primary key (business_idea_id)
)
    comment '企业意见';

drop table if exists contact;
create table contact
(
    contact_id bigint auto_increment comment 'id',
    name varchar(10) null comment '姓名',
    phone varchar(11) null comment '电话',
    email varchar(50) null comment '邮箱',
    address varchar(100) null comment '地址',
    position varchar(100) null comment '单位',
    constraint contact_pk
        primary key (contact_id)
)
    comment '联系人';

drop table if exists activity;
create table activity
(
    activity_id bigint auto_increment comment 'id',
    name varchar(50) null comment '名称',
    publish_time datetime null comment '发布时间',
    address varchar(100) null comment '地点',
    content varchar(100) null comment '内容',
    contact_id bigint null comment '联系人id',
    publisher_id bigint null comment '发布人id',
    publisher_type tinyint null comment '发布人角色类型',
    constraint activity_pk
        primary key (activity_id)
)
    comment '活动';

drop table if exists service_type_index;
create table service_type_index
(
    id bigint auto_increment,
    name varchar(20) not null comment '名称',
    constraint service_type_index_pk
        primary key (id)
)
    comment '服务类型检索';

drop table if exists profession_field_index;
create table profession_field_index
(
    id bigint auto_increment,
    name varchar(20) not null comment '名称',
    constraint profession_field_index_pk
        primary key (id)
)
    comment '行业领域检索';

drop table if exists invest_field_index;
create table invest_field_index
(
    id bigint auto_increment,
    name varchar(20) not null comment '名称',
    constraint invest_field_index_pk
        primary key (id)
)
    comment '投资领域检索';

drop table if exists invest_money_index;
create table invest_money_index
(
    id bigint auto_increment,
    name varchar(20) not null comment '名称',
    constraint invest_money_index_pk
        primary key (id)
)
    comment '投资金额检索';

drop table if exists ensure_method_index;
create table ensure_method_index
(
    id bigint auto_increment,
    name varchar(20) not null comment '名称',
    constraint ensure_method_index_pk
        primary key (id)
)
    comment '担保方式检索';

drop table if exists ensure_money_index;
create table ensure_money_index
(
    id bigint auto_increment,
    name varchar(20) not null comment '名称',
    constraint ensure_money_index_pk
        primary key (id)
)
    comment '贷款额度检索';

drop table if exists loan_deadline_index;
create table loan_deadline_index
(
    id bigint auto_increment,
    name varchar(20) not null comment '名称',
    constraint loan_deadline_index_pk
        primary key (id)
)
    comment '贷款期限检索';

drop table if exists policy_category_index;
create table policy_category_index
(
    id bigint auto_increment,
    name varchar(20) not null comment '名称',
    constraint policy_category_index_pk
        primary key (id)
)
    comment '政策分类检索';

drop table if exists time_index;
create table time_index
(
    id bigint auto_increment,
    name varchar(20) not null comment '名称',
    constraint time_index_pk
        primary key (id)
)
    comment '时间检索';

DROP TABLE IF EXISTS `park`;
CREATE TABLE `park` (
                        `park_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '园区id',
                        `park_name` varchar(50) DEFAULT NULL COMMENT '园区名称',
                        `park_image_url` varchar(1000) DEFAULT NULL COMMENT '园区图片url',
                        `park_phone` varchar(50) DEFAULT NULL COMMENT '园区电话',
                        `park_website` varchar(100) DEFAULT NULL COMMENT '园区网址',
                        `park_introduction` text COMMENT '园区简介',
                        `avatar` text COMMENT '园区新闻',
                        `park_supporting` text COMMENT '配套设施',
                        `favoured_policy` text CHARACTER SET utf8 COLLATE utf8_unicode_ci COMMENT '优惠政策',
                        `product_positioning` text COMMENT '产品定位',
                        `key_points` text COMMENT '招商重点',
                        PRIMARY KEY (`park_id`)
)
    comment '科技园区';

create table consultation
(
    id bigint auto_increment,
    user_id bigint not null comment '用户id',
    category varchar(20) null comment '咨询内容类型（1：申报政策 2：金融政策 3：科技服务 4：人才政策 5：科技园区 6：其他）',
    content text not null comment '咨询内容',
    email varchar(100) null comment '邮箱',
    phone varchar(11) null comment '联系电话',
    constraint consultation_pk
        primary key (id)
)
    comment '咨询';