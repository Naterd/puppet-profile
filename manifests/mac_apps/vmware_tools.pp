# Install VMware Tools from the internet
class profile::mac_apps::vmware_tools {
  
  if $virtual == 'vmware' {
    package { 'vmwaretools':
      source   => "https://www.dropbox.com/s/wartjc2zbbyb5gr/VMwareTools.pkg.zip?raw=1",
      provider => 'compressed_pkg',
    }
  }
}