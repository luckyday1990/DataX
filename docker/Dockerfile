# 基于哪个镜像.
#FROM openjdk:8-alpine
FROM registry.cn-hangzhou.aliyuncs.com/szss-safety/openjdk:8-jre-alpine

MAINTAINER szss
#设置时区
ENV TZ Asia/Shanghai

ENV APP_NAME datax

ADD datax.tar.gz .

RUN echo http://mirrors.aliyun.com/alpine/v3.8/main/ >/etc/apk/repositories \
	&& echo http://mirrors.aliyun.com/alpine/v3.8/community/ >>/etc/apk/repositories \
	&& apk update \
	&& apk add --no-cache python bash curl \
	# 启动定时任务
	&& crond \
	&& chmod +x /datax/bin/datax.py \
	&& export JAVA_OPTS='-Xmx=2048M -Xss512K'

ENV PATH ${PATH}:/datax/bin
ENV DATAX_JOB_DIR="/data/datax/job"

#-Djava.security.egd为JAVA中的配置发生器,file:/dev/./urandom为Linux要表示urandom的路径,也就是/dev/urandom文件
ENTRYPOINT ["/bin/bash","-c","tail -f /dev/null"]
