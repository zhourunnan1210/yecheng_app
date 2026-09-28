# 运行时镜像：Java 8 JRE（基于 alpine）
FROM eclipse-temurin:8-jre-alpine

# 安装字体渲染依赖（图片加水印需要）
RUN apk add --no-cache libgcc freetype fontconfig

WORKDIR /app



# 复制 jar 包
COPY target/highly-new-app-0.0.1-SNAPSHOT.jar /app/app.jar

ENV JAVA_OPTS="-Xms256m -Xmx512m"
ENV SERVER_PORT=10086

EXPOSE 10086


ENTRYPOINT ["sh","-c","java $JAVA_OPTS -Dserver.port=\"$SERVER_PORT\" -jar /app/app.jar"]
