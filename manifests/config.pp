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

  $local_vip_file = "/etc/ucarp/vip-${ucarp::virtual_id}.conf"

  # UCARP configuration
  file {
    $ucarp::params::config_ucarp_conf:
      ensure  => present,
      mode    => '0600',
      owner   => root,
      group   => root,
      path    => $ucarp::params::config_ucarp_conf,
      content => template('ucarp/etc/vip-common.conf.erb');

    $local_vip_file:
      ensure  => present,
      mode    => '0644',
      owner   => root,
      group   => root,
      path    => $local_vip_file,
      content => template('ucarp/etc/vip-000.conf.erb');
  }
}
