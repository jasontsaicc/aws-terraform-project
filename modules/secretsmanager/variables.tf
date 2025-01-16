variable "project_name" {
    type = string
  
}

variable "rds_credentials" {
  type = map(string)
  default = {
    username = "admin123"
    password = "Admin1234"
  }
}

variable "secret_version" {
  type    = number
  default = "6" # 每次需要手動遞增
}