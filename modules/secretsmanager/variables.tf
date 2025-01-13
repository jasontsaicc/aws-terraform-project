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
