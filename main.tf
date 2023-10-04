# resource "google_project_service" "compute_service" {
#   project = local.project_id
#   service = "compute.googleapis.com"
# }

module "network" {
  source                       = "./modules/network"
  private_subnet_cidr_block    = "10.240.0.0/24"
  public_subnet_cidr_block     = "10.240.1.0/24"
  vpc_name                     = "main-vpc"
  private_subnet_name          = "k8s-private-subnet"
  public_subnet_name           = "k8s-public-subnet"
  router_name                  = "jenkins-router"
  router_nat_name              = "jenkins-router-nat"
  allow_internal_firewall_name = "k8s-allow-internal"
  allow_external_firewall_name = "k8s-allow-external"
}

module "controller_instances" {
  source                  = "./modules/instances"
  instance_count          = 1
  instance_tags           = ["k8s-server", "controller"]
  instance_startup_script = "apt-get install -y python"
  machine_type            = "e2-micro"
  k8s_type_instance       = "controller"
  instance_image          = "ubuntu-2204-jammy-v20230919"
  gcp_zone                = var.gcp_zone
  network_id              = module.network.network_id
  subnetwork_id           = module.network.subnetwork_id
  scopes                  = ["compute-rw", "storage-ro", "service-management", "service-control", "logging-write", "monitoring"]
  network_ip_base         = "10.240.0.1"
}

module "worker_instances" {
  source                  = "./modules/instances"
  instance_count          = 1
  instance_tags           = ["k8s-server", "worker"]
  instance_startup_script = "apt-get install -y python"
  include_pod_cidr        = true
  machine_type            = "e2-micro"
  k8s_type_instance       = "worker"
  instance_image          = "ubuntu-2204-jammy-v20230919"
  gcp_zone                = var.gcp_zone
  network_id              = module.network.network_id
  subnetwork_id           = module.network.subnetwork_id
  scopes                  = ["compute-rw", "storage-ro", "service-management", "service-control", "logging-write", "monitoring"]
  network_ip_base         = "10.240.0.2"
}
