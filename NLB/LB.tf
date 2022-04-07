resource "aws_lb" "NLB" {
  name               = "NLB"
  internal           = false
  load_balancer_type = "network"
  subnets            = [aws_subnet.PublicTrainingsubnet.id]
  security_groups = [aws_security_group.Secgrp_Instance.id]
  enable_deletion_protection = true

    tcp_enabled                             = true
    access_logs_enabled                     = true
  #description = "A boolean flag to enable/disable cross zone load balancing"
    cross_zone_load_balancing_enabled       = true
    ip_address_type                         = "ipv4"
#description = "The amount of time to wait in seconds before changing the state of a deregistering target to unused"
    deregistration_delay                    = 15
    health_check_enabled                    = true
    health_check_port                       = 80
    health_check_protocol                   = tcp
#description = "The number of consecutive health checks successes required before considering an unhealthy target healthy, or failures required before considering a health target unhealthy"
    health_check_healthy_threshold          = 2
    health_check_unhealthy_threshold        = 2
# description = "The duration in seconds in between health checks"
    health_check_interval                   = 10
   

  tags = {
    Environment = "production"
  }
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
    security_groups = [aws_security_group.Secgrp_NLB.id]
  
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

