{
  local clusters = ['gke', 'digitalocean'],

  version: '2',
  output: 'prefixed',
  tasks: {
    [cluster + '_taskfile']: {
      desc: 'generate task file in tmp directory for cluster: ' + cluster,
      cmds: [
        'mkdir -p tmp/' + cluster,
        //'kr8 jsonnet render --cluster ' + cluster + ' --format yaml templates/task-generate-cluster-parallel.jsonnet > tmp/' + cluster + '/Taskfile.yml',
        'kr8 jsonnet render --cluster ' + cluster + ' --format yaml templates/task-generate-cluster-sequential.jsonnet > tmp/' + cluster + '/Taskfile.yml',
      ],
    }
    for cluster in clusters
  } + {
    [cluster]: {
      desc: 'generate components for ' + cluster,
      cmds: [
        { task: cluster + '_taskfile' },
        'task -d tmp/' + cluster + ' default',
      ],
    }
    for cluster in clusters
  } + {
    default: {
      cmds: [
              'kr8-helpers check-environment',
            ] +
            [
              { task: cluster }
              for cluster in clusters
            ],
    },
    taskfiles: {
      desc: 'generate task files for all clusters',
      cmds: [
        { task: cluster + '_taskfile' }
        for cluster in clusters
      ],
    },
  },
}
