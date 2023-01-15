locals {
  vms = {
    stage = {
      news: 1,
      redis: 1,
    },
    prod = {
      news: 2,
      redis: 3,
      balancer: 1,
    }

  }
  news_cores = {
    default = 2
    stage = 2
    prod = 2
  }
  news_disk_size = {
    default = 20
    stage = 20
    prod = 40
  }
  news_instance_count = {
    default = 1
    stage = 1
    prod = 2
  }
  vpc_subnets = {
    default = [
      {
        "v4_cidr_blocks": [
          "10.126.0.0/24"
        ],
//        "zone": var.yc_zone
      }
    ]
    stage = [
      {
        "v4_cidr_blocks": [
          "10.127.0.0/24"
        ],
  //      "zone": var.yc_zone
      }
    ]
    prod = [
      {
        zone           = "ru-central1-a"
        v4_cidr_blocks = ["10.128.0.0/24"]
      },
      {
        zone           = "ru-central1-b"
        v4_cidr_blocks = ["10.129.0.0/24"]
      },
      {
        zone           = "ru-central1-c"
        v4_cidr_blocks = ["10.130.0.0/24"]
      }
    ]
  }
}

