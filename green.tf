resource "aws_instance" "green" {
  count                  = var.enable_green_env ? var.green_instance_count : 0
  ami                    = data.aws_ami.amazon.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.grp4-subnet-1.id
  vpc_security_group_ids = [aws_security_group.group-4.id]
  user_data = file("green.sh")
    
  tags = {
    Name = var.green_instance_name
  }
}

resource "aws_lb_target_group" "green" {
  name     = var.green_lb_tg
  port     = var.lb_tg_ports[0]
  protocol = var.lb_tg_protocol[0]
  vpc_id   = aws_vpc.group-4.id

  health_check {
    port     = var.lb_tg_ports[0]
    protocol = var.lb_tg_protocol[0]
    timeout  = 5
    interval = 10
  }
}

resource "aws_lb_target_group_attachment" "green" {
  count            = length(aws_instance.green)
  target_group_arn = aws_lb_target_group.green.arn
  target_id        = aws_instance.green[count.index].id
  port             = var.lb_tg_ports[0]
}