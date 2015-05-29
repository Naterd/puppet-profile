# This file is only needed on Yosemite. It will disable the 
# Diagnostic Window when first logging in as an administrator.
class profile::mac_settings::disable_diagnostic_msg {
  $DiaMsg = 'puppet:///modules/profile/DiagnosticMessages/DiagnosticMessagesHistory.plist'
  $min_os_version = '10.10'

    if version_compare($::macosx_productversion_major, $min_os_version) < 0 {
      #notice('This operating system does not need the DiagnosticMessagesHistory file.')
    }
    else {
      file {"/Library/Application Support/CrashReporter/DiagnosticMessagesHistory.plist":
        replace => "no",
        source  => $DiaMsg,
        owner   => root,
        group   => admin,
        mode    => '0664',
      }
    }
}
