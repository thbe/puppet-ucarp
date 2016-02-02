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
      $linux             = true

      # Package definition
      $package_common    = 'ucarp'

      # Config definition
      $config_ucarp_conf = '/etc/ucarp/vip-common.conf'

      # Service definition
      $service_name      = 'ucarp'

      # Upscript/Downscript directory
      $script_dir        = '/usr/libexec/ucarp'
    }
    default  : {
      $linux             = false
    }
  }

  # UCARP definitions
  $virtual_id = '001'
  $virtual_ip = '192.168.0.1'
  $virtual_if = 'eth0'
  $virtual_pw = 'SuperHyperSecret'
  $upscript   = 'ucarp/vip-up.erb'
  $downscript = 'ucarp/vip-down.erb'
}
