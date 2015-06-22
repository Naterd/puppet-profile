#!/usr/bin/python
# -*- coding: UTF-8 -*-
##
# Exchange configuration script for 10.6 - 10.11
#
# Will configure Mail.app, AddressBook & iCal with our Exchange server using the native Exchange support in 10.6 - 10.11 (EWS)
#
# Runs if the following paths doesn't exists (so if you want to re-setup for example iCal, delete the folders/files below)
#
# iCal:			~/Library/Calendars/*.exchange
#				~/Library/Calendars/Calendar Cache
# AddressBook:	~/Library/Application Support/AddressBook/Sources/
# Mail:			~/Library/Preferences/com.apple.mail.plist
#
# Update varibles "templatesDir", "ExchangeServerInfo" and function "getUserData" to suite your own environemt.
#
# Run script as the logged in user "./mailSetupEWS.py"
#
#	
# 2012-05-09	daniel.svensson3@ikea.com	1.0 Public version.
# 2012-05-29	daniel.svensson3@ikea.com	1.1	Added code to read user's email & fullName from their AD-account (thanks Bjørn Bergli Fodstad, Oslo University College!)
# 2012-11-01	mikael.andersson@atea.se	1.2	Added support for 10.8
# 2013-11-10	daniel.svensson3@ikea.com	1.3 Support for 10.9 (currently prompts user for their password to due a bug in 10.9.0 where if you leave the Password field blank the mdmclient will set it to MCXDummyPassword and lock the users AD-account)
# 2013-11-14	daniel.svensson3@ikea.com	1.4 Support for Centrify (thanks Timo Lemburg)
# 2015-06-22    clayton.burlison@birdvilleschools.net   1.5 Support for 10.10 & 10.11

try:
	import os, sqlite3, sys, shutil, plistlib, re, time
	import Foundation
except Exception, error:
	print "Error, missing required modules: " + str(error)
	sys.exit()

# What are we running on
os_version = os.popen("/usr/bin/sw_vers | grep ProductVersion | cut -f 2 -d :").readline().strip('\n\t')

# this is where we store info about the user
UserData = {}

#########################################################
#### Update for your own environment

## Specify Active Directory Plug-in
supportedADplugins = ['Apple', 'Centrify']
ADPlugin = supportedADplugins[0]

## copy the templates from here
templatesDir = "/usr/local/outset/resources/mail-setup/templates"

# Profile-identifier for 10.9+
exchangeProfileIdentier = "k12.bisd.exchangesetup"

### Exchange server
ExchangeServerInfo = {}
ExchangeServerInfo['fqdn'] 				= "exchange.birdvilleschools.net"
ExchangeServerInfo['serverRootPath']	= "/ews/exchange.asmx"
ExchangeServerInfo['EWS url'] 			= "https://" + str(ExchangeServerInfo['fqdn']) + ExchangeServerInfo['serverRootPath']

######### SETTINGS #########
## Get info about our user
if ADPlugin == 'Apple':
	homedir = os.popen('echo $HOME').readline().strip('\n')
	loggedInUser = os.popen('whoami').readline().strip('\n')
	adSearchPath = os.popen('dscl /Search -read / CSPSearchPath | grep \"Active Directory\"').readline().strip('\n').strip()
	shortname = os.popen('dscl "' + adSearchPath + '" -read /Users/' + loggedInUser + ' sAMAccountName | cut -d \' \' -f 2').readline().strip('\n').strip()

elif ADPlugin == 'Centrify':
	homedir = os.popen('echo $HOME').readline().strip('\n') 
	loggedInUser = os.popen('whoami').readline().strip('\n') 
	adSearchPath = os.popen('dscl /Search -read / CSPSearchPath | grep \"CentrifyDC\"').readline().strip('\n').strip() 
	shortname = os.popen('who | grep console | awk \'{print$1}\'').readline().strip('\n').strip() 

else:
	sys.exit(u"Unsupported AD-plugin")
	
logString = "com.ikea.mailSetup {" + loggedInUser + "} ";


##### end here
#########################################################

## By default we should setup all apps
setupiCal = setupAddressBook = setupMail = True

