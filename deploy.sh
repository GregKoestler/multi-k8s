docker build -t gregkoestler/multi-client:latest -t gregkoestler/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t gregkoestler/multi-server:latest -t gregkoestler/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t gregkoestler/multi-worker:latest -t gregkoestler/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push gregkoestler/multi-client:latest
docker push gregkoestler/multi-server:latest
docker push gregkoestler/multi-worker:latest

docker push gregkoestler/multi-client:$SHA
docker push gregkoestler/multi-server:$SHA
docker push gregkoestler/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployment/server-deployment server=gregkoestler/multi-server:$SHA
kubectl set image deployment/client-deployment client=gregkoestler/multi-client:$SHA
kubectl set image deployment/worker-deployment worker=gregkoestler/multi-worker:$SHA