#!/bin/sh

# Copyright (C) 2009 Carlos Valiente.
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
# 02110-1301, USA.

opensuse_bootstrap() {
  # Bootstrap an OpenSuSE installation
  target="$1"

  $MKDIR_P $target/proc
  mount -t proc /proc $target/proc
  CLEANUP+=("umount $target/proc")

  $MKDIR_P $target/dev
  (cd $target/dev && MAKEDEV std ptmx fd)

  $MKDIR_P $target/var/lib/rpm
  $RPM --initdb --verbose --root $target

  $MKDIR_P $target/etc/zypp/repos.d
  cat > $target/etc/zypp/repos.d/oss.repo <<EOT
[oss]
name=Main Repository (OSS)
enabled=1
autorefresh=1
baseurl=$MIRROR/distribution/$VERSION/repo/oss/
path=/
type=yast2
keeppackages=0
EOT
  cat > $target/etc/zypp/repos.d/non-oss.repo <<EOT
[non-oss]
name=Main Repository (NON-OSS)
enabled=1
autorefresh=1
baseurl=$MIRROR/distribution/$VERSION/repo/non-oss/
path=/
type=yast2
keeppackages=0
EOT
  cat > $target/etc/zypp/repos.d/update.repo <<EOT
[update]
name=Main Update Repository
enabled=1
autorefresh=1
baseurl=$MIRROR/update/$VERSION/
path=/
type=rpm-md
keeppackages=0
EOT

  # Several RPMs rely on service 'boot.localfs' being enabled, so install
  # aaa_base first and enable it manually.
  $ZYPPER \
    --root $target \
    --no-gpg-checks \
    --non-interactive \
    install \
    --auto-agree-with-licenses \
    --no-recommends \
    aaa_base
  chroot $target /sbin/chkconfig --add boot.localfs

  # Proceed to install zypper and basic RPMs
  $ZYPPER \
    --root $target \
    --no-gpg-checks \
    --non-interactive \
    install \
    --auto-agree-with-licenses \
    --no-recommends \
      dump \
      kernel-xen \
      ntp \
      syslog-ng \
      vim \
      xinetd \
      util-linux \
      yast2 yast2-ncurses \
      yast2-inetd \
      yast2-mail \
      yast2-ntp-client \
      yast2-online-update \
      yast2-runlevel \
      yast2-sysconfig \
      yast2-update \
      zypper

  # Set up host name
  echo "$INSTANCE_NAME" > $target/etc/HOSTNAME

  # Make sure root may log in
  chroot $target /usr/bin/passwd --stdin root < /dev/null
  echo "console" >> $target/etc/securetty

  # Unmount /proc so that cache tar file creation works
  umount $target/proc
}
