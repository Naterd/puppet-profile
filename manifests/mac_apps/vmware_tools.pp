# Install vmware tools from the vmware website
class profile::mac_apps::vmware_tools {
  $script = '/etc/puppet/environments/production/modules/profile/files/vmware/install_vmware_tools.sh'

  if $virtual == 'vmware' {
    
    file {'/private/tmp/install_vmware_tools.sh':
        ensure => present,
        source  => $script,
        owner   => root,
        group   => wheel,
        mode    => '0755',
    }
    
    exec { "Install vmware tools":
        command => '/private/tmp/install_vmware_tools.sh',
        creates => "/Library/Application Support/VMware Tools/vmware-tools-cli",
        require => File['/private/tmp/install_vmware_tools.sh'],
    }
  }
}