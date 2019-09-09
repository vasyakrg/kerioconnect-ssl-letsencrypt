#===============================================
# Create kerio-connect server
#===============================================
resource "google_compute_instance" "nc" {
  name         = "kerio-connect-app"
  machine_type = "${var.machine_type}"
  zone         = "${var.zone_instance}"
  tags         = ["${var.net_tag}"]

  # add image disk
  boot_disk {
    initialize_params {
      image = "${var.disk_image}"
    }
  }

  # add network
  network_interface {
    network       = "${var.network_name}"
    access_config = {}
  }

  # ssh_key
  metadata = {
    sshKeys = "${var.username}:${file("~/.ssh/id_rsa.pub")}"
  }

  metadata_startup_script = "${file("scripts/preinstall.sh")}"

  connection {
    host        = "${self.network_interface.0.access_config.0.nat_ip}"
    type        = "ssh"
    user        = "${var.username}"
    private_key = "${file("~/.ssh/id_rsa")}"
  }

  provisioner "remote-exec" {
    inline = [
      "wget --no-check-certificate ${var.wget_kci_path}",
    ]
  }

  provisioner "file" {
    source      = "scripts/install.sh"
    destination = "/home/${var.username}/install.sh"
  }

  provisioner "local-exec" {
    command = "echo '${self.network_interface.0.access_config.0.nat_ip} ansible_ssh_user=${var.username}' > ../ansible/inventory"
  }

  provisioner "local-exec" {
    command = "rm -rf host"
    when    = "destroy"
  }
}
