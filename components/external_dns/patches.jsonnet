local helpers = import 'helpers.libsonnet';  // some helper functions
local kube = import 'kube.libsonnet';
local config = std.extVar('kr8');

// remove Secret objects and add a namespace
[
  if object.kind == 'Secret' then {} else object
  for object in helpers.list(
    // object list is converted to hash of named objects, then they can be modified by name
    helpers.named(helpers.helmInput) + {
      ['Deployment/' + config.release_name]+: helpers.patchContainer({
        // Add extra arg to container
        [if std.objectHas(config, 'zoneIdFilters') then 'args']+: ['--zone-id-filter=' + i for i in config.zoneIdFilters],
      }),
    },
  )
] + [
  kube.Namespace(config.namespace),
]
