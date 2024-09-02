resource "aws_route53_record" "hostname" {
  zone_id = data.aws_route53_zone.public.id
  name    = local.route53_name
  type    = "CNAME"
  ttl     = 60

  records = [
    aws_instance.ec2.private_dns
  ]
}
