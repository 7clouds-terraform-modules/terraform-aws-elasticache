# ELASTICACHE SUBNET GROUP VARIABLES

# REQUIRED
variable "SUBNET_GROUP_NAME" {
  description = "Name for the cache subnet group. ElastiCache converts this name to lowercase."
  type        = string
}

variable "SUBNET_GROUP_IDS_LIST" {
  description = "List of VPC Subnet IDs for the cache subnet group"
  type        = list(string)
}

# OPTIONAL

variable "PROJECT_NAME" {
  description = "The project name that will be prefixed to resource names on tags"
  type        = string
  default     = null
}

variable "SUBNET_GROUP_DESCRIPTION" {
  description = "Description for the cache subnet group. Defaults to 'Managed by Terraform'"
  type        = string
  default     = "Subnet group for associating subnets to Elasticache Cluster Resource"
}

# ELASTICACHE CLUSTER VARIABLES

# REQUIRED

variable "CLUSTER_ID" {
  description = "Group identifier. ElastiCache converts this name to lowercase. Changing this value will re-create the resource"
  type        = string
}

variable "CLUSTER_ENGINE" {
  description = "Required if replication_group_id is not specified. Name of the cache engine to be used for this cache cluster. Valid values are memcached or redis"
  type        = string
}

variable "CLUSTER_NODE_TYPE" {
  description = "Required unless replication_group_id is provided. The instance class used.  For Memcached, changing this value will re-create the resource"
  type        = string
}

variable "CLUSTER_NUM_CACHE_NODES" {
  description = "Required unless replication_group_id is provided. The initial number of cache nodes that the cache cluster will have. For Redis, this value must be 1. For Memcached, this value must be between 1 and 40. If this number is reduced on subsequent runs, the highest numbered nodes will be removed"
  type        = number
}

variable "CLUSTER_PARAMETER_GROUP_NAME" {
  description = "Required unless replication_group_id is provided. The name of the parameter group to associate with this cache cluster"
  type        = string
  default     = null
}

# OPTIONAL

variable "CLUSTER_APPLY_IMMEDIATELY" {
  description = "Whether any database modifications are applied immediately, or during the next maintenance window. Default is false"
  type        = bool
  default     = false
}

variable "CLUSTER_AUTO_MINOR_VERSION_UPGRADE" {
  description = "Specifies whether minor version engine upgrades will be applied automatically to the underlying Cache Cluster instances during the maintenance window. Only supported for engine type 'redis' and if the engine version is 6 or higher. Defaults to true"
  type        = bool
  default     = true
}

variable "CLUSTER_AZS" {
  description = "Availability Zone for the cache cluster. If you want to create cache nodes in multi-az, use preferred_availability_zones instead. Default: System chosen Availability Zone. Changing this value will re-create the resource"
  type        = string
  default     = null
}

variable "CLUSTER_AZ_MODE" {
  description = "Memcached only. Whether the nodes in this Memcached node group are created in a single Availability Zone or created across multiple Availability Zones in the cluster's region. Valid values for this parameter are single-az or cross-az, default is single-az. If you want to choose cross-az, num_cache_nodes must be greater than 1"
  type        = string
  default     = null
}

variable "CLUSTER_ENGINE_VERSION" {
  description = "Version number of the cache engine to be used. If not set, defaults to the latest version. When engine is redis and the version is 6 or higher, the major and minor version can be set, e.g., 6.2, or the minor version can be unspecified which will use the latest version at creation time, e.g., 6.x. Otherwise, specify the full version desired, e.g., 5.0.6. The actual engine version used is returned in the attribute engine_version_actual"
  type        = string
  default     = null
}

variable "CLUSTER_FINAL_SNAPSHOT_IDENTIFIER" {
  description = "Redis only. Name of your final cluster snapshot. If omitted, no final snapshot will be made"
  type        = string
  default     = null
}

variable "CLUSTER_LOG_DELIVERY_CONFIGURATION" {
  description = "The log_delivery_configuration block allows the streaming of Redis SLOWLOG or Redis Engine Log to CloudWatch Logs or Kinesis Data Firehose. Max of 2 blocks"
  type        = map(any)
  default     = {}
}

variable "CLUSTER_MAINTENANCE_WINDOW" {
  description = "Specifies the weekly time range for when maintenance on the cache cluster is performed. The format is ddd:hh24:mi-ddd:hh24:mi (24H Clock UTC). The minimum maintenance window is a 60 minute period"
  type        = string
  default     = null
}

variable "CLUSTER_NOTIFICATION_TOPIC_ARN" {
  description = " ARN of an SNS topic to send ElastiCache notifications to. Example: arn:aws:sns:us-east-1:012345678999:my_sns_topic"
  type        = string
  default     = null
}

variable "CLUSTER_PORT_NUMBER" {
  description = "The port number on which each of the cache nodes will accept connections. For Memcached the default is 11211, and for Redis the default port is 6379. Cannot be provided with replication_group_id. Changing this value will re-create the resource"
  type        = number
  default     = null
}

variable "CLUSTER_PREFERRED_AZS" {
  description = "Memcached only. List of the Availability Zones in which cache nodes are created. If you are creating your cluster in an Amazon VPC you can only locate nodes in Availability Zones that are associated with the subnets in the selected subnet group. The number of Availability Zones listed must equal the value of num_cache_nodes. If you want all the nodes in the same Availability Zone, use availability_zone instead, or repeat the Availability Zone multiple times in the list. Default: System chosen Availability Zones. Detecting drift of existing node availability zone is not currently supported. Updating this argument by itself to migrate existing node availability zones is not currently supported and will show a perpetual difference"
  type        = list(string)
  default     = []
}

variable "CLUSTER_REPLICATION_GROUP_ID" {
  description = "Required if engine is not specified. ID of the replication group to which this cluster should belong. If this parameter is specified, the cluster is added to the specified replication group as a read replica; otherwise, the cluster is a standalone primary that is not part of any replication group"
  type        = string
  default     = null
}

variable "CLUSTER_SECURITY_GROUPS_IDS" {
  description = "VPC only. One or more VPC security groups associated with the cache cluster"
  type        = list(string)
  default     = []
}

variable "CLUSTER_SNAPSHOT_ARNS" {
  description = "Redis only. Single-element string list containing an Amazon Resource Name (ARN) of a Redis RDB snapshot file stored in Amazon S3. The object name cannot contain any commas. Changing snapshot_arns forces a new resource"
  type        = list(string)
  default     = []
}

variable "CLUSTER_SNAPSHOT_NAME" {
  description = "Redis only. Name of a snapshot from which to restore data into the new node group. Changing snapshot_name forces a new resource"
  type        = string
  default     = null
}

variable "CLUSTER_SNAPSHOT_RETENTION_LIMIT" {
  description = "Redis only. Number of days for which ElastiCache will retain automatic cache cluster snapshots before deleting them. For example, if you set SnapshotRetentionLimit to 5, then a snapshot that was taken today will be retained for 5 days before being deleted. If the value of SnapshotRetentionLimit is set to zero (0), backups are turned off. Please note that setting a snapshot_retention_limit is not supported on cache.t1.micro cache nodes"
  type        = number
  default     = null
}

variable "CLUSTER_SNAPSHOT_WINDOW" {
  description = "Daily time range (in UTC) during which ElastiCache will begin taking a daily snapshot of your cache cluster. Example: 05:00-09:00"
  type        = string
  default     = null
}

# TAGS VARIABLE

variable "TAGS" {
  description = "Tags map"
  type        = map(string)
  default     = null
}