class profile::mac_settings::boot_drive_name {
# Force the boot drive partition to be named BirdvilleISD.

  exec { "set_compname":
      command => '/usr/sbin/diskutil rename / "BirdvilleISD"',
      onlyif  => 'volname=$(/usr/sbin/diskutil list / | awk '{print $3}' | grep "BirdvilleISD") | if [ "$volname" != "BirdvilleISD" ]; then; echo exit 1; else exit 0; fi',
  }
}
