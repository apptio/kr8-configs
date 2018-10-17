local config = std.extVar('kr8');

{
  nameOverride: config.release_name,
  txtOwnerId: config.txtOwnerId,
  domainFilters: config.domainFilters,
  provider: config.provider,
  [if std.objectHas(config, 'txtPrefix') then 'txtPrefix']: config.txtPrefix,
  aws: {} + if std.objectHas(config, 'aws') then config.aws else {},
  extraEnv: {} + if std.objectHas(config, 'extraEnv') then config.extraEnv else {},
  /*
  nodeSelector: {
    'node-role.kubernetes.io/master': '',
  },
  tolerations: [
    {
      operator: 'Exists',
      value: '',
      effect: 'NoSchedule',
      key: 'node-role.kubernetes.io/master',
    },
  ],
  */
  registry: 'txt',
  rbac: {
    create: true,
  },
  policy: 'sync',
  logLevel: 'debug',
}
