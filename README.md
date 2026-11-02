# Infrastructure Azure modulaire avec Terraform

Projet de formation DevOps : définition de ressources Azure avec Terraform et validation automatisée avec GitHub Actions.

**Terraform · Azure · GitHub Actions · OIDC · TFLint · Checkov**

## Ce que montre ce projet

- Organisation de l’infrastructure en modules : réseau, stockage, App Service, Function App et conteneur.
- Utilisation d’un Resource Group existant et d’un backend Terraform Azure.
- Validation du format et de la configuration, analyse TFLint et génération du plan.
- Scan Checkov informatif : les résultats sont visibles, mais le workflow utilise actuellement `soft_fail: true`.
- Déploiement et destruction déclenchés manuellement dans un workflow distinct.

## Ressources définies

| Domaine | Ressources |
| --- | --- |
| Réseau | Virtual Network, subnets frontend/backend, Network Security Group |
| Stockage | Storage Account et containers Blob `api-logs` et `api-config` |
| Applications | App Service Linux et Function App Linux |
| Conteneurs | Azure Container Instance avec Nginx |

## Structure

```text
.github/workflows/
  terraform.yml         # contrôles et plan
  terraform-deploy.yml  # apply / destroy manuels
terraform/
  backend.tf
  main.tf
  outputs.tf
  providers.tf
  variables.tf
  terraform.tfvars.example
  modules/
    app-service/
    container/
    function-app/
    network/
    storage/
```

## Vérifier le code

Depuis le dossier `terraform`, les premiers contrôles peuvent être lancés sans connexion au backend :

```bash
terraform fmt -check -recursive
terraform init -backend=false
terraform validate
```

Ces contrôles vérifient le format et la cohérence de la configuration ; ils ne prouvent pas qu’un déploiement Azure a réussi.

## CI/CD et configuration

La [CI Terraform](./.github/workflows/terraform.yml) exécute les contrôles sur les pushes et les pull requests vers `main`. Elle utilise OIDC pour la connexion Azure et publie le plan dans les pull requests. La configuration du backend est fournie par les secrets GitHub du projet ; son accès utilise actuellement une clé de stockage.

Le [workflow de déploiement](./.github/workflows/terraform-deploy.yml) est déclenché manuellement avec le choix `apply` ou `destroy`. Les noms et variables doivent être adaptés à l’environnement cible avant toute utilisation.

[Consulter les exécutions et rapports](https://github.com/A-benslimane/azure-infra-terraform/actions) · [Parcourir les modules](./terraform/modules)

## Autres projets Azure

[Azure Quiz — infrastructure Terraform](https://github.com/A-benslimane/azur-iac-terraform) · [Architectures Bicep](https://github.com/A-benslimane/TP-Bicep-Azure)
