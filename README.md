# 构建镜像
```bash
build-torch
```


# 常见错误
### 拉取 Dockerhub 镜像，无法连接 Cloudflare
如
```bash
docker pull node:10.16-alpine

10.16-alpine: Pulling from library/node
e7c96db7181b: Already exists
50958466d97a: Pulling fs layer
56174ae7ed1d: Pulling fs layer
284842a36c0d: Pulling fs layer
error pulling image configuration: Get https://production.cloudflare.docker.com/registry-v2 /docker/registry/v2/blobs/sha256/b9/b95baba1cfdbfa8b789137179d8e fff08b9768f1906725a8758cf0c431b59621/data? verify=1636603895-lbb1QIruPZBdfgfhBZ95ArGK0wU%3D: dial tcp 104.18.124.25:443: i/o timeout
```
### 解决
#### 修改 DNS 地址

CentOS ，修改 `/etc/resolv.conf` 文件，新增一行 `nameserver 8.8.8.8` , 重启docker  

Ubuntu 修改 `/etc/systemd/resolved.conf`，添加
```bash
[Resolve]
DNS=8.8.8.8
```
然后重启docker  

**重启docker**  
upstart系统:
```bash
sudo service docker restart
```
systemd系统：
```bash
sudo systemctl daemon-reload
sudo systemctl restart docker
```

#### 本地与服务器时间偏差过大
进行时间同步即可
```bash
ntpdate time.windows.com
```