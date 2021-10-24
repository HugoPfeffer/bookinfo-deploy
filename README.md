<p align="center">
    <img alt="Red Hat Logo" height="100" src="Logo-RedHat-Hat-Color-RGB.png">
</p>

<h1 align="center">
    Deployment Script for Bookinfo app
</h1>

<h2 align="center">
    A complete deploy of bookinfo app for demos of service mesh.
</h2>

<p align="center">
    <!-- <img alt="CentOS Version" src="https://img.shields.io/badge/Linux-CentOS8-green"> -->
    <img alt="Made By" src="https://img.shields.io/badge/Made%20By-Hugo%20Pfeffer-blue?style=for-the-badge">
    <img alt="Made By" src="https://img.shields.io/badge/License-GPL%203.0-green?style=for-the-badge">
</p>

</br>
</br>
<h2>About:</h2>
The script includes files for the deployment of the required operators on OpenShift 4.x. Files for the deployment of the bookinfo app and configuration files for istio.  
</br></br>

<h2>Tools:</h2>
<ul>
    <li>OpenShift 4.x</li>
</ul>
</br>

<h2>How to use:</h2>

Give the right permission to both `deploy-operators.sh` and `deploy-service-mesh.sh`

```sh
sudo chmod 0700 deploy-operators.sh deploy-service-mesh.sh
```

First run the `deploy-operators.sh` command to deploy the required operators:

```sh
./deploy-operators.sh
```

Check if everything was installed correctly:

`OpenShift Administrator Console > Operators > Installed Operators`

If everything is up and running, then run the `deploy-service-mesh.sh` script:

```sh
./deploy-service-mesh.sh
```














