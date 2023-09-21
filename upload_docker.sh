#!/usr/bin/env bash
# This file tags and uploads an image to Docker Hub

# Assumes that an image is built via `run_docker.sh`

# Step 1:
# Create dockerpath
dockerpath="leok13/duytt10-clouddevopsengin-project4"

# Step 2:  
# Authenticate & tag
docker login
docker tag duytt10-clouddevopsengin-project4 $dockerpath
echo "Docker ID and Image: $dockerpath"

# Step 3:
# Push image to a docker repository
docker push $dockerpath
