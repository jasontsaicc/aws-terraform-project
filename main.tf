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
  subnet_id    = module.vpc.private_subnet_ids
  secret_id    = module.secretsmanager.secret_id
  secret_arn   = module.secretsmanager.secret_arn
}

module "ec2" {
  source       = "./modules/ec2"
  project_name = var.project_name
  subnet_id    = element(module.vpc.private_subnet_ids, 0) # 傳入第一個子網 ID
  vpc_id       = module.vpc.vpc_id
  instance_type = var.instance_type
}
module "eks" {
  source       = "./modules/eks"
  project_name = var.project_name
  vpc_id       = module.vpc.vpc_id
  subnet_ids    = module.vpc.private_subnet_ids
}