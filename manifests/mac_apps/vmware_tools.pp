# Install VMware Tools from the internet
class profile::mac_apps::vmware_tools {
  
  if $virtual == 'vmware' {
    package { 'vmwaretools':
      source   => "http://cburlison.s3.amazonaws.com/public/VMwareTools.dmg",
      provider => 'pkgdmg',
    }
  }
}