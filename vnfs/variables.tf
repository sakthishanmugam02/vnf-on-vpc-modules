variable "ssh_key_name" {
  default     = ""
  description = "The name of the public SSH key to be used when provisining F5-BIGIP VSI."
}

variable "vnf_instance_name" {
  default     = "f5-1arm-vsi01"
  description = "The name of your F5-BIGIP Virtual Server to be provisioned."
}

variable "vnf_profile" {
  default     = "bx2-2x8"
  description = "The profile of compute CPU and memory resources to be used when provisioning F5-BIGIP VSI. To list available profiles, run `ibmcloud is instance-profiles`."
}

variable "zone" {
  default     = "us-south-1"
  description = "The VPC Zone that you want your VPC networks and virtual servers to be provisioned in. To list available zones, run `ibmcloud is zones`."
}

variable "vpc_name" {
  default     = ""
  description = "The name of your VPC where F5-BIGIP VSI is to be provisioned."
}
