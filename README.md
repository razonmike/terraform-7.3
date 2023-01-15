Домашнее задание к занятию "14. Основы и принцип работы Терраформ"
Задача 1. Создадим бэкэнд в S3 (необязательно, но крайне желательно).
Если в рамках предыдущего задания у вас уже есть аккаунт AWS, то давайте продолжим знакомство со взаимодействием терраформа и aws.

Создайте s3 бакет, iam роль и пользователя от которого будет работать терраформ. Можно создать отдельного пользователя, а можно использовать созданного в рамках предыдущего задания, просто добавьте ему необходимы права, как описано здесь.
Зарегистрируйте бэкэнд в терраформ проекте как описано по ссылке выше.


Задача 2. Инициализируем проект и создаем воркспейсы.
Выполните terraform init:
если был создан бэкэнд в S3, то терраформ создат файл стейтов в S3 и запись в таблице dynamodb.
иначе будет создан локальный файл со стейтами.
Создайте два воркспейса stage и prod.
В уже созданный aws_instance добавьте зависимость типа инстанса от вокспейса, что бы в разных ворскспейсах использовались разные instance_type.
Добавим count. Для stage должен создаться один экземпляр ec2, а для prod два.
Создайте рядом еще один aws_instance, но теперь определите их количество при помощи for_each, а не count.
Что бы при изменении типа инстанса не возникло ситуации, когда не будет ни одного инстанса добавьте параметр жизненного цикла create_before_destroy = true в один из рессурсов aws_instance.
При желании поэкспериментируйте с другими параметрами и рессурсами.

В виде результата работы пришлите:

Вывод команды terraform workspace list.

```
razonmike@razonmike-ThinkPad-T480:~/netology/terraform-7.3/terraform$ terraform workspace list
  default
* prod
  stage
```