### iCal settings
# Path and name of plist to create
iCalBasePath	= "/Library/Calendars/"
iCalPlist_template	= templatesDir + '/iCal_template.plist'
iCalDB_template		= templatesDir + '/iCalDB_template'

### AddressBook settings
AddressBookBasePath = "/Library/Application Support/AddressBook/Sources/"
AddressBook_template = templatesDir + '/AddressBook_template.plist'

### Mail.app settings
## If we are running on anything lower than 10.6, exit.
if("10.11" in os_version):
	Mail_template	= templatesDir + '/Mail_template10.10.plist'
	MailPlist		= "/Library/Mail/V2/MailData/Accounts.plist"

elif("10.10" in os_version):
	Mail_template	= templatesDir + '/Mail_template10.10.plist'
	MailPlist		= "/Library/Mail/V2/MailData/Accounts.plist"

elif("10.9" in os_version):
	Mail_template	= templatesDir + '/Mail_template10.9.plist'
	MailPlist		= "/Library/Mail/V2/MailData/Accounts.plist"

elif("10.8" in os_version):
	Mail_template	= templatesDir + '/Mail_template10.7.plist'
	MailPlist		=  "/Library/Mail/V2/MailData/Accounts.plist"

elif("10.7" in os_version):
	Mail_template	= templatesDir + '/Mail_template10.7.plist'
	MailPlist		=  "/Library/Mail/V2/MailData/Accounts.plist"

elif("10.6" in os_version):
	Mail_template	= templatesDir + '/Mail_template.plist'
	MailPlist		=  "/Library/Preferences/com.apple.mail.plist"
	
else:
	sys.exit("[ERROR] Unsupported OS version")


######### END OF SETTINGS #########

######### Functions 

def logger(msg):
	
	global logString
	
	# Send the msg to /usr/bin/logger
	os.popen("/usr/bin/logger \"%s%s\""% (logString, msg))
	print "%s%s"% (logString, msg)
	
	return
	
#Function will return your ldap server based on domain
def getldapSRV(domain):
	tryCount = 0
	
	while(tryCount < 3):
		ldapSRVS = os.popen('/usr/bin/host -t SRV _ldap._tcp.dc._msdcs.' + domain).readlines()
		ldapSRV = ldapSRVS.pop().strip().split().pop()
		
		if not re.search(domain, ldapSRV):
			time.sleep(15)
			logger("[ERROR] Could not find an ldap server, waiting for network to wake up...")
			tryCount +=1
		else:
			logger('[INFO] Will use ' + ldapSRV + ' as ldap server')
			return ldapSRV
			break

# Generate a UUID
def generateUUID():
	return os.popen('uuidgen').readline().strip('\n')
	
# Will dump all installed profiles and return as python dict
def dumpAllProfiles(shortname):
	tmp = "/tmp/%s.plist"% generateUUID()
	os.system('profiles -L %s -o %s'% (shortname, tmp))
	
	try:
		_data = plistlib.readPlist(tmp)
	except:
		_data = {}
		logger("[ERROR] Could not list installed profiles")

	return _data

# Check if a Profile with the passed identifier is already installed
def isProfileInstalled(shortname, exchangeProfileIdentier):
	installedProfiles = dumpAllProfiles(shortname)
	
	logger("[INFO] Checking if %s is already installed or not"% exchangeProfileIdentier)
	
	try:
		return installedProfiles[shortname][0]['ProfileIdentifier'] == exchangeProfileIdentier
	except:
		logger("[ERROR] Could not identify installed profile %s"% exchangeProfileIdentier)
		return False

