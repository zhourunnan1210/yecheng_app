# 前端 H5 静态资源目录

## 放置方式

将 Uni-app H5 打包产物放入此目录：

```
deploy/nginx/html/
├── index.html
├── static/
│   └── ...
└── ...
```

## 打包步骤

1. 用 **HBuilderX** 打开 `frontend` 项目
2. 点击菜单栏 **发行 -> 网站-H5手机版**
3. 等待编译完成
4. 将生成的 `unpackage/dist/build/h5/` 目录下的所有文件复制到此目录

> 打包前记得把 `frontend/utils/api.js` 里的 `BASE_URL` 改成服务器地址，
> 否则前端会去请求 `localhost:10086`。
