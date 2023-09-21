#!/usr/bin/env bash

# This tags and uploads an image to Docker Hub

# Step 1:
# This is your Docker ID/path
app="duytt10-clouddevopsengin-project4"
dockerpath="leok13/$app"
forceUpdate=${1:-false}

# Step 2.1
# Check pod before deployment
listpodname=$(kubectl get pods -o jsonpath='{range .items[*]}{.metadata.name} {end}')

# Step 2.2
# Run the Docker Hub container with kubernetes
if [[ $listpodname =~ (^|[[:space:]])$app($|[[:space:]]) ]]; then
    if [[ $forceUpdate == true ]]; then
        echo "force update"
        kubectl delete pods $app
        kubectl run duytt10-clouddevopsengin-project4 --image=$dockerpath --port=80 --labels app=$app
    else
        echo "pod $app has already created"
    fi
else
    kubectl run duytt10-clouddevopsengin-project4 --image=$dockerpath --port=80 --labels app=$app
fi

# Step 3:
# List kubernetes pods
echo "kubectl get pods"
kubectl get pods

while :; do
    if [[ $(kubectl get pods -o jsonpath='{.items[0].status.phase}') != "Running" ]]; then
        echo "Waiting for pod running"
        sleep 5
    else
        echo "Pod running"
        break
    fi
done
# Step 4:
# Forward the container port to a host
kubectl port-forward duytt10-clouddevopsengin-project4 8000:80
