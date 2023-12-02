# Deploy an https static website with AWS S3 and Cloudfront

## Aim of this project

The goal is to deploy automatically, via terraform, a static website hosted on S3, with https and a custom domain name. You can also manually do it from here:
<https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/getting-started-s3.html>

## Important Note

CAREFUL: if you want your own custom domain name, you'll need to register a domain name and a bucket that has exactly the same name for this to work. \
(Ex: registering domain name "mysuperwebsite.com", you'll also need to get the buckets "mysuperwebsite.com" and "www.mysuperwebsite.com")
Make sure that both the Route53 domain name and S3 bucket names are not already taken. \

## Manual steps

Register a domain with route 53 (ex: mysuperwebsite.com). You will have to pay for it. \
<https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/domain-register.html>

## S3 Buckets

The S3 bucket(s) will contain the website static data. \
This terraform will automatically create the corresponding S3 buckets based on the Domain name you provided in the user_input.tfvars. \
If you have already manually created them: no problem, we will import them into terraform (see steps below...) \

## Pre-requisites

- Terraform must be installed
- You must have registered an AWS account
- You should have registered a domain name on AWS Route53
- You must have an AWS authentication method in place (via an AWS Profile or Environment variables or use hardcoded credentials in the provider.tf file).
More information here -> <https://registry.terraform.io/providers/hashicorp/aws/latest/docs>

## Enter your website info in user_input.tfvars

In the user_input.tfvars file: \

- aws_region: enter the region where you want your website to be hosted (leave eu-west-1 otherwise)
- domain_name: enter the domain name you got in Route53 and under which you want to host the website.

```tf title="user_input.tfvars"
aws_region  = "eu-west-1"
domain_name = "mysuperwebsite.com"
```

## Setup your authentication in providers.tf

If you are using AWS cli and already have an AWS profile (a file 'credentials' in a ~/.aws folder) you can de-comment the profile and use your profile there.  \
Otherwise you can set the environment variables AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY with your AWS key credentials.  \
Otherwise you can also (not the most recommended method) hardcode your credentials in this file under access_key and secret_key. Don't forget to de-comment the lines. \

```tf title="providers.tf"
  # Authentication: [1] use AWS CLI profile or [2] env variable (AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY) or [3] enter hardcoded credentials below
  # profile = var.aws_profile
  # access_key = "your_aws_access_key"
  # secret_key = "your_aws_secret_access_key"
```

!!! Note "Note"
If you use the profile or the hardcoded credentials, don't forget to uncomment the wanted line(s) for the 2 providers in this file.

## Deploying the website with Terraform

Enter your custom values and authentication method in user_input.tfvars.

Execute the following commands in this project folder:

```tf
terraform init
```

Note: if you have already manually created your S3 buckets, you will need to import them in terraform:

```tf
terraform import 'aws_s3_bucket.website_root_domain' name-of-your-root-bucket # (ex: mysuperwebsite.com)
terraform import 'aws_s3_bucket.website_subdomain' name-of-your-subdomain-bucket # (ex: www.mysuperwebsite.com)
```

Then:

```tf
terraform apply --var-file=user_input.tfvars
```

If you like what you see, you can enter 'yes'.
