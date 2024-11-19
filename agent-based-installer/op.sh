cat op.sh
#!/bin/bash

# Set the backup directory
BACKUP_DIR=./openshift_backup
mkdir -p $BACKUP_DIR

# Backup OpenShift configurations
for namespace in $(oc get namespace -o jsonpath='{.items[*].metadata.name}'); do
    mkdir -p $BACKUP_DIR/$namespace
    for item in $(oc api-resources --verbs=list -o name | grep -v event); do
        oc -n $namespace get $item -o yaml > $BACKUP_DIR/$namespace/$item.yaml
    done
done