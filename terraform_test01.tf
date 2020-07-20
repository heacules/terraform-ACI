terraform {
  required_version = ">= 0.12"
}

locals {
 #vrf = "vrf_a"
  vrf = {
    1 = "VRF_A"
    2 = "VRF_B"
  }
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

resource "aci_tenant" "terraform-rocks_2"{
   name = "terraform-rocks_2"
   description ="This tenant is created by terraform"
}

resource "aci_vrf" "vrf_a"{
   tenant_dn = aci_tenant.terraform-rocks_2.id
   name = local.vrf.1
}

#resource "aci_tenant" "test-tenant" {
#  name        = "test-tenant"
#  description = "This tenant is created by terraform"
#}

resource "aci_application_profile" "test-app" {
  tenant_dn   = aci_tenant.terraform-rocks_2.id
  name        = "test-app"
  description = "This app profile is created by terraform"
}

resource "aci_bridge_domain" "terraform_bridge"{
    tenant_dn = aci_tenant.terraform-rocks_2.id
    name = "Terraform_bridge"
    arp_flood = "yes"
    relation_fv_rs_ctx = aci_vrf.vrf_a.id
}

resource "aci_subnet" "terraformsubnet" {
    bridge_domain_dn = aci_bridge_domain.terraform_bridge.id
    ip = "10.60.23.1/24"
    #scope = "private"
}
resource "aci_application_epg" "terraform_epg"{
    application_profile_dn = aci_application_profile.test-app.id
    name = "terraform_epg"
}
#
#data "aci_tenant" "import_2"{
#  name = "import_test"
#}
#resource "aci_vrf" "vrf_b"{
#   tenant_dn = aci_tenant.import_test.id
#   name = locals.vrf.2  
#}