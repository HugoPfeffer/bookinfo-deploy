#!/bin/sh
export BOOK_URL=$(oc get routes -n user1-istio-system | grep istio-ingressgateway | awk  '{print $2}')
if [ -z "$BOOK_URL" ]
then
echo "\$BOOK_URL is empty"
else
find /home/demo/openshift-servicemesh-demo/* -type f -name "*.yaml" -exec sed -i "s/istio-ingressgateway-user1-istio-system.apps.cluster-jwn6r.jwn6r.sandbox1508.opentlc.com/$BOOK_URL/g" {} \;
fi
find /home/demo/openshift-servicemesh-demo/* -type f -name "*.yaml" -exec sed -i "s/user1/user1/g" {} \;
