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
  file {
    "${ucarp::params::script_dir}/vip-up":
      ensure  => file,
      mode    => '0700',
      owner   => root,
      group   => root,
      path    => "${ucarp::params::script_dir}/vip-up",
      content => template($ucarp::upscript);

    "${ucarp::params::script_dir}/vip-down":
      ensure  => file,
      mode    => '0700',
      owner   => root,
      group   => root,
      path    => "${ucarp::params::script_dir}/vip-down",
      content => template($ucarp::downscript);
  }
}
