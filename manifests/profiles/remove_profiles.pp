class profile::profiles::remove_profiles (
){
  outset::everyboot{'remove_profiles.sh':
      script => 'puppet:///modules/profile/profiles/remove_profiles.sh'
  }
}