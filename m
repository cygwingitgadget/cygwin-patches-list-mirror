Return-Path: <cygwin-patches-return-5368-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31014 invoked by alias); 6 Mar 2005 20:53:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30950 invoked from network); 6 Mar 2005 20:53:08 -0000
Received: from unknown (HELO mail.gmx.net) (213.165.64.20)
  by sourceware.org with SMTP; 6 Mar 2005 20:53:08 -0000
Received: (qmail invoked by alias); 06 Mar 2005 20:53:03 -0000
Received: from unknown (EHLO mordor) (213.16.60.188)
  by mail.gmx.net (mp022) with SMTP; 06 Mar 2005 21:53:03 +0100
X-Authenticated: #14308112
Date: Sun, 06 Mar 2005 20:53:00 -0000
From: Pavel Tsekov <ptsekov@gmx.net>
X-X-Sender: ptsekov@mordor
To: cygwin-patches@cygwin.com
Subject: [PATCH]: Use the user supplied cygdrive prefix
Message-ID: <Pine.CYG.4.58.0503062225170.1264@mordor>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-623233870-1110142316=:308"
X-Y-GMX-Trusted: 0
X-SW-Source: 2005-q1/txt/msg00071.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-623233870-1110142316=:308
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-length: 2251

Hello,

with the latest release (1.5.13-1) I have trouble accessing drives via a
prefix other than /cygdrive. It seems that this was introduced by the
following change:

2004-10-28  Pierre Humblet <pierre.humblet@ieee.org>

        * path.cc (mount_info::from_registry): Deimpersonate while
        accessing HKLM.
        (mount_info::read_cygdrive_info_from_registry): Ditto.
        * cygheap.h: Define NO_IMPERSONATION.
        (cygheap_user::issetuid): Replace INVALID_HANDLE_VALUE by
        NO_IMPERSONATION.
        (cygheap_user::has_impersonation_tokens): Ditto.
        (cygheap_user::close_impersonation_tokens): Ditto.
        * uinfo.cc (uinfo_init): Ditto.
        * syscalls.cc (seteuid32): Ditto.
        * security.cc (set_impersonation_token): Ditto.

Here is how the system behaves without the patch:

Administrator@mordor ~
$ mount
C:\cygwin\usr\X11R6\lib\X11\fonts on /usr/X11R6/lib/X11/fonts type system
(binmode)
C:\cygwin\usr\share\mc\extfs on /usr/share/mc/extfs type system
(binmode,cygexec)
C:\cygwin\bin on /usr/bin type system (binmode)
C:\cygwin\lib on /usr/lib type system (binmode)
C:\cygwin on / type system (binmode)
c: on /cygdrive/c type system (binmode,noumount)

Administrator@mordor ~
$ mount -p
Prefix              Type         Flags
/mnt                user         binmode
/cygdrive           system       binmode

Administrator@mordor ~
$ cd /mnt/c
bash: cd: /mnt/c: No such file or directory

Administrator@mordor ~
$

and with the patch:

Administrator@mordor ~
$ mount
C:\cygwin\usr\X11R6\lib\X11\fonts on /usr/X11R6/lib/X11/fonts type system
(binmode)
C:\cygwin\usr\share\mc\extfs on /usr/share/mc/extfs type system
(binmode,cygexec)
C:\cygwin\bin on /usr/bin type system (binmode)
C:\cygwin\lib on /usr/lib type system (binmode)
C:\cygwin on / type system (binmode)
c: on /mnt/c type user (binmode,noumount)

Administrator@mordor ~
$ mount -p
Prefix              Type         Flags
/mnt                user         binmode
/cygdrive           system       binmode

Administrator@mordor ~
$ cd /mnt/c

Administrator@mordor /mnt/c
$


Here is the changelog entry:

2005-03-06  Pavel Tsekov  <ptsekov@gmx.net>

	* path.cc (mount_info::read_cygdrive_info_from_registry):
	Use the user prefix if it exists.

---559023410-623233870-1110142316=:308
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="path.cc.cygdrive.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.CYG.4.58.0503062251560.308@mordor>
Content-Description: 
Content-Disposition: attachment; filename="path.cc.cygdrive.patch"
Content-length: 659

SW5kZXg6IHBhdGguY2MNCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NClJDUyBm
aWxlOiAvY3ZzL3NyYy9zcmMvd2luc3VwL2N5Z3dpbi9wYXRoLmNjLHYNCnJl
dHJpZXZpbmcgcmV2aXNpb24gMS4zNTENCmRpZmYgLXUgLXAgLXIxLjM1MSBw
YXRoLmNjDQotLS0gcGF0aC5jYwk2IE1hciAyMDA1IDIwOjE1OjA3IC0wMDAw
CTEuMzUxDQorKysgcGF0aC5jYwk2IE1hciAyMDA1IDIwOjUxOjI0IC0wMDAw
DQpAQCAtMTk1Niw2ICsxOTU2LDcgQEAgbW91bnRfaW5mbzo6cmVhZF9jeWdk
cml2ZV9pbmZvX2Zyb21fcmVnaQ0KIAljeWdkcml2ZV9mbGFncyB8PSBNT1VO
VF9TWVNURU07DQogICAgICAgc2xhc2hpZnkgKGN5Z2RyaXZlLCBjeWdkcml2
ZSwgMSk7DQogICAgICAgY3lnZHJpdmVfbGVuID0gc3RybGVuIChjeWdkcml2
ZSk7DQorICAgICAgYnJlYWs7DQogICAgIH0NCiB9DQogDQo=

---559023410-623233870-1110142316=:308--
