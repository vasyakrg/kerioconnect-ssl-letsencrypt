output "address" {
  value = "${google_compute_instance.nc.network_interface.0.access_config.0.nat_ip}"
}

output "domain_name" {
  value = "${google_dns_record_set.kerio_dns.name}"
}
