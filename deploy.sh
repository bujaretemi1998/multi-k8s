docker build -t bujaretemi1998/multi-client-k8s:latest -t bujaretemi1998/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t bujaretemi1998/multi-server-k8s-pgfix:latest -t bujaretemi1998/multi-server-k8s-pgfix:$SHA -f ./server/Dockerfile ./server
docker build -t bujaretemi1998/multi-worker-k8s:latest -t bujaretemi1998/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push bujaretemi1998/multi-client-k8s:latest
docker push bujaretemi1998/multi-server-k8s-pgfix:latest
docker push bujaretemi1998/multi-worker-k8s:latest

docker push bujaretemi1998/multi-client-k8s:$SHA
docker push bujaretemi1998/multi-server-k8s-pgfix:$SHA
docker push bujaretemi1998/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=bujaretemi1998/multi-server-k8s-pgfix:$SHA
kubectl set image deployments/client-deployment client=bujaretemi1998/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=bujaretemi1998/multi-worker-k8s:$SHA