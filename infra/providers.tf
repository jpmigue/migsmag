provider "aws" {
  region = var.region
}

# CloudFront certificates MUST be in us-east-1 if you use a custom domain + ACM
provider "aws" {
  alias  = "use1"
  region = "us-east-1"
}
