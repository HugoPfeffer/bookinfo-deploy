#!/bin/bash

oc new-project istio-system

sleep 10

oc create -n istio-system -f ./istio-install/istio-installation.yaml


sleep 60

oc new-project bookinfo

sleep 10

oc create -n istio-system -f ./istio-install/servicemeshmemberroll-default.yaml

sleep 60

oc apply -n bookinfo -f https://raw.githubusercontent.com/Maistra/istio/maistra-2.0/samples/bookinfo/platform/kube/bookinfo.yaml

sleep 10

oc apply -n bookinfo -f https://raw.githubusercontent.com/Maistra/istio/maistra-2.0/samples/bookinfo/networking/bookinfo-gateway.yaml

sleep 10

export GATEWAY_URL=$(oc -n istio-system get route istio-ingressgateway -o jsonpath='{.spec.host}')

oc apply -n bookinfo -f https://raw.githubusercontent.com/Maistra/istio/maistra-2.0/samples/bookinfo/networking/destination-rule-all.yaml

echo "################################################################################"
echo "http://$GATEWAY_URL/productpage"