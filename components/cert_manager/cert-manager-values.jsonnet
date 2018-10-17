local config = std.extVar('kr8');

{
  rbac: {
    create: true,
  },

  ingressShim: {
    defaultIssuerName: 'letsencrypt',
    defaultIssuerKind: 'ClusterIssuer',
  },

}
