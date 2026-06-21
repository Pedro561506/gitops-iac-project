terraform {
  required_version = ">= 1.5.0"
}

resource "local_file" "inventory" {
  filename = "${path.module}/inventory.txt"

  content = <<EOT
Projeto: GitOps IaC
Cluster: kind-gitops-lab
Ambientes: dev e hml
Ferramentas: Terraform, Kubernetes, Kustomize, Argo CD e GitHub Actions
EOT
}