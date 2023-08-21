
location = "central us"
env = ["pro", "dev"]
app = "commet"
rg_name = ["network", "app", "database", "storage"]
address_space = ["172.20.10.0/25"]
subnets = {
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
ngw_sku = "Standard"
ngw_subnet = ["web", "app"]

