class profile::profiles::base_profiles (

  $puppet_path = '/private/etc/puppet/environments/production/modules/profile/files/profiles'
    
) {
    
    
    # ensure profiles are either absent or present
    # the name needs to be the exact same as the PayloadIdentifier (case senitive)
    config_profile { 'BISD-GeekTool':
      ensure    => present,
      path      => '${puppet_path}/BISD-GeekTool.mobileconfig',
      system    => true,
    }
    
    config_profile { 'Geektool-login-item':
      ensure    => present,
      path      => '${puppet_path}/Geektool-login-item.mobileconfig',
      system    => true,
    }
}