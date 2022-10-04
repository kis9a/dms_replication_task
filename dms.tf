resource "aws_dms_endpoint" "source" {
  endpoint_id   = "${var.prefix}-source"
  endpoint_type = "source"
  engine_name   = var.source_map.engine_name
  server_name   = var.source_map.server_name
  port          = var.source_map.port
  database_name = var.source_map.database_name
  username      = var.source_map.username
  password      = var.source_map.password
}

resource "aws_dms_endpoint" "target" {
  endpoint_id   = "${var.prefix}-target"
  endpoint_type = "target"
  engine_name   = var.target_map.engine_name
  server_name   = var.target_map.server_name
  port          = var.target_map.port
  database_name = var.target_map.database_name
  username      = var.target_map.username
  password      = var.target_map.password
}

resource "aws_dms_replication_instance" "service" {
  replication_instance_id     = "${var.prefix}-replication-instance"
  replication_subnet_group_id = aws_dms_replication_subnet_group.service.id
  kms_key_arn                 = var.kms_key_arn
  publicly_accessible         = var.public_accessible
  vpc_security_group_ids      = var.security_group_ids
  replication_instance_class  = var.instance_class
  allocated_storage           = var.allocated_storage
  apply_immediately           = var.apply_immediately
  multi_az                    = var.multi_az
  depends_on = [
    aws_iam_role_policy_attachment.dms_access_for_endpoint_amazon_dms_redshift_s3_role,
    aws_iam_role_policy_attachment.dms_cloudwatch_logs_role_amazon_dms_cloud_watch_logs_role,
    aws_iam_role_policy_attachment.dms_vpc_role_amazon_dmsvpc_management_role
  ]
}

resource "aws_dms_replication_subnet_group" "service" {
  replication_subnet_group_description = "${var.prefix}-dms-replication-subnet-group"
  replication_subnet_group_id          = "${var.prefix}-dms-replication-subnet-group"
  subnet_ids                           = var.subnet_ids
}

resource "aws_dms_replication_task" "service" {
  migration_type           = var.migration_type
  replication_instance_arn = aws_dms_replication_instance.service.replication_instance_arn
  replication_task_id      = "${var.prefix}-dms-replication-task"
  table_mappings           = var.table_mappings_string
  source_endpoint_arn      = aws_dms_endpoint.source.endpoint_arn
  target_endpoint_arn      = aws_dms_endpoint.target.endpoint_arn
}
