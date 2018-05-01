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
# Sample Usage:
#
class ucarp::config {

  $local_vip_conf_file = "${ucarp::params::config_dir}/vip-${ucarp::virtual_id}.conf"
  $local_vip_pwd_file = "${ucarp::params::config_dir}/vip-${ucarp::virtual_id}.pwd"

  # UCARP configuration
  file {
    $ucarp::params::config_dir:
      ensure  => directory,
      mode    => '0755',
      purge   => true,
      force   => true,
      recurse => true;
  }

  file { $ucarp::params::config_common:
    ensure  => file,
    mode    => '0600',
    content => template($ucarp::params::config_common_template),
    notify  => Service[$ucarp::local_service_ucarp],
    require => Package[$ucarp::params::package_common];
  }

  file { $local_vip_conf_file:
    ensure  => file,
    mode    => '0600',
    content => template($ucarp::params::config_vip_template),
    notify  => Service[$ucarp::local_service_ucarp],
    require => Package[$ucarp::params::package_common];
  }

  file { $local_vip_pwd_file:
    ensure  => file,
    mode    => '0600',
    content => template($ucarp::params::config_vip_pwd_template),
    notify  => Service[$ucarp::local_service_ucarp],
    require => Package[$ucarp::params::package_common];
  }
}
