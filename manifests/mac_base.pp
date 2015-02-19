# Base class that gets applied to all Macs
class profile::mac_base {
  if $::osfamily != 'Darwin' {
    fail("unsupported osfamily: ${::osfamily}")
  }

  $min_os_version = '10.9'

  if version_compare($::macosx_productversion_major, $min_os_version) < 0 {
    notice('This is an unsupported operating system version. You are older than 10.9.')
  }
  else {
    include managedmac
  }

  include desktoppicture
  include outset
  include profile::mac_apps::geektool
  include profile::mac_apps::vmware_tools
  include profile::mac_settings::apple_setup_done
  include profile::mac_settings::disable_diagnostic_msg
  include profile::munki::munkitools
  include profile::profiles::base_profiles
  include profile::puppet::clean_reports
  include class profile::puppet::pluginsync
}