variable "AWS_REGION" {
  default     = "us-east-1"
  description = "This is vpc region"
}

variable "CIDR_VPC" {
  default     = "10.0.0.0/16"
  description = "This is full VPC CIDR block"
}

variable "CIDR_SUBNET" {
  default     = "10.0.0.0/28"
  description = "This is CIDR for Subnet"
}

variable "MAP_PUBLIC_IP_ON_LAUNCH" {
  default     = "true"
  description = "subnet should have public ip or not"
}
