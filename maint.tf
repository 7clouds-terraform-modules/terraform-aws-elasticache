resource "aws_elasticache_subnet_group" "this" {
name = var.SUBNET_GROUP_NAME
subnet_ids = var.SUBNET_GROUP_IDS_LIST
description = var.SUBNET_GROUP_DESCRIPTION
tags = var.TAGS 
}

resource "aws_elasticache_cluster" "this" {
  cluster_id = var.CLUSTER_ID
  engine = var.CLUSTER_ENGINE
  node_type = var.CLUSTER_NODE_TYPE
  num_cache_nodes = var.CLUSTER_NUM_CACHE_NODES
  parameter_group_name = var.CLUSTER_PARAMETER_GROUP_NAME

  apply_immediately = var.CLUSTER_APPLY_IMMEDIATELY
  auto_minor_version_upgrade = var.CLUSTER_AUTO_MINOR_VERSION_UPGRADE
  availability_zone = var.CLUSTER_AZS
  az_mode = var.CLUSTER_AZ_MODE
  engine_version = var.CLUSTER_ENGINE_VERSION
  final_snapshot_identifier = var.CLUSTER_FINAL_SNAPSHOT_IDENTIFIER
  dynamic "log_delivery_configuration" {
    for_each = var.CLUSTER_LOG_DELIVERY_CONFIGURATION

    content {
        destination = CLUSTER_LOG_DELIVERY_CONFIGURATION.value.destination
        destination_type = CLUSTER_LOG_DELIVERY_CONFIGURATION.value.destination_type
        log_format = CLUSTER_LOG_DELIVERY_CONFIGURATION.value.log_format
        log_type = CLUSTER_LOG_DELIVERY_CONFIGURATION.value.log_type
    }
  }
  maintenance_window = var.CLUSTER_MAINTENANCE_WINDOW
  notification_topic_arn = var.CLUSTER_NOTIFICATION_TOPIC_ARN
  port = var.CLUSTER_PORT_NUMBER
  preferred_availability_zones = var.CLUSTER_PREFERRED_AZS
  replication_group_id = var.CLUSTER_REPLICATION_GROUP_ID
  security_group_ids = var.CLUSTER_SECURITY_GROUPS_IDS
  snapshot_arns = var.CLUSTER_SNAPSHOT_ARNS
  snapshot_name = var.CLUSTER_SNAPSHOT_NAME
  snapshot_retention_limit = var.CLUSTER_SNAPSHOT_RETENTION_LIMIT
  snapshot_window = var.CLUSTER_SNAPSHOT_WINDOW
  subnet_group_name = aws_elasticache_subnet_group.this.name
  tags = var.TAGS
}
