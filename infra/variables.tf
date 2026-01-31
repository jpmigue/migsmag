variable "region" {
  type    = string
  default = "eu-west-1"
}

variable "project" {
  type    = string
  default = "migsmag"
}

variable "bucket_name" {
  type        = string
  description = "S3 bucket name for Hugo SSG site content"
}

variable "domain_name" {
  type        = string
  description = "Apex domain name of website"
}

variable "hosted_zone_id" {
  type        = string
  description = "Route 53 Hosted Zone ID for domain_name"
}
