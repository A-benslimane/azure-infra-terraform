# Azure Infrastructure Terraform

Ce projet déploie une infrastructure Azure avec Terraform dans le cadre du TP Infrastructure as Code.

## Objectif

L'objectif est de créer et gérer automatiquement plusieurs ressources Azure avec Terraform, puis d'automatiser les vérifications avec GitHub Actions et OIDC.

## Ressources déployées

Le projet déploie les ressources suivantes :

- Resource Group existant utilisé par Terraform
- Storage Account applicatif
- Containers Blob :
  - `api-logs`
  - `api-config`
- App Service Linux
- Function App Linux
- Azure Container Instance avec Nginx
- Virtual Network
- Subnets :
  - `subnet-frontend`
  - `subnet-backend`
- Network Security Group avec règles HTTP, HTTPS et deny all inbound

## Structure du projet

```text
.
├── .github/
│   └── workflows/
│       └── terraform.yml
├── terraform/
│   ├── backend.tf
│   ├── main.tf
│   ├── outputs.tf
│   ├── providers.tf
│   ├── variables.tf
│   └── modules/
│       ├── app-service/
│       ├── container/
│       ├── function-app/
│       ├── network/
│       └── storage/
└── README.md