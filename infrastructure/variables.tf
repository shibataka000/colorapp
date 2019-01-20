variable "region" {
  default ="us-east-1"
}

variable "worker_node_image_id" {
  default = {
    "us-east-1" = "ami-0440e4f6b9713faf6"
    "us-west-2" = "ami-0a54c984b9f908c81"
  }
}

variable "key_pair_name" {
  default = "default"
}

variable "colorgateway_image_name" {
  default = "colorgateway"
}

variable "colorteller_image_name" {
  default = "colorteller"
}

variable "mesh_name" {
  default = "default"
}

variable "services_domain" {
  default = "default.svc.cluster.local"
}
