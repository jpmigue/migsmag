# migsmag

Personal project used to build and automate a static website on AWS.

The project uses:

- Hugo for static site generation
- Terraform for AWS infrastructure
- S3 for private site storage
- CloudFront with Origin Access Control
- Route 53 and ACM for DNS and TLS
- GitHub Actions for CI/CD
- GitHub OIDC for AWS authentication without stored AWS credentials
- Remote Terraform state with DynamoDB locking

The deployment workflow builds the Hugo site, synchronises the generated
content to S3 and invalidates the CloudFront cache.

Infrastructure changes are managed separately through a Terraform workflow.
