#!/bin/bash

aliyun_image='registry.cn-hangzhou.aliyuncs.com/szss-safety/datax:0.1.1'
env=$(basename $0 .sh)

jar_name="datax"
jar_full_path=''
curr_path="${PWD}"
echo ${curr_path}

# project root
cd ..
pwd

mvn -U clean package assembly:assembly -DskipTests=true -Dpackage.jar-name=${jar_name}
jar_full_path="${PWD}/target/${jar_name}.tar.gz"
ls target

if [[ ! -f "${jar_full_path}" ]];then
  echo "打包失败[${jar_full_path}]!!!!!!!!!!!!!!!!!!!!!!!!!!"
  exit
fi


# docker
cd ${curr_path}
cd ../docker
ls
# 备份Dockerfile
cp Dockerfile Dockerfile-bak

# 替换jar包名称
#sed -i 's/${target_jar}'"/${jar_name}/g" Dockerfile

cp ${jar_full_path} .
docker rmi datax:curr_v -f
docker build -t datax:curr_v .
docker rmi ${aliyun_image} -f
docker tag datax:curr_v ${aliyun_image}
docker push ${aliyun_image}

echo "==========================="
echo "IMAGE：${aliyun_image}"
echo "==========================="

mv Dockerfile-bak Dockerfile
rm -f "${jar_name}.tar.gz"