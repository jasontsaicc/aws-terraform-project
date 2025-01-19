#測試環境目前只有建在2個az, 正式環境會在調整3個az
module "vpc" {
  source       = "./modules/vpc"
  project_name = var.project_name
  vpc_cidr     = var.vpc_cidr
  subnet_cidr  = var.subnet_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
}

module "s3" {
  source       = "./modules/s3"
  project_name = var.project_name
}

module "ecr" {
  source = "./modules/ecr"
  project_name = var.project_name
}

module "secretsmanager" {
  source = "./modules/secretsmanager"
  project_name = var.project_name
}

module "rds" {
  source       = "./modules/rds"
  project_name = var.project_name
  vpc_id       = module.vpc.vpc_id
  private_subnet_ids    = module.vpc.private_subnet_ids
  secret_id    = module.secretsmanager.secret_id
  secret_arn   = module.secretsmanager.secret_arn
}

#測試環境建置在public_subnet, os是windows tableau server, 測試方便連入所以建置在public, 正式環境改放在private subnet
module "ec2" {
  source       = "./modules/ec2"
  project_name = var.project_name
  public_subnet_ids    = element(module.vpc.public_subnet_ids, 0) # 傳入第一個子網 ID
  vpc_id       = module.vpc.vpc_id
  }

module "eks" {
  source       = "./modules/eks"
  project_name = var.project_name
  vpc_id       = module.vpc.vpc_id
  private_subnet_ids    = module.vpc.private_subnet_ids
  }

#建置在public subnet, 用來當作連入EKS的跳板機
module "ec2_bastion" {
  source       = "./modules/ec2_bastion"
  project_name = var.project_name
  vpc_id       = module.vpc.vpc_id
  public_subnet_ids    = module.vpc.public_subnet_ids
  }


module "redshift" {
  source       = "./modules/redshift"
  project_name = var.project_name
  vpc_id       = module.vpc.vpc_id
  private_subnet_ids    = module.vpc.private_subnet_ids
  }


module "alb" {
  source       = "./modules/alb"
  project_name = var.project_name
  vpc_id       = module.vpc.vpc_id
  private_subnet_ids    = module.vpc.private_subnet_ids
  ec2_arn      = module.ec2.tableau_ec2
  }

#測試環境建置在public subnet, 設置固定IP, 正式環境改放在private subnet改用內部DX連線
module "nlb" {
  source       = "./modules/nlb"
  project_name = var.project_name
  vpc_id       = module.vpc.vpc_id
  public_subnet_ids    = module.vpc.public_subnet_ids
  alb_arn      = module.alb.alb_arn
  alb_dns_name = module.alb.alb_dns_name
  alb_target_group_arn = module.alb.alb_target_group_arn
  }