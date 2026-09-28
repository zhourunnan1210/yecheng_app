# database — 数据库

MySQL 8 的建表语句与示例数据，共 **65 张表**。

## 文件

| 文件 | 说明 |
|------|------|
| `yecheng_app_2604.sql` | 建表 + 示例数据，由 Navicat 导出后做过处理（见下） |

用 Docker 部署时无需手动导入：`deploy/docker-compose.yml` 会把本目录挂载到
MySQL 容器的 `/docker-entrypoint-initdb.d/`，首次启动自动执行。

手动导入：

```bash
mysql -uroot -p -e "CREATE DATABASE yecheng_app_2604 CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;"
mysql -uroot -p --default-character-set=utf8mb4 yecheng_app_2604 < database/yecheng_app_2604.sql
```

## 表分组

| 分组 | 表 |
|------|-----|
| **业务主表** | `user`、`business_info`、`company`、`park`、`school_info`、`policy`、`news` |
| **人才** | `talent_need`、`talent_supply`、`interview_application`、`people_require_each_position`、`user_behavior` |
| **金融** | `financial_institution`、`financial_product`、`financing_need`、`investing_need`、`invest_financial_project` |
| **技术成果** | `technology_achievement`、`technology_need`、`technology_product`、`tech_ach_evaluation_report`、`evaluation_case` |
| **对接与咨询** | `contact`、`consultation`、`service_product` |
| **专家** | `expert` |
| **字典 / 索引** | `china`（行政区划 3555 行）、`all_index`、`*_index`、`time_index` |
| **若依后台（RuoYi）** | `sys_user`、`sys_role`、`sys_menu`、`sys_dept`、`sys_dict_*`、`sys_config`、`sys_job*`、`sys_logininfor`、`sys_oper_log`、`sys_notice`、`sys_post`、`gen_table*`、`qrtz_*` |

> 最后两组来自若依（RuoYi）框架，配套的后台管理服务**不在本仓库内**。
> 表结构和默认账号保留着，是为了让数据库结构完整、便于你接上自己的后台系统。

## 数据处理说明

这份 SQL 在导出后被处理过，改动点如下，便于你判断哪些是原始数据、哪些是后加的：

**1. 个人信息已脱敏（18 张表、1178 行）**

人名、手机号、邮箱、地址、证件照路径、后台账号密码、登录 IP 等字段替换为虚构数据。
下表说明每类字段的处理方式：

| 字段类型 | 处理方式 |
|----------|----------|
| 姓名 | 由姓氏/名字字库随机组合，如「华梅」「吕秀燕」 |
| 手机号 | 使用虚构号段（130-139 / 150-159 / 182-188），不指向真实号码 |
| 邮箱 | 统一替换为 `xxx@example.com` |
| 地址 | 虚构的省市街道组合 |
| 密码 | 前台 `user` 表 → MD5(`123456`)；后台 `sys_user` → BCrypt(`admin123`) |
| 登录/操作 IP | 统一 `127.0.0.1` |
| 证件照 / 简历 / 信用材料路径 | 清空或替换为 `/static/defaultImage/1.png` |
| OSS 图片直链 | 替换为本地默认图，共 59 处 |

**2. 保留不变的部分**

- 全部 65 张表的建表语句，逐字节保持原样
- 每条记录的主键、外键、时间、状态、金额等结构性字段
- 政策、新闻、园区、金融产品等公开信息类内容
- 业务描述性文本（项目介绍、岗位职责、政策正文等）

因此页面之间的关联查询（如人才需求 → 联系人、融资需求 → 企业信息）依然正常，
只是联系方式和身份信息都是假的。

**3. 补了一行 `SET sql_mode`**

原 dump 里 `tech_ach_evaluation_report.complete_time` 等字段存在 `'0000-00-00 00:00:00'`
零值日期，MySQL 8 默认的 `sql_mode` 会直接报错中断导入。脚本开头加了一行，只放开
`NO_ZERO_DATE` / `NO_ZERO_IN_DATE`，保留 `STRICT_TRANS_TABLES` 等其余校验：

```sql
SET sql_mode = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
```

已在 MySQL 8.0.43 上完整导入验证通过（65 张表全部创建、5583 条 INSERT 无报错）。

## 演示账号

| 入口 | 账号 | 密码 | 密码存储 |
|------|------|------|----------|
| 前台用户 | `user001` | `123456` | MD5 |
| 后台管理员 | `admin` | `admin123` | BCrypt |

## 重新生成示例数据

如果你想换成自己的数据，改完数据后注意两点：

1. 别把真实个人信息提交进仓库
2. 如果新增了零值日期，要么改成 `NULL`，要么保留脚本开头那行 `SET sql_mode`
