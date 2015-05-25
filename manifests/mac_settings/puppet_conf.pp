class profile::mac_settings::puppet_conf {
  
  if $::hostname =~ /test/ {
    $testConf = 'puppet:///modules/profile/puppetconf/puppet_test.conf'
    file {"/private/etc/puppet/puppet.conf":
      source  => $testConf,
      owner   => root,
      group   => wheel,
      mode    => '0644',
    }
  }
  else {
    $prodConf = 'puppet:///modules/profile/puppetconf/puppet_prod.conf'
    file {"/private/etc/puppet/puppet.conf":
      source  => $prodConf,
      owner   => root,
      group   => wheel,
      mode    => '0644',
    }
  }
}
