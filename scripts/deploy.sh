#!/bin/bash
echo "ECR_REGISTRY=$ECR_REGISTRY"
echo "ECR_REPOSITORY=$ECR_REPOSITORY"
echo "IMAGE_TAG=$IMAGE_TAG"
echo "AWS_REGION=$AWS_REGION"

aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $ECR_REGISTRY
docker pull $ECR_REGISTRY/$ECR_REPOSITORY:$IMAGE_TAG
docker stop flask-app || true
docker rm flask-app || true
docker run -d -p 80:80 --name flask-app $ECR_REGISTRY/$ECR_REPOSITORY:$IMAGE_TAG
