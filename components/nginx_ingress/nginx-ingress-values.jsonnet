local config = std.extVar('kr8');

{
  rbac: {
    create: true,
  },
  controller: {
    config: {
     // "use-proxy-protocol": "true",
    },
    image: {
      tag: '0.17.1',
    },
    extraArgs: {
      'sort-backends': true,
    },
    publishService: {
      enabled: true,
    },
    stats: {
      enabled: true,
    },

    service: {
    //  targetPorts: {
    //    https: 'http',
    //  },
      type: 'LoadBalancer',
    //  annotations: config.annotations,
    },

    metrics: {
      enabled: true,
    },
  },
}
