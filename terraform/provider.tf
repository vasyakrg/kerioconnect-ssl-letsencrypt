provider "google" {
  project = "${var.project}"
  region  = "${var.region}"
  version = "0.11.11"
}
