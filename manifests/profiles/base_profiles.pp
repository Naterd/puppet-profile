class profile::profiles::base_profiles (

  $puppet_path = '/private/etc/puppet/environments/production/modules/profile/files/profiles'
    
) {
    
    # ensure profiles are either absent or present
    # the name needs to be the exact same as the PayloadIdentifier (case sensitive)
    
    
    config_profile { 'BISD-GeekTool':
      ensure    => present,
      path      => "${puppet_path}/BISD-GeekTool.mobileconfig",
      system    => true,
    }

    if $geektool_test == 'true' {
      config_profile { 'Geektool-login-item':
        ensure    => present,
        path      => "${puppet_path}/Geektool-login-item.mobileconfig",
        system    => true,
        # require   => Package['Geektool'],
        # subscribe => Package['Geektool'],
      }
    }
    
    # if $mac_laptop == mac_laptop {
    #   config_profile { 'BISD-Secure_System':
    #     ensure    => present,
    #     path      => "${puppet_path}/BISD-Secure_System.mobileconfig",
    #     system    => true,
    #   }
    # }
}