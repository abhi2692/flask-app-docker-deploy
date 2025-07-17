# 🚀 Flask App Docker Deployment on EC2 with GitHub Actions

This project demonstrates how to build, push, and deploy a simple Flask web application using Docker, AWS ECR, EC2, and GitHub Actions.

## 🗂️ Folder Structure

```
flask-app-docker-deploy/
├── Dockerfile                  # Docker image definition
├── README.md                   # Project documentation
├── .github/
│   └── workflows/
│       └── deploy.yaml         # GitHub Actions workflow
├── app/
│   ├── app.py                  # Flask application
│   └── requirements.txt        # Python dependencies
└── scripts/
    └── deploy.sh               # EC2 deployment script
```

## ⚙️ How It Works

1. **Build & Push Docker Image:**  
   GitHub Actions builds the Docker image and pushes it to AWS ECR on every push to `main`.

2. **Deploy to EC2:**  
   The workflow uploads `deploy.sh` to your EC2 instance and runs it via SSH.  
   The script pulls the latest image from ECR and runs the Flask app in a Docker container.

## 🏗️ EC2 Infrastructure

This project assumes an EC2 instance is already created. You can:

- ✅ Manually create an EC2 instance (Amazon Linux 2, with public IP)
- 🔧 Or provision infrastructure using Terraform from this repo: [terraform-aws-infra](https://github.com/abhi2692/terraform-aws-infra.git)

Make sure you:

- Allow inbound HTTP (port 80) and SSH (port 22)
- Upload the public key of your SSH keypair to EC2
- Store the private key in your GitHub repo secrets

## 🔐 Required GitHub Secrets

Set these secrets in your GitHub repository:

- `AWS_ACCESS_KEY_ID` – AWS access key
- `AWS_SECRET_ACCESS_KEY` – AWS secret key
- `AWS_REGION` – AWS region (e.g., `us-east-1`)
- `ECR_REGISTRY` – ECR registry URI
- `ECR_REPOSITORY` – ECR repository name
- `EC2_HOST` – Public IP of your EC2 instance
- `EC2_SSH_KEY` – EC2 private key (OpenSSH format)

## 🏁 To Deploy

1. Push changes to the `main` branch.
2. GitHub Actions will build, push, and deploy automatically.

##