resource "google_compute_firewall" "allow-ports" {
  name = "allow-posts-kerio"

  # name of net
  network = "default"

  allow {
    protocol = "tcp"

    ports = [
      "443",
      "80",
      "22",
      "4040",
    ]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["${var.net_tag}"]
}
