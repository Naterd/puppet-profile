#!/usr/bin/python

import csv
import subprocess
import plistlib
import sys

FILE_LOCATION = '/usr/local/name_mac/names.csv'

def get_hardware_info():
    '''Uses system profiler to get hardware info for this machine'''
    cmd = ['/usr/sbin/system_profiler', 'SPHardwareDataType', '-xml']
    proc = subprocess.Popen(cmd, shell=False, bufsize=-1,
                            stdin=subprocess.PIPE,
                            stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    (output, unused_error) = proc.communicate()
    try:
        plist = plistlib.readPlistFromString(output)
        # system_profiler xml is an array
        sp_dict = plist[0]
        items = sp_dict['_items']
        sp_hardware_dict = items[0]
        return sp_hardware_dict
    except Exception:
        return {}

def check_compname(serial_number):
    with open(FILE_LOCATION, 'rbU') as csvfile:
        csv_data = csv.DictReader(csvfile, delimiter=',')
        for row in csv_data:
            serial = row['serial']
            computername = row['name']
            asset_tag = row['asset']
            if serial == serial_number:
                set_computername(computername)
                set_hostname(computername)
                set_localhostname(computername)
                set_asset_tag(asset_tag)

def get_serial_number():
    hardware_info = get_hardware_info()
    return hardware_info.get('serial_number', 'UNKNOWN') 

def set_computername(computername):
    cmd = ['/usr/sbin/scutil', '--set', 'ComputerName', computername]
    proc = subprocess.Popen(cmd, shell=False, bufsize=-1,
                            stdin=subprocess.PIPE,
                            stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    (output, unused_error) = proc.communicate()
    return output.rstrip('\n')

def set_hostname(computername):
    cmd = ['/usr/sbin/scutil', '--set', 'HostName', computername]
    proc = subprocess.Popen(cmd, shell=False, bufsize=-1,
                            stdin=subprocess.PIPE,
                            stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    (output, unused_error) = proc.communicate()
    return output.rstrip('\n')

def set_localhostname(computername):
    cmd = ['/usr/sbin/scutil', '--set', 'LocalHostName', computername]
    proc = subprocess.Popen(cmd, shell=False, bufsize=-1,
                            stdin=subprocess.PIPE,
                            stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    (output, unused_error) = proc.communicate()
    return output.rstrip('\n')

def set_asset_tag(asset_tag):
    cmd = ['/usr/bin/defaults', 'write', '/Library/Preferences/com.apple.RemoteDesktop.plist', 'Text2', asset_tag]
    proc = subprocess.Popen(cmd, shell=False, bufsize=-1,
                            stdin=subprocess.PIPE,
                            stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    (output, unused_error) = proc.communicate()
    return output.rstrip('\n')

def main():
    serial_number = get_serial_number()
    check_compname(serial_number)

if __name__ == '__main__':
    main()