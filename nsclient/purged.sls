{% from "nsclient/map.jinja" import nsclient with context %}

{% set server = {
  'package': nsclient.lookup.package,
  'upgrade': salt['pillar.get']('nsclient:server:package:upgrade', False),
  'config': {
    'manage': salt['pillar.get']('nsclient:server:config:manage', False), 
    'name': nsclient.server.config,
    'source': salt['pillar.get']('nsclient:server:config:source', 'salt://nsclient/conf/server.cfg'),
    },
  'service': {
    'name': nsclient.lookup.service,
    'manage': salt['pillar.get']('nsclient:server:service:manage', False), 
    'enable': salt['pillar.get']('nsclient:server:service:enable', True), 
  },
} %}

nsclient.server.purged:
  pkg.purged:
    - name: {{ server.package }}
{% if server.config.manage %}
  file.absent:
    - name: {{ server.config.name }}
{% endif %}
  require:
    - nsclient.plugins.purged