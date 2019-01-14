docker build -t drazziweht/multi-client:latest -t drazziweht/multi-client:$SHA ./client/Dockerfile ./client
docker build -t drazziweht/multi-server:latest -t drazziweht/multi-server:$SHA ./server/Dockerfile ./server
docker build -t drazziweht/multi-worker:latest -t drazziweht/multi-worker:$SHA ./worker/Dockerfile ./worker
docker push drazziweht/multi-client:latest
docker push drazziweht/multi-server:latest
docker push drazziweht/multi-worker:latest
docker push drazziweht/multi-client:$SHA
docker push drazziweht/multi-server:$SHA
docker push drazziweht/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=drazziweht/multi-server:$SHA
kubectl set image deployments/client-deployment client=drazziweht/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=drazziweht/multi-worker:$SHA