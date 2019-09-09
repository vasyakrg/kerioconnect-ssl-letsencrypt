provider "google" {
  project = "${var.project}"
  region  = "${var.region}"
}

terraform {
  required_version = ">=0.11.11"
}
