NAMESPACE=`oc project -q`
sed -i'' "s/namespace:.*/namespace: $NAMESPACE/g" ./deploy/rbac.yaml ./deploy/deployment.yaml

oc apply -f rbac.yaml

oc create role use-scc-hostmount-anyuid --verb=use --resource=scc --resource-name=hostmount-anyuid -n nfs-namespace
oc get roles -n nfs-namespace
oc adm policy add-role-to-user use-scc-hostmount-anyuid -z nfs-client-provisioner --role-namespace nfs-namespace -n nfs-namespace

oc apply -f deployment.yaml
oc apply -f class.yaml
