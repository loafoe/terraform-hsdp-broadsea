module "broadsea" {
  source = "/../../"

  org_name   = var.cf_org_name
  space_name = var.cf_space_name

  user        = var.ldap_user
  user_groups = [var.ldap_user]

  cartel_secret = var.cartel_secret
  cartel_token  = var.cartel_token

  agent = true
}
