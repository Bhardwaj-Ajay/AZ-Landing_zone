
location = "central us"


env = ["pro", "dev"]


app = "commet"


rg_name = ["network", "app", "database", "storage"]


pro_address_space = ["172.20.10.0/25", "172.20.30.0/25"]

pro_subnets = {
  web = {
    address_prefix = "172.20.10.0/28"
  },
  app = {
    address_prefix = "172.20.10.16/28"
  },
  db = {
    address_prefix = "172.20.10.32/28"
  }

}
dev_address_space = ["172.20.20.0/25"]

dev_subnets = {
  web = {
    address_prefix = "172.20.20.0/28"
  },
  app = {
    address_prefix = "172.20.20.16/28"
  },
  db = {
    address_prefix = "172.20.20.32/28"
  }

}