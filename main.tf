locals {
  postfix = var.name_postfix != "" ? var.name_postfix : random_pet.deploy.id
}

resource "random_pet" "deploy" {
}

resource "hsdp_container_host" "broadsea" {
  name          = "broadsea-${local.postfix}.dev"
  volumes       = 1
  volume_size   = var.volume_size
  instance_type = var.instance_type

  user_groups     = var.user_groups
  security_groups = ["analytics"]

  user = var.user

  private_key = var.private_key
  agent       = var.agent

  commands = [
    "docker volume create broadsea",
  ]
}

resource "hsdp_container_host_exec" "server" {
  triggers = {
    cluster_instance_ids = hsdp_container_host.broadsea.id
  }

  host        = hsdp_container_host.broadsea.private_ip
  user        = var.user
  private_key = var.private_key
  agent       = var.agent

  file {
    content = templatefile("${path.module}/scripts/bootstrap-server.sh.tmpl", {
      postgres_username              = module.postgres.credentials.username
      postgres_password              = module.postgres.credentials.password
      postgres_hostname              = module.postgres.credentials.hostname
      enable_fluentd                 = var.hsdp_product_key == "" ? "false" : "true"
      log_driver                     = var.hsdp_product_key == "" ? "local" : "fluentd"
      broadsea_webtools_image        = var.broadsea_webtools_image
      broadsea_methods_library_image = var.broadsea_methods_library_image
      superset_id                    = random_pet.deploy.id
    })
    destination = "/home/${var.user}/bootstrap-server.sh"
    permissions = "0755"
  }

  file {
    content = templatefile("${path.module}/scripts/bootstrap-fluent-bit.sh.tmpl", {
      ingestor_host    = data.hsdp_config.logging.url
      shared_key       = var.hsdp_shared_key
      secret_key       = var.hsdp_secret_key
      product_key      = var.hsdp_product_key
      custom_field     = var.hsdp_custom_field
      fluent_bit_image = var.fluent_bit_image
    })
    destination = "/home/${var.user}/bootstrap-fluent-bit.sh"
    permissions = "0755"
  }

  commands = [
    "/home/${var.user}/bootstrap-fluent-bit.sh",
    "/home/${var.user}/bootstrap-server.sh"
  ]
}
