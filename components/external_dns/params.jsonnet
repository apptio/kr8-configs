{
  release_name: 'external-dns',  // equivalent of name used for helm install --name ...
  namespace: 'external-dns',
  kubecfg_gc_enable: true,

  provider: 'aws',
  // must be a list
  domainFilters: [],
  txtOwnerId: std.format('%s', $._cluster.cluster_name),
}
