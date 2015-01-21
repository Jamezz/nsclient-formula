{% from "nsclient/map.jinja" import nsclient with context %}

nsclient:
  pkg.installed:
    - name: {{ nsclient.lookup.package }}
  service.running:
    - name: {{ nsclient.lookup.service }}
    - enable: True
