
## Modules

| Name | Source | Version |
|------|--------|---------|
| access_logs | cloudposse/lb-s3-bucket/aws | 0.10.0 |
| default_target_group_label | cloudposse/label/null | 0.22.1 |
| this | cloudposse/label/null | 0.22.1 |

## Resources

| Name |
|------|
| [aws_lb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) |
| [aws_lb_listener](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) |
| [aws_lb_listener_certificate](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_certificate) |
| [aws_lb_target_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) |
| [aws_security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) |
| [aws_security_group_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| access_logs_enabled | A boolean flag to enable/disable access_logs | string | `true` | no |
| access_logs_prefix | The S3 bucket prefix | string | `` | no |
| access_logs_region | The region for the access_logs S3 bucket | string | `us-east-1` | no |
| access_logs_bucket_name | Bucket name (not recommended, legacy support only.) | string | `` | no |
| attributes | Additional attributes, e.g. `1` | list | `<list>` | no |
| certificate_arn | The ARN of the default SSL certificate for HTTPS listener | string | `` | no |
| cross_zone_load_balancing_enabled | A boolean flag to enable/disable cross zone load balancing | string | `true` | no |
| deletion_protection_enabled | A boolean flag to enable/disable deletion protection for ALB | string | `false` | no |
| delimiter | Delimiter to be used between `namespace`, `name`, `stage` and `attributes` | string | `-` | no |
| deregistration_delay | The amount of time to wait in seconds before changing the state of a deregistering target to unused | string | `15` | no |
| health_check_healthy_threshold | The number of consecutive health checks successes required before considering an unhealthy target healthy | string | `2` | no |
| health_check_interval | The duration in seconds in between health checks | string | `15` | no |
| health_check_matcher | The HTTP response codes to indicate a healthy check | string | `200-399` | no |
| health_check_path | The destination for the health check request | string | `/` | no |
| health_check_timeout | The amount of time to wait in seconds before failing a health check request | string | `10` | no |
| health_check_unhealthy_threshold | The number of consecutive health check failures required before considering the target unhealthy | string | `2` | no |
| http2_enabled | A boolean flag to enable/disable HTTP/2 | string | `true` | no |
| http_enabled | A boolean flag to enable/disable HTTP listener | string | `true` | no |
| http_ingress_cidr_blocks | List of CIDR blocks to allow in HTTP security group | list | `<list>` | no |
| http_ingress_prefix_list_ids | List of prefix list IDs for allowing access to HTTP ingress security group | list | `<list>` | no |
| http_port | The port for the HTTP listener | string | `80` | no |
| https_enabled | A boolean flag to enable/disable HTTPS listener | string | `false` | no |
| https_ingress_cidr_blocks | List of CIDR blocks to allow in HTTPS security group | list | `<list>` | no |
| https_ingress_prefix_list_ids | List of prefix list IDs for allowing access to HTTPS ingress security group | list | `<list>` | no |
| https_port | The port for the HTTPS listener | string | `443` | no |
| test_enabled | A boolean flag to enable/disable Blue/Green listeners | string | `false` | no |
| test_ingress_cidr_blocks | List of CIDR blocks to allow in test security group | list | `<list>` | no |
| test_ingress_prefix_list_ids | List of prefix list IDs for allowing access to test ingress security group | list | `<list>` | no |
| test_port | The port for the test listener | string | `8080` | no |
| idle_timeout | The time in seconds that the connection is allowed to be idle | string | `60` | no |
| internal | A boolean flag to determine whether the ALB should be internal | string | `false` | no |
| ip_address_type | The type of IP addresses used by the subnets for your load balancer. The possible values are `ipv4` and `dualstack`. | string | `ipv4` | no |
| name | Solution name, e.g. `app` | string | - | yes |
| namespace | Namespace, which could be your organization name, e.g. `cp` or `cloudposse` | string | - | yes |
| security_group_ids | A list of additional security group IDs to allow access to ALB | list | `<list>` | no |
| stage | Stage, e.g. `prod`, `staging`, `dev`, or `test` | string | - | yes |
| subnet_ids | A list of subnet IDs to associate with ALB | list | - | yes |
| tags | Additional tags (e.g. `map(`BusinessUnit`,`XYZ`) | map | `<map>` | no |
| vpc_id | VPC ID to associate with ALB | string | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| access\_logs\_bucket\_id | The S3 bucket ID for access logs |
| alb\_arn | The ARN of the ALB |
| alb\_arn\_suffix | The ARN suffix of the ALB |
| alb\_dns\_name | DNS name of ALB |
| alb\_name | The ARN suffix of the ALB |
| alb\_zone\_id | The ID of the zone which ALB is provisioned |
| default\_target\_group\_arn | The default target group ARN |
| http\_listener\_arn | The ARN of the HTTP forwarding listener |
| http\_redirect\_listener\_arn | The ARN of the HTTP to HTTPS redirect listener |
| https\_listener\_arn | The ARN of the HTTPS listener |
| listener\_arns | A list of all the listener ARNs |
| security\_group\_id | The security group ID of the ALB |
<!-- markdownlint-restore -->
