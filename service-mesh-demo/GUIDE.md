<p align="center">
    <img alt="Red Hat Logo" height="100" src="../Logo-RedHat-Hat-Color-RGB.png">
</p>

<h1 align="center">
    Demonstration Guide
</h1>

<h2 align="center">
    Document made to guide Solution Architects during the presentation of Service Mesh using OpenShift 4.x
</h2>

<p align="center">
    <!-- <img alt="CentOS Version" src="https://img.shields.io/badge/Linux-CentOS8-green"> -->
    <img alt="Made By" src="https://img.shields.io/badge/Made%20By-Hugo%20Pfeffer-blue?style=for-the-badge">
    <img alt="Made By" src="https://img.shields.io/badge/License-GPL%203.0-green?style=for-the-badge">
</p>

# Deploy Bookinfo app
### Run the `deploy-service-mesh.sh` to deploy the entire workload

```sh
./deploy-service-mesh.sh
```
</br>

### Alternativaly you can run them separatly:

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

# Monitoring

### Show `Kiali` dashboard
```sh 
oc get routes -n istion-system | grep kiali 
```

- Refresh page to generate traffic
- Show traffic being routed through the mesh using ROUND-ROBIN
- Show the monitoring capabilities on the graph

### Show `Jaeger` dashboard
```sh 
oc get routes -n istion-system | grep jaeger
```

- Show time for each request to demonstrate the tracing capabilities of our tool.

# Customizations
