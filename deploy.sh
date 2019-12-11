docker build -t kale7/multi-client:latest -t kale7/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t kale7/multi-server:latest -t kale7/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t kale7/multi-worker:latest -t kale7/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push kale7/multi-client:latest
docker push kale7/multi-server:latest
docker push kale7/multi-worker:latest

docker push kale7/multi-client:$SHA
docker push kale7/multi-server:$SHA
docker push kale7/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=kale7/multi-server:$SHA
kubectl set image deployments/client-deployment client=kale7/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=kale7/multi-worker:$SHA