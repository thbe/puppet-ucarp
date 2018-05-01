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
# Copyright 2018 Thomas Bendler
#
class ucarp (
  $virtual_id           = $ucarp::params::virtual_id,
  $virtual_ip           = $ucarp::params::virtual_ip,
  $virtual_if           = $ucarp::params::virtual_if,
  $virtual_pw           = $ucarp::params::virtual_pw) inherits ucarp::params {

  # Fix service name for systemd
  $local_service_ucarp = "${ucarp::params::service_ucarp}@${ucarp::virtual_id}"

  # Start workflow
  if $ucarp::params::linux {
    contain ::ucarp::install
    contain ::ucarp::config
    contain ::ucarp::service

    Class['ucarp::install']
    -> Class['ucarp::config']
    -> Class['ucarp::service']
  }
}
