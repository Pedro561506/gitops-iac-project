output "inventory_file" {
  description = "Arquivo de inventário gerado pelo Terraform"
  value       = local_file.inventory.filename
}