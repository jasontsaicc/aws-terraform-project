resource "aws_lb" "this" {
  name               = "${var.project_name}-alb"
  load_balancer_type = "application"
  subnets            = var.subnet_id

  tags = {
    Name = "${var.project_name}-alb"
  }
}

# 建立 Target Groups (TG) 給 EKS 與 EC2 用
resource "aws_lb_target_group" "eks_tg" {
  name        = "${var.project_name}-eks-tg"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip" 
}

resource "aws_lb_target_group" "tableau_ec2_tg" {
  name        = "${var.project_name}-ec2-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"
}


resource "aws_lb_listener" "tableau_ec2_http_listener" {
  load_balancer_arn = aws_lb.this.arn # 連接 ALB 的 ARN
  port              = 80             # 監聽端口
  protocol          = "HTTP"         # 協議
  
  default_action {                   # 預設動作：轉發流量
    type             = "forward"
    target_group_arn = aws_lb_target_group.tableau_ec2_tg.arn
  }
}

resource "aws_lb_listener" "eks_http_listener" {
  load_balancer_arn = aws_lb.this.arn # 連接 ALB 的 ARN
  port              = 8080           # 監聽端口
  protocol          = "HTTP"         # 協議
  
  default_action {                   # 預設動作：轉發流量
    type             = "forward"
    target_group_arn = aws_lb_target_group.eks_tg.arn
  }
}