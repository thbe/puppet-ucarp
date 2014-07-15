# == Class: ucarp
#
# This module manages UCARP.
#
# === Parameters
#
# Document parameters here.
#
# [*vId*]
#   Set the virtual ID
#
# [*vIp*]
#   Set the virtual IP
#
# [*vIf*]
#   Set the virtual Interface
#
# [*vPw*]
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
#    vId        => '001',
#    vIp        => '192.168.0.1',
#    vIf        => 'eth0',
#    vPw        => 'SuperHyperSecret',
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
# Copyright 2013 Thomas Bendler
#
class ucarp (
  $vId = $ucarp::params::vId,
  $vIp = $ucarp::params::vIp,
  $vIf = $ucarp::params::vIf,
  $vPw = $ucarp::params::vPw,
  $upscript = $ucarp::params::upscript,
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
