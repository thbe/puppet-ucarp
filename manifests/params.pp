# Class: ucarp::params
#
# This module contain the parameters for UCARP
#
# Parameters:   This module has no parameters
#
# Actions:      This module has no actions
#
# Requires:     This module has no requirements
#
# Sample Usage: include ucarp::params
#
class ucarp::params {

  # Operating system specific definitions
  case $::osfamily {
    'RedHat' : {
      $linux = true

      # Package definition
      $packageCommon = 'ucarp'

      # Config definition
      $configUcarpConf = '/etc/ucarp/vip-common.conf'

      # Service definition
      $serviceName = 'ucarp'
    }
    default  : {
      $linux = false
    }
  }

  # UCARP definitions
  $vId = '001'
  $vIp = '192.168.0.1'
  $vIf = 'eth0'
  $vPw = 'SuperHyperSecret'
}
