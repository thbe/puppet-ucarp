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
# [*script_up_template*]
#   Set a template for the "upscript," or script that runs when your vIp comes online.
#   Defaults to Red Hat-provided script.
#
# [*script_down_template*]
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
  $virtual_id           = $ucarp::params::virtual_id,
  $virtual_ip           = $ucarp::params::virtual_ip,
  $virtual_if           = $ucarp::params::virtual_if,
  $virtual_pw           = $ucarp::params::virtual_pw,
  $script_up_template   = $ucarp::params::script_up_template,
  $script_down_template = $ucarp::params::script_down_template) inherits ucarp::params {

  # Fix service name for systemd
  if $::operatingsystemmajrelease == '7' {
    $local_service_ucarp = "${ucarp::params::service_ucarp}@${ucarp::virtual_id}"
  } else {
    $local_service_ucarp = $ucarp::params::service_ucarp
  }

  # Start workflow
  if $ucarp::params::linux {
    contain ::ucarp::package
    contain ::ucarp::config
    contain ::ucarp::scripts
    contain ::ucarp::service

    Class['ucarp::package']
    -> Class['ucarp::config']
    -> Class['ucarp::scripts']
    -> Class['ucarp::service']
  }
}
