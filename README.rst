================
nsclient-formula
================

A saltstack formula that is used to install and create a basic configuration for NSClient on Windows.

This formula depends on having two packages defined in your repo/salt filesystem
 - nsclient_x64
 - nsclient_x86

 Example definition of nsclient_x64:

 
 nsclient_x64:
    0.4.2.93:
        installer: 'http://files.nsclient.org/released/NSCP-0.4.2.93-x64.msi'
        full_name:  'NSClient++ (x64)'
        reboot: False
        install_flags: '/quiet'
        msiexec: True
        uninstaller: 'http://files.nsclient.org/released/NSCP-0.4.2.93-x64.msi'
        uninstall_flags: '/quiet'


Available states
================

.. contents::
    :local:

``installed``
------------

Installs the NSClient package, sets the configuration file and starts the associated service (nscp).

NOTE: You will need to restart the service to apply the configuration written by salt.

``purged``
------------

Purges the NSClient package and configuration.
