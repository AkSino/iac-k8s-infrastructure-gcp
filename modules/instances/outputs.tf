output "instance_public_ips" {
  description = "Liste des adresses IP publiques des instances"
  value = tolist([
    for instance in google_compute_instance.k8s_instance :
    instance.network_interface[0].access_config[0].nat_ip
  ])
}

output "instance_names" {
  description = "Liste des noms des instances"
  value = tolist([
    for instance in google_compute_instance.k8s_instance :
    instance.name
  ])
}