# Generates our mobileconfig to setup EWS for the passed user
def buildExchangeConfigurationProfileFromTemplate(UserData):
	global exchangeProfileIdentier, Mail_template, ExchangeServerInfo

	'''Read in our template to a python-dict'''
	try:
		ourProfile = plistlib.readPlist(Mail_template)
	except:
		logger("[ERROR] Could not read template into dict from %s"% Mail_template)
		return False
		
	try:
		# Outer settings
		ourProfile['PayloadUUID'] = generateUUID()
		ourProfile['PayloadIdentifier'] = exchangeProfileIdentier
		
		# Inner settings
		ourProfile['PayloadContent'][0]['PayloadUUID']			= generateUUID()
		ourProfile['PayloadContent'][0]['PayloadIdentifier'] 	= exchangeProfileIdentier
		
		# Our user settings
		ourProfile['PayloadContent'][0]['UserName'] 			= UserData['shortname']
		ourProfile['PayloadContent'][0]['Path']					= ExchangeServerInfo['serverRootPath']
		ourProfile['PayloadContent'][0]['Host']					= ExchangeServerInfo['fqdn']
		ourProfile['PayloadContent'][0]['ExternalHost']			= ExchangeServerInfo['fqdn']
		ourProfile['PayloadContent'][0]['ExternalPath']			= ExchangeServerInfo['serverRootPath']
		ourProfile['PayloadContent'][0]['EmailAddress']			= UserData['email']
		ourProfile['PayloadContent'][0]['Password']				= UserData['password']

	except:
		return False
		
	return ourProfile

def getResultFromNSAppleEventDescriptor(key, string):
	
	# Example input:
	# <NSAppleEventDescriptor: { 'ttxt':'utxt'("whatwewant"), 'bhit':'utxt'("Continueâ?|"), 'gavu':'fals'("false") }> : None
	# 
	# We want 'ttxt':'utxt'("whatwewant")
	# where key = ttxt
	#
	
	if(key=="ttxt"):
		try:
			return unicode(string.paramDescriptorForKeyword_(1953790068).stringValue())
		except IndexError as e:
			print "Error, %s not found"% key
	else:
		return ""

def getUserPassword(typeOfDialog):
	
	# Generate an AppleScript and have the user enter their password
	if(typeOfDialog == "normal"):
		mysource = u'tell application "Finder"\n \
					display dialog \
					"Please enter your network password" with title \
					"BISD Exchange Email Setup" with icon 1 \
					default answer \
					"" buttons {"Continue..."} \
					default button 1 \
					giving up after 30 with hidden answer\n \
					end tell'
	else:
		mysource = u'tell application "Finder"\n \
					display dialog \
					"Password incorrect!\n\nPlease enter your network password" with title \
					"BISD Exchange Email Setup" with icon 2 \
					default answer \
					"" buttons {"Continue..."} \
					default button 1 \
					giving up after 30 with hidden answer\n \
					end tell'
		

	# Create our script-object
	myScript = Foundation.NSAppleScript.alloc().initWithSource_(mysource)

	# Run it
	ev, e = myScript.executeAndReturnError_(None)
	
	# Get the text-result
	theTextResult = getResultFromNSAppleEventDescriptor("ttxt", ev)
	
	return theTextResult
	
# Takes a python-dict representing a mobile config profile and install it
def installProfileFromDict(profileDict):
	tmp = "/tmp/%s.mobileconfig"% generateUUID()
	
	try:
		plistlib.writePlist(profileDict, tmp)
	except:
		logger("[ERROR] Could not create profile at %s"% tmp)
		return None
		
	returnCode = os.system("profiles -I -F %s"% tmp)
	
	if(returnCode != 0):
		logger("[ERROR] Installing profile failed with code %s"% returnCode)
		return bool(returnCode)
	else:
		return True

