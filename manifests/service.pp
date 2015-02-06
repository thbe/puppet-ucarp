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
  service { $ucarp::params::serviceName:
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    name       => $ucarp::params::serviceName,
    require    => [
      Package[$ucarp::params::packageCommon],
      File[$ucarp::params::configUcarpConf]];
  }
}
