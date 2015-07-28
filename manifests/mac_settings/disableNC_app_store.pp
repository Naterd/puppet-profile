# This class will copy the script that disables the App Store 
# Notification Center alerts. The script disables the following:
#  * OS upgrades ("Free Yosemite Upgrade")
#  * Other App Store updates
class profile::mac_settings::disableNC_app_store {
  include profile::utils::NCutil
  
  outset::login_every{'disableNC_app_store.sh':
    script   => 'puppet:///modules/profile/NCutil/disableNC_app_store.sh',
    update   => true,
    priority => '10'
  }
}