def getUserData(shortname, homedir):
	
	global adSearchPath, loggedInUser, ADplugin
	
	# Try to retrive the mail adress this user
	try:
		
		if ADPlugin == 'Apple':
			_email = os.popen('dscl "' + adSearchPath + '" -read /Users/' + loggedInUser + ' EMailAddress | cut -d \' \' -f 2').readline().strip('\n').strip()
			_fullname = os.popen('dscl "' + adSearchPath + '" -read /Users/' + loggedInUser + ' RealName | grep -v \"RealName\"').readline().strip('\n').strip()
			_fullname = unicode((_fullname),"utf-8")
		
		elif ADPlugin == 'Centrify':
			_email = os.popen('adquery user -j ' + loggedInUser + ' | grep "mail:" | awk \'{sub("mail:","");print}\'').readline().strip('\n').strip() 
			_fullname = os.popen('adquery user -j ' + loggedInUser + ' | grep "_UserRealName:" | awk \'{sub("_UserRealName:","");print}\'').readline().strip('\n').strip() 
			_fullname = unicode((_fullname),"utf-8") 


	except Exception, error:
		logger("[ERROR " +str(error))
		
	if(re.search('@', _email)):
		# Yepp, this seems to be a mail adress
		UserData['email'] = _email
	else:
		logger('[ERROR] Could not find a valid email adress for ' + str(loggedInUser))
		sys.exit('[ERROR] Could not find a valid email adress for ' + str(loggedInUser))
		
	if(_fullname != ""):
		# Yepp, this seems to be a mail adress
		UserData['fullname'] = _fullname
	else:
		logger('[ERROR] Could not find full name for ' + str(loggedInUser))
		sys.exit('[ERROR] Could not find full name for ' + str(loggedInUser))
	
	# Genereate a GUID to use for this account. Use the same in all applications for brevity
	UserData['uuid']		= generateUUID()
	UserData['homedir']		= homedir
	UserData['shortname']	= shortname
	
	#print("Found this info for the user:\n" + str(UserData))
	return UserData

def configureiCal(iCalBasePath, UserData):
	
	global iCalPlist_template, ExchangeServerInfo
	
	# Settings 
	iCalPlist		= iCalBasePath + UserData['uuid'] + ".exchange/Info.plist"
	iCalDB			= iCalBasePath + "Calendar Cache"

	# Read in the template
	try:
		_data	= plistlib.readPlist(iCalPlist_template)
	except Exception, error:
		logger("[ERROR] Could not read " + str(iCalPlist_template))
		sys.exit("[ERROR] Could not read " + str(iCalPlist_template))
	
	# Replace with info for the running user
	_data['Title'] 					= UserData['email']
	_data['Login']					= UserData['shortname']
	_data['CalendarUserAddresses'] 	= ["mailto:" + UserData['email']]
	_data['ServerURL'] 				= ExchangeServerInfo['EWS url']
	_data['Mailbox']				= UserData['email']
	_data['FullName'] 				= UserData['fullname']
	_data['Key']					= UserData['uuid']

	_sql = ['INSERT INTO "ZACCOUNT" VALUES(NULL,3,1,900,NULL,NULL,1,"' + _data['Login'] + '","' + _data['ServerURL'] + '",NULL,NULL,NULL);',
	'''INSERT INTO "ZNODE" VALUES(NULL,38,1,1,3,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
	NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,0,1,3,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
	NULL,NULL,"''' + UserData['uuid'] + '''",NULL,"''' + _data['Mailbox'] + '''","#808080FF",
	NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,"''' + _data['FullName'] + '''",NULL,NULL,NULL,NULL,
	NULL,NULL,NULL,NULL,NULL,NULL,NULL,"''' + _data['Mailbox'] + '''",NULL);''']

	
	# Create the destination directories if the doesnt exist
	try:
		if(not os.path.exists(os.path.dirname(iCalPlist))):
			os.makedirs(os.path.dirname(iCalPlist))
	except Exception, error:
		logger("[ERROR] Could create directory " + str(os.path.dirname(iCalPlist)))
		sys.exit("[ERROR] Could create directory " + str(os.path.dirname(iCalPlist)))
		
	# Write out the finished plist	
	try:
		plistlib.writePlist(_data, iCalPlist)
	except Exception, error:
		logger("[ERROR] Could not write plist for iCal")
		sys.exit("[ERROR] Could not write plist for iCal")

	# Continue with the Calendar Cache
	# If it doesnt exist, use our template
	if(not os.path.exists(iCalDB)):
		try:
			shutil.copy(iCalDB_template, iCalDB)
		except Exception, error:
			logger("[ERROR] Could not copy the Calendar Cache template")
			sys.exit("[ERROR] Could not copy the Calendar Cache template")

	# Open the database and run the SQL-insert code
	try:
		connection = sqlite3.connect(iCalDB)
		cursor = connection.cursor()
		
		for sqlInsert in _sql:
			data = cursor.execute(sqlInsert)
		
	except sqlite3.OperationalError:
		# Ooops, looks like we tried to write into a newer version of the calendar cache file.
		# Let's rename it and use our default cache instead

		connection.close()
		
		try:
			os.rename(iCalDB, str(iCalDB+".old"))	
			shutil.copy(iCalDB_template, iCalDB)
			
		except Exception, error:
			logger("[ERROR] Could not copy the Calendar Cache template")
			sys.exit("[ERROR] Could not copy the Calendar Cache template")
			
		# Ok, let's try again!
		
		connection = sqlite3.connect(iCalDB)
		cursor = connection.cursor()

		for sqlInsert in _sql:
			data = cursor.execute(sqlInsert)

	except Exception, error:
		logger("[ERROR] Could read or write the Calendar Cache database")
		sys.exit("[ERROR] Could read or write the Calendar Cache database, got this error: \"" + str(error) + "\"")

	finally:
		
		# Make sure to commit and close the DB
		connection.commit()
		connection.close()
		
	return

