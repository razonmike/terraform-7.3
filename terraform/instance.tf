resource "yandex_compute_instance" "centos-7" {
  count = local.instance_count[terraform.workspace]
  name  = "${terraform.workspace}-count-${count.index}"

  resources {
    cores  = local.vm_cores[terraform.workspace]
    memory = local.vm_memory[terraform.workspace]
  }

  boot_disk {
    initialize_params {
      image_id = var.centos-7-base
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.default.id
    nat       = true
  }

  metadata = {
    ssh-keys = "centos:${file("~/.ssh/id_rsa.pub")}"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "yandex_compute_instance" "centos-1-fe" {

  for_each = local.vm_foreach[terraform.workspace]
  name     = "${terraform.workspace}-foreach-${each.key}"

  resources {
    cores  = each.value.cores
    memory = each.value.memory
  }

  boot_disk {
    initialize_params {
      image_id = var.centos-7-base
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.default.id
    nat       = true
  }

  metadata = {
    ssh-keys = "centos:${file("~/.ssh/id_rsa.pub")}"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "yandex_vpc_network" "default" {
  name = "net"
}

resource "yandex_vpc_subnet" "default" {
  name           = "subnet"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.default.id
  v4_cidr_blocks = ["10.10.10.0/24"]
}


locals {
  instance_count = {
    "prod"  = 2
    "stage" = 1
  }
  vm_cores = {
    "prod"  = 2
    "stage" = 1
  }
  vm_memory = {
    "prod"  = 2
    "stage" = 1
  }
  vm_foreach = {
    prod = {
      "3" = { cores = "2", memory = "2" },
      "2" = { cores = "2", memory = "2" }
    }
    stage = {
      "1" = { cores = "1", memory = "1" }
    }
  }
}

output "internal_ip_address_vm_1" {
  value = yandex_compute_instance.centos-7[*].network_interface.0.ip_address
}

output "external_ip_address_vm_1" {
  value = yandex_compute_instance.centos-7[*].network_interface.0.nat_ip_address
}
