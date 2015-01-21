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
    'name': salt['pillar.get']('nsclient:lookup:server:service:', 'nscp'),
    'manage': salt['pillar.get']('nsclient:server:service:manage', False), 
    'enable': salt['pillar.get']('nsclient:server:service:enable', True), 
  },
} %}

nsclient.installed:
  pkg.{{ 'latest' if server.upgrade else 'installed' }}:
    - name: {{ server.package }}
{% if server.service.manage %}
  service.{{ 'running' if server.service.enable else 'dead' }}:
    - name: {{ server.service.name }}
    - require:
      - pkg: nsclient.server.installed
  {% if server.config.manage %}
      - file: nsclient.installed
  {% endif %}
    - watch:
      - pkg: nsclient.installed
  {% if server.config.manage %}
      - file: nsclient.installed
  {% endif %}
{% endif %}
{% if server.config.manage %}
  file.managed:
    - name: {{ server.config.name }}
    - source: {{ server.config.source }}
    - template: jinja
{% endif %}