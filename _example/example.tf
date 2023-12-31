provider "google" {
  project = "cypik-397319"
  region  = "asia-northeast1"
  zone    = "asia-northeast1-a"
}

#####==============================================================================
##### vpc module call.
#####==============================================================================
module "vpc" {
  source                                    = "git::https://github.com/cypik/terraform-gcp-vpc.git?ref=v1.0.0"
  name                                      = "app"
  environment                               = "test"
  network_firewall_policy_enforcement_order = "AFTER_CLASSIC_FIREWALL"
}

#####==============================================================================
##### subnet module call.
#####==============================================================================
module "subnet" {
  source        = "git::https://github.com/cypik/terraform-gcp-subnet.git?ref=v1.0.0"
  name          = "subnet"
  environment   = "test"
  gcp_region    = "asia-northeast1"
  network       = module.vpc.vpc_id
  ip_cidr_range = "192.168.0.0/24"
}

#####==============================================================================
##### firewall module call.
#####==============================================================================
module "firewall" {
  source        = "git::https://github.com/cypik/terraform-gcp-firewall.git?ref=v1.0.0"
  name          = "app"
  environment   = "test"
  network       = module.vpc.vpc_id
  source_ranges = ["0.0.0.0/0"]

  allow = [
    { protocol = "tcp"
      ports    = ["22", "80"]
    }
  ]
}

#####==============================================================================
##### compute_instance module call.
#####==============================================================================
module "compute_instance" {
  source                 = "../"
  name                   = "app"
  environment            = "test"
  instance_tags          = ["foo", "bar"]
  machine_type           = "e2-small"
  gcp_zone               = "asia-northeast1-a"
  service_account_scopes = ["cloud-platform"]
  subnetwork             = module.subnet.subnet_id

  ######### public IP if enable_public_ip is true
  enable_public_ip = true
  metadata = {
    ssh-keys = <<EOF
      test:ssh-rsa AAAxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxbLLNM= suresh@suresh
    EOF
  }
}
