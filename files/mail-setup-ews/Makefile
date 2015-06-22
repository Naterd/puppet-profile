USE_PKGBUILD=1
include /usr/local/share/luggage/luggage.make

TITLE=bisdmailsetup
REVERSE_DOMAIN=k12.bisd
PACKAGE_VERSION=1.5
PAYLOAD=\
		l_usr_local_outset \
		pack-usr-local-outset-login-every \
		pack-templates
		
l_usr_local_outset: l_usr_local
	@sudo mkdir -p ${WORK_D}/usr/local/outset/{firstboot-packages,firstboot-scripts,everyboot-scripts,login-every,login-once}
	@sudo chown -R root:wheel ${WORK_D}/usr/local/outset
	@sudo chmod -R 755 ${WORK_D}/usr/local/outset

pack-usr-local-outset-login-every: l_usr_local_outset
	@sudo ${INSTALL} -m 755 -g wheel -o root mailSetupEWS.py ${WORK_D}/usr/local/outset/login-every
	
pack-templates: l_usr_local_outset
	@sudo mkdir -p ${WORK_D}/usr/local/outset/resources/mail-setup
	@sudo cp -r ./templates ${WORK_D}/usr/local/outset/resources/mail-setup
	@sudo chown -R root:wheel ${WORK_D}/usr/local/outset/resources/mail-setup/templates
	@sudo chmod -R 755 ${WORK_D}/usr/local/outset/resources/mail-setup/templates	