# DEPLOY AN HTTPS STATIC WEBSITE WITH AWS S3 AND CLOUDFRONT

## AIM OF THIS PROJECT

The goal is to deploy via terraform a static website hosted on S3. You can also manually do it from here:
<https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/getting-started-s3.html>

## IMPORTANT NOTE

CAREFULL: you will need to register a domain name and create a bucket with the same name for this to work. \
Make sure that both the Route53 domain name and S3 bucket name are not already taken. \

In case you dont want a proper domain name, just remove the route_53.tf file from the project. Instead your website will be available behind a cloudfront url (ex: <https://d111111abcdef8.cloudfront.net>)

## Manual steps

Register a domain with route 53 (ex: mysite.com). You will have to pay for it.
<https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/domain-register.html>

## S3 Buckets

The S3 bucket(s) will contain the website static data.
This terraform will automatically create the corresponding S3 buckets based on the Domain name you provided in the user_input.tfvars.
If you have already manually created them: no problem, we will import them into terraform (see below...)

## Terraform steps

Enter your custom values in user_input.tfvars. Then:

```tf
terraform init
```

Note: if you have already manually created your S3 buckets, you will need to import them in terraform:

```tf
terraform import 'aws_s3_bucket.website_root_domain' name-of-your-root-bucket # (ex: mywebsite.com)
terraform import 'aws_s3_bucket.website_subdomain' name-of-your-subdomain-bucket # (ex: www.mywebsite.com)
```

Then:

```tf
terraform apply --var-file=user_input.tfvars
```

If you like what you see, you can enter 'yes'.
