osname=$(subst ganeti-instance-,,$(PACKAGE))

osdir=$(OS_DIR)/$(osname)

dist_os_SCRIPTS = create import export rename opensuse.sh
dist_os_DATA = ganeti_api_version
os_DATA = common.sh

dist_doc_DATA = COPYING NEWS README

EXTRA_DIST = \
	     common.sh.in \
	     defaults \
	     init.d/ganeti \
	     init.d/ganeti-hostname

common.sh: common.sh.in

CLEANFILES = common.sh
