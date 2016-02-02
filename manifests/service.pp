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
class ucarp::service inherits ucarp::params {
  service { $ucarp::params::service_name:
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    name       => $ucarp::params::service_name,
    require    => [
      Package[$ucarp::params::package_common],
      File[$ucarp::params::config_ucarp_conf]];
  }
}
