# Ansible-Terraform-Integration
This project demonstrates how to use Terraform and Ansible together to provision and configure EC2 instances across multiple environments (Dev, Stage, and Prod).

Terraform handles the **infrastructure provisioning**, while Ansible automates **configuration management**, making this an ideal starter project for understanding how both tools collaborate in a real-world DevOps workflow.

---

## 🚀 Project Overview

### What this project does:
- Provisions **8 EC2 instances** (`dev`: 2, `stage`: 2, `prod`: 4).
- Creates a **security group** with rules for SSH (22) and HTTP (80).
- Uses **Ansible** to configure web servers on each instance.
- Deploys environment-specific `index.html` pages:
  - `dev` → Minimal UI with a developer theme.
  - `stage` → Modern preview UI.
  - `prod` → Portfolio UI with achievements, skills, certifications, socials, and image.

### Why it’s awesome:
- Full Infrastructure as Code (IaC) workflow.
- Dynamic inventory generation after `terraform apply`.
- Environment-based configuration using Ansible variables.
- Simple to extend to multi-region or autoscaling setups.

---

## 🧱 Project Structure

```

terra-ansible-starter/
├── terraform-config/
│   ├── main.tf
│   ├── outputs.tf
│   ├── variables.tf
│   └── provider.tf
│
├── ansible/
│   ├── ansible.cfg
│   ├── inventory/
│   │   └── hosts.ini
│   ├── playbook.yml
│   └── roles/
│       └── webserver/
│           ├── tasks/
│           │   └── main.yml
│           └── files/
│               ├── index-dev.html
│               ├── index-stage.html
│               └── index-prod.html
│
├── scripts/
│   ├── generate_inventory.py
|
|
|--- deploy.sh
│
└── README.md

```

---

## ⚙️ Setup Instructions

### 1. Clone the repo
```bash
git clone https://github.com/u-niks/Ansible-Terraform-Integration.git
cd Ansible-Terraform-Integration
```

### 2. Create SSH key for EC2 access

This project uses an SSH key named **appKey** to access your instances.

```bash
ssh-keygen -t rsa -b 4096 -f ~/.ssh/appKey
```

> Make sure to update your Terraform configuration to use this key.

### 3. Initialize Terraform

```bash
cd terraform_config
terraform init
```

### 4. Apply Terraform configuration

```bash
terraform apply -auto-approve
terraform output -json instance_public_ips > output.json 
```

This will:

* Create your EC2 instances.
* Generate a `inventory.json` file with their public IPs.

### 5. Generate Ansible inventory

```bash
python3 scripts/generate_inventory.py
```

This script converts the Terraform output JSON into a valid Ansible inventory file under `ansible/inventory/hosts.ini`.

### 6. Run Ansible playbook

```bash
ansible-playbook -i ansible/inventory/hosts.ini ansible/playbook.yml
```

This will install and configure Nginx, and deploy the corresponding `index.html` page for each environment.

---

## 🧩 One-Click Deployment

To automate the full flow (Terraform → Inventory → Ansible):

```bash
bash deploy.sh
```

This script:

1. Runs `terraform apply`
2. Generates inventory
3. Executes the Ansible playbook
   All in one command ⚡️

---

## 🧰 Tools & Technologies

* **Terraform** — Infrastructure provisioning
* **Ansible** — Configuration management
* **AWS EC2** — Compute service
* **Nginx** — Web server
* **Python** — Used for generating inventory file

---

## 🌐 Environments Overview

| Environment | Instances | Description                                           |
| ----------- | --------- | ----------------------------------------------------- |
| `dev`       | 2         | Lightweight static pages for development              |
| `stage`     | 2         | Preview deployment before production                  |
| `prod`      | 4         | Final portfolio version with achievements and socials |

---

## 👨‍💻 Author

**Nikhil Jadhav**
AWS DevOps Engineer • Cloud Enthusiast

🐦 [Twitter](https://x.com/u_niks_)
💼 [LinkedIn](https://www.linkedin.com/in/nikhil-jadhav-ab6b0021a/)

---

## ⭐️ Support

If you found this project helpful:

* Give the repo a ⭐️ on [GitHub](http://github.com/u-niks/Ansible-Terraform-Integration)
* Share it with your DevOps friends!
* Follow me for more DevOps projects and blogs 🚀

---