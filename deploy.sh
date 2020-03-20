docker build -t stanislavprihoda/multi-client:latest -t stanislavprihoda/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t stanislavprihoda/multi-server:latest -t stanislavprihoda/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t stanislavprihoda/multi-worker:latest -t stanislavprihoda/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push stanislavprihoda/multi-client:latest
docker push stanislavprihoda/multi-server:latest
docker push stanislavprihoda/multi-worker:latest
docker push stanislavprihoda/multi-client:$SHA
docker push stanislavprihoda/multi-server:$SHA
docker push stanislavprihoda/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=stanislavprihoda/multi-client:$SHA
kubectl set image deployments/server-deployment server=stanislavprihoda/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=stanislavprihoda/multi-worker:$SHA