{
  _cluster: {
    // Global Defaults and Mandatory Parameters
    cluster_name: error '"cluster_name" must be set to the cluster name',
    cluster_type: error '"cluster_type" must be set to the cluster type',
    region_name: error '"region_name" must be set to the region name',
    tier: error '"tier" must be set to the tier name',

    aws_region: if $._cluster.cluster_type == 'aws' then error 'aws_region must be set for aws clusters' else null,
  },
} +
{
  // Components
  _components: {
    sealed_secrets: { path: 'components/sealed_secrets' },

  },
    // Components for AWS clusters
}
