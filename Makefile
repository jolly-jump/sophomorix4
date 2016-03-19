#!/usr/bin/make
# This is the sophomorix Makefile
# for Debian packaging (make DESTDIR=/root/sophomorix)
DESTDIR=

# Installing from this Makefile
#====================================
# if you use this Makefile to install sophomorix (instead of 
# installing the debian-Package) you will miss:
#   1. html-documentation
#   2. manpages
# This is because debian has scripts to install 1. and 2. VERY easily
# see debian/rules -> dh_installman, dh-installdocs



# Debian
#====================================

# Homes
#HOME=$(DESTDIR)/home

# Developement
#USERROOT=$(DESTDIR)/root

# Data
LIBDIR=$(DESTDIR)/var/lib/sophomorix

# Cache
#CACHEDIR=$(DESTDIR)/var/cache/sophomorix

# Logs
LOGDIR=$(DESTDIR)/var/log/sophomorix

# Perl modules
PERLMOD=$(DESTDIR)/usr/share/perl5/Sophomorix

# Dokumentation
#DOCDEBDIR=$(DESTDIR)/usr/share/doc

# configs
CONF=$(DESTDIR)/etc/sophomorix

# Schema
#SCHEMA=$(DESTDIR)/etc/ldap/schema

# Developer configs
DEVELCONF=$(DESTDIR)/usr/share/sophomorix

# Encoding-data
#ENCODING=$(DESTDIR)/usr/share/sophomorix/encoding-data

# Language
LANGUAGE=$(DESTDIR)/usr/share/sophomorix/lang

# Filter
#FILTER=$(DESTDIR)/usr/share/sophomorix/filter

# SAMBADEBCONFDIR f�r Debian 
#SAMBADEBCONFDIR=$(DESTDIR)/etc/samba

# SAMBA Debian 
#SAMBADIR=$(DESTDIR)/var/lib/samba
#SAMBAROOTPREEXEC=$(DESTDIR)/etc/linuxmuster/samba/root-preexec.d
#SAMBAROOTPOSTEXEC=$(DESTDIR)/etc/linuxmuster/samba/root-postexec.d

# Config-templates
#CTEMPDIR=$(DESTDIR)/usr/share/sophomorix/config-templates

# Testfiles
#DEVELOPERDIR=$(DESTDIR)/usr/share/sophomorix-developer

# sophomorix-virusscan
#VIRUSSCAN=$(DESTDIR)/usr/share/sophomorix-virusscan

# Tools
#TOOLS=$(DESTDIR)/root/sophomorix-developer


all: install-samba install-virusscan

help:
	@echo ' '
	@echo 'Most common options of this Makefile:'
	@echo '-------------------------------------'
	@echo ' '
	@echo '   make help'
	@echo '      show this help'
	@echo ' '
	@echo '   make | make all'
	@echo '      make an installation of files to the local ubuntu xenial'
	@echo ' '
	@echo '   make developer'
	@echo '      create a debian package'
	@echo ' '
	@echo '   make deb'
	@echo '      create a debian package for ubuntu xenial'
	@echo ' '


deb:
	### Prepare to build an ubuntu xenial package
	@echo 'Did you do a dch -i ?'
	@sleep 2
	dpkg-buildpackage -tc -uc -us -sa -rfakeroot
	@echo ''
	@echo 'Do not forget to tag this version with: git tag V-x.y.z'
	@echo ''

#clean: clean-doc clean-debian
clean: clean-debian

clean-debian:
	rm -rf  debian/sophomorix
	rm -rf  debian/sophomorix-virusscan

# sophomorix-samba
install-samba:
	### install-samba
# some dirs
	@install -d -m700 -oroot -groot $(LIBDIR)
	@install -d -m700 -oroot -groot $(LIBDIR)/tmp
	@install -d -m700 -oroot -groot $(LIBDIR)/lock
	@install -d -m700 -oroot -groot $(LIBDIR)/print-data
