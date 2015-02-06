class profile::mac_settings::computername {

  if $::mac_current_user == "root" {
    notice ("root account")
  }
  else {
    exec {"setcomputername":
      command => "/usr/sbin/systemsetup -setcomputername $mac_current_user.$sp_serial_number",
      unless  => "/usr/sbin/systemsetup -getcomputername | grep $mac_current_user ",
    }
    exec {"sethostname":
      command => "/usr/sbin/scutil --set HostName $mac_current_user.$sp_serial_number",
      unless  => "/usr/sbin/scutil --get HostName | grep $mac_current_user.$sp_serial_number",
    }
    exec {"setlocalhostname":
      command => "/usr/sbin/systemsetup -setlocalsubnetname $sp_serial_number",
      unless  => "/usr/sbin/systemsetup -getlocalsubnetname | grep $sp_serial_number",
    }
  }
}
