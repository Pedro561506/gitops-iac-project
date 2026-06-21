# Drift e Rollback

## Experimento de Drift

Foi realizado um drift manual no ambiente Kubernetes alterando a quantidade de réplicas do deployment.

Comando executado:

```bash
kubectl scale deployment gitops-app --replicas=3
```

Resultado observado:

```text
gitops-app   3/3
```

Esse estado ficou diferente do estado desejado definido no repositório Git.

## Reconciliação

Para restaurar o estado desejado, foi aplicado novamente o manifesto do ambiente DEV:

```bash
kubectl apply -k k8s/overlays/dev
```

Resultado:

```text
deployment.apps/gitops-app configured
```

## Rollback

O rollback pode ser realizado utilizando Git:

```bash
git log --oneline
git revert <hash-do-commit>
git push
```

Dessa forma, o ambiente retorna para uma versão anterior registrada no histórico do repositório.