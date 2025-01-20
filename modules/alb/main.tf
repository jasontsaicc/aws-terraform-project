resource "aws_lb" "this" {
  name               = "${var.project_name}-alb"
  load_balancer_type = "application"
  subnets            = var.private_subnet_ids
  internal           = true   
  security_groups    = [aws_security_group.alb_sg.id]  

  tags = {
    Name = "${var.project_name}-alb"
    Environment = "dev"
  }
}

# Security Group 配置
resource "aws_security_group" "alb_sg" {
  name        = "${var.project_name}-alb-sg"
  description = "Security Group for ALB"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  dynamic "egress" {
    for_each = var.egress_rules
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }

  tags = {
    Name = "${var.project_name}-alb-sg"
    Environment = "dev"
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

resource "aws_lb_target_group_attachment" "tableau_ec2_tg_attachment" {
  target_group_arn = aws_lb_target_group.tableau_ec2_tg.arn
  target_id        = var.ec2_arn # ALB 的 ARN
  port             = 80
  depends_on = [ 
    aws_lb_listener.tableau_ec2_http_listener
   ]
  
}