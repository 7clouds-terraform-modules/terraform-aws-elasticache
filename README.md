# Terraform AWS Elasticache Module by 7Clouds

Thank you for riding with us! Feel free to download or reference this respository in your terraform projects and studies

This module is a part of our product SCA — An automated API and Serverless Infrastructure generator that can reduce your API development time by 40-60% and automate your deployments up to 90%! Check it out at <https://seventechnologies.cloud>

Please rank this repo 5 starts if you like our job!

## Usage

The module deploys an Elasticache Subnet Group and an Elasticache Cluster. May be used for deploying for both Redis and Memcached. Future enhancements may include Replication Group.

## Example

```hcl
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
  name = "security_group_for_testing"
  vpc_id = aws_vpc.main.id
}

module "elasticache_memcached" {
  source = "./"

  SUBNET_GROUP_NAME = "subnet-group-test-memcached"
  SUBNET_GROUP_IDS_LIST = [aws_subnet.subnet_1.id, aws_subnet.subnet_2.id] # It is a set of strings, so each item inside the list must be a different string. If you are referencing from Subnets with count argument, you should use the function join.

  CLUSTER_ID = "test-elasticache-memcached-cluster-0"
  CLUSTER_ENGINE = "memcached"
  CLUSTER_NODE_TYPE = "cache.t2.micro"
  CLUSTER_NUM_CACHE_NODES = 1
  CLUSTER_PORT_NUMBER = 11211
  CLUSTER_SECURITY_GROUPS_IDS = [aws_security_group.main.id]
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_elasticache_cluster.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_cluster) | resource |
| [aws_elasticache_subnet_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_subnet_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_CLUSTER_APPLY_IMMEDIATELY"></a> [CLUSTER\_APPLY\_IMMEDIATELY](#input\_CLUSTER\_APPLY\_IMMEDIATELY) | Whether any database modifications are applied immediately, or during the next maintenance window. Default is false | `bool` | `false` | no |
| <a name="input_CLUSTER_AUTO_MINOR_VERSION_UPGRADE"></a> [CLUSTER\_AUTO\_MINOR\_VERSION\_UPGRADE](#input\_CLUSTER\_AUTO\_MINOR\_VERSION\_UPGRADE) | Specifies whether minor version engine upgrades will be applied automatically to the underlying Cache Cluster instances during the maintenance window. Only supported for engine type 'redis' and if the engine version is 6 or higher. Defaults to true | `bool` | `true` | no |
| <a name="input_CLUSTER_AZS"></a> [CLUSTER\_AZS](#input\_CLUSTER\_AZS) | Availability Zone for the cache cluster. If you want to create cache nodes in multi-az, use preferred\_availability\_zones instead. Default: System chosen Availability Zone. Changing this value will re-create the resource | `string` | `null` | no |
| <a name="input_CLUSTER_AZ_MODE"></a> [CLUSTER\_AZ\_MODE](#input\_CLUSTER\_AZ\_MODE) | Memcached only. Whether the nodes in this Memcached node group are created in a single Availability Zone or created across multiple Availability Zones in the cluster's region. Valid values for this parameter are single-az or cross-az, default is single-az. If you want to choose cross-az, num\_cache\_nodes must be greater than 1 | `string` | `null` | no |
| <a name="input_CLUSTER_ENGINE"></a> [CLUSTER\_ENGINE](#input\_CLUSTER\_ENGINE) | Required if replication\_group\_id is not specified. Name of the cache engine to be used for this cache cluster. Valid values are memcached or redis | `string` | n/a | yes |
| <a name="input_CLUSTER_ENGINE_VERSION"></a> [CLUSTER\_ENGINE\_VERSION](#input\_CLUSTER\_ENGINE\_VERSION) | Version number of the cache engine to be used. If not set, defaults to the latest version. When engine is redis and the version is 6 or higher, the major and minor version can be set, e.g., 6.2, or the minor version can be unspecified which will use the latest version at creation time, e.g., 6.x. Otherwise, specify the full version desired, e.g., 5.0.6. The actual engine version used is returned in the attribute engine\_version\_actual | `string` | `null` | no |
| <a name="input_CLUSTER_FINAL_SNAPSHOT_IDENTIFIER"></a> [CLUSTER\_FINAL\_SNAPSHOT\_IDENTIFIER](#input\_CLUSTER\_FINAL\_SNAPSHOT\_IDENTIFIER) | Redis only. Name of your final cluster snapshot. If omitted, no final snapshot will be made | `string` | `null` | no |
| <a name="input_CLUSTER_ID"></a> [CLUSTER\_ID](#input\_CLUSTER\_ID) | Group identifier. ElastiCache converts this name to lowercase. Changing this value will re-create the resource | `string` | n/a | yes |
| <a name="input_CLUSTER_LOG_DELIVERY_CONFIGURATION"></a> [CLUSTER\_LOG\_DELIVERY\_CONFIGURATION](#input\_CLUSTER\_LOG\_DELIVERY\_CONFIGURATION) | The log\_delivery\_configuration block allows the streaming of Redis SLOWLOG or Redis Engine Log to CloudWatch Logs or Kinesis Data Firehose. Max of 2 blocks | `map(any)` | `{}` | no |
| <a name="input_CLUSTER_MAINTENANCE_WINDOW"></a> [CLUSTER\_MAINTENANCE\_WINDOW](#input\_CLUSTER\_MAINTENANCE\_WINDOW) | Specifies the weekly time range for when maintenance on the cache cluster is performed. The format is ddd:hh24:mi-ddd:hh24:mi (24H Clock UTC). The minimum maintenance window is a 60 minute period | `string` | `null` | no |
| <a name="input_CLUSTER_NODE_TYPE"></a> [CLUSTER\_NODE\_TYPE](#input\_CLUSTER\_NODE\_TYPE) | Required unless replication\_group\_id is provided. The instance class used.  For Memcached, changing this value will re-create the resource | `string` | n/a | yes |
| <a name="input_CLUSTER_NOTIFICATION_TOPIC_ARN"></a> [CLUSTER\_NOTIFICATION\_TOPIC\_ARN](#input\_CLUSTER\_NOTIFICATION\_TOPIC\_ARN) | ARN of an SNS topic to send ElastiCache notifications to. Example: arn:aws:sns:us-east-1:012345678999:my\_sns\_topic | `string` | `null` | no |
| <a name="input_CLUSTER_NUM_CACHE_NODES"></a> [CLUSTER\_NUM\_CACHE\_NODES](#input\_CLUSTER\_NUM\_CACHE\_NODES) | Required unless replication\_group\_id is provided. The initial number of cache nodes that the cache cluster will have. For Redis, this value must be 1. For Memcached, this value must be between 1 and 40. If this number is reduced on subsequent runs, the highest numbered nodes will be removed | `number` | n/a | yes |
| <a name="input_CLUSTER_PARAMETER_GROUP_NAME"></a> [CLUSTER\_PARAMETER\_GROUP\_NAME](#input\_CLUSTER\_PARAMETER\_GROUP\_NAME) | Required unless replication\_group\_id is provided. The name of the parameter group to associate with this cache cluster | `string` | `null` | no |
| <a name="input_CLUSTER_PORT_NUMBER"></a> [CLUSTER\_PORT\_NUMBER](#input\_CLUSTER\_PORT\_NUMBER) | The port number on which each of the cache nodes will accept connections. For Memcached the default is 11211, and for Redis the default port is 6379. Cannot be provided with replication\_group\_id. Changing this value will re-create the resource | `number` | `null` | no |
| <a name="input_CLUSTER_PREFERRED_AZS"></a> [CLUSTER\_PREFERRED\_AZS](#input\_CLUSTER\_PREFERRED\_AZS) | Memcached only. List of the Availability Zones in which cache nodes are created. If you are creating your cluster in an Amazon VPC you can only locate nodes in Availability Zones that are associated with the subnets in the selected subnet group. The number of Availability Zones listed must equal the value of num\_cache\_nodes. If you want all the nodes in the same Availability Zone, use availability\_zone instead, or repeat the Availability Zone multiple times in the list. Default: System chosen Availability Zones. Detecting drift of existing node availability zone is not currently supported. Updating this argument by itself to migrate existing node availability zones is not currently supported and will show a perpetual difference | `list(string)` | `[]` | no |
| <a name="input_CLUSTER_REPLICATION_GROUP_ID"></a> [CLUSTER\_REPLICATION\_GROUP\_ID](#input\_CLUSTER\_REPLICATION\_GROUP\_ID) | Required if engine is not specified. ID of the replication group to which this cluster should belong. If this parameter is specified, the cluster is added to the specified replication group as a read replica; otherwise, the cluster is a standalone primary that is not part of any replication group | `string` | `null` | no |
| <a name="input_CLUSTER_SECURITY_GROUPS_IDS"></a> [CLUSTER\_SECURITY\_GROUPS\_IDS](#input\_CLUSTER\_SECURITY\_GROUPS\_IDS) | VPC only. One or more VPC security groups associated with the cache cluster | `list(string)` | `[]` | no |
| <a name="input_CLUSTER_SNAPSHOT_ARNS"></a> [CLUSTER\_SNAPSHOT\_ARNS](#input\_CLUSTER\_SNAPSHOT\_ARNS) | Redis only. Single-element string list containing an Amazon Resource Name (ARN) of a Redis RDB snapshot file stored in Amazon S3. The object name cannot contain any commas. Changing snapshot\_arns forces a new resource | `list(string)` | `[]` | no |
| <a name="input_CLUSTER_SNAPSHOT_NAME"></a> [CLUSTER\_SNAPSHOT\_NAME](#input\_CLUSTER\_SNAPSHOT\_NAME) | Redis only. Name of a snapshot from which to restore data into the new node group. Changing snapshot\_name forces a new resource | `string` | `null` | no |
| <a name="input_CLUSTER_SNAPSHOT_RETENTION_LIMIT"></a> [CLUSTER\_SNAPSHOT\_RETENTION\_LIMIT](#input\_CLUSTER\_SNAPSHOT\_RETENTION\_LIMIT) | Redis only. Number of days for which ElastiCache will retain automatic cache cluster snapshots before deleting them. For example, if you set SnapshotRetentionLimit to 5, then a snapshot that was taken today will be retained for 5 days before being deleted. If the value of SnapshotRetentionLimit is set to zero (0), backups are turned off. Please note that setting a snapshot\_retention\_limit is not supported on cache.t1.micro cache nodes | `number` | `null` | no |
| <a name="input_CLUSTER_SNAPSHOT_WINDOW"></a> [CLUSTER\_SNAPSHOT\_WINDOW](#input\_CLUSTER\_SNAPSHOT\_WINDOW) | Daily time range (in UTC) during which ElastiCache will begin taking a daily snapshot of your cache cluster. Example: 05:00-09:00 | `string` | `null` | no |
| <a name="input_PROJECT_NAME"></a> [PROJECT\_NAME](#input\_PROJECT\_NAME) | The project name that will be prefixed to resource names on tags | `string` | `null` | no |
| <a name="input_SUBNET_GROUP_DESCRIPTION"></a> [SUBNET\_GROUP\_DESCRIPTION](#input\_SUBNET\_GROUP\_DESCRIPTION) | Description for the cache subnet group. Defaults to 'Managed by Terraform' | `string` | `"Subnet group for associating subnets to Elasticache Cluster Resource"` | no |
| <a name="input_SUBNET_GROUP_IDS_LIST"></a> [SUBNET\_GROUP\_IDS\_LIST](#input\_SUBNET\_GROUP\_IDS\_LIST) | List of VPC Subnet IDs for the cache subnet group | `list(string)` | n/a | yes |
| <a name="input_SUBNET_GROUP_NAME"></a> [SUBNET\_GROUP\_NAME](#input\_SUBNET\_GROUP\_NAME) | Name for the cache subnet group. ElastiCache converts this name to lowercase. | `string` | n/a | yes |
| <a name="input_TAGS"></a> [TAGS](#input\_TAGS) | Tags map | `map(string)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ELASTICACHE_CLUSTER_ID"></a> [ELASTICACHE\_CLUSTER\_ID](#output\_ELASTICACHE\_CLUSTER\_ID) | Elasticache Cluster's ID for references |
| <a name="output_ELASTICACHE_NODE_ADDRESS"></a> [ELASTICACHE\_NODE\_ADDRESS](#output\_ELASTICACHE\_NODE\_ADDRESS) | Elasticache node address for reference. It gets a list, so on referencing it in another module/resource you should use 'module.module\_name.ELASTICACHE\_NODE\_ADDRESS[item\_number\_you\_want]' |
| <a name="output_ELASTICACHE_NODE_PORT_NUMBER"></a> [ELASTICACHE\_NODE\_PORT\_NUMBER](#output\_ELASTICACHE\_NODE\_PORT\_NUMBER) | Elasticache node address for reference. It gets a list, so on referencing it in another module/resource you should use 'module.module\_name.ELASTICACHE\_NODE\_PORT\_NUMBER[item\_number\_you\_want] |
| <a name="output_ELASTICACHE_SUBNET_GROUP_ID"></a> [ELASTICACHE\_SUBNET\_GROUP\_ID](#output\_ELASTICACHE\_SUBNET\_GROUP\_ID) | Elasticache Cluster's ID for references |
<!-- END_TF_DOCS -->