#	@install -d -m755 -oroot -groot $(CACHEDIR)
	@install -d -m700 -oroot -groot $(LOGDIR)
	@install -d -m700 -oroot -groot $(LOGDIR)/user
#	@install -d -m700 -oroot -groot $(CTEMPDIR)
#	@install -d -m700 -oroot -groot $(CTEMPDIR)/samba/netlogon
#	@install -d -m700 -oroot -groot $(CTEMPDIR)/apache
# Install the scripts
	@install -d $(DESTDIR)/usr/sbin
	@install -oroot -groot --mode=0744 sophomorix-samba/scripts/sophomorix-*[a-z1-9] $(DESTDIR)/usr/sbin
# Install the modules
	@install -d -m755 -oroot -groot $(PERLMOD)
	@install -oroot -groot --mode=0644 sophomorix-samba/modules/Sophomorix*[a-z1-9.]pm $(PERLMOD)


# group owner is changed in postinst-script to lehrer
#	@install -oroot -groot --mode=4750 sophomorix-base/scripts-teacher/sophomorix-*[a-z1-9] $(DESTDIR)/usr/bin
# installing configs for root
	@install -d -m755 -oroot -groot $(CONF)/user
	@install -oroot -groot --mode=0644 sophomorix-samba/config/sophomorix.conf $(CONF)/user
#	@install -oroot -groot --mode=0600 sophomorix-samba/config/quota.txt $(CONF)/user
#	@install -oroot -groot --mode=0600 sophomorix-samba/config/mailquota.txt $(CONF)/user
	@install -d -m755 -oroot -groot $(CONF)/project
#	@install -oroot -groot --mode=0644 sophomorix-samba/config/projects.create $(CONF)/project
#	@install -oroot -groot --mode=0644 sophomorix-samba/config/projects.update $(CONF)/project
# config-templates
#	@install -oroot -groot --mode=0600 sophomorix-samba/config-templates/*.txt $(CTEMPDIR)
#	@install -oroot -groot --mode=0600 sophomorix-samba/config-templates/*.map $(CTEMPDIR)
#	@install -oroot -groot --mode=0600 sophomorix-samba/config/sophomorix.conf $(CTEMPDIR)
# configs for developers
	@install -d -m755 -oroot -groot $(DEVELCONF)/devel
	@install -oroot -groot --mode=0644 sophomorix-samba/config-devel/sophomorix-devel.conf $(DEVELCONF)/devel
#	@install -oroot -groot --mode=0644 sophomorix-base/config-devel/sophomorix-support.conf $(DEVELCONF)/devel
#	@install -oroot -groot --mode=0600 sophomorix-base/config-devel/repair.directories $(DEVELCONF)/devel
#	@install -d -m755 -oroot -groot $(DEVELCONF)/devel/repair-directories-alt
#	@install -oroot -groot --mode=0600 sophomorix-base/config-devel/repair-directories-alt/README $(DEVELCONF)/devel/repair-directories-alt
#	@install -oroot -groot --mode=0600 sophomorix-base/config-devel/repair-directories-alt/repair.directories-6.0-stable $(DEVELCONF)/devel/repair-directories-alt
#	@install -oroot -groot --mode=0600 sophomorix-base/config-devel/repair-directories-alt/repair.directories-6.1-stable $(DEVELCONF)/devel/repair-directories-alt
#	@install -oroot -groot --mode=0600 sophomorix-base/config-devel/repair-directories-alt/repair.directories-6.1 $(DEVELCONF)/devel/repair-directories-alt
#	@install -oroot -groot --mode=0600 sophomorix-base/config-devel/repairhome.administrator $(DEVELCONF)/devel
#	@install -oroot -groot --mode=0600 sophomorix-base/config-devel/repairhome.teacher $(DEVELCONF)/devel
#	@install -oroot -groot --mode=0600 sophomorix-base/config-devel/repairhome.student $(DEVELCONF)/devel
#	@install -oroot -groot --mode=0600 sophomorix-base/config-devel/repairhome.examaccount $(DEVELCONF)/devel
#	@install -oroot -groot --mode=0600 sophomorix-base/config-devel/repairhome.attic $(DEVELCONF)/devel
#	@install -oroot -groot --mode=0600 sophomorix-base/config-devel/repairhome.domcomp $(DEVELCONF)/devel
	@install -d -m755 -oroot -groot $(LANGUAGE)
	@install -oroot -groot --mode=0644 sophomorix-samba/lang/sophomorix-lang.*[a-z] $(LANGUAGE)
	@install -oroot -groot --mode=0644 sophomorix-samba/lang/errors.*[a-z] $(LANGUAGE)
