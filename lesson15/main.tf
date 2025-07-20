module "subnet_data" {
  source = "./modules/data-subnets"
  vpc_id = var.vpc_id
}

module "vm" {
  source = "./modules/vm-creation"

  ami_id        = var.ami_id
  instance_type = var.instance_type
  instance_name = var.instance_name
  subnet_id     = module.subnet_data.subnet_ids_by_zone[var.zone][0]
}