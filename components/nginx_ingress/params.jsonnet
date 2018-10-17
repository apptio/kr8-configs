{
  local config = self,
  namespace: 'kube-system',
  release_name: 'nginx-ingress',
  kubecfg_gc_enable: true,
  annotations: {
    'nginx.ingress.kubernetes.io/force-ssl-redirect': 'true',
  },
}
