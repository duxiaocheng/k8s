#!/bin/bash
#----------
# Kubernetes guide of myweb and mysql
# http://10.9.245.194:30012/demo/

# kubectl delete -f ./
function stop {
	for it in myweb mysql; do
		kubectl delete service $it
		kubectl delete rc $it
		#kubectl delete -f ./${it}-rc.yaml
	done
}

# kubectl create -f ./
function start {
	for it in myweb mysql; do
		kubectl create -f ./${it}-rc.yaml
		kubectl create -f ./${it}-svc.yaml
	done
}

# kubectl get -f ./
function status {
	for it in services rc; do
		echo "----------------------------"
		kubectl get $it myweb mysql -o wide
	done
	echo "----------------------------"
	kubectl get pods -o wide | grep -E "(myweb|mysql|NAME)"
}

case "$1" in
        "start" )
                start
                ;;  
        "stop" )
                stop
                ;;  
	"status" )
		status
		;;
        "restart" )
                stop
		start
                ;;  
        * ) 
                ;;  
esac

