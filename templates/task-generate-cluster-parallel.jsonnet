{
  local kr8_cluster = std.extVar('kr8_cluster'),
  local kr8_components = std.extVar('kr8_components'),
  local component_list = std.objectFields(kr8_components),
  local task_prefix = 'generate_component_',

  version: '2',
  output: 'group',
  tasks: {
    [task_prefix + component]: {
      desc: 'Generate ' + component + ' for ' + kr8_cluster.cluster_name,
      dir: '$KR8_BASE/' + kr8_components[component].path,
      cmds: [
        'KR8_CLUSTER=' + kr8_cluster.cluster_name + ' task generate KR8_COMPONENT=' + component,
      ],
    }
    for component in component_list
  } + {
    default: {
      cmds: [
        'kr8-helpers check-environment',
        'rm -fr $KR8_BASE/generated/' + kr8_cluster.cluster_name,
        { task: '_pardeps' },
      ],
    },
    _pardeps: {
      deps: [task_prefix + component for component in component_list],
    },
  },
}
