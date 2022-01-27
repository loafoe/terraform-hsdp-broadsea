variable "instance_type" {
  description = "The instance type to use"
  type        = string
  default     = "m5.xlarge"
}

variable "volume_size" {
  description = "The volume size to use in GB"
  type        = number
  default     = 50
}

variable "user_groups" {
  description = "User groups to assign to cluster"
  type        = list(string)
}

variable "user" {
  description = "LDAP user to use for connections"
  type        = string
}


variable "agent" {
  description = "Use SSH agent for authentication"
  type        = bool
  default     = false
}

variable "private_key" {
  description = "Private key for SSH access (should not have a passphrase)"
  type        = string
  default     = ""
}

variable "org_name" {
  description = "Cloudfoundry ORG name to use for reverse proxy"
  type        = string
}

variable "space_name" {
  description = "Cloudfoundry SPACE name to use for reverse proxy"
  type        = string
}

variable "broadsea_methods_library_image" {
  description = "The Broadsea methods library image to use"
  type        = string
  default     = "ohdsi/broadsea-methodslibrary:latest"
}

variable "broadsea_webtools_image" {
  description = "The Broadsea methods library image to use"
  type        = string
  default     = "ohdsi/broadsea-webtools:latest"
}

variable "fluent_bit_image" {
  description = "Fluent-bit image"
  type        = string
  default     = "philipssoftware/fluent-bit-out-hsdp:latest"
}

variable "postgres_plan" {
  description = "The HSDP-RDS PostgreSQL plan to use"
  type        = string
  default     = "postgres-medium-dev"
}

variable "hsdp_shared_key" {
  description = "HSDP Logging shared key"
  type        = string
  default     = ""
}

variable "hsdp_secret_key" {
  description = "HSDP Logging secret key"
  type        = string
  default     = ""
}

variable "hsdp_product_key" {
  description = "HSDP Logging product key"
  type        = string
  default     = ""
}

variable "hsdp_custom_field" {
  description = "Post structured JSON message to HSDP Logging custom field"
  type        = string
  default     = "true"
}

variable "hsdp_region" {
  description = "The HSDP region of the deployment"
  type        = string
  default     = "us-east"
}

variable "hsdp_environment" {
  description = "The HSDP environment of the deployment"
  type        = string
  default     = "client-test"
}

variable "cartel_token" {
  description = "The Cartel token to use for autoscaling"
  type        = string
  default     = ""
}

variable "cartel_secret" {
  description = "The Cartel secret to use for autoscaling"
  type        = string
  default     = ""
}

variable "name_postfix" {
  type        = string
  description = "The postfix string to append to the hostname, prevents namespace clashes"
  default     = ""
}

variable "docker_username" {
  type        = string
  description = "Docker registry username"
  default     = ""
}

variable "docker_password" {
  type        = string
  description = "Docker registry password"
  default     = ""
}

variable "caddy_image" {
  type        = string
  description = "Caddy server image to use"
  default     = "caddy:2.4.5"
}

variable "omop_data_hostname" {
  type        = string
  description = "The OMOP database hostname"
}

variable "omop_data_username" {
  type        = string
  description = "The OMOP database username"
}

variable "omop_data_password" {
  type        = string
  description = "The OMOP database password"
}

