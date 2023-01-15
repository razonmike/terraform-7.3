terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "~> 0.84.0"
    }
  }
  required_version = ">= 1.1.0"
  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "bucket-object-storage-netology"
    region     = "ru-central1"
    key        = "state/terraform.tfstate"
    access_key = ""
    secret_key = ""

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}
provider "yandex" {
  token     = var.yc_token
  cloud_id  = var.yc_cloud_id
  folder_id = var.yc_folder_id
  zone      = var.yc_zone
}
