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

resource "null_resource" "example1" {
  provisioner "local-exec" {
    command     = "backup.sh"
    interpreter = ["sh"]
  }
}
