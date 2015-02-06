# configure printers using the mosen/cups module
class profile::printers::printers {
  # The configuration for each printer is defined in hiera.
  $printers = hiera_hash('printer')
  
  # create_resources is documented here: https://docs.puppetlabs.com/references/latest/function.html#createresources
  create_resources(printer, $printers)
}

