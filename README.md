# alpine-ycsb
YCSB running on Alpine Linux and Zulu JDK


```
docker run -t --name loadgen_5901 -p 5901:5900 \
-e ACTION='load' \
-e DBTYPE='redis' \
-e WORKLETTER='a' \
-e DBARGS='-p redis.host=10.0.0.1' \
bluemedora/nosql-loadgen:beta1
```
