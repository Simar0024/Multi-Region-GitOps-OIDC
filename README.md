# 🌍 Multi-Region GitOps with OIDC & Terraform 🚀

[![IaC Security Scan](https://img.shields.io/badge/Security-Checkov-green?logo=checkov)](https://www.checkov.io/)
[![Terraform](https://img.shields.io/badge/Terraform-Azure-blueviolet?logo=terraform)]
[![CI/CD](https://img.shields.io/github/workflow/status/Simar0024/Multi-Region-GitOps-OIDC/Production%20GitOps%20Pipeline/main?label=GitOps%20Pipeline&logo=github)]

## ✨ Overview

**Multi-Region-GitOps-OIDC** is a reference implementation for deploying highly available Azure App Services across multiple regions using Terraform, GitHub Actions, and secure OIDC authentication. It features:

- 🌐 **Multi-region deployment** (Central India & Korea Central)
- 🔒 **OIDC-based authentication** for secure, secretless CI/CD
- ⚡ **Automated drift detection** and IaC security scanning
- 🏗️ **Modular Terraform** for scalable infrastructure

---

## 📁 Project Structure

```text
terraform/
  main.tf                # Root module: resource groups & app modules
  providers.tf           # Provider & backend config (OIDC, remote state)
  variables.tf           # Global variables
  modules/
    app-service/
      main.tf            # App Service Plan & Web App resources
      variables.tf       # Module variables
.github/
  workflows/
    pipeline.yml         # Main GitOps pipeline (plan, apply, security)
    detect-change.yml    # Scheduled drift detection
```

---

## 🚦 CI/CD Workflows

### 1. **Production GitOps Pipeline** (`.github/workflows/pipeline.yml`)

- **Triggers:** On push/PR to `main`
- **Stages:**
  - ✅ **Checkov Security Scan**: Ensures Terraform code is secure
  - 📝 **Terraform Plan**: Previews changes, comments on PRs
  - 🚀 **Terraform Apply**: Deploys to Azure on merge to `main`
- **OIDC Auth:** Uses GitHub OIDC for Azure login (no secrets!)

### 2. **Infrastructure Drift Detection** (`.github/workflows/detect-change.yml`)

- **Schedule:** Runs daily at midnight UTC
- **Purpose:** Detects configuration drift and creates a GitHub Issue if found

---

## ☁️ Infrastructure Details

### **Resource Groups**

- `rg-prod-centralindia` (Central India)
- `rg-prod-koreacentral` (Korea Central)

### **App Service Module**

- Deploys a Linux App Service Plan and Web App per region
- **Features:**
  - System-assigned managed identity
  - Always-on, HTTP/2, health checks
  - Python 3.12 stack
  - Secure logging (detailed errors, failed request tracing)
  - App settings for environment and region

---

## 🛡️ Security & Best Practices

- **Checkov**: Automated IaC security scanning
- **OIDC**: No long-lived secrets in CI/CD
- **Terraform Remote State**: Stored in Azure Storage with OIDC
- **Code Comments**: Inline suppressions for student/demo constraints

---

## 🚀 Getting Started

### 1. **Clone the Repo**

```bash
git clone https://github.com/Simar0024/Multi-Region-GitOps-OIDC.git
cd Multi-Region-GitOps-OIDC
```

### 2. **Configure Azure & GitHub OIDC**

- Set up Azure resources for remote state (see `providers.tf`)
- Add required secrets to your GitHub repo:
  - `AZURE_CLIENT_ID`
  - `AZURE_SUBSCRIPTION_ID`
  - `AZURE_TENANT_ID`

### 3. **Run the Pipeline**

- Push changes or open a PR to `main`
- The pipeline will:
  - Scan for security issues
  - Plan and comment on PRs
  - Apply changes on merge

---

## 🧩 Customization

- **Add more regions:** Duplicate the `module "app_*"` block in `main.tf`
- **Change stack:** Edit the `application_stack` in `modules/app-service/main.tf`
- **App settings:** Add to the `app_settings` map

---

## 📝 Example: Add a New Region

```hcl
module "app_eastus" {
  source              = "./modules/app-service"
  resource_group_name = "rg-prod-eastus"
  location            = "East US"
  app_name            = "web-prod-eastus-001"
}
```

---

## 🤝 Contributing

PRs and issues are welcome! Please open an issue for feature requests or bug reports.

---

## 📚 References

- [Terraform Azure Provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [GitHub Actions OIDC](https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/about-security-hardening-with-openid-connect)
- [Checkov](https://www.checkov.io/)

---

## 🏷️ Tags

`#terraform` `#azure` `#gitops` `#oidc` `#multiregion` `#iac` `#devops` `#github-actions`

---
