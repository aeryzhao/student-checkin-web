#!/bin/sh  
  
# 镜像名称
IMAGE_NAME=student-checkin:0.0.1-SNAPSHOT
# 项目名称也是容器名称
PROJECT_NAME=student-checkin
# 宿主机端口号
PORT=8080

# 找到正在运行的容器停止删除
CONTAINER_NAME=$(docker ps -aq --filter name=^/$PROJECT_NAME$)  
if [[ -n "$CONTAINER_NAME" ]]; then  
docker rm -f $CONTAINER_NAME;  
echo "$PROJECT_NAME 停止并删除成功....."  
fi  
  
sleep 3s

# 找到并删除之前的镜像
ARG2=$(docker images -q --filter reference=$IMAGE_NAME)   
if [ -n "$ARG2" ]; then  
docker rmi -f $ARG2  
echo "$IMAGE_NAME镜像删除成功......"  
fi  
  

echo "构建新镜像"   
docker build -t $IMAGE_NAME .  
  
echo "镜像构建成功, 开始构建容器并启动"   
docker run -d --name $PROJECT_NAME -p $PORT:80 $IMAGE_NAME
echo "容器启动成功"

