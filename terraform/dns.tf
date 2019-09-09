resource "google_dns_record_set" "kerio_dns" {
  name = "${var.record_name}.${var.dns_zone_name}."
  type = "A"
  ttl  = 300

  managed_zone = "${var.dns_zone_id}"

  rrdatas = ["${google_compute_instance.nc.network_interface.0.access_config.0.nat_ip}"]
}
