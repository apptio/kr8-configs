domainFilters:
- example.com
logLevel: debug
nameOverride: external-dns
policy: sync
provider: google
rbac:
  create: true
registry: txt
txtOwnerId: gke
txtPrefix: _

