variable "ibmcloud_endpoint" {
  default     = "cloud.ibm.com"
  description = "The IBM Cloud environmental variable 'cloud.ibm.com' or 'test.cloud.ibm.com'"
}

variable "ibmcloud_svc_api_key" {
  default     = ""
  type        = "string"
  description = "The APIKey of the IBM Cloud service account that is hosting the F5-BIGIP qcow2 image file. This should be a the API Key of a Service ID in the account"
}

variable "vnf_cos_image_url" {
  default     = ""
  description = "The COS image object SQL URL for F5-BIGIP qcow2 image."
}

variable "vnf_cos_instance_id" {
  default     = ""
  description = "The COS instance-id hosting the F5-BIGIP qcow2 image."
}

variable "vnf_vpc_image_name" {
  default     = "f5-bigip-15-0-1-0-0-11"
  description = "The name of the F5-BIGIP custom image to be provisioned in your IBM Cloud account."
}
