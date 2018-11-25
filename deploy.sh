docker build -t douglasmuraoka/docker-fibo-app-client:latest -t douglasmuraoka/docker-fibo-app-client:$SHA -f ./client/Dockerfile ./client
docker build -t douglasmuraoka/docker-fibo-app-server:latest -t douglasmuraoka/docker-fibo-app-server:$SHA -f ./server/Dockerfile ./server
docker build -t douglasmuraoka/docker-fibo-app-worker:latest -t douglasmuraoka/docker-fibo-app-worker:$SHA -f ./worker/Dockerfile ./worker

docker push douglasmuraoka/docker-fibo-app-client:latest
docker push douglasmuraoka/docker-fibo-app-server:latest
docker push douglasmuraoka/docker-fibo-app-worker:latest

docker push douglasmuraoka/docker-fibo-app-client:$SHA
docker push douglasmuraoka/docker-fibo-app-server:$SHA
docker push douglasmuraoka/docker-fibo-app-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=douglasmuraoka/docker-fibo-app-server:$SHA
kubectl set image deployments/client-deployment client=douglasmuraoka/docker-fibo-app-client:$SHA
kubectl set image deployments/worker-deployment worker=douglasmuraoka/docker-fibo-app-worker:$SHA