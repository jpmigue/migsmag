terraform {
  backend "s3" {
    bucket         = "migsmag-tfstate"
    key            = "migsmag/infra/terraform.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "migsmag-tfstate-lock"
    encrypt        = true
  }
}
