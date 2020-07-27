variable "tenant" {
    type = string 
    description = "et navn til Tenant"
    default = "_terraform-rocks_2"
    }
variable "vrf_name" {
    type = string 
    description = "et navn til VRF"
    default = "VRF_A"
    }
variable "bridge" {
    type = string 
    description = "et Navn til bridge"
    default = "Terraform_bridge"
    }
variable "type" {
    type = string 
    description = "et Navn til type af server"
    }
variable "service" {
    type = string 
    description = "et Navn til service"
    }
variable "ip" {
    type = string 
    description = "et ip range"
    }