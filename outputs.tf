output "ELASTICACHE_NODE_ADDRESS" {
  description = "Elasticache node address for reference"
  value = aws_elasticache_cluster.this.cache_nodes.0.address
}

output "ELASTICACHE_NODE_PORT_NUMBER" {
  description = "Elasticache node address for reference"
  value = aws_elasticache_cluster.this.cache_nodes.0.port
}