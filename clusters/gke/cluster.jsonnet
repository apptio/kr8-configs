{
  _cluster+: {
    tier: 'dev',
    region_name: 'us-west1',
    cluster_name: 'gke',
    cluster_type: 'gke',
    dns_domain: 'example.com',
  },
  _components+: {
    sealed_secrets: { path: 'components/sealed_secrets' },
    nginx_ingress: { path: 'components/nginx_ingress' },
    external_dns: { path: 'components/external_dns' },
    cert_manager: { path: 'components/cert_manager' },
  },

  external_dns+: {

    provider: 'google',
    txtPrefix: '_',
    domainFilters: [
      'example.com',
    ],
  },
}
