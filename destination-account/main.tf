terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.59.0"
    }
  }
}

provider "aws" {
  region  = "us-west-1"
  profile = "dr-recovery"
}

resource "aws_backup_vault" "vault_destination" {
  name        = var.backup_vault
  kms_key_arn = var.kms_key_arn
}

resource "aws_backup_vault_policy" "destination" {
  backup_vault_name = aws_backup_vault.vault_destination.name

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": "*",
            "Action": "backup:CopyIntoBackupVault",
            "Resource": "*",
            "Condition": {
                "StringEquals": {
                    "aws:PrincipalOrgID": "o-4qsnsdafc3"
                }
            }
        }
    ]
}
POLICY
}

data "aws_backup_vault" "vault_destination_data" {
  name = "us-west-1-destination-vault"
}
output "vault_destination_data" {
  value = data.aws_backup_vault.vault_destination_data.arn
}

