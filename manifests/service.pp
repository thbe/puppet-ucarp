# Class: ucarp::service
#
# This module contain the service configuration for UCARP
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
# [Remember: No empty lines between comments and class definition]
class ucarp::service {

  service {
    $ucarp::local_service_ucarp:
      ensure  => 'running',
      enable  => true,
      require => Package[$ucarp::params::package_common];
  }
}
