docker build -t maurilioferreira/multi-client:latest -t maurilioferreira/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t maurilioferreira/multi-server:latest -t maurilioferreira/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t maurilioferreira/multi-worker:latest -t maurilioferreira/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push maurilioferreira/multi-client:latest
docker push maurilioferreira/multi-server:latest
docker push maurilioferreira/multi-worker:latest

docker push maurilioferreira/multi-client:$SHA
docker push maurilioferreira/multi-server:$SHA
docker push maurilioferreira/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=maurilioferreira/multi-client:$SHA
kubectl set image deployments/server-deployment server=maurilioferreira/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=maurilioferreira/multi-worker:$SHA

