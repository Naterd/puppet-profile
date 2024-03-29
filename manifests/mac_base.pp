# Base class that gets applied to all Macs
class profile::mac_base {
  if $::osfamily != 'Darwin' {
    fail("unsupported osfamily: ${::osfamily}")
  }

  $min_os_version = '10.9'

  if version_compare($::macosx_productversion_major, $min_os_version) < 0 {
    notice('Managedmac is unsupported on this operating system version. You are older than 10.9.')
  }
  else {
    include managedmac
  }

  include desktoppicture
  include outset
  include profile::mac_apps::beamoff
  # include profile::mac_apps::geektool
  include profile::mac_apps::vmware_tools
  include profile::mac_settings::apple_setup_done
  # include profile::mac_settings::boot_drive_name
  include profile::mac_settings::cleanup_mgt_files
  include profile::mac_settings::computername
  include profile::mac_settings::disable_diagnostic_msg
  include profile::mac_settings::dock
  include profile::mac_settings::finder_prefs
  include profile::mac_settings::googlechrome
  include profile::mac_settings::mouseRightClick
  include profile::mac_settings::puppet_conf
  include profile::munki::munkitools
  include profile::profiles::base_profiles
  include profile::puppet::clean_reports
  include profile::profiles::remove_profiles
  # include profile::puppet::pluginsync # This should be included in common hiera (hopefully)
}