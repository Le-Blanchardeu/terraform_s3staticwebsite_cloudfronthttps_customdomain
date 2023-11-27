data "aws_route53_zone" "website_domain" {
  name = "${var.domain_name}."
}

# Pointing your domain name to your cloudfront distribution
resource "aws_route53_record" "website_rootdomain" {
  zone_id = data.aws_route53_zone.website_domain.zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.website_rootdomain.domain_name
    zone_id                = aws_cloudfront_distribution.website_rootdomain.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "website_subdomain" {
  zone_id = data.aws_route53_zone.website_domain.zone_id
  name    = "www.${var.domain_name}"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.website_subdomain.domain_name
    zone_id                = aws_cloudfront_distribution.website_subdomain.hosted_zone_id
    evaluate_target_health = false
  }
}