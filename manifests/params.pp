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
      $linux                  = true

      # Package definition
      $package_common         = 'ucarp'

      # Config definition
      $config_dir             = '/etc/ucarp'
      $config_common          = '/etc/ucarp/vip-common.conf'
      $config_common_template = 'ucarp/etc/vip-common.conf.erb'
      $config_id_template     = 'ucarp/etc/vip-template.conf.erb'

      # Service definition
      $service_ucarp          = 'ucarp'

      # Upscript/Downscript directory
      $script_dir             = '/usr/libexec/ucarp'
      $script_up_template     = 'ucarp/scripts/vip-up.erb'
      $script_down_template   = 'ucarp/scripts/vip-down.erb'
    }
    default  : {
      $linux                  = false
    }
  }

  # UCARP definitions
  $virtual_id = '001'
  $virtual_ip = '192.168.0.1'
  $virtual_if = 'eth0'
  $virtual_pw = 'SuperHyperSecret'
}
