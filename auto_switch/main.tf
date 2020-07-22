terraform {
  required_version = ">= 0.12"
}

resource "aci_tenant" "terraform-rocks"{
   name = var.tenant
   description ="by terraform: https://github.com/heacules/terraform-ACI"
}

resource "aci_vrf" "vrf_a"{
   tenant_dn = aci_tenant.terraform-rocks.id
   name = var.vrf_name
}

resource "aci_bridge_domain" "terraform_bridge"{
    tenant_dn = aci_tenant.terraform-rocks.id
    name = var.bridge
    arp_flood = "yes"
    relation_fv_rs_ctx = aci_vrf.vrf_a.id
}

resource "aci_application_profile" "ap_01" {
  tenant_dn  = aci_tenant.terraform-rocks.id
  name       = var.type
}


 resource "aci_application_epg" "fooapplication_epg" {
    application_profile_dn  = aci_application_profile.ap_01.id
    name                        = "${var.type}-${var.service}"
    description                   = "%s"
    annotation                    = "tag_epg"
    exception_tag               = "0"
    flood_on_encap               = "disabled"
    #fwd_ctrl                    = "none"
    has_mcast_source            = "no"
    is_attr_based_epg           = "no"
    match_t                     = "AtleastOne"
    name_alias                  = "alias_epg"
    pc_enf_pref                 = "unenforced"
    pref_gr_memb                = "exclude"
    prio                            = "unspecified"
    shutdown                    = "no"
  }

    resource "aci_subnet" "foosubnet" {
        bridge_domain_dn = aci_bridge_domain.terraform_bridge.id
        ip               = var.ip
        annotation       = "${var.type}-${var.service}"
       # name_alias       = "alias_subnet"
        preferred        = "no"
        scope            = "private"
        virtual          = "yes"
    } 