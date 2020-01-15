data "ibm_is_ssh_key" "f5_ssh_pub_key" {
  name = "${var.ssh_key_name}"
}

data "ibm_is_instance_profile" "vnf_profile" {
  name = "${var.vnf_profile}"
}

data "ibm_is_region" "region" {
  name = "${var.region}"
}

data "ibm_is_zone" "zone" {
  name   = "${var.zone}"
  region = "${data.ibm_is_region.region.name}"
}

resource "ibm_is_instance" "f5_vsi" {
  name    = "${var.vnf_instance_name}"
  image   = "${data.ibm_is_image.f5_custom_image.id}"
  profile = "${data.ibm_is_instance_profile.vnf_profile.name}"

  primary_network_interface = {
    subnet = "${data.ibm_is_subnet.f5_subnet1.id}"
  }

  vpc  = "${data.ibm_is_vpc.f5_vpc.id}"
  zone = "${data.ibm_is_zone.zone.name}"
  keys = ["${data.ibm_is_ssh_key.f5_ssh_pub_key.id}"]

  timeouts {
    create = "10m"
    delete = "10m"
  }

  provisioner "local-exec" {
    command = "sleep 30"
  }
}
