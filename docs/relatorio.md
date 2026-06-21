# Relatório Técnico – Infrastructure as Code (GitOps)

## 1. Identificação

- Aluno: Pedro
- Disciplina: Infrastructure as Code (GitOps)
- Curso: Cloud Computing
- Instituição: FIAP
- Data: Junho de 2026

---

## 2. Resumo Executivo

Este projeto teve como objetivo implementar uma esteira GitOps completa para provisionamento, validação e gerenciamento de infraestrutura como código.

A solução foi desenvolvida utilizando Terraform para provisionamento dos namespaces Kubernetes, Kind para criação do cluster local, Kubernetes para orquestração dos recursos, Kustomize para gerenciamento dos ambientes DEV e HML e GitHub Actions para automação das validações.

Também foi realizado um experimento de Drift e sua posterior reconciliação, além da documentação do processo de rollback através do Git.

---

## 3. Objetivos

Implementar uma solução GitOps capaz de:

- Versionar infraestrutura em Git;
- Provisionar recursos com Terraform;
- Automatizar validações utilizando CI;
- Criar ambientes DEV e HML;
- Gerenciar configurações com Kustomize;
- Demonstrar detecção e correção de Drift;
- Documentar o processo de Rollback.

---

## 4. Arquitetura da Solução

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

## 5. Tecnologias Utilizadas

| Ferramenta | Finalidade |
|-----------|------------|
| Git | Controle de versão |
| GitHub | Hospedagem do repositório |
| GitHub Actions | Pipeline CI |
| Docker Desktop | Execução de containers |
| Kind | Cluster Kubernetes local |
| Kubernetes | Orquestração |
| Kustomize | Gerenciamento dos ambientes |
| Terraform | Provisionamento |
| VS Code | Ambiente de desenvolvimento |

---

## 6. Estrutura do Projeto

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

## 7. Provisionamento com Terraform

O Terraform foi utilizado para provisionar os namespaces Kubernetes.

### Recursos criados

- Namespace `dev`
- Namespace `hml`

### Comandos executados

```bash
cd infra

terraform init

terraform validate

terraform plan

terraform apply
```

### Resultado

```text
dev_namespace = "dev"

hml_namespace = "hml"
```

Verificação:

```bash
kubectl get ns
```

Resultado:

```text
NAME     STATUS

dev      Active

hml      Active
```

---

## 8. Ambientes Kubernetes

### Ambiente DEV

Aplicação:

```bash
kubectl apply -k k8s/overlays/dev
```

Resultado:

```text
gitops-app   1/1
```

---

### Ambiente HML

Aplicação:

```bash
kubectl apply -k k8s/overlays/hml
```

Resultado:

```text
hml-gitops-app   2/2
```

---

## 9. Pipeline CI

A pipeline foi implementada utilizando GitHub Actions.

As seguintes validações foram realizadas:

- Checkout do projeto;
- Terraform Init;
- Terraform Validate;
- Verificação da estrutura Kubernetes;
- Política simples de segurança;
- Bloqueio da pipeline em caso de falha.

Arquivo:

```text
.github/workflows/ci.yml
```

---

## 10. Experimento de Drift

Foi realizado um experimento de Drift alterando manualmente a quantidade de réplicas do deployment.

Comando utilizado:

```bash
kubectl scale deployment gitops-app --replicas=3
```

Resultado:

```text
gitops-app   3/3
```

Esse procedimento gerou uma divergência entre o estado real do cluster e o estado desejado armazenado no Git.

---

## 11. Reconciliação

Para restaurar o estado desejado, foi utilizado:

```bash
kubectl apply -k k8s/overlays/dev
```

Resultado:

```text
deployment.apps/gitops-app configured
```

Após a reconciliação, o ambiente voltou ao estado definido no repositório.

---

## 12. Rollback

O rollback pode ser realizado através do Git.

Comandos:

```bash
git log --oneline

git revert <hash-do-commit>

git push
```

Esse processo permite restaurar versões anteriores da infraestrutura e das configurações da aplicação.

---

## 13. Conclusão

O projeto demonstrou a implementação de uma esteira GitOps utilizando ferramentas amplamente empregadas no mercado.

Foi possível versionar a infraestrutura, automatizar validações, criar ambientes distintos, realizar provisionamento com Terraform e demonstrar cenários de Drift e Reconciliação.

A solução apresentou bom nível de automação, reprodutibilidade e facilidade de manutenção, atendendo aos objetivos propostos pela atividade.

---

## 14. Referências

- https://www.terraform.io/
- https://kubernetes.io/
- https://kind.sigs.k8s.io/
- https://kustomize.io/
- https://argo-cd.readthedocs.io/
- https://docs.github.com/actions