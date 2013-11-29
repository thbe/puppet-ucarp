# Class: ucarp::package
#
# This module contain the service configuration for UCARP
#
# Parameters:   This module has no parameters
#
# Actions:      This module has no actions
#
# Requires:     This module has no requirements
#
# Sample Usage: include ucarp::package
#
class ucarp::package {
  package { $ucarp::params::packageCommon: ensure => installed; }
}
