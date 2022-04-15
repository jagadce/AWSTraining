#ALB
resource "aws_lb" "ALB" {
  name               = "ALB"
  internal           = false
  load_balancer_type = "application"
  subnets            = [aws_subnet.PrivateTrainingsubnet.id]
  enable_deletion_protection = true
  #access_logs {
    #bucket  = aws_s3_bucket.alb-bucket.bucket
    #prefix  = "prod"
    #enabled = true
  #}

  tags = {
    Environment = "production"
  }
}
 
  #ALB Listener:
resource "aws_lb_listener" "ALB_Listener" {
  load_balancer_arn = aws_lb.ALB.arn
  port              = "80"
  protocol          = "HTTP"
  #ssl_policy        = "ELBSecurityPolicy-2016-08"
  #certificate_arn   = ""

  default_action {
    type             = "redirect"
    target_group_arn = aws_lb_target_group.front_end.arn
  }
}

resource "aws_lb_listener_rule" "redirect_http_to_https" {
  listener_arn = aws_lb_listener.ALB_Listener.arn

  action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}
#resource "aws_lb_listener_certificate" "listener_certificate" {
 # listener_arn    = aws_lb_listener.NLB_Listener.arn
  #certificate_arn = aws_acm_certificate.NLB.arn
#}

#Creating Target group 
resource "aws_lb_target_group" "ALBTargetGroup" {
  name        = "ALBTargetGroup"
  port        = 80
  protocol    = "TCP"
  target_type = "instance"
  vpc_id      = aws_vpc.Training.id
}

#Attaching Instance into Target group
resource "aws_lb_target_group_attachment" "NLB-Tragetgroup-Attach" {
  count = length(aws_instance.ALB-Instance)
 target_group_arn = aws_lb_target_group.ALBTargetGroup
  target_id = aws_instance.ALB-Instance[count.index].id 
port = 80        
 }


#Securtiy Group for ALB

resource "aws_security_group" "Secgrp_ALB" {
  name        = "Secgrp_ALB"
  description = "Secgrp for ALB"
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
    cidr_blocks      = ["177.249.220.178/30"]
  
  }
 ingress {
    description      = "Accpet only 80 port from ALB"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["177.249.220.178/30"]  
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
    value = aws_lb.ALB.dns_name  
}
