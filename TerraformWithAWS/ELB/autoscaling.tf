#Auto scaling Lauch Configuration
resource "aws_launch_configuration" "Autoscaling" {
  name_prefix   = "Autoscaling"
  image_id      = "ami-0454207e5367abf01"
  instance_type = "t2.micro"
  key_name = aws_key_pair.Training_Key.key_name
  security_groups = [aws_security_group.Secgrp_Instance.id]
}

resource "aws_key_pair" "Training_Key" {
  key_name   = "Training_Key"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
 }

#Create Autoscaling Group
resource "aws_autoscaling_group" "Autoscaling_Group" {
  name                 = "Autoscaling_Group"
  vpc_zone_identifier =  [aws_subnet.PrivateTrainingsubnet.id, aws_subnet.PrivateTrainingsubnet1.id]
  launch_configuration = aws_launch_configuration.Autoscaling.name
  min_size             = 2
  max_size             = 2
  health_check_grace_period = 200
  health_check_type         = "ELB"
  load_balancers = [aws_elb.ELB.name]
  force_delete              = true

  tag {
    key                 = "LB"
    value               = "AutoscalingMachine via load bancer"
    propagate_at_launch = true
  }

}

output "ELB" {
value = aws_elb.ELB.dns_name  
}