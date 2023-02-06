resource "aws_route_table_association" "Association" {
  count = length(var.subnet-ip)
  subnet_id      = var.subnet-ip[count.index]
  route_table_id = var.table-id
}