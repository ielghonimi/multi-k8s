docker build -t markib5/multi-client:latest -t markib5/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t markib5/multi-server:latest -t markib5/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t markib5/multi-worker:latest -t markib5/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push markib5/multi-client:latest
docker push markib5/multi-server:latest
docker push markib5/multi-worker:latest

docker push markib5/multi-client:$SHA
docker push markib5/multi-server:$SHA
docker push markib5/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=markib5/multi-server:$SHA
kubectl set image deployments/client-deployment client=markib5/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=markib5/multi-worker:$SHA

