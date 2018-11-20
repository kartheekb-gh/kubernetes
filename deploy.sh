docker build -t kbdocked/multi-client:latest -t kbdocked/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t kbdocked/multi-server:latest -t kbdocked/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t kbdocked/multi-worker:latest -t kbdocked/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push kbdocked/multi-client:latest
docker push kbdocked/multi-server:latest
docker push kbdocked/multi-worker:latest

docker push kbdocked/multi-client:$SHA
docker push kbdocked/multi-server:$SHA
docker push kbdocked/multi-worker:$SHA

kubectl apply -f ./k8s
kubectl set image deployments/server-deployment server=kbdocked/multi-server:$SHA
kubectl set image deployments/client-deployment client=kbdocked/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=kbdocked/multi-worker:$SHA
