# gcp-terraform-lab

> GCP VPC, Compute Engine, and networking fundamentals with Terraform

![Terraform](https://img.shields.io/badge/Terraform-IaC-purple?logo=terraform)
![GCP](https://img.shields.io/badge/GCP-google_5.x-red?logo=googlecloud)

---

## Overview

A foundational GCP infrastructure lab built with Terraform. Deploys a VPC with a public subnet, firewall rules, and a Compute Engine instance — demonstrating core GCP IaC patterns. Complements the [aws-terraform-lab](https://github.com/BadAsh99/aws-terraform-lab) for cross-cloud infrastructure comparison.

Uses Application Default Credentials (ADC) — no credential files committed to version control.

---

## Architecture

```
GCP Project
└── VPC Network (ash-lab-vpc)
        └── Public Subnet (10.0.1.0/24)
                └── Compute Instance (Debian 11, e2-micro)
                        └── Firewall Rule: allow-ssh
                                └── TCP 22 inbound (lab config)
                        └── Ephemeral Public IP
```

---

## Features

- Custom VPC with manual subnet configuration (no auto-create)
- Public subnet with ephemeral public IP assignment
- Firewall rule scoped to SSH access
- Compute Engine instance on e2-micro (free-tier eligible)
- Debian 11 OS — stable, lightweight for lab use
- Application Default Credentials — no credential files in repo
- Output: instance public IP

---

## Tech Stack

| Component | Technology |
|-----------|-----------|
| IaC | Terraform, google ~5.x |
| Cloud | Google Cloud Platform |
| Compute | Compute Engine (e2-micro, Debian 11) |
| Networking | VPC, Subnet, GCP Firewall Rules |
| Auth | Application Default Credentials (`gcloud auth application-default login`) |

---

## Getting Started

### Prerequisites

- `gcloud` CLI (`gcloud auth application-default login`)
- Terraform v1.5+
- GCP project with billing enabled

### Deploy

```bash
git clone https://github.com/BadAsh99/gcp-terraform-lab.git
cd gcp-terraform-lab
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars: set gcp_project_id, region, zone
terraform init
terraform plan
terraform apply
```

### Connect

```bash
gcloud compute ssh ash-lab-vm --zone=$(terraform output -raw zone)
```

---

## Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `gcp_project_id` | GCP project ID | — |
| `gcp_region` | Deployment region | `us-central1` |
| `gcp_zone` | Compute zone | `us-central1-a` |

---

## Outputs

| Output | Description |
|--------|-------------|
| `instance_public_ip` | Ephemeral public IP of the instance |

---

## Cleanup

```bash
terraform destroy
```

---

## Author

**Ash Clements** — Sr. Principal Security Consultant | Infrastructure Automation
[github.com/BadAsh99](https://github.com/BadAsh99)
