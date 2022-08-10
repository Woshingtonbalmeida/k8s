#output "subnet_id" {
#  value = azurerm_subnet.sub10.id
#}
#output "vnet_id" {
#  value = azurerm_virtual_network.vnet.id
#}
output "vm_ip_0" {
  value = azurerm_linux_virtual_machine.vm[0].public_ip_address
}
output "vm_ip_1" {
  value = azurerm_linux_virtual_machine.vm[1].public_ip_address
}
output "vm_ip_2" {
  value = azurerm_linux_virtual_machine.vm[2].public_ip_address
}
output "vm_ip_3" {
  value = azurerm_linux_virtual_machine.vm[3].public_ip_address
}
output "vm_ip_4" {
  value = azurerm_linux_virtual_machine.vm[4].public_ip_address
}
output "vm_ip_5" {
  value = azurerm_linux_virtual_machine.vm[5].public_ip_address
}
