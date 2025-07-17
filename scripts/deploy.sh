#!/bin/bash

# Authenticate with ECR
aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $ECR_REGISTRY

# Pull and restart container
docker rm -f flask-app || true
docker pull $ECR_REGISTRY/$ECR_REPOSITORY:$IMAGE_TAG
docker run -d -p 80:80 --name flask-app $ECR_REGISTRY/$ECR_REPOSITORY:$IMAGE_TAG