def verifyPassword(user, password):
	# Verify a user with password
	return not bool(os.system("dscl /Search -authonly %s \"%s\""% (user, password)))

def configureAddressBook(AddressBookBasePath, UserData):
	global AddressBook_template, ExchangeServerInfo

	# Setup 
	AddressBookPlist = AddressBookBasePath + UserData['uuid'] + "/Configuration.plist"

	# Read in the template
	try:
		_data = plistlib.readPlist(AddressBook_template)
	except Exception, error:
		logger("[ERROR] Could not read " + str(AddressBook_template))
		sys.exit("[ERROR] Could not read " + str(AddressBook_template))

	# Replace with info for the running user
	_data['emailAddress'] 	= UserData['email']
	_data['name']			= UserData['email']
	_data['fullName'] 		= UserData['fullname']
	_data['userName']		= UserData['shortname']
	_data['serverRootPath']	= ExchangeServerInfo['serverRootPath']
	_data['serverName'] 	= ExchangeServerInfo['fqdn']

	# Create the destination directories if the doesnt exist
	try:
		if(not os.path.exists(os.path.dirname(AddressBookPlist))):
			os.makedirs(os.path.dirname(AddressBookPlist))
	except Exception, error:
		logger("[ERROR] Could create directory " + str(os.path.dirname(AddressBookPlist)))
		sys.exit("[ERROR] Could create directory " + str(os.path.dirname(AddressBookPlist)))

	try:
		# Write out the finished plist	
		plistlib.writePlist(_data, AddressBookPlist)

	except Exception, error:
		logger("[ERROR] Error writing the AddressBookPlist")
		sys.exit("[ERROR] Error writing the AddressBookPlist, got this error: \"" + str(error) + "\"")

		
	return

def configureMail(MailPlist, UserData):
	global Mail_template, ExchangeServerInfo, os_version

	# Read in the template
	try:
		_data	= plistlib.readPlist(Mail_template)
	except Exception, error:
		logger("[ERROR] Could not read " + str(Mail_template))
		sys.exit("[ERROR] Could not read " + str(Mail_template))

	for Account in _data['MailAccounts']:
		# Replace the necessary keys with info about our running user
	
		if("10.9" in os_version):
			Account['AccountPath']				= "~/Library/Mail/V2/EWS-" + UserData['shortname'] + "@" + ExchangeServerInfo['fqdn']

		elif("10.8" in os_version):
			Account['AccountPath']				= "~/Library/Mail/V2/EWS-" + UserData['shortname'] + "@" + ExchangeServerInfo['fqdn']

		elif("10.7" in os_version):
			Account['AccountPath']				= "~/Library/Mail/V2/EWS-" + UserData['shortname'] + "@" + ExchangeServerInfo['fqdn']

		elif("10.6" in os_version):
			Account['AccountPath']				= "~/Library/Mail/EWS-" + UserData['shortname'] + "@" + ExchangeServerInfo['fqdn']
		
		Account['AccountName'] 				= UserData['email']
		Account['EmailAddresses'] 			= [UserData['email']]
		Account['FullUserName'] 				= UserData['fullname']
		Account['Username']					= UserData['shortname']
		Account['uniqueId']					= UserData['uuid']
		Account['ToDosCalendarsGroupUID']	= [UserData['email']]
		Account['InternalServerPath']		= ExchangeServerInfo['serverRootPath']
		Account['Hostname'] 				= ExchangeServerInfo['fqdn']
	
	# Save our new Account into the plist
	_data['MailAccounts'] == [Account]
	
	# Test our destination path before writing to disk
	if not (os.path.exists(os.path.dirname(MailPlist))):
		try:
			os.popen("mkdir -p " + os.path.dirname(MailPlist))
		except Exception, error:
			logger("[ERROR] Could not create " + os.path.dirname(MailPlist))
			sys.exit("[ERROR] Could not create " + os.path.dirname(MailPlist) + ", got this error: \"" + str(error) + "\"")
			
	try:
		# Write out the finished plist	
		plistlib.writePlist(_data, MailPlist)

	except Exception, error:
		logger("[ERROR] Error writing the Mail.plist")
		sys.exit("[ERROR] Error writing the Mail.plist, got this error: \"" + str(error) + "\"")
		
	return

