backup_vault_name     = "source"
kms_key_arn           = "arn:aws:kms:us-east-1:var.source:key/63593a03-80bc-406e-9bff-9fc4ef2c8d22"
backup_plan_name      = "EFS-to-DR"
rule_name             = "tf_efs_backup_rule"
target_vault_name     = "source"
schedule              = "cron(0 12 * * ? *)"
destination_vault_arn = "arn:aws:backup:us-west-1:var.destination:backup-vault:us-west-1-destination-vault"
tags = {
  name        = "efs-with-terraform"
  environment = "test"
}
