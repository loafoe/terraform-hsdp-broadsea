resource "cloudfoundry_app" "superset_proxy" {
  name         = "tf-superset-proxy-${local.postfix}"
  space        = data.cloudfoundry_space.space.id
  memory       = 128
  disk_quota   = 512
  docker_image = var.caddy_image
  docker_credentials = {
    username = var.docker_username
    password = var.docker_password
  }

  environment = merge({
    CADDYFILE_BASE64 = base64encode(templatefile("${path.module}/templates/Caddyfile", {
      webapi_hostname  = cloudfoundry_route.broadsea_proxy.endpoint
      rstudio_hostname = cloudfoundry_route.rstudio_proxy.endpoint
      webapi_url       = "http://${hsdp_container_host.broadsea.private_ip}:10000"
      rstudio_url      = "http://${hsdp_container_host.broadsea.private_ip}:10001"
    }))
  }, {})

  command           = "echo $CADDYFILE_BASE64 | base64 -d > /etc/caddy/Caddyfile && cat /etc/caddy/Caddyfile && caddy run -config /etc/caddy/Caddyfile"
  health_check_type = "process"

  //noinspection HCLUnknownBlockType
  routes {
    route = cloudfoundry_route.broadsea_proxy.id
  }
  //noinspection HCLUnknownBlockType
  routes {
    route = cloudfoundry_route.rstudio_proxy.id
  }
}

resource "cloudfoundry_route" "broadsea_proxy" {
  domain   = data.cloudfoundry_domain.domain.id
  space    = data.cloudfoundry_space.space.id
  hostname = "tf-broadsea-${local.postfix}"
}

resource "cloudfoundry_route" "rstudio_proxy" {
  domain   = data.cloudfoundry_domain.domain.id
  space    = data.cloudfoundry_space.space.id
  hostname = "tf-rstudio-${local.postfix}"
}
