# Class: ucarp::scripts
#
# This module contains the scripts configuration for UCARP.
# Currently, this is just the up- and down-scripts.
#
# Parameters:   This module has no parameters
#
# Actions:      This module has no actions
#
# Requires:     This module has no requirements
#
# Sample Usage: include ucarp::package
#
class ucarp::scripts {

  $local_script_up   = "${ucarp::params::script_dir}/vip-up"
  $local_script_down = "${ucarp::params::script_dir}/vip-down"

  file { $local_script_up:
    ensure  => file,
    mode    => '0755',
    content => template($ucarp::script_up_template),
    notify  => Service[$ucarp::params::service_ucarp],
    require => Package[$ucarp::params::package_common];
  }

  file { $local_script_down:
    ensure  => file,
    mode    => '0755',
    content => template($ucarp::script_down_template),
    notify  => Service[$ucarp::params::service_ucarp],
    require => Package[$ucarp::params::package_common];
  }
}
