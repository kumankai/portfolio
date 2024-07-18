data "aws_route53_zone" "hosted_zone" {
  name = "jacobangga.com"
}

# Create record set in route 53
resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.hosted_zone.zone_id
  name    = "www.jacobangga.com"
  type    = "A"
  ttl     = 300
  records = [aws_instance.myportfolio.public_ip]
}
