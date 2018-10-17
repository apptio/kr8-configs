local apptio = import 'apptio.libsonnet';
local config = std.extVar('kr8');

[
  if std.objectHas(config, 'extraEnv') then
    apptio.SealedSecret('external-dns') {
      data: config.extraEnv,
    },
]
