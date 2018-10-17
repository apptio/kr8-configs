local config = std.extVar('config');

{
  kind: 'Namespace',
  apiVersion: 'v1',
  metadata: {
    namespace: config.namespace,
    labels: {
      name: config.namespace,
    },
    name: config.namespace,
  },
}
