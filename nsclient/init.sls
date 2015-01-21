{% from "nsclient/map.jinja" import nsclient with context %}

nsclient:
  pkg.installed:
    - name: {{ template.pkg }}
  service.running:
    - name: {{ template.service }}
    - enable: True
