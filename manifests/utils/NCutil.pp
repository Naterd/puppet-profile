# Install NCutil.py command line utility for managing
# Notification Center alerts, sounds, etc.
class profile::utils::NCutil{
  $NCutil = 'puppet:///modules/profile/NCutil/2.3/NCutil.py'
  
  file {'/usr/local/bin/NCutil.py':
    owner  => root,
    group  => admin,
    mode   => '0755',
    source  => $NCutil,
    ensure => 'present',
  }
}