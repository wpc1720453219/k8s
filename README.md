## k8s
word需要的资源：  
链接：https://pan.baidu.com/s/1HpgvJizvdG2QFnqI9uAVSw?pwd=b3we  
提取码：b3we  


### 第一章：
```shell
子网 + 子网掩码 一起来确定一个网段
例如：子网 192.168.10.0   子网掩码 255.255.255.0   可以容纳 192.168.10.1--192.168.10.254 的ip地址  2*8-2
子网 192.168.10.0   子网掩码 255.255.255.252   可以容纳 192.168.10.1--192.168.10.2 的ip地址  2*2-2
子网确定网络ip前缀、子网掩码确定后缀范围

在一个子网中，有很多主机，这些主机跟外面的网络通信，需要通过一个叫作网关的主机。网关的特点：
1. 网关的IP跟子网同一网段（也就是说，网关也是子网的一个主机）
2. 网关具备路由功能，能路由到外面网络去
```




###第二章：

```shell
查看历史日志
journalctl -exu luna-sunht-dev-ats-basicdata

# -e  --pager-end   Immediately jump to the end in the pager  立即跳到寻呼机的末尾
#  -f  --follow  Follow the journal  关注期刊, 最新的
# -x  --catalog   Add message explanations where available  添加消息说明（如果有）
# -u  --unit=UNIT   Show logs from the specified unit   显示指定单位的日志

跟踪日志
journalctl -exfu luna-sunht-dev-ats-basicdata


linux下：
Ctrl Insert
复制，日常的ctrl c替代快捷键

Shift Insert
粘贴，日常的ctrl v替代快捷键




ps aux | grep zookeeper  与 ps ef | grep zookeeper 区别

-A 显示所有进程（同-e）
-a 显示当前终端的所有进程
-u 显示进程的用户信息
-o 以用户自定义形式显示进程信息
-f 显示程序间的关系


#查看系统中所有的进程
USER PID %CPU %MEM  VSZ  RSS   TTY STAT START TIME COMMAND
root   1  0.0  0.2 2872 1416   ?   Ss   Jun04 0:02 /sbin/init
root   2  0.0  0.0    0    0   ?    S   Jun04 0:00 [kthreadd]
root   3  0.0  0.0    0    0   ?    S   Jun04 0:00 [migration/0]
root   4  0.0  0.0    0    0   ?    S   Jun04 0:00 [ksoftirqd/0]



表头	含义
USER	该进程是由哪个用户产生的。
PID	进程的 ID。
%CPU	该进程占用 CPU 资源的百分比，占用的百分比越高，进程越耗费资源。
%MEM	该进程占用物理内存的百分比，占用的百分比越高，进程越耗费资源。
VSZ	该进程占用虚拟内存的大小，单位为 KB。
RSS	该进程占用实际物理内存的大小，单位为 KB。
TTY	该进程是在哪个终端运行的。其中，tty1 ~ tty7 代表本地控制台终端（可以通过 Alt+F1 ~ F7 快捷键切换不同的终端），tty1~tty6 是本地的字符界面终端，tty7 是图形终端。pts/0 ~ 255 代表虚拟终端，一般是远程连接的终端，第一个远程连接占用 pts/0，第二个远程连接占用 pts/1，依次増长。
STAT	进程状态。常见的状态有以下几种：
-D：不可被唤醒的睡眠状态，通常用于 I/O 情况。
-R：该进程正在运行。
-S：该进程处于睡眠状态，可被唤醒。
-T：停止状态，可能是在后台暂停或进程处于除错状态。
-W：内存交互状态（从 2.6 内核开始无效）。
-X：死掉的进程（应该不会出现）。
-Z：僵尸进程。进程已经中止，但是部分程序还在内存当中。
-<：高优先级（以下状态在 BSD 格式中出现）。
-N：低优先级。
-L：被锁入内存。
-s：包含子进程。
-l：多线程（小写 L）。
-+：位于后台。
START	该进程的启动时间。
TIME	该进程占用 CPU 的运算时间，注意不是系统时间。
COMMAND	产生此进程的命令名。


s%-Xms512m -Xmx512m -Xmn256m%-Xmx300m%g"  xms xmx xmn 三个作用
xms   内存的初始大小
xmx   内存的最大大小
Xmn 堆内新生代的大小。通过这个值也可以得到老生代的大小：-Xmx减去-Xmn

-Xms:初始堆大小
-Xmx:最大堆大小
-Xmn:新生代大小
```



### 第三章
```shell

docker inspect nexus3 | jq      jq:用来格式化json输出
dockerfile    add熟悉    发现无法绝对路径

自定义镜像后，应该通过 docker  -e 的方式选择配置性启动，而不是写死在start 脚本 或者启动命令里
-e  映射的是启动脚本或者启动命令  ENV定义的环境变量   ENV对应export 全局变量


containerd和runc、docker的关系
containerd是一个纯粹的，面向容器工业一个容器管理运行时
runc是一个包装了libcontainer的满足OCI标准的类库
docker则更像是一个承载容器而又不想只做容器引擎的一个复杂产物
• containerd本身负责管理容器整个的生命周期，从镜像拉取，到挂载fs，再到启动，销毁等，它对外提供grpc形式的API，对内通过调用runc等类库来创建满足OCI标准的容器，并且屏蔽了底层的实现细节。

Linux 容器的 Namespace技术：它帮助进程隔离出自己单独的空间
Docker是怎么限制每个空间的大小，保证它们不会互相争抢的呢？这就要用到Linux的Cgroups 技术

containerd和Docker之间的关系
Docker包含 containerd，containerd专注于运行时的容器管理，而Docker除了容器管理之外，还可以完成镜像构建之类的功能。
containerd提供的API偏底层，不是给普通用户直接用的。对于普通用户来说，可以继续使用 Docker。容器编排系统的开发者才需要 containerd，比如阿里云容器服务团队。

7.5.4 containerd、OCI和runC之间的关系
OCI 是一个标准化的容器规范，包括运行时规范和镜像规范。runC 是基于此规范的一个参考实现，Docker贡献了runC的主要代码。
从技术栈上看，containerd比runC的层次更高，containerd可以使用runC启动容器，还可以下载镜像，管理网络。

7.5.5 containerd和容器编排系统的关系
从下图 可以看出 containerd在容器技术生态中的位置。在开源编排系统中，Kubernetes现在直接使用Docker，将来的版本可以转而使用containerd；Mesos和其他的编排引擎也可以使用 containerd 而不是直接使用 Docker。
对于云计算开发商来说，也可以非常方便地基于 containerd 提供定制化的容器网络、容器存储和编排方案。
```

### 第四章
```shell
curl命令
curl 是常用的命令行工具，用来请求 Web 服务器。它的名字就是客户端（client）的 URL 工具的意思。
它的功能非常强大，命令行参数多达几十种。如果熟练的话，完全可以取代 Postman 这一类的图形界面工具。
curl -sfL
-s(--silent) — 不显示错误和进度信息。
-f(--fail) — 表示在服务器错误时，阻止一个返回的表示错误原因的 HTML 页面，而由 curl 命令返回一个错误码 22 来提示错误。
-L(--location) — 参数会让 HTTP 请求跟随服务器的重定向。curl 默认不跟随重定向。


- name: SW_OAP_ADDRESS
  value: http://skywalking-server:12800
```



























