resource "aws_cloudwatch_metric_alarm" "ec2_high_cpu" {
  alarm_name        = "${var.project_name}-ec2-high-cpu"
  alarm_description = "Alarm when EC2 CPU > 70% (1-minute period)"

  namespace   = "AWS/EC2"
  metric_name = "CPUUtilization"
  statistic   = "Average"

  period              = 60 # 1 minute
  evaluation_periods  = 1
  datapoints_to_alarm = 1

  threshold           = 70
  comparison_operator = "GreaterThanThreshold"

  dimensions = {
    InstanceId = aws_instance.team_vm.id
  }

  treat_missing_data = "missing"

  # Sin acciones (como el lab: Remove notifications)
  actions_enabled = false
}