#	@install -d -m755 -oroot -groot $(LANGUAGE)/latex-templates
#	@install -oroot -groot --mode=0644 sophomorix-base/latex-templates/*.tex $(LANGUAGE)/latex-templates
# Encoding-data
#	@install -d -m755 -oroot -groot $(ENCODING)
#	@install -oroot -groot --mode=0644 sophomorix-base/encoding-data/*.txt $(ENCODING)
# filter scripts
#	@install -d -m755 -oroot -groot $(FILTER)
#	@install -oroot -groot --mode=0755 sophomorix-base/filter/*-filter $(FILTER)
#	@install -oroot -groot --mode=0755 sophomorix-base/filter/*-schueler $(FILTER)
# Copy the module
#	@install -d -m755 -oroot -groot $(PERLMOD)
#	@install -oroot -groot --mode=0644 sophomorix-base/modules/Sophomorix*[A-Za-z1-9].pm $(PERLMOD)
# for samba
#	@install -d -m700 -oroot -groot $(DESTDIR)/home/samba/netlogon
#	@install -oroot -groot --mode=0600 sophomorix-base/samba/netlogon/*.bat.template $(CTEMPDIR)/samba/netlogon
#	@install -d -m700 -oroot -groot $(SAMBAROOTPREEXEC)
#	@install -oroot -groot --mode=0700 sophomorix-base/samba/root-preexec/sophomorix-root-preexec $(SAMBAROOTPREEXEC)
#	@install -d -m700 -oroot -groot $(SAMBAROOTPOSTEXEC)
#	@install -oroot -groot --mode=0700 sophomorix-base/samba/root-postexec/sophomorix-root-postexec $(SAMBAROOTPOSTEXEC)


install-pgldap:
	### install-pgldap
# patch sophomorix.sql.template BEFORE installation
# ./buildhelper/sopho-sqldbmod
# installing lib for managing the user database in pgldap
# scripts
	@install -d $(DESTDIR)/usr/sbin
	@install -oroot -groot --mode=0744 sophomorix-pgldap/scripts/sophomorix-*[a-z1-9] $(DESTDIR)/usr/sbin
# postgres2slapd scripts
	@install -oroot -groot --mode=0744 sophomorix-pgldap/postgres2slapd/dump-postgres-for-ldap.sh $(DESTDIR)/usr/sbin
	@install -oroot -groot --mode=0744 sophomorix-pgldap/postgres2slapd/gen-ldif-from-sql.perl $(DESTDIR)/usr/sbin
# Copy the module
	@install -d -m755 -oroot -groot $(PERLMOD)
	@install -oroot -groot --mode=0644 sophomorix-pgldap/modules/Sophomorix*[a-z1-9] $(PERLMOD)
# Copy the config
	@install -d -m755 -oroot -groot $(CONF)/pgldap/
	@install -oroot -groot --mode=0644 sophomorix-pgldap/config/pgldap.conf $(CONF)/pgldap/
