{
  _cluster+: {
    tier: 'dev',
    region_name: 'sfo2',
    cluster_name: 'digitalocean',
    cluster_type: 'digitalocean',
    dns_domain: 'example.com',
  },
  _components+: {
    sealed_secrets: { path: 'components/sealed_secrets' },
    nginx_ingress: { path: 'components/nginx_ingress' },
    external_dns: { path: 'components/external_dns' },
    cert_manager: { path: 'components/cert_manager' },
  },

  external_dns+: {
    extraEnv: {
      CF_API_KEY: 'some_key',
      CF_API_EMAIL: 'admin@example.com',
    },

    provider: 'cloudflare',
    txtPrefix: 'do',
    domainFilters: [
      'example.com',
      'example.io',
      'example.work',
    ],
  },
}
