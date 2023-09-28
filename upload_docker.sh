#!/usr/bin/env bash

# build a docker image
echo "Build docker image"
IMAGE_NAME="duytt10-clouddevopsengin-capstone:${1:-latest}"
docker build -t "$IMAGE_NAME" .

# Authenticate to your default registry
ECR_URL="041996649308.dkr.ecr.us-east-1.amazonaws.com"
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $ECR_URL

export REPO_NAME="duytt10-clouddevopsengin-capstone"
repository_info=$(aws ecr describe-repositories --repository-names $REPO_NAME --region us-east-1 2>&1 | grep -i -w "RepositoryNotFoundException") || true
if [[ $repository_info ]]; then
    echo "The repo $REPO_NAME does not exist"
    aws ecr create-repository \
        --repository-name $REPO_NAME \
        --image-scanning-configuration scanOnPush=true \
        --region us-east-1
else
    echo "The repo $REPO_NAME exists"
fi

# Push an image to Amazon ECR'
docker images
docker tag "${IMAGE_NAME}" ${ECR_URL}/${REPO_NAME}:"${1:-latest}"
docker push ${ECR_URL}/${REPO_NAME}:"${1:-latest}"
echo "push docker image with tag ${1:-latest} sucessfully"
