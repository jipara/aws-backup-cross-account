terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.59.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"


  # assume_role {
  #   role_arn = var.assume_role_arn
  #   external_id = var.external_id
  # }
}




resource "aws_backup_vault" "vault-souce" {
  name        = var.backup_vault_name
  kms_key_arn = var.kms_key_arn
  tags        = var.tags
}

resource "aws_backup_vault_policy" "allow-policy" {
  backup_vault_name = aws_backup_vault.vault-souce.name

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "Allow var.destination to copy into source",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::var.destination:root"
            },
            "Action": "backup:CopyIntoBackupVault",
            "Resource": "*"
        }
    ]
}
POLICY
}
resource "aws_backup_plan" "EFS-to-DR" {
  name = var.backup_plan_name

  rule {
    rule_name         = var.rule_name
    target_vault_name = var.target_vault_name
    schedule          = var.schedule
    copy_action {
      destination_vault_arn = var.destination_vault_arn
    }
  }
}
resource "aws_backup_selection" "example" {
  iam_role_arn = "arn:aws:iam::var.source:role/service-role/AWSBackupDefaultServiceRole"
  name         = "AWSServiceRoleForBackup"
  plan_id      = aws_backup_plan.EFS-to-DR.id

  resources = [
    "arn:aws:elasticfilesystem:us-east-1:var.source:file-system/fs-463b39f2"
  ]
}

