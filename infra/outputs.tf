output "dev_namespace" {
  value = kubernetes_namespace.dev.metadata[0].name
}

output "hml_namespace" {
  value = kubernetes_namespace.hml.metadata[0].name
}