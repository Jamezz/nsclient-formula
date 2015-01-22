{% from "nsclient/map.jinja" import nsclient with context %}

{% set server = {
  'package': nsclient.lookup.package,
  'upgrade': salt['pillar.get']('nsclient:server:package:upgrade', False),
  'config': {
    'manage': salt['pillar.get']('nsclient:server:config:manage', False), 
    'name': nsclient.lookup.config,
    'source': salt['pillar.get']('nsclient:server:config:source', 'salt://nsclient/conf/server.cfg'),
    },
  'service': {
    'name': salt['pillar.get']('nsclient:lookup:server:service:', 'nscp'),
    'manage': salt['pillar.get']('nsclient:server:service:manage', False), 
    'enable': salt['pillar.get']('nsclient:server:service:enable', True), 
  },
} %}

nsclient.purged:
  pkg.purged:
    - name: {{ server.package }}
{% if server.config.manage %}
  file.absent:
    - name: {{ server.config.name }}
{% endif %}