Вывод команды terraform plan для воркспейса prod.
```
terraform plan

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # yandex_compute_instance.centos-1-fe["2"] will be created
  + resource "yandex_compute_instance" "centos-1-fe" {
      + created_at                = (known after apply)
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + hostname                  = (known after apply)
      + id                        = (known after apply)
      + metadata                  = {
          + "ssh-keys" = <<-EOT
                centos:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC3FwLIHAglyTAa0HS7BmjM0tay7BdSWj4tRrB0+wqxKfChecB1DJxn7X5JH9PnI/LnTDTd8Bn96oh6ww5hW0ytR54/dE/NCvdFn8I/ueYY3IRZsp2tpty2dQRN7epQQ6Nx04+6HEmjumyAiDdUVv6S7H2Huof+YlJybHbss0rmS2e/6Ek8WZo5y8k+Aq9lqs1ezmlSRlhIudOOAciNBAmme4a0H4JI4PSYXzyv+wOuYd74tvD5cSrvk22rf7gOp3DMRFk5zzd1W2Bu+7sJ/p8l2zLDBFXUcEEZICVnd+SRVZL3TxS0B1gRRiBB5FpIHjJNmlIQb1oyPy7CkXe51pokZNyqtfNupuVOlg5gd5DavDaZUsnpg3/N4wKLVx1xLuvd+EOpZxKTPQpoUjCVYwyAuPfRhqvCehocFuEsHFAv7av1jsLdO9TvZG75gGZ/PoLrWkJtwUgIUJmgrrjOWAabPEtmNaZ5n2hXWH4lov8j7ZEuKF6Sq1X2mKeiUoiNXrE= razonmike@razonmike-ThinkPad-T480
            EOT
        }
      + name                      = "prod-foreach-2"
      + network_acceleration_type = "standard"
      + platform_id               = "standard-v1"
      + service_account_id        = (known after apply)
      + status                    = (known after apply)
      + zone                      = (known after apply)

      + boot_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = (known after apply)

          + initialize_params {
              + block_size  = (known after apply)
              + description = (known after apply)
              + image_id    = "fd8p8u2qtq9amcilvd3q"
              + name        = (known after apply)
              + size        = (known after apply)
              + snapshot_id = (known after apply)
              + type        = "network-hdd"
            }
        }

      + metadata_options {
          + aws_v1_http_endpoint = (known after apply)
          + aws_v1_http_token    = (known after apply)
          + gce_http_endpoint    = (known after apply)
          + gce_http_token       = (known after apply)
        }

      + network_interface {
          + index              = (known after apply)
          + ip_address         = (known after apply)
          + ipv4               = true
          + ipv6               = (known after apply)
          + ipv6_address       = (known after apply)
          + mac_address        = (known after apply)
          + nat                = true
          + nat_ip_address     = (known after apply)
          + nat_ip_version     = (known after apply)
          + security_group_ids = (known after apply)
          + subnet_id          = (known after apply)
        }

      + placement_policy {
          + host_affinity_rules = (known after apply)
          + placement_group_id  = (known after apply)
        }

      + resources {
          + core_fraction = 100
          + cores         = 2
          + memory        = 2
        }

      + scheduling_policy {
          + preemptible = (known after apply)
        }
    }

  # yandex_compute_instance.centos-1-fe["3"] will be created
  + resource "yandex_compute_instance" "centos-1-fe" {
      + created_at                = (known after apply)
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + hostname                  = (known after apply)
      + id                        = (known after apply)
      + metadata                  = {
          + "ssh-keys" = <<-EOT
                centos:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC3FwLIHAglyTAa0HS7BmjM0tay7BdSWj4tRrB0+wqxKfChecB1DJxn7X5JH9PnI/LnTDTd8Bn96oh6ww5hW0ytR54/dE/NCvdFn8I/ueYY3IRZsp2tpty2dQRN7epQQ6Nx04+6HEmjumyAiDdUVv6S7H2Huof+YlJybHbss0rmS2e/6Ek8WZo5y8k+Aq9lqs1ezmlSRlhIudOOAciNBAmme4a0H4JI4PSYXzyv+wOuYd74tvD5cSrvk22rf7gOp3DMRFk5zzd1W2Bu+7sJ/p8l2zLDBFXUcEEZICVnd+SRVZL3TxS0B1gRRiBB5FpIHjJNmlIQb1oyPy7CkXe51pokZNyqtfNupuVOlg5gd5DavDaZUsnpg3/N4wKLVx1xLuvd+EOpZxKTPQpoUjCVYwyAuPfRhqvCehocFuEsHFAv7av1jsLdO9TvZG75gGZ/PoLrWkJtwUgIUJmgrrjOWAabPEtmNaZ5n2hXWH4lov8j7ZEuKF6Sq1X2mKeiUoiNXrE= razonmike@razonmike-ThinkPad-T480
            EOT
        }
      + name                      = "prod-foreach-3"
      + network_acceleration_type = "standard"
      + platform_id               = "standard-v1"
      + service_account_id        = (known after apply)
      + status                    = (known after apply)
      + zone                      = (known after apply)

      + boot_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = (known after apply)

          + initialize_params {
              + block_size  = (known after apply)
              + description = (known after apply)
              + image_id    = "fd8p8u2qtq9amcilvd3q"
              + name        = (known after apply)
              + size        = (known after apply)
              + snapshot_id = (known after apply)
              + type        = "network-hdd"
            }
        }

      + metadata_options {
          + aws_v1_http_endpoint = (known after apply)
          + aws_v1_http_token    = (known after apply)
          + gce_http_endpoint    = (known after apply)
          + gce_http_token       = (known after apply)
        }

      + network_interface {
          + index              = (known after apply)
          + ip_address         = (known after apply)
          + ipv4               = true
          + ipv6               = (known after apply)
          + ipv6_address       = (known after apply)
          + mac_address        = (known after apply)
          + nat                = true
          + nat_ip_address     = (known after apply)
          + nat_ip_version     = (known after apply)
          + security_group_ids = (known after apply)
          + subnet_id          = (known after apply)
        }

      + placement_policy {
          + host_affinity_rules = (known after apply)
          + placement_group_id  = (known after apply)
        }

      + resources {
          + core_fraction = 100
          + cores         = 2
          + memory        = 2
        }

      + scheduling_policy {
          + preemptible = (known after apply)
        }
    }

  # yandex_compute_instance.centos-7[0] will be created
  + resource "yandex_compute_instance" "centos-7" {
      + created_at                = (known after apply)
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + hostname                  = (known after apply)
      + id                        = (known after apply)
      + metadata                  = {
          + "ssh-keys" = <<-EOT
                centos:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC3FwLIHAglyTAa0HS7BmjM0tay7BdSWj4tRrB0+wqxKfChecB1DJxn7X5JH9PnI/LnTDTd8Bn96oh6ww5hW0ytR54/dE/NCvdFn8I/ueYY3IRZsp2tpty2dQRN7epQQ6Nx04+6HEmjumyAiDdUVv6S7H2Huof+YlJybHbss0rmS2e/6Ek8WZo5y8k+Aq9lqs1ezmlSRlhIudOOAciNBAmme4a0H4JI4PSYXzyv+wOuYd74tvD5cSrvk22rf7gOp3DMRFk5zzd1W2Bu+7sJ/p8l2zLDBFXUcEEZICVnd+SRVZL3TxS0B1gRRiBB5FpIHjJNmlIQb1oyPy7CkXe51pokZNyqtfNupuVOlg5gd5DavDaZUsnpg3/N4wKLVx1xLuvd+EOpZxKTPQpoUjCVYwyAuPfRhqvCehocFuEsHFAv7av1jsLdO9TvZG75gGZ/PoLrWkJtwUgIUJmgrrjOWAabPEtmNaZ5n2hXWH4lov8j7ZEuKF6Sq1X2mKeiUoiNXrE= razonmike@razonmike-ThinkPad-T480
            EOT
        }
      + name                      = "prod-count-0"
      + network_acceleration_type = "standard"
      + platform_id               = "standard-v1"
      + service_account_id        = (known after apply)
      + status                    = (known after apply)
      + zone                      = (known after apply)

      + boot_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = (known after apply)

          + initialize_params {
              + block_size  = (known after apply)
              + description = (known after apply)
              + image_id    = "fd8p8u2qtq9amcilvd3q"
              + name        = (known after apply)
              + size        = (known after apply)
              + snapshot_id = (known after apply)
              + type        = "network-hdd"
            }
        }

      + metadata_options {
          + aws_v1_http_endpoint = (known after apply)
          + aws_v1_http_token    = (known after apply)
          + gce_http_endpoint    = (known after apply)
          + gce_http_token       = (known after apply)
        }

      + network_interface {
          + index              = (known after apply)
          + ip_address         = (known after apply)
          + ipv4               = true
          + ipv6               = (known after apply)
          + ipv6_address       = (known after apply)
          + mac_address        = (known after apply)
          + nat                = true
          + nat_ip_address     = (known after apply)
          + nat_ip_version     = (known after apply)
          + security_group_ids = (known after apply)
          + subnet_id          = (known after apply)
        }

      + placement_policy {
          + host_affinity_rules = (known after apply)
          + placement_group_id  = (known after apply)
        }

      + resources {
          + core_fraction = 100
          + cores         = 2
          + memory        = 2
        }

      + scheduling_policy {
          + preemptible = (known after apply)
        }
    }

  # yandex_compute_instance.centos-7[1] will be created
  + resource "yandex_compute_instance" "centos-7" {
      + created_at                = (known after apply)
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + hostname                  = (known after apply)
      + id                        = (known after apply)
      + metadata                  = {
          + "ssh-keys" = <<-EOT
                centos:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC3FwLIHAglyTAa0HS7BmjM0tay7BdSWj4tRrB0+wqxKfChecB1DJxn7X5JH9PnI/LnTDTd8Bn96oh6ww5hW0ytR54/dE/NCvdFn8I/ueYY3IRZsp2tpty2dQRN7epQQ6Nx04+6HEmjumyAiDdUVv6S7H2Huof+YlJybHbss0rmS2e/6Ek8WZo5y8k+Aq9lqs1ezmlSRlhIudOOAciNBAmme4a0H4JI4PSYXzyv+wOuYd74tvD5cSrvk22rf7gOp3DMRFk5zzd1W2Bu+7sJ/p8l2zLDBFXUcEEZICVnd+SRVZL3TxS0B1gRRiBB5FpIHjJNmlIQb1oyPy7CkXe51pokZNyqtfNupuVOlg5gd5DavDaZUsnpg3/N4wKLVx1xLuvd+EOpZxKTPQpoUjCVYwyAuPfRhqvCehocFuEsHFAv7av1jsLdO9TvZG75gGZ/PoLrWkJtwUgIUJmgrrjOWAabPEtmNaZ5n2hXWH4lov8j7ZEuKF6Sq1X2mKeiUoiNXrE= razonmike@razonmike-ThinkPad-T480
            EOT
        }
      + name                      = "prod-count-1"
      + network_acceleration_type = "standard"
      + platform_id               = "standard-v1"
      + service_account_id        = (known after apply)
      + status                    = (known after apply)
      + zone                      = (known after apply)

      + boot_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = (known after apply)

          + initialize_params {
              + block_size  = (known after apply)
              + description = (known after apply)
              + image_id    = "fd8p8u2qtq9amcilvd3q"
              + name        = (known after apply)
              + size        = (known after apply)
              + snapshot_id = (known after apply)
              + type        = "network-hdd"
            }
        }

      + metadata_options {
          + aws_v1_http_endpoint = (known after apply)
          + aws_v1_http_token    = (known after apply)
          + gce_http_endpoint    = (known after apply)
          + gce_http_token       = (known after apply)
        }

      + network_interface {
          + index              = (known after apply)
          + ip_address         = (known after apply)
          + ipv4               = true
          + ipv6               = (known after apply)
          + ipv6_address       = (known after apply)
          + mac_address        = (known after apply)
          + nat                = true
          + nat_ip_address     = (known after apply)
          + nat_ip_version     = (known after apply)
          + security_group_ids = (known after apply)
          + subnet_id          = (known after apply)
        }

      + placement_policy {
          + host_affinity_rules = (known after apply)
          + placement_group_id  = (known after apply)
        }

      + resources {
          + core_fraction = 100
          + cores         = 2
          + memory        = 2
        }

      + scheduling_policy {
          + preemptible = (known after apply)
        }
    }

  # yandex_vpc_network.default will be created
  + resource "yandex_vpc_network" "default" {
      + created_at                = (known after apply)
      + default_security_group_id = (known after apply)
      + folder_id                 = (known after apply)
      + id                        = (known after apply)
      + labels                    = (known after apply)
      + name                      = "net"
      + subnet_ids                = (known after apply)
    }

  # yandex_vpc_subnet.default will be created
  + resource "yandex_vpc_subnet" "default" {
      + created_at     = (known after apply)
      + folder_id      = (known after apply)
      + id             = (known after apply)
      + labels         = (known after apply)
      + name           = "subnet"
      + network_id     = (known after apply)
      + v4_cidr_blocks = [
          + "10.10.10.0/24",
        ]
      + v6_cidr_blocks = (known after apply)
      + zone           = "ru-central1-a"
    }

Plan: 6 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + external_ip_address_vm_1 = [
      + (known after apply),
      + (known after apply),
    ]
  + internal_ip_address_vm_1 = [
      + (known after apply),
      + (known after apply),
    ]
```