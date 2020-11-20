export image="mailer"
export version="0.1.0"

docker build -t registry.cn-beijing.aliyuncs.com/edgora-oss/$image --no-cache  -f Dockerfile .

docker tag  registry.cn-beijing.aliyuncs.com/edgora-oss/$image  registry.cn-beijing.aliyuncs.com/edgora-oss/$image:$version

docker push  registry.cn-beijing.aliyuncs.com/edgora-oss/$image

docker push  registry.cn-beijing.aliyuncs.com/edgora-oss/$image:$version


docker tag  registry.cn-beijing.aliyuncs.com/edgora-oss/$image:$version  edgora/$image:$version
docker push edgora/$image:$version
docker tag edgora/$image:$version  edgora/$image

docker push edgora/$image

