# Class: ucarp::config
#
# This module contain the configuration for UCARP
#
# Parameters:   This module has no parameters
#
# Actions:      This module has no actions
#
# Requires:     This module has no requirements
#
# Sample Usage: include ucarp::config
#
class ucarp::config {

  $localVipFile = "/etc/ucarp/vip-${ucarp::vId}.conf"

  # UCARP configuration
  file {
    $ucarp::params::configUcarpConf:
      ensure  => present,
      mode    => '0600',
      owner   => root,
      group   => root,
      path    => $ucarp::params::configUcarpConf,
      content => template('ucarp/etc/vip-common.conf.erb');

    $localVipFile:
      ensure  => present,
      mode    => '0644',
      owner   => root,
      group   => root,
      path    => $localVipFile,
      content => template('ucarp/etc/vip-000.conf.erb');
  }
}
