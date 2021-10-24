#!/bin/bash
echo "Creating operator-redhat namespace"
oc create -f ./operator-install/namespace-operators-redhat.yaml

sleep 10
echo "Creating operator group"
oc create -f ./operator-install/operatorgroup-redhat.yaml

sleep 10
echo "Installing Elastic Search"
oc create -f ./operator-install/subscription-elasticsearch.yaml

sleep 60
echo "Installing Jaeger Operator"
oc create -f ./operator-install/subscription-jaeger.yaml

sleep 60
echo "Installing Kiali Operator"
oc create -f ./operator-install/subscription-kiali.yaml

sleep 60
echo "Installing Service Mesh Operator"
oc create -f ./operator-install/subscription-service-mesh.yaml


echo "Finished installing Operators"

