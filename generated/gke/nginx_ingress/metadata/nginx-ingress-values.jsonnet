controller:
  extraArgs:
    sort-backends: true
  image:
    tag: 0.17.1
  metrics:
    enabled: true
  publishService:
    enabled: true
  service:
    type: LoadBalancer
  stats:
    enabled: true
rbac:
  create: true

