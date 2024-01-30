## Hands-On Project: Deploying a Simple Web App on AKS
### Step 1: Create a Kubernetes Deployment YAML
#### Create a file named web-app-deployment.yaml with my-web-app.yaml content. This YAML defines a simple Kubernetes Deployment for an Nginx web server with 2 replicas.
### Step 2: Apply the Deployment
#### Apply the deployment to your AKS cluster:
> kubectl apply -f my-web-app.yaml
```
deployment.apps/web-app created
```
#### This command tells Kubernetes to create the specified deployment on your AKS cluster.
### Step 3: Expose the Deployment as a Service
#### Create a file named web-app-service.yaml with web-app-service.yaml content. This YAML defines a Kubernetes Service to expose the web application outside the cluster.
#### Apply the service configuration:
> kubectl apply -f web-app-service.yaml
```
service/web-app-service created
```
### Step 4: Access the Web Application
#### Wait for a few moments until the external IP address is assigned to your service. You can check the status using
> kubectl get services -o wide
```
PS D:\devops\terraform-project\azure\k8s\deployment> kubectl get services -o wide
NAME              TYPE           CLUSTER-IP     EXTERNAL-IP     PORT(S)        AGE   SELECTOR
kubernetes        ClusterIP      10.0.0.1       <none>          443/TCP        29m   <none>
web-app-service   LoadBalancer   10.0.185.191   4.157.117.232   80:30264/TCP   9s    app=web-app
```




