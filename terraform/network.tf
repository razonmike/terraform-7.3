resource "yandex_vpc_network" "default" {
  name = "net"
}

resource "yandex_vpc_subnet" "default" {
  name = "subnet"
  zone           = var.yc_zone
  network_id     = "${yandex_vpc_network.default.id}"
  v4_cidr_blocks = ["10.10.10.0/24"]
}