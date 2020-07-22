terraform {
  required_version = ">= 0.12"
}

 provider "aci" {
    #required_version = "= 0.3.3"
    # cisco-aci user name
    username = "admin"
    # cisco-aci password
    password = "ciscopsdt"
    # cisco-aci url
    url      = "https://sandboxapicdc.cisco.com"
    insecure = true
}

module "autoswitch"{
  source =".//auto_switch"
  tenant ="_terrform_hex_module"
  vrf_name = "rigtig_hex"
  bridge = "what_it_worked"
  type = "web_farm"
  service = "it_host"
  ip = ""
}




