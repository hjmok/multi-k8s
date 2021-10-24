#https://www.udemy.com/course/docker-and-kubernetes-the-complete-guide/learn/lecture/11628252#questions
#Build all our images, tag each one, push each to Docker Hub
docker build -t hjmok/multi-client:latest -t hjmok/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t hjmok/multi-server:latest -t hjmok/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t hjmok/multi-worker:latest -t hjmok/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push hjmok/multi-client:latest
docker push hjmok/multi-server:latest
docker push hjmok/multi-worker:latest
docker push hjmok/multi-client:$SHA
docker push hjmok/multi-server:$SHA
docker push hjmok/multi-worker:$SHA
#Apply all configs in the k8s folder
kubectl apply -f k8s 
#Imperatively set latest images on each deployment
kubectl set image deployments/client-deployment client=hjmok/multi-client:$SHA #from the k8s/client-deployment.yaml file
kubectl set image deployments/server-deployment server=hjmok/multi-server:$SHA #from the k8s/server-deployment.yaml file
kubectl set image deployments/worker-deployment worker=hjmok/multi-worker:$SHA #from the k8s/worker-deployment.yaml file
