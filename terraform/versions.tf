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
    key        = ".terraform/terraform.tfstate"
    access_key = var.access_key
    secret_key = var.secret_key

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}
