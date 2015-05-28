class profile::mac_settings::remove_profiles {
  tidy { "/usr/local/profiles":
    age     => "0",
    recurse => true,
    rmdirs  => true,
  }
}
