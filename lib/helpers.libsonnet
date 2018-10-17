{
  patchPodSpec(dep, patch)::
    dep { spec+: { template+: { spec+: patch } } },

  patchContainer(container)::
    {
      spec+: { template+: { spec+: {
        local checkContainerCount = std.assertEqual(std.length(super.containers), 1),

        containers: [super.containers[0] + container],
      } } },
    },

  patchContainerNamed(name, container)::
    {
      spec+: { template+: { spec+: {
        containers: [
          if c.name == name then c + container else c
          for c in super.containers
        ],
      } } },
    },

  patchVolume(volume)::
    {
      spec+: { template+: { spec+: {
        local checkVolumeCount = std.assertEqual(std.length(super.volumes), 1),
        volumes: [super.volumes[0] + volume],
      } } },
    },

  patchPort(portNumber, portSpec)::
    {
      spec+: {
        ports: std.map(
          function(oldPort)
            if oldPort.port == portNumber then oldPort + portSpec else oldPort,
          super.ports
        ),
      },
    },

  named(objectlist)::
    {
      [k.kind + '/' +
       (if std.objectHas(k.metadata, 'namespace') then k.metadata.namespace + '/' else '') +
       k.metadata.name]: k
      for k in
        std.makeArray(
          std.length(objectlist),
          function(i)
            objectlist[i] { _named_object_index:: i }
        )
    },

  list(objecthash)::
    local objs = [objecthash[f] for f in std.objectFields(objecthash)];
    local objsKeyed = { [std.toString(o._named_object_index)]: o for o in objs };
    [
      o
      for o in std.makeArray(
        std.length(objs),
        function(i)
          local k = std.toString(i);
          if std.objectHas(objsKeyed, k) then objsKeyed[k] else null
      )
      if o != null
    ],

  env(name)::
    std.native('env')(name),

  // --- helm processing
  // This reads a Yaml stream from extvar "inputYaml" which is provided by kr8 when rendering a helm chart
  // It strips out some bad things and returns the filtered list of objects
  helmInput::
    std.map(
      function(v) std.prune(v {
        [if v.kind == 'Service' && std.objectHas(v.spec, 'clusterIP') && v.spec.clusterIP == '' then 'spec']+: {
          clusterIP: null,
        },
      }),
      std.native('parseYaml')(std.extVar('inputYaml')),
    ),
}
