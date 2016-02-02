# == Class: ucarp
#
# This module manages UCARP.
#
# === Parameters
#
# Document parameters here.
#
# [*virtual_id*]
#   Set the virtual ID
#
# [*virtual_ip*]
#   Set the virtual IP
#
# [*virtual_if*]
#   Set the virtual Interface
#
# [*virtual_pw*]
#   Set the ucarp password
#
# [*upscript*]
#   Set a template for the "upscript," or script that runs when your vIp comes online.
#   Defaults to Red Hat-provided script.
#
# [*downscript*]
#   Set a template for the "downscript," or script that runs when your vIp goes offline.
#   Defaults to Red Hat-provided script.
#
# === Variables
#
# === Examples
#
#  class { '::ucarp':
#    virtual_id => '001',
#    virtual_ip => '192.168.0.1',
#    virtual_if => 'eth0',
#    virtual_pw => 'SuperHyperSecret',
#    upscript   => 'mymodule/vip-up.erb',
#    downscript => 'mymodule/vip-down.erb',
#  }
#
# === Authors
#
# Author Thomas Bendler <project@bendler-net.de>
#
# === Copyright
#
# Copyright 2016 Thomas Bendler
#
class ucarp (
  $virtual_id = $ucarp::params::virtual_id,
  $virtual_ip = $ucarp::params::virtual_ip,
  $virtual_if = $ucarp::params::virtual_if,
  $virtual_pw = $ucarp::params::virtual_pw,
  $upscript   = $ucarp::params::upscript,
  $downscript = $ucarp::params::downscript) inherits ucarp::params {

  # Require class yum to have the relevant repositories in place
  require yum

  # Start workflow
  if $ucarp::params::linux {
    contain ucarp::package
    contain ucarp::config
    contain ucarp::scripts
    contain ucarp::service

    Class['ucarp::package'] ->
    Class['ucarp::config'] ->
    Class['ucarp::scripts'] ->
    Class['ucarp::service']
  }
}