# Copy the ldap config-templates
	@install -d -m755 -oroot -groot $(CTEMPDIR)/ldap/
	@install -oroot -groot --mode=0644 sophomorix-pgldap/config-ldap/*.template $(CTEMPDIR)/ldap/
	@install -d -m755 -oroot -groot $(CTEMPDIR)/ldap/oneiric/15_ldap
	@install -oroot -groot --mode=0644 sophomorix-pgldap/config-ldap/oneiric/15_ldap/* $(CTEMPDIR)/ldap/oneiric/15_ldap
# Copy the upgrade scripts
	@install -d -m755 -oroot -groot $(CTEMPDIR)/scripts/
	@install -d -m755 -oroot -groot $(CTEMPDIR)/scripts/upgrade/
	@install -oroot -groot --mode=0744 sophomorix-base/upgrade-scripts/*.upgrade $(CTEMPDIR)/scripts/upgrade/
# Copy the pg config-templates
	@install -d -m755 -oroot -groot $(CTEMPDIR)/pg/
	@install -oroot -groot --mode=0644 sophomorix-pgldap/config-pg/*.template $(CTEMPDIR)/pg/
	@install -oroot -groot --mode=0644 sophomorix-pgldap/config-pg/sophomorix.sql $(CTEMPDIR)/pg/
	@install -oroot -groot --mode=0644 sophomorix-pgldap/config-pg/sophomorix-admin.sql $(CTEMPDIR)/pg/
	@install -oroot -groot --mode=0644 sophomorix-pgldap/config-pg/sophomorix-lang.sql $(CTEMPDIR)/pg/
	@install -oroot -groot --mode=0644 sophomorix-pgldap/config-pg/create-index.sql $(CTEMPDIR)/pg/
	@install -oroot -groot --mode=0644 sophomorix-pgldap/config-pg/drop-index.sql $(CTEMPDIR)/pg/
# Copy the pg upgrade files
	@install -d -m755 -oroot -groot $(CTEMPDIR)/pg/upgrade
	@install -oroot -groot --mode=0644 sophomorix-pgldap/config-pg/db-upgrade/*.sql $(CTEMPDIR)/pg/upgrade/
# Copy the pam config-templates
	@install -d -m755 -oroot -groot $(CTEMPDIR)/pam/
	@install -oroot -groot --mode=0644 sophomorix-pgldap/config-pam/*.template $(CTEMPDIR)/pam/
# Copy the samba config-templates
	@install -d -m755 -oroot -groot $(CTEMPDIR)/samba/
	@install -oroot -groot --mode=0644 sophomorix-pgldap/config-samba/smb.conf.template $(CTEMPDIR)/samba/
	@install -oroot -groot --mode=0644 sophomorix-pgldap/config-samba/smb.conf.template.linbo $(CTEMPDIR)/samba/
	@install -oroot -groot --mode=0644 sophomorix-pgldap/config-samba/smb.conf.template.rembo $(CTEMPDIR)/samba/
	@install -oroot -groot --mode=0644 sophomorix-pgldap/config-samba/smb.conf.template.tivoli $(CTEMPDIR)/samba/
	@install -oroot -groot --mode=0644 sophomorix-pgldap/config-samba/smb.conf.global $(CTEMPDIR)/samba/
# install samba.schema
	@install -d -m755 -oroot -groot $(SCHEMA)/
	@install -oroot -groot --mode=0755 sophomorix-pgldap/config-ldap/samba.schema $(SCHEMA)/
# install sophomorix.schema
	@install -d -m755 -oroot -groot $(SCHEMA)/
	@install -oroot -groot --mode=0755 sophomorix-pgldap/schema/sophomorix.schema $(SCHEMA)/
# Copy the apache-templates
	@install -oroot -groot --mode=0644 sophomorix-base/apache-templates/*-template $(CTEMPDIR)/apache/
# the install script for the database installation
	@install -d -m755 -oroot -groot $(DBINSTALL)/
	@install -oroot -groot --mode=0644 sophomorix-pgldap/config-pg/sophomorix.sql $(DBINSTALL)/pgsql
# the install-dbadmin script for the database installation
	@install -d -m755 -oroot -groot $(DBADMININSTALL)/
	@install -oroot -groot --mode=0644 sophomorix-pgldap/config-pg/sophomorix-admin.sql $(DBADMININSTALL)/pgsql
# the install script for the database installation
# obsolete ???
	@install -d -m755 -oroot -groot $(DBUPGRADE)/
# put the update scripts into place ()
	@install -d -m755 -oroot -groot $(CTEMPDIR)/bdb/
	@install -oroot -groot --mode=0644 sophomorix-pgldap/config-bdb/DB_CONFIG $(CTEMPDIR)/bdb/
	@install -oroot -groot --mode=0644 sophomorix-pgldap/config-bdb/slapd-standalone.DB_CONFIG $(CTEMPDIR)/bdb/


install-virusscan:
#	### install-virusscan
#	@install -d -m755 -oroot -groot $(CONF)/virusscan
#	@install sophomorix-virusscan/config/sophomorix-virusscan.conf $(CONF)/virusscan
#	@install sophomorix-virusscan/config/sophomorix-virusscan-excludes.conf $(CONF)/virusscan
#	@install -d $(DESTDIR)/usr/sbin
#	@install -oroot -groot --mode=0744 sophomorix-virusscan/scripts/sophomorix-virusscan $(DESTDIR)/usr/sbin


#install-janitor:
#	### install-janitor
#	@install -d $(DESTDIR)/usr/sbin
#	@install -oroot -groot --mode=0744 sophomorix-base/scripts/sophomorix-janitor $(DESTDIR)/usr/sbin



#install-developer:
	### install-developer
### installing test and developement tools
#	@install -d $(DESTDIR)/usr/sbin
#	@install -oroot -groot --mode=0744 sophomorix-developer/scripts/sophomorix-test $(DESTDIR)/usr/sbin
#	@install -oroot -groot --mode=0744 sophomorix-developer/scripts/sophomorix-*[a-z1-9] $(DESTDIR)/usr/sbin
# copying perl developer modules
#	@install -d -m755 -oroot -groot $(PERLMOD)
#	@install -oroot -groot --mode=0644 sophomorix-developer/modules/Sophomorix*[a-z1-9] $(PERLMOD)
# tools for developing
# installing sources.list examples
#	@install -d $(TOOLS)/apt/s-lists
#	@install -oroot -groot --mode=0644 sophomorix-developer/tools/apt/s-lists/*sources.list $(TOOLS)/apt/s-lists
# installing testfiles
#	@install -d $(DEVELOPERDIR)
#	@install -d $(DEVELOPERDIR)/testfiles
#	@install -oroot -groot --mode=0644 sophomorix-developer/testfiles/*.txt $(DEVELOPERDIR)/testfiles
#	@install -d $(DEVELOPERDIR)/projectfiles
#	@install -oroot -groot --mode=0644 sophomorix-developer/projectfiles/*.dump $(DEVELOPERDIR)/projectfiles
#	@install -d $(TOOLS)/projectdumps
# installing  scripts for laptop development
#	@install -d $(TOOLS)/scripts/laptop
#	@install -oroot -groot --mode=0755 sophomorix-developer/tools/scripts/laptop/*-cvs $(TOOLS)/scripts/laptop



#clean-doc:
#	### clean-doc
#	rm -rf sophomorix-doc/html

# you need to: 
#       apt-get install docbook-utils
# on debian to create documentation
#doc:
#	### doc
## Creating html-documentation
#	cd ./sophomorix-doc/source/sgml; docbook2html --nochunks --output ../../html  sophomorix.sgml
## Creating html-manpages
#	./buildhelper/sopho-man2html
## Creating changelog
#	./buildhelper/sopho-changelog


