output "replication_instance" {
  value = aws_dms_replication_instance.service
}

output "replication_task" {
  value = aws_dms_replication_task.service
}

output "dms_endpoint_source" {
  value = aws_dms_endpoint.source
}

output "dms_endpoint_target" {
  value = aws_dms_endpoint.target
}
