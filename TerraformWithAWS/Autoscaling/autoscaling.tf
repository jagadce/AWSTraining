resource "aws_key_pair" "Training_Key1" {
  key_name   = "Training_Key"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
 }

#Auto scaling Lauch Configuration
resource "aws_launch_configuration" "Autoscaling" {
  name_prefix   = "Autoscaling"
  image_id      = "ami-0454207e5367abf01"
  instance_type = "t2.micro"
key_name = aws_key_pair.Training_Key1.key_name
}


#Create Autoscaling Group
resource "aws_autoscaling_group" "Autoscaling_Group" {
  name                 = "Autoscaling_Group"
  vpc_zone_identifier = ["us-west-1a","us-west-1b"]
  launch_configuration = aws_launch_configuration.Autoscaling.name
  min_size             = 1
  max_size             = 2
  health_check_grace_period = 200
  health_check_type         = "EC2"
  force_delete              = true

  tag {
    key                 = "Name"
    value               = "AutoscalingMachine"
    propagate_at_launch = true
  }

}

#Create Autoscaling Policy
resource "aws_autoscaling_policy" "scalingpolicy" {
  name                   = "scalingpolicy"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 200
  autoscaling_group_name = aws_autoscaling_group.Autoscaling_Group.name
}

#Create Autoscaling cloud watch monitoring
resource "aws_cloudwatch_metric_alarm" "Scaling_monitoring" {
  alarm_name                = "Scaling_monitoring"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = "120"
  statistic                 = "Average"
  threshold                 = "30"
  alarm_description         = "CPU Average more than 30%"
  
 dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.Autoscaling_Group.name
  }

    alarm_actions     = [aws_autoscaling_policy.scalingpolicy.arn]
}

#Create Auto-descaling Policy
resource "aws_autoscaling_policy" "de-scalingpolicy" {
  name                   = "de-scalingpolicy"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 200
  autoscaling_group_name = aws_autoscaling_group.Autoscaling_Group.name
}

#Create Auto-descaling cloud watch monitoring
resource "aws_cloudwatch_metric_alarm" "de-Scaling_monitoring" {
  alarm_name                = "de-Scaling_monitoring"
  comparison_operator       = "LessThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = "120"
  statistic                 = "Average"
  threshold                 = "10"
  alarm_description         = "CPU Average less 10%"

 dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.Autoscaling_Group.name
  }

    alarm_actions     = [aws_autoscaling_policy.de-scalingpolicy.arn]
}
