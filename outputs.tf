output "ELASTICACHE_NODE_ADDRESS" {
  description = "Elasticache node address for reference. It gets a list, so on referencing it in another module/resource you should use 'module.module_name.ELASTICACHE_NODE_ADDRESS[item_number_you_want]'"
  value       = aws_elasticache_cluster.this.cache_nodes.*.address
}

output "ELASTICACHE_NODE_PORT_NUMBER" {
  description = "Elasticache node address for reference. It gets a list, so on referencing it in another module/resource you should use 'module.module_name.ELASTICACHE_NODE_PORT_NUMBER[item_number_you_want]"
  value       = aws_elasticache_cluster.this.cache_nodes.*.port
}

output "ELASTICACHE_CLUSTER_ID" {
  description = "Elasticache Cluster's ID for references"
  value       = aws_elasticache_cluster.this.id
}

output "ELASTICACHE_SUBNET_GROUP_ID" {
  description = "Elasticache Cluster's ID for references"
  value       = aws_elasticache_subnet_group.this.id
}