output "resource_group" {
  value = azurerm_resource_group.rg.name
}

output "public_ip" {
  value       = azurerm_public_ip.pip.ip_address
  description = "Public IP of the web server"
}

output "vm_id" {
  value = azurerm_linux_virtual_machine.vm.id
}