docker build -t vinok88/multi-client:latest -t vinok88/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t vinok88/multi-server:latest -t vinok88/multi-server:$SHA -f ./client/Dockerfile ./client
docker build -t vinok88/multi-worker:latest -t vinok88/multi-worker:$SHA -f ./client/Dockerfile ./client
docker push vinok88/multi-client:latest
docker push vinok88/multi-client:$SHA
docker push vinok88/multi-server:latest
docker push vinok88/multi-server:$SHA
docker push vinok88/multi-worker:latest
docker push vinok88/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=vinok88/multi-server:$SHA
kubectl set image deployments/client-deployment client=vinok88/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=vinok88/multi-worker:$SHA