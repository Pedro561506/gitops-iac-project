# GitOps IaC Project

Projeto acadêmico desenvolvido para demonstrar os conceitos de Infrastructure as Code (IaC) e GitOps utilizando Terraform, Kubernetes, Kustomize e GitHub Actions.

---

## Objetivo

Implementar uma esteira GitOps completa capaz de:

- Versionar infraestrutura e aplicações;
- Validar alterações automaticamente;
- Aplicar configurações declarativas;
- Criar ambientes DEV e HML;
- Garantir políticas básicas de segurança;
- Demonstrar Drift e Rollback;
- Automatizar verificações utilizando GitHub Actions.

---

## Tecnologias Utilizadas

| Tecnologia | Função |
|------------|-------|
| Git | Versionamento |
| GitHub | Repositório remoto |
| GitHub Actions | Pipeline CI |
| Terraform | Provisionamento |
| Kubernetes | Orquestração |
| Kind | Cluster local |
| Kustomize | Gerenciamento de ambientes |
| Docker | Containers |
| Nginx | Aplicação exemplo |

---

## Estrutura do Projeto

```text
gitops-iac-project/

├── .github/
│   └── workflows/
│       └── ci.yml

├── app/
│   ├── Dockerfile
│   └── index.html

├── docs/
│   ├── arquitetura.md
│   ├── relatorio.md
│   └── rollback-drift.md

├── infra/
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf

├── k8s/
│   ├── base/
│   │   ├── deployment.yaml
│   │   ├── service.yaml
│   │   └── kustomization.yaml
│   │
│   └── overlays/
│       ├── dev/
│       │   └── kustomization.yaml
│       │
│       └── hml/
│           └── kustomization.yaml

├── .gitignore

└── README.md
```

---

## Arquitetura

O projeto segue o fluxo GitOps:

```text
+----------------+
|     GitHub     |
| Repositório IaC|
+-------+--------+
        |
        |
   Pull Request
        |
        v

+----------------+
| GitHub Actions |
| CI / Validação |
+-------+--------+
        |
        |
   Merge Main
        |
        v

+----------------+
|     GitOps     |
|   Kustomize    |
+-------+--------+
        |
  +-----+-----+
  |           |
  v           v

+------+   +------+
| DEV  |   | HML  |
+------+   +------+

Terraform cria namespaces
Kubernetes aplica manifests
```

---

## Provisionamento Terraform

O Terraform é responsável pela criação dos namespaces Kubernetes:

- Namespace DEV
- Namespace HML

Inicialização:

```bash
cd infra

terraform init
```

Planejamento:

```bash
terraform plan
```

Aplicação:

```bash
terraform apply
```

Verificar namespaces:

```bash
kubectl get ns
```

Resultado esperado:

```text
dev      Active
hml      Active
```

---

## Kubernetes

Aplicação exemplo utilizando:

- Deployment
- Service
- ClusterIP

Aplicar ambiente DEV:

```bash
kubectl apply -k k8s/overlays/dev
```

Aplicar ambiente HML:

```bash
kubectl apply -k k8s/overlays/hml
```

Verificar:

```bash
kubectl get deployments

kubectl get pods

kubectl get services
```

---

## Ambientes

### DEV

Características:

- Prefixo: `dev-`
- Réplicas: `1`

Aplicação:

```bash
kubectl apply -k k8s/overlays/dev
```

---

### HML

Características:

- Prefixo: `hml-`
- Réplicas: `2`

Aplicação:

```bash
kubectl apply -k k8s/overlays/hml
```

---

## Pipeline CI

A pipeline foi implementada com GitHub Actions.

Valida:

### Terraform

- terraform init
- terraform validate

### Kubernetes

Valida:

- deployment.yaml
- service.yaml
- kustomization.yaml

---

## Política de Segurança

Foi implementada uma política simples:

### Bloqueio de NodePort

Caso algum manifesto contenha:

```yaml
type: NodePort
```

O pipeline falha automaticamente.

Exemplo:

```bash
NodePort não permitido

exit 1
```

---

## Fluxo GitOps

Fluxo adotado:

1. Criar branch

```bash
git checkout -b feature-x
```

2. Realizar alterações

3. Commit

```bash
git add .

git commit -m "feat: altera recurso"
```

4. Push

```bash
git push
```

5. Criar Pull Request

6. Pipeline executa validações

7. Merge para main

8. Estado desejado atualizado.

---

## Drift

Foi realizado um drift manual alterando a quantidade de réplicas.

Comando:

```bash
kubectl scale deployment gitops-app --replicas=3
```

Resultado:

```text
gitops-app  3/3
```

O estado ficou diferente do definido no Git.

---

## Reconciliação

Para restaurar o estado desejado:

```bash
kubectl apply -k k8s/overlays/dev
```

Resultado:

```text
deployment.apps/gitops-app configured
```

As réplicas retornam para o valor definido no repositório.

---

## Rollback

Rollback utilizando Git:

```bash
git log --oneline
```

Selecionar commit:

```bash
git revert <hash>
```

Enviar alteração:

```bash
git push
```

Dessa forma o ambiente retorna para uma versão anterior registrada no histórico.

---

## Inventário dos Recursos

Recursos criados:

### Cluster

- kind cluster
- Nome: gitops-lab

### Namespaces

- dev
- hml

### Deployments

- gitops-app
- hml-gitops-app

### Services

- gitops-app-service
- hml-gitops-app-service

### Pipeline

- GitHub Actions

### Terraform

- kubernetes_namespace.dev
- kubernetes_namespace.hml

---

## Limpeza do Ambiente

Remover recursos Kubernetes:

```bash
kubectl delete -k k8s/overlays/dev

kubectl delete -k k8s/overlays/hml
```

Destruir Terraform:

```bash
cd infra

terraform destroy
```

Excluir cluster:

```bash
kind delete cluster --name gitops-lab
```

---

## Pull Requests

Foram realizados Pull Requests simulando fluxo GitOps:

- Atualização do README;
- Atualização do relatório;
- Alterações documentadas com merge para main.

---

## Autor

Pedro Gonçalves
RM561506

Projeto desenvolvido individualmente para a disciplina de Infrastructure as Code (GitOps), utilizando ambiente local controlado e práticas seguras de desenvolvimento.