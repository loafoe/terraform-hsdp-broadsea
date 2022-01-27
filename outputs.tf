output "broadsea_proxy_endpoint" {
  description = "URL of the Broadsea proxy"
  value       = cloudfoundry_route.broadsea_proxy.endpoint
}

output "broadsea_ip" {
  description = "Private IP address of Broadsea server"
  value       = hsdp_container_host.broadsea.private_ip
}

output "broadsea_id" {
  description = "Server ID of Broadsea"
  value       = random_pet.deploy.id
}
