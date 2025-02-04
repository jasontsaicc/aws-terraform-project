# 為 NLB 設定固定的 EIP
resource "aws_eip" "nlb_eip" {
  # count = var.enable_eip ? length(var.public_subnet_ids) : 0 # 每個子網對應一個 EIP
  domain = "vpc"
  tags = {
    # Name = "${var.project_name}-nlb-eip-${count.index + 1}"
    Name        = "${var.project_name}-nlb-eip"

    Environment = "dev"
  }
}

# 建立 NLB 的 Security Group
resource "aws_security_group" "nlb_sg" {
  name        = "${var.project_name}-nlb-sg"
  description = "Security Group for NLB"
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
    Name = "${var.project_name}-nlb-sg"
  }
}
# 建立 NLB
resource "aws_lb" "this" {
  name               = "${var.project_name}-nlb"
  load_balancer_type = "network"
  ip_address_type    = "ipv4"
  security_groups    = [aws_security_group.nlb_sg.id]  

  # subnets            = var.enable_eip ? null : var.public_subnet_ids # 當啟用 EIP 時，使用 subnet_mapping 配置

  # dynamic "subnet_mapping" {
  #   for_each = var.enable_eip ? toset(var.public_subnet_ids) : [] # 動態生成 subnet_mapping 配置
  #   content {
  #     subnet_id     = subnet_mapping.value
  #     allocation_id = aws_eip.nlb_eip[index(var.public_subnet_ids, subnet_mapping.value)].id
  #   }
  # }
  subnet_mapping {
    subnet_id     = var.public_subnet_ids[0]
    allocation_id = aws_eip.nlb_eip.id
  }

  tags = {
    Name = "${var.project_name}-nlb"
    Environment = "dev"
  }
}

# NLB 的 Target Group，指向 ALB
resource "aws_lb_target_group" "nlb_to_alb_tg" {
  name        = "${var.project_name}-nlb-to-alb-tg"
  port        = 80 # 根據 ALB 的 HTTP Listener 設定端口
  protocol    = "TCP" # 使用 TCP，因為 NLB 是第四層負載均衡
  vpc_id      = var.vpc_id
  target_type = "alb" 

  depends_on = [ 
    aws_lb.this
   ]
  tags = {
    Name = "${var.project_name}-nlb-to-alb-tg"
    Environment = "dev"
  }

}

# NLB Listener，將流量轉發至 ALB
resource "aws_lb_listener" "nlb_tcp_listener" {
  load_balancer_arn = aws_lb.this.arn
  port              = 80
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nlb_to_alb_tg.arn
  }
}

# 將 ALB 的 IP 地址手動添加至 NLB Target Group
resource "aws_lb_target_group_attachment" "nlb_to_alb_tg_attachment" {
  target_group_arn = aws_lb_target_group.nlb_to_alb_tg.arn
  target_id        = var.alb_arn # ALB 的 ARN
  port             = 80
  depends_on = [ 
    aws_lb_target_group.nlb_to_alb_tg,
    aws_lb_listener.nlb_tcp_listener
   ]
  
}


