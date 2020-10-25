# sg for elb
resource "aws_security_group" "elb" {
  name = "steeleye"

  ingress {
    from_port   = 8484
    to_port     = 8484
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# elb definition
resource "aws_elb" "example" {
  name               = "steeleye"
  availability_zones = ["eu-west-1b", "eu-west-1a"]
#  availability_zones = ["eu-west-1b"]
  security_groups    = [aws_security_group.elb.id]

# Listener
  listener {
    lb_port           = 8484
    lb_protocol       = "http"
    instance_port     = 8484
    instance_protocol = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 30
    target              = "HTTP:8484/"
  }
#  instances                   = ["aws_instance.myInstance[0].id", "aws_instance.myInstance[1].id"]
#  instances                   = [aws_instance.myInstance[count.index].id]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

}
# Instances attachment to elb
resource "aws_elb_attachment" "myattach" {
  count = 2
  elb = aws_elb.example.id
  instance = element(list(aws_instance.myInstance[count.index].id), count.index)
}
# Output the elb dns name
output "elb_dns_name" {
  value = aws_elb.example.dns_name
}