############ MAIN SCRIPT ############


###### Check iCal ######
# Unless we find a directory in ~/Library/Calendars/ that ends with .exchange we setup iCal
try:
	for folder in os.listdir(homedir + iCalBasePath):
		if folder.endswith(".exchange"):
			# Set to False since there already seems to be a exchange config for iCal
			setupiCal = False
except:
	# The ~/Library/Calendars/ doesnt exists, probably because someone deleted it so let's re-setup iCal
	setupiCal = True

###### Check AddressBook ######
# If we dont find '~/Library/Application Support/AddressBook/Sources' we setup AddressBook
setupAddressBook = True
if(os.path.exists(homedir + AddressBookBasePath)):
	setupAddressBook = False

###### Check Mail.app ######
# If ~/Library/Preferences/com.apple.Mail.plist doesnt exis we setup Mail.app
if(os.path.exists(homedir + MailPlist) or isProfileInstalled(shortname, exchangeProfileIdentier)):
	setupMail = False

### If we need to setup any of the applications, go ahead and query CDS & AD for more user info. If not, just quit
if(setupiCal or setupAddressBook or setupMail):
	UserData = getUserData(shortname, homedir)

	### Here we take a de-tour if we run 10.9 or not
	if("10.9" in os_version):
		# We are on 10.9, use Profile
		try:		
			if(setupMail):
			
				typeOfDialog = "normal"
							
				for x in range(3):
					
					# Try and grab user's password
					userPass = getUserPassword(typeOfDialog)
					
					# Now verify the result
					if not verifyPassword(UserData['shortname'], userPass):
						typeOfDialog = "alert"
						x += 1
						logger("[ERROR] Got authentication failed while validating password")
					else:
						logger("[INFO] Successfully verified users password")
						UserData['password'] = userPass

						break
						
				if not 'password' in UserData.keys():
					logger("[ERROR] Password verification failed")
					raise Exception
			
	
				logger("[INFO] Setting up Exchange support in Mail.app")
				ourMobileConfig = buildExchangeConfigurationProfileFromTemplate(UserData)
			
				if(ourMobileConfig):
					logger("[INFO] Mobileconfig succesfully generated.")				
				else:
					raise Exception
				
				if(installProfileFromDict(ourMobileConfig)):
					logger("[INFO] Mobileconfig succesfully installed.")
				else:
					raise Exception
				
		except Exception as e:
			logger("[ERROR] An error occured: %s"% e)
		
	else:
		# We are on pre 10.9, setup with legacy code.	
		
		if(setupiCal):
			logger("[INFO] Setting up Exchange support in iCal")
			configureiCal(UserData['homedir'] + iCalBasePath, UserData)
		else:
			logger("[SKIPPING] iCal already configured")
	
		if(setupAddressBook):
			logger("[INFO] Setting up Exchange support in AddressBook")
			configureAddressBook(UserData['homedir'] + AddressBookBasePath, UserData)
		else:
			logger("[SKIPPING] AddressBook already configured")
	
		if(setupMail):
			logger("[INFO] Setting up Exchange support in Mail.app")
			configureMail(UserData['homedir'] + MailPlist, UserData)
		else:
			logger("[SKIPPING] Mail.app already configured")
else:

	logger("[INFO] Exchange support already setup")
############ END OF SCRIPT ############