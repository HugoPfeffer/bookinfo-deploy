<p align="center">
    <img alt="Red Hat Logo" height="100" src="../Logo-RedHat-Hat-Color-RGB.png">
</p>

<h1 align="center">
    Demonstration Guide
</h1>

<h3 align="center"><i> Based on <bold>Gustavo Gianini's</bold> <a href="https://github.com/ggianini/openshift-servicemesh-demo">demo</a></i></h3><br>
<p align="center">
    <!-- <img alt="CentOS Version" src="https://img.shields.io/badge/Linux-CentOS8-green"> -->
    <img alt="Made By" src="https://img.shields.io/badge/Made%20By-Hugo%20Pfeffer-blue?style=for-the-badge">
    <img alt="Made By" src="https://img.shields.io/badge/License-GPL%203.0-green?style=for-the-badge">
</p>

<br>

# The CCN Roadshow(Dev Track) Module 3 Labs 2021

These labs provide templates, generated Java codes, empty configuration for each lab that the workshop attenddees will develop during the roadshow.
The included Java projects and/or installation files are here: 

* Catalog - Spring Boot project
* Inventory - Quarkus project 
* Istio - Servie Mesh configuration
  * <a href="https://github.com/HugoPfeffer/bookinfo-deploy/tree/main/service-mesh-demo#deploy-bookinfo-app">Deploying Bookinfo app</a>
  * <a href="https://github.com/HugoPfeffer/bookinfo-deploy/tree/main/service-mesh-demo#monitoring">Monitoring</a>
  * <a href="https://github.com/HugoPfeffer/bookinfo-deploy/tree/main/service-mesh-demo#customizations">Customizations</a>
  * <a href="https://github.com/HugoPfeffer/bookinfo-deploy/tree/main/service-mesh-demo#tracing-faulty-apps-with-jaeger">Tracing faulty apps with Jaeger</a>

 

<br>

# #1 Deploy Bookinfo app
## Run the `deploy-service-mesh.sh` to deploy the entire workload
```sh
./deploy-service-mesh.sh
```
</br>

## Alternatively you can run them separately:

- Change to the correct directory:
```sh 
cd deploy-bookinfo-app/
```
- Create a namespace to hold all configurations for the Service Mesh.
```sh
oc new-project istio-system
```
- Deploy the Service Mesh Control Plane.
```sh
oc create -n istio-system -f ./istio-install/istio-installation.yaml
```
- Create a new namespace to hold the bbookinfo application.
```sh
oc new-project bookinfo
```
- Create the Servce Mesh Member Roll.
```sh
oc create -n istio-system -f ./istio-install/servicemeshmemberroll-default.yaml
```
- Deploy the bookinfo application.
```sh
oc apply -n bookinfo -f https://raw.githubusercontent.com/Maistra/istio/maistra-2.0/samples/bookinfo/platform/kube/bookinfo.yaml
```
- Create the bookinfo gateway.
```sh
oc apply -n bookinfo -f https://raw.githubusercontent.com/Maistra/istio/maistra-2.0/samples/bookinfo/networking/bookinfo-gateway.yaml
```
- Use this command to get the url for your application.
```sh
oc -n istio-system get route istio-ingressgateway -o jsonpath='{.spec.host}'
```
- Lastly add the proper destination rules for your application.
```sh
oc apply -n bookinfo -f https://raw.githubusercontent.com/Maistra/istio/maistra-2.0/samples/bookinfo/networking/destination-rule-all.yaml
```

<br>

# #2 Monitoring

<br>

### Show `Kiali` dashboard
```sh 
oc get routes -n istio-system | grep kiali 
```

- Refresh page to generate traffic
- Show traffic being routed through the mesh using ROUND-ROBIN
- Show the monitoring capabilities on the graph

<br>

### Show `Jaeger` dashboard
```sh 
oc get routes -n istio-system | grep jaeger
```

- Show time for each request to demonstrate the tracing capabilities of our tool.

<br>

# #3 Customizations

<br>

## Change to correct directory:
```sh 
cd ../service-mesh-demo/istio
```

## **ROUND ROBIN to RANDOM**

<br>

### Change the routing rule from `ROUND ROBIN` to `RANDOM` by removing the commented lines on `./service-mesh-demo/istio/destination-rule-all.yaml`

<br>

### Apply the changes:
```sh 
oc apply -f destination-rule-all.yaml 
```
- Show that the request are now being routed randomly

<br>

## **AB testing**

<br>


### Apply the `DestinationRule` for Firefox AB testing:
```sh 
oc apply -f virtualservices/ab-firefox.yaml 
```
- Access the application using Firefox

### Apply the `DestinationRule` for the user 'Jason' AB testing:
```sh 
oc apply -f virtualservices/ab-jason.yaml 
```
- Log in with the user **Jason** | jason:admin
- Show that you're now being routed through a specific version

<br>



## **Deployments** 

<br>

### Apply the `DestinationRule` for the Blue-Green deployment:
```sh 
oc apply -f virtualservices/bluegreen.yaml 
```
- Refresh the page to show the changes

### Apply the `DestinationRule` for the Canary deployment:
```sh 
oc apply -f virtualservices/canary.yaml 
```
- Refresh the page to show the changes

<br>

## **Inject failure**

<br>

### Apply the `DestinationRule` for the injected delay to show a failing app:
```sh 
oc apply -f virtualservices/delay-jason.yaml 
```
- Refresh the page while logged with the user Jason


### Apply the `DestinationRule` for the injected error to show a faulty app:
```sh 
oc apply -f virtualservices/fail-jason.yaml 
```
- Refresh the page while logged with the user Jason

<br>


## **Route to a single version**

<br>

### Apply the `DestinationRule` for the routing to a single version:
```sh 
oc apply -f virtualservices/virtual-service-all-v1.yaml 
```
- Refresh the page

<br>

# #4 Tracing faulty apps with **Jaeger**

<br>

### Open **Jaeger** dashboard
```sh 
oc get routes -n istio-system | grep jaeger
```
- Show the faulty and delayed apps on the dashboard





