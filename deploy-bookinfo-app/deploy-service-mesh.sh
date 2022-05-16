#!/bin/bash

oc new-project istio-system

sleep 10

oc create -n istio-system -f ./istio-install/istio-installation.yaml


sleep 60

oc new-project bookinfo

sleep 10

oc create -n istio-system -f ./istio-install/servicemeshmemberroll-default.yaml

sleep 80

oc apply -n bookinfo -f https://raw.githubusercontent.com/Maistra/istio/maistra-2.0/samples/bookinfo/platform/kube/bookinfo.yaml

sleep 10

oc apply -n bookinfo -f https://raw.githubusercontent.com/Maistra/istio/maistra-2.0/samples/bookinfo/networking/bookinfo-gateway.yaml

sleep 10

export GATEWAY_URL=$(oc -n istio-system get route istio-ingressgateway -o jsonpath='{.spec.host}')

oc apply -n bookinfo -f https://raw.githubusercontent.com/Maistra/istio/maistra-2.0/samples/bookinfo/networking/destination-rule-all.yaml

oc label deployment/productpage-v1 app.openshift.io/runtime=python --overwrite
oc annotate deployment/productpage-v1 app.openshift.io/connects-to=details-v1,reviews-v1,reviews-v2,reviews-v3 --overwrite
oc label deployment.apps/reviews-v1 app.openshift.io/runtime=java --overwrite
oc label deployment.apps/reviews-v2 app.openshift.io/runtime=java --overwrite
oc label deployment.apps/reviews-v3 app.openshift.io/runtime=java --overwrite
oc label deployment.apps/details-v1 app.openshift.io/runtime=ruby --overwrite
oc label deployment.apps/ratings-v1 app.openshift.io/runtime=nodejs --overwrite
oc annotate deployment/reviews-v2 app.openshift.io/connects-to=ratings-v1 --overwrite
oc annotate deployment/reviews-v3 app.openshift.io/connects-to=ratings-v1 --overwrite


echo "################################################################################"
echo "http://$GATEWAY_URL/productpage"