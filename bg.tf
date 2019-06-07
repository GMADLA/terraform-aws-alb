resource "aws_security_group_rule" "prod_ingress" {
  count             = "${var.blue_green_enabled == "true" ? 1 : 0}"
  type              = "ingress"
  from_port         = "${var.prod_port}"
  to_port           = "${var.prod_port}"
  protocol          = "tcp"
  cidr_blocks       = ["${var.prod_ingress_cidr_blocks}"]
  prefix_list_ids   = ["${var.prod_ingress_prefix_list_ids}"]
  security_group_id = "${aws_security_group.default.id}"
}

resource "aws_security_group_rule" "test_ingress" {
  count             = "${var.blue_green_enabled == "true" ? 1 : 0}"
  type              = "ingress"
  from_port         = "${var.test_port}"
  to_port           = "${var.test_port}"
  protocol          = "tcp"
  cidr_blocks       = ["${var.test_ingress_cidr_blocks}"]
  prefix_list_ids   = ["${var.test_ingress_prefix_list_ids}"]
  security_group_id = "${aws_security_group.default.id}"
}

module "blue_target_group_label" {
  source     = "git::https://github.com/cloudposse/terraform-terraform-label.git?ref=tags/0.1.6"
  attributes = "${concat(var.attributes, list("blue"))}"
  delimiter  = "${var.delimiter}"
  name       = "${var.name}"
  namespace  = "${var.namespace}"
  stage      = "${var.stage}"
  tags       = "${var.tags}"
}

module "green_target_group_label" {
  source     = "git::https://github.com/cloudposse/terraform-terraform-label.git?ref=tags/0.1.6"
  attributes = "${concat(var.attributes, list("green"))}"
  delimiter  = "${var.delimiter}"
  name       = "${var.name}"
  namespace  = "${var.namespace}"
  stage      = "${var.stage}"
  tags       = "${var.tags}"
}

resource "aws_lb_target_group" "blue" {
  count                = "${var.blue_green_enabled == "true" ? 1 : 0}"
  name                 = "${module.blue_target_group_label.id}"
  port                 = "80"
  protocol             = "HTTP"
  vpc_id               = "${var.vpc_id}"
  target_type          = "ip"
  deregistration_delay = "${var.deregistration_delay}"

  health_check {
    path                = "${var.health_check_path}"
    timeout             = "${var.health_check_timeout}"
    healthy_threshold   = "${var.health_check_healthy_threshold}"
    unhealthy_threshold = "${var.health_check_unhealthy_threshold}"
    interval            = "${var.health_check_interval}"
    matcher             = "${var.health_check_matcher}"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_target_group" "green" {
  count                = "${var.blue_green_enabled == "true" ? 1 : 0}"
  name                 = "${module.green_target_group_label.id}"
  port                 = "80"
  protocol             = "HTTP"
  vpc_id               = "${var.vpc_id}"
  target_type          = "ip"
  deregistration_delay = "${var.deregistration_delay}"

  health_check {
    path                = "${var.health_check_path}"
    timeout             = "${var.health_check_timeout}"
    healthy_threshold   = "${var.health_check_healthy_threshold}"
    unhealthy_threshold = "${var.health_check_unhealthy_threshold}"
    interval            = "${var.health_check_interval}"
    matcher             = "${var.health_check_matcher}"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_listener" "prod" {
  count             = "${var.blue_green_enabled == "true" ? 1 : 0}"
  load_balancer_arn = "${aws_lb.default.arn}"

  port            = "${var.prod_port}"
  protocol        = "HTTP"

  default_action {
    target_group_arn = "${aws_lb_target_group.blue.arn}"
    type             = "forward"
  }
}

resource "aws_lb_listener" "test" {
  count             = "${var.blue_green_enabled == "true" ? 1 : 0}"
  load_balancer_arn = "${aws_lb.default.arn}"

  port            = "${var.test_port}"
  protocol        = "HTTP"

  default_action {
    target_group_arn = "${aws_lb_target_group.green.arn}"
    type             = "forward"
  }
}
