locals {
  user_acct_id = "${substr(element(split("a/", data.ibm_is_vpc.f5_vpc.resource_crn), 1), 0, 32)}"
}

data "ibm_is_region" "region" {
  name = "${var.region}"
}

data "ibm_resource_group" "rg" {
  name = "${var.resource_group}"
}

data "ibm_is_vpc" "f5_vpc" {
  name = "${var.vpc_name}"
}

data "external" "authorize_policy_for_image" {
  depends_on = ["data.ibm_is_vpc.f5_vpc"]
  program    = ["bash", "${path.module}/scripts/create_auth.sh"]

  query = {
    ibmcloud_endpoint           = "${var.ibmcloud_endpoint}"
    ibmcloud_svc_api_key        = "${var.ibmcloud_svc_api_key}"
    source_service_account      = "${local.user_acct_id}"
    source_service_name         = "is"
    source_resource_type        = "image"
    target_service_name         = "cloud-object-storage"
    target_resource_type        = "bucket"
    roles                       = "Reader"
    target_resource_instance_id = "${var.vnf_cos_instance_id}"
    region                      = "${data.ibm_is_region.region.name}"
    resource_group_id           = "${data.ibm_resource_group.rg.id}"
  }
}

resource "random_uuid" "image_name" {

}

resource "ibm_is_image" "f5_custom_image" {
  depends_on       = ["data.external.authorize_policy_for_image", "random_uuid.image_name"]
  href             = "${var.vnf_cos_image_url}"
  name             = "${var.vnf_vpc_image_name}-${random_uuid.image_name.result}"
  operating_system = "centos-7-amd64"

  timeouts {
    create = "30m"
    delete = "10m"
  }
}

data "external" "delete_auth_policy_for_image" {
  depends_on = ["ibm_is_image.f5_custom_image"]
  program    = ["bash", "${path.module}/scripts/delete_auth.sh"]

  query = {
    id                   = "${lookup(data.external.authorize_policy_for_image.result, "id")}"
    ibmcloud_endpoint    = "${var.ibmcloud_endpoint}"
    ibmcloud_svc_api_key = "${var.ibmcloud_svc_api_key}"
    region               = "${data.ibm_is_region.region.name}"
  }
}
