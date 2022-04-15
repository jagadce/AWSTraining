#ALB
resource "aws_lb" "ALB" {
  name               = "ALB"
  internal           = false
  load_balancer_type = "application"
  subnets            = [aws_subnet.PrivateTrainingsubnet.id]
  enable_deletion_protection = true
  access_logs {
    bucket  = aws_s3_bucket.alb-bucket.bucket
    prefix  = "prod"
    enabled = true
  }

  tags = {
    Environment = "production"
  }
}
 
  #ALB Listener:
resource "aws_lb_listener" "_Listener" {
  load_balancer_arn = aws_lb.ALB.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = ""

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.front_end.arn
  }
}

#resource "aws_lb_listener_certificate" "listener_certificate" {
 # listener_arn    = aws_lb_listener.NLB_Listener.arn
  #certificate_arn = aws_acm_certificate.NLB.arn
#}

#Creating Target group 
resource "aws_lb_target_group" "NLBTargetGroup" {
  name        = "NLBTargetGroup"
  port        = 80
  protocol    = "TCP"
  target_type = "instance"
  vpc_id      = aws_vpc.Training.id
#resource "aws_vpc" "Training" {
 # cidr_block = "10.0.0.0/16"
#}
}

#Attaching Instance into Target group
resource "aws_lb_target_group_attachment" "NLB-Tragetgroup-Attach" {
  count = length(aws_instance.ALB-Instance)
 target_group_arn = aws_lb_target_group.NLBTargetGroup
  target_id = aws_instance.ALB-Instance[count.index].id 
port = 80        
 }


#Securtiy Group for ELB

resource "aws_security_group" "Secgrp_NLB" {
  name        = "Secgrp_NLB"
  description = "Secgrp for NLB"
  vpc_id      = aws_vpc.Training.id

  ingress {
    description      = "Accpet only 80Port"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
      }

  tags = {
    Name = "Secgrp_NLB"
  }
}

#Securtiy Group for Instance

resource "aws_security_group" "Secgrp_Instance" {
  name        = "Secgrp_Instance"
  description = "Secgrp for Instance"
  vpc_id      = aws_vpc.Training.id

  ingress {
    description      = "Accpet only ssh"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  
  }
 ingress {
    description      = "Accpet only 80 port from ELB"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]  
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
      }

  tags = {
    Name = "Secgrp_Instance"
  }
}

output "dns_name" {
    value = aws_lb.NLB.dns_name  
}
