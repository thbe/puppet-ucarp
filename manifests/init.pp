# == Class: ucarp
#
# This module manages UCARP.
#
# === Parameters
#
# Document parameters here.
#
# [*vIp*]
#   Set the virtual IP
#
# [*vId*]
#   Set the virtual ID
#
# [*vPw*]
#   Set the ucarp password
#
# [*revaliases*]
#   Array of reverse aliases
#
# === Variables
#
# === Examples
#
#  class { '::ucarp':
#    vId => '001',
#    vIp => '192.168.0.1',
#    vIf => 'eth0',
#    vPw => 'SuperHyperSecret'
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
  $vPw = $ucarp::params::vPw) inherits ucarp::params {

  # Include Puppetlabs standard library
  include stdlib

  # Start workflow
  if $ucarp::params::linux {
    anchor { 'ucarp::start': }
    -> class { 'ucarp::package': }
    ~> class { 'ucarp::config': }
    ~> class { 'ucarp::service': }
    ~> anchor { 'ucarp::end': }
  }
}
