#ALB
resource "aws_lb" "ALB" {
  name               = "ALB"
  internal           = false
  load_balancer_type = "application"
  subnets            = [aws_subnet.PrivateTrainingsubnet.id,aws_subnet.PrivateTrainingsubnet1.id]
  enable_deletion_protection = true
   

  tags = {
    Environment = "production"
  }
}
 
  #ALB Listener:
#ssl cert generate: openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/apache2/apache2.crt -keyout /etc/apache2/apache2.key
resource "aws_lb_listener" "ALB_Listener" {
  load_balancer_arn = aws_lb.ALB.arn
    port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "arn:aws:acm:us-west-1:672021480727:certificate/8189bae4-5174-47f8-957d-febb35a671f4"
  
  #default_action {
 # type             = "forward"
  # target_group_arn = aws_lb_target_group.ALBTargetGroup.arn
  #}
  
   default_action {
    type = "forward"
target_group_arn = aws_lb_target_group.ALBTargetGroup.arn
    redirect {
     port        = "443"
      protocol    = "HTTPS"
     status_code = "HTTP_301"
        }
   }
}
 

#resource "aws_lb_listener_rule" "redirect_http_to_https" {
 # listener_arn = aws_lb_listener.ALB_Listener.arn

  #action {
   # type = "redirect"

    #redirect {
     # port        = "443"
      #protocol    = "HTTPS"
    #  status_code = "HTTP_301"
    #}
  #}
#}

#resource "aws_lb_listener_certificate" "listener_certificate" {
#listener_arn    = aws_lb_listener.ALB_Listener.arn
#certificate_arn = "arn:aws:acm:us-west-1:672021480727:certificate/73b745ba-45e4-4539-a92f-6a108adec58e"
 #}

#Creating Target group 
resource "aws_lb_target_group" "ALBTargetGroup" {
  name        = "ALBTargetGroup"
  port        = 443
  protocol    = "HTTPS"
  target_type = "instance"
  vpc_id      = aws_vpc.Training.id
    health_check {
    port     = 443
    protocol = "HTTPS"
    path = "/var/www/html/index.html"
  }
}


#Attaching Instance into Target group
resource "aws_lb_target_group_attachment" "ALB-Tragetgroup-Attach" {
  count = length(aws_instance.ALB-Instance)
 target_group_arn = aws_lb_target_group.ALBTargetGroup.arn
  target_id = aws_instance.ALB-Instance[count.index].id 
port = 443        
 }


#Securtiy Group for ALB

resource "aws_security_group" "Secgrp_ALB" {
  name        = "Secgrp_ALB"
  description = "Secgrp for ALB"
  vpc_id      = aws_vpc.Training.id

  ingress {
    description      = "Accpet only 80Port"
    from_port        = 443
    to_port          = 443
    protocol         = "TCP"
    cidr_blocks      = ["0.0.0.0/0"]
  
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
      }

  tags = {
    Name = "Secgrp_ALB"
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
    cidr_blocks      = ["177.249.220.176/30"]
  
  }
 ingress {
    description      = "Accpet only 443 port from ALB"
    from_port        = 443
    to_port          = 443
    protocol         = "TCP"
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
    value = aws_lb.ALB.dns_name  
}
