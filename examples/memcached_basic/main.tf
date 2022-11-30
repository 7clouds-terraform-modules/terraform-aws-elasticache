resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "subnet_1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
}

resource "aws_subnet" "subnet_2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
}

resource "aws_security_group" "main" {
  name   = "security_group_for_testing"
  vpc_id = aws_vpc.main.id
}

module "elasticache_memcached" {
  source = "../.."

  SUBNET_GROUP_NAME     = "subnet-group-test-memcached"
  SUBNET_GROUP_IDS_LIST = [aws_subnet.subnet_1.id, aws_subnet.subnet_2.id]

  CLUSTER_ID                  = "test-elasticache-memcached-cluster-0"
  CLUSTER_ENGINE              = "memcached"
  CLUSTER_NODE_TYPE           = "cache.t2.micro"
  CLUSTER_NUM_CACHE_NODES     = 1
  CLUSTER_PORT_NUMBER         = 11211
  CLUSTER_SECURITY_GROUPS_IDS = [aws_security_group.main.id]
}
