# Hands-On Project: Deploying a Simple Web App on AKS
### Step 1: Create a Kubernetes Deployment YAML
#### Create a file named my-web-app.yaml with my-web-app.yaml content. This YAML defines a simple Kubernetes Deployment for an Nginx web server with 2 replicas.
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
#### Look for the EXTERNAL-IP field. Once it's assigned, open a web browser and navigate to the external IP address. You should see the default Nginx welcome page.
### Scale the web application
#### Increase the value of replicas to 3 and the re apply.
> kubectl apply -f .\my-web-app.yaml
```
deployment.apps/web-app configured
```
### Verify Scaling
> kubectl get deployment web-app
```
NAME      READY   UP-TO-DATE   AVAILABLE   AGE
web-app   3/3     3            3           32m
```
#### Look for the "DESIRED," "CURRENT," and "UP-TO-DATE" values. They should all be equal to the number of replicas (3 in this example). Also, check the "AVAILABLE" value to ensure all replicas are ready.
### Test the Scaling
#### To further verify that the replicas are working fine, you can describe the pods and check their status:
>   kubectl describe pods | Select-String "^Name"
```
Name:             web-app-868995d7cf-5jqwq
Namespace:        default
Name:             web-app-868995d7cf-m29kj
Namespace:        default
Name:             web-app-868995d7cf-mmn7x
Namespace:        default
```
#### This will filter the output to lines starting with "Name." If you want to display the entire line, you can use:
> kubectl describe pod <pod-name>
### Access the Web Application:
#### If you've scaled successfully, your web application should still be accessible using the external IP address obtained from the service. If you've lost the external IP, you can retrieve it again:
> kubectl get services -o wide
## Simulating Pod Failure and Recovery:
### Step 1: Identify Pods:
#### List the pods in your deployment:
> kubectl get pods
```
NAME                       READY   STATUS    RESTARTS   AGE
web-app-868995d7cf-5jqwq   1/1     Running   0          47m
web-app-868995d7cf-m29kj   1/1     Running   0          15m
web-app-868995d7cf-mmn7x   1/1     Running   0          47m
```
#### Identify one of the pods from the deployment named web-app. Note its name.
### Step 2: Delete a Pod:
#### Manually delete one of the pods to simulate a failure:
> kubectl delete pod web-app-868995d7cf-m29kj
```
pod "web-app-868995d7cf-m29kj" deleted
```
### Step 3: Verify Pod Recovery:
#### Watch the pods to see the new pod being created:
> kubectl get pods -w
```
PS D:\devops\terraform-project\azure\k8s\deployment> kubectl get pods -w
NAME                       READY   STATUS    RESTARTS   AGE
web-app-868995d7cf-5jqwq   1/1     Running   0          49m
web-app-868995d7cf-d4cnw   1/1     Running   0          119s
web-app-868995d7cf-mmn7x   1/1     Running   0          49m
```
#### Observe the status of the pods. Kubernetes will create a new pod to replace the one you deleted. Once the new pod is in the "Running" state, the recovery is complete.
### Step 4: Verify Deployment:
#### Check the status of your deployment:
> kubectl get deployment web-app
```
PS D:\devops\terraform-project\azure\k8s\deployment> kubectl get deployment web-app
NAME      READY   UP-TO-DATE   AVAILABLE   AGE
web-app   3/3     3            3           50m
```


