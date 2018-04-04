output "vpc_id" {
  description = "This is ID of the security group"
  value       = "${aws_vpc.VPC_TRF.id}"
}

output "gw_id" {
  description = "This is Gateway id"
  value       = "${aws_internet_gateway.GW_TRF.id}"
}

output "route_table_id" {
  description = "This is route table id created for VPC"
  value       = "${(aws_route_table.RT_TRF.id)}"
}

output "nacl_id" {
  description = "This is route table id created for VPC"
  value       = "${(aws_network_acl.NACL_TRF.id)}"
}

output "subnet_id" {
  description = "This is Gateway id"
  value       = "${aws_subnet.SUBNET_TRF.id}"
}

output "security_group_id" {
  description = "This is security group id"
  value       = "${module.createSG_Name.security_group_id}"
}
