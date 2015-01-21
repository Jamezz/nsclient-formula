{% from "nsclient/map.jinja" import nsclient with context %}

include:
     - nsclient.installed


nsclient:
    require:
       - sls: nsclient.installed