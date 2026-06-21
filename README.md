# GitOps IaC Project

Projeto desenvolvido para a disciplina de Infrastructure as Code (GitOps) da FIAP.

## Objetivo

Implementar uma esteira GitOps completa para provisionamento, validação e entrega de infraestrutura imutável, utilizando:

- Terraform
- Kubernetes
- Kind
- Kustomize
- GitHub Actions
- Argo CD
- Docker

---

## Arquitetura

```text
                 +----------------+
                 |     GitHub     |
                 | Repositório IaC|
                 +--------+-------+
                          |
                    Pull Request
                          |
                 +--------v-------+
                 | GitHub Actions |
                 | CI / Validação |
                 +--------+-------+
                          |
                   Merge Main
                          |
                 +--------v-------+
                 |    GitOps      |
                 | Kustomize      |
                 +--------+-------+
                          |
              +-----------+------------+
              |                        |
        +-----v-----+            +-----v-----+
        | Namespace |            | Namespace |
        |    dev    |            |    hml    |
        +-----------+            +-----------+
              |                        |
        Deployment               Deployment
         1 réplica                2 réplicas
```

---

## Estrutura do Projeto

```text
gitops-iac-project

├── .github
│   └── workflows
│       └── ci.yml

├── app
│   ├── Dockerfile
│   └── index.html

├── docs
│   ├── arquitetura.md
│   ├── relatorio.md
│   └── rollback-drift.md

├── infra
│   ├── main.tf
│   ├── outputs.tf
│   └── variables.tf

├── k8s
│   ├── base
│   │   ├── deployment.yaml
│   │   ├── service.yaml
│   │   └── kustomization.yaml
│   │
│   └── overlays
│       ├── dev
│       │   └── kustomization.yaml
│       │
│       └── hml
│           └── kustomization.yaml

└── README.md
```

---

## Tecnologias Utilizadas

- Git e GitHub
- GitHub Actions
- Docker Desktop
- Kind
- Kubernetes
- Kustomize
- Terraform
- Argo CD
- Visual Studio Code

---

## Provisionamento com Terraform

O Terraform é responsável pela criação dos namespaces Kubernetes.

Namespaces criados:

- dev
- hml

### Executar

```bash
cd infra

terraform init

terraform validate

terraform plan

terraform apply
```

### Verificar

```bash
kubectl get ns
```

Exemplo:

```text
NAME              STATUS

dev               Active

hml               Active
```

---

## Kubernetes

### Aplicar ambiente DEV

```bash
kubectl apply -k k8s/overlays/dev
```

Verificar:

```bash
kubectl get deployments

kubectl get pods
```

---

### Aplicar ambiente HML

```bash
kubectl apply -k k8s/overlays/hml
```

Verificar:

```bash
kubectl get deployments

kubectl get pods
```

---

## Pipeline CI

A pipeline foi implementada utilizando GitHub Actions.

Validações realizadas:

- Checkout do projeto
- Terraform Init
- Terraform Validate
- Verificação da estrutura Kubernetes
- Política de segurança
- Bloqueio em caso de falha

Arquivo:

```text
.github/workflows/ci.yml
```

---

## Drift

Foi realizado um experimento de drift alterando manualmente o número de réplicas do deployment.

Comando utilizado:

```bash
kubectl scale deployment gitops-app --replicas=3
```

Resultado:

```text
gitops-app    3/3
```

---

## Reconciliação

O ambiente foi restaurado para o estado desejado utilizando:

```bash
kubectl apply -k k8s/overlays/dev
```

Resultado:

```text
deployment.apps/gitops-app configured
```

---

## Rollback

O rollback pode ser realizado através do Git:

```bash
git log --oneline

git revert <hash-do-commit>

git push
```

---

## Evidências

O projeto apresenta:

- Histórico de commits
- Pull Requests simulados
- Pipeline CI
- Provisionamento Terraform
- Cluster Kubernetes local
- Ambientes DEV e HML
- Experimento de Drift
- Reconciliação
- Rollback documentado

---

## Autor

Pedro

Disciplina: Infrastructure as Code (GitOps)

FIAP - Cloud Computing