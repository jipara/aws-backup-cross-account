output "vault" {
  value = aws_backup_vault.vault-souce.arn
}
output "backup_plan" {
  value = aws_backup_plan.EFS-to-DR.name
}
output "backup_rule" {
  value = aws_backup_plan.EFS-to-DR.rule
}
