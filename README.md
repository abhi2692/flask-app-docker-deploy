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

```

## ⚙️ How It Works

1. **Build & Push Docker Image:**  
   GitHub Actions builds the Docker image and pushes it to AWS ECR on every push to `main`.

2. **Deploy to EC2:**  
   The workflow connects to your EC2 instance via SSH and runs deployment commands directly.  
   It pulls the latest image from ECR and runs the Flask app in a Docker container.
   
## 🏗️ EC2 Infrastructure

This project assumes an EC2 instance is already created. You can:

- ✅ Manually create an EC2 instance (Amazon Linux 2, with public IP)
- 🔧 Or provision infrastructure using Terraform from this repo: [terraform-aws-infra](https://github.com/abhi2692/terraform-aws-infra.git)

Make sure you:

- Allow inbound HTTP (port 80) for app access  
- Allow inbound SSH (port 22) for deployment  
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

---

## ⚠️ Security Note

For **testing/demo purposes**, you can open SSH (`port 22`) on your EC2 to `0.0.0.0/0`.  
This allows GitHub Actions runners to connect from anywhere.  

👉 **However, this is not secure for production.** Here are better options:  

1. **Allow only GitHub Actions IP ranges**  
   - GitHub publishes runner IPs [here](https://api.github.com/meta).  
   - Update your Security Group to allow only those ranges.  

2. **Use a Bastion Host**  
   - Keep your app EC2 private.  
   - GitHub connects to the bastion → bastion connects to app EC2.  

3. **Self-Hosted Runner**  
   - Run GitHub Actions runner *inside* your AWS VPC.  
   - No public SSH access required at all.  

For this beginner-friendly project, option **1 (open to 0.0.0.0/0 temporarily)** is fine.  
But in a **real-world setup**, use option **2 or 3** for secure deployments. 
