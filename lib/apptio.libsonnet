local kube = import 'kube.libsonnet';

// helper library for k8s in apptio

{
  //--------- RBAC

  // rolerefs for pre-defined roles, to use in rolebindings (these are invisible)
  roleref_admin_clusterrole:: {
    kind: 'ClusterRole',
    metadata: {
      name: 'admin',
    },
  },
  roleref_clusteradmin_clusterrole:: {
    kind: 'ClusterRole',
    metadata: {
      name: 'cluster-admin',
    },
  },
  roleref_view_clusterrole:: {
    kind: 'ClusterRole',
    metadata: {
      name: 'view',
    },
  },

  namespace(name): { metadata+: { namespace: name } },

  personal_namespace_binding(user, roleref, nameformat):
    // A binding in the user's personal namespace
    kube.RoleBinding(std.format(nameformat, user)) {
      roleRef_: roleref,
      subjects: [
        {
          kind: 'User',
          name: std.format('%s@apptio.com', user),
          apiGroup: 'rbac.authorization.k8s.io',
        },
      ],
    } + $.namespace(user),

  usergroups_to_namespace_binding(groups, users, roleref, namespace, nameformat='%s_rolebinding'):
    kube.RoleBinding(std.format(nameformat, namespace)) {
      local u_subject(user) = {
        kind: 'User',
        name: std.format('%s@apptio.com', user),
        apiGroup: 'rbac.authorization.k8s.io',
      },
      local g_subject(group) = {
        kind: 'Group',
        name: group,
        apiGroup: 'rbac.authorization.k8s.io',
      },
      roleRef_: roleref,
      subjects: std.map(u_subject, users) + std.map(g_subject, groups),
    } + $.namespace(namespace),

  usergroups_to_clusterrolebinding(groups, users, roleref, name):
    kube.ClusterRoleBinding(name) {
      local g_subject(group) = {
        kind: 'Group',
        name: group,
        apiGroup: 'rbac.authorization.k8s.io',
      },
      local u_subject(user) = {
        kind: 'User',
        name: std.format('%s@apptio.com', user),
        apiGroup: 'rbac.authorization.k8s.io',
      },
      roleRef_: roleref,
      subjects: std.map(u_subject, users) + std.map(g_subject, groups),
    },

  //--------- Secrets/Sealed Secrets

  // Pass in encrypted data structure as "data"
  // To encrypt normal secret, and extract data: kubeseal < mysecret.json | jq .spec.encryptedData
  SealedSecret(name): {
    local this = self,
    apiVersion: 'bitnami.com/v1alpha1',
    kind: 'SealedSecret',
    metadata: {
      name: name,
    },
    spec: {
      encryptedData: this.data,
    },
    data:: {},
  },
}
