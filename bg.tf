resource "aws_security_group_rule" "test_ingress" {
  count             = "${var.test_enabled == "true" ? 1 : 0}"
  type              = "ingress"
  from_port         = "${var.test_port}"
  to_port           = "${var.test_port}"
  protocol          = "tcp"
  cidr_blocks       = ["${var.test_ingress_cidr_blocks}"]
  prefix_list_ids   = ["${var.test_ingress_prefix_list_ids}"]
  security_group_id = "${aws_security_group.default.id}"
}

resource "aws_lb_listener" "test" {
  count             = "${var.test_enabled == "true" ? 1 : 0}"
  load_balancer_arn = "${aws_lb.default.arn}"

  port            = "${var.test_port}"
  protocol        = "HTTP"

  default_action {
    target_group_arn = "${aws_lb_target_group.default.arn}"
    type             = "forward"
  }
}
