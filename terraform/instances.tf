module "instance" {
  for_each = local.vms[terraform.workspace]
  source = "./modules/instance"
  instance_count = each.value

  subnet_id     = module.vpc.subnet_ids[0]
//  zone          = var.yc_zone
//  folder_id     = var.yc_folder_id
  image         = var.image
  platform_id   = "standard-v2"
  name          = each.key
  description   = "News App Demo"
  instance_role = "news,balancer"
  users         = "centos"
  cores         = local.news_cores[terraform.workspace]
  boot_disk     = "network-ssd"
  disk_size     = local.news_disk_size[terraform.workspace]
  nat           = "true"
  memory        = "2"
  core_fraction = "100"
}

output "public_ip" {
  value = {
    for k, v in module.instance : k => v.instance_public_ip
  }
}