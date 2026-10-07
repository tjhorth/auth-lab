terraform {
    backend "s3" {
        bucket = "terraform-s3-backend-horth"
        key = "state/terraform.tfstate"
        region = "us-east-1"
        encrypt = true
        use_lockfile = true
    }
}