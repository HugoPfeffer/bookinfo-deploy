#!/bin/bash

oc create -f ./operator-install/namespace-operators-redhat.yaml

sleep 10

oc create -f ./operator-install/operatorgroup-redhat.yaml

sleep 10

oc create -f ./operator-install/subscription-elasticsearch.yaml

sleep 60

oc create -f ./operator-install/subscription-jaeger.yaml

sleep 60

oc create -f ./operator-install/subscription-kiali.yaml

sleep 60

oc create -f ./operator-install/subscription-service-mesh.yaml


echo "Finished installing Operators"

