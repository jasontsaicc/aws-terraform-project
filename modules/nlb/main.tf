# 為 NLB 設定固定的 EIP
resource "aws_eip" "nlb_eip" {
  count = var.enable_eip ? length(var.subnet_id) : 0 # 每個子網對應一個 EIP
  domain = "vpc"
  tags = {
    Name = "${var.project_name}-nlb-eip-${count.index + 1}"
  }
}

resource "aws_lb" "this" {
  name               = "${var.project_name}-nlb"
  load_balancer_type = "network"
  ip_address_type    = "ipv4"
  subnets            = var.enable_eip ? null : var.subnet_id # 當啟用 EIP 時，使用 subnet_mapping 配置

  dynamic "subnet_mapping" {
    for_each = var.enable_eip ? toset(var.subnet_id) : [] # 動態生成 subnet_mapping 配置
    content {
      subnet_id     = subnet_mapping.value
      allocation_id = aws_eip.nlb_eip[index(var.subnet_id, subnet_mapping.value)].id
    }
  }

  tags = {
    Name = "${var.project_name}-nlb"
  }
}
