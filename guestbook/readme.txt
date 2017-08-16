# Kubernetes Guestbook Demo
#
# http://10.9.245.194:30002/
######################################
# create
kubectl create -f ./

# delete
kubectl delete -f ./

# status
kubectl get -f ./ -o wide
kubectl get pods -o wide

######################################
[root@node1 ~]# docker history docker.io/kubeguide/redis-master
IMAGE               CREATED             CREATED BY                                      SIZE                COMMENT
405a0b586f7e        24 months ago       /bin/sh -c #(nop) ADD multi:0a8d9f4785c98c51a   112 B               
<missing>           24 months ago       /bin/sh -c #(nop) MAINTAINER kubeguide          0 B                 
<missing>           2 years ago         /bin/sh -c #(nop) EXPOSE map[6379/tcp:{}]       0 B                 
<missing>           2 years ago         /bin/sh -c #(nop) CMD [redis-server /etc/redi   0 B  

[root@node1 ~]# docker ps -a | grep master
CONTAINER ID        IMAGE                   COMMAN                 CREATED             STATUS         PORTS   NAMES
62236078afb3        kubeguide/redis-master "redis-server /etc/re"   6 seconds ago       Up 3 seconds                                    k8s_master.b41c7d90_redis-master-3007595338-bp6m0_default_f38810d9-8246-11e7-8f72-fa163ea3dff3_1007c718

[root@node1 ~]# docker top 62236078afb3
ID     PID      PPID      C     STIME    TTY    TIME        CMD
root   5999     5984      0     05:51    ?      00:00:00    redis-server *:6379

[root@node1 ~]# docker exec -it 62236078afb3 bash
[ root@redis-master-3007595338-bp6m0:/data ]$ redis-server -v
Redis server v=2.8.19 sha=00000000:0 malloc=jemalloc-3.6.0 bits=64 build=2b4e98638e2b3ac8

[ root@redis-master-3007595338-bp6m0:/data ]$ redis-cli -h 127.0.0.1 -p 6379
127.0.0.1:6379> config get *

127.0.0.1:6379> info replication
# Replication
role:master
connected_slaves:2
slave0:ip=10.255.61.0,port=6379,state=online,offset=589,lag=0
slave1:ip=10.255.95.4,port=6379,state=online,offset=589,lag=1
master_repl_offset:589
repl_backlog_active:1
repl_backlog_size:1048576
repl_backlog_first_byte_offset:2
repl_backlog_histlen:588

127.0.0.1:6379> keys *
1) "messages"

127.0.0.1:6379> get messages
"Hello World!"

######################################
[root@node1 ~] tail -f /var/log/messages
Aug 16 06:11:11 centos3 journal: [1] 16 Aug 06:11:11.133 - DB 0: 1 keys (0 volatile) in 4 slots HT.
Aug 16 06:11:11 centos3 journal: [1] 16 Aug 06:11:11.133 - 0 clients connected (2 slaves), 1841728 bytes in use
Aug 16 06:11:16 centos3 journal: [1] 16 Aug 06:11:16.145 - DB 0: 1 keys (0 volatile) in 4 slots HT.
Aug 16 06:11:16 centos3 journal: [1] 16 Aug 06:11:16.146 - 0 clients connected (2 slaves), 1841728 bytes in use
Aug 16 06:11:21 centos3 journal: [1] 16 Aug 06:11:21.158 - DB 0: 1 keys (0 volatile) in 4 slots HT.
Aug 16 06:11:21 centos3 journal: [1] 16 Aug 06:11:21.158 - 0 clients connected (2 slaves), 1841728 bytes in use


