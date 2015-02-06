class profile::puppet::hiera {
  file {'/etc/puppet/hiera.yaml':
    ensure => present,
    source => 'puppet:///modules/profile/puppet/hiera.yaml',
    group  => 'staff',
    owner  => 'puppet',
    mode   => '755',
  }
}
