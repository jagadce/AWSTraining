resource "aws_lb" "NLB" {
  name               = "NLB"
  internal           = false
  load_balancer_type = "network"
  subnets            = [aws_subnet.PublicTrainingsubnet.id]
# security_groups = [aws_security_group.Secgrp_Instance.id]
  enable_deletion_protection = true
  
     tags = { 
    Environment = "production"
  }
}  

#Creating NLB Listener:
#resource "aws_lb_listener" "NLB_Listener" {
# load_balancer_arn = aws_lb.NLB.arn
#  port              = "80"
#  protocol          = "TLS"
#  certificate_arn   = "arn:aws:iam::672021480727:user/AWS-Admin"
#  alpn_policy       = "HTTP2Preferred"

#  default_action {
#  type             = "forward"
#   target_group_arn = aws_lb_target_group.NLBTargetGroup.arn
#  }
#}

#resource "aws_lb_listener_certificate" "listener_certificate" {
 # listener_arn    = aws_lb_listener.NLB_Listener.arn
 # certificate_arn = aws_acm_certificate.example.arn
#}

#Creating Target group 
resource "aws_lb_target_group" "NLBTargetGroup" {
  name        = "NLBTargetGroup"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = aws_vpc.Training.id

}
#resource "aws_vpc" "Training" {
 # cidr_block = "10.0.0.0/16"
#}

#Attaching Instance into Target group
resource "aws_lb_target_group_attachment" "NLB-Tragetgroup-Attach" {
  target_group_arn = aws_lb_target_group.NLBTargetGroup.arn
  Load_balancer = aws_lb.NLB.arn
  target_id = "i-0fe03e25171373c7e"
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

