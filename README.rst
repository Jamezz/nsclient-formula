================
nsclient-formula
================

A saltstack formula that is used to install and create a basic configuration for NSClient on Windows.

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
