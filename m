Return-Path: <cygwin-patches-return-4689-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11738 invoked by alias); 20 Apr 2004 14:52:43 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11725 invoked from network); 20 Apr 2004 14:52:41 -0000
Date: Tue, 20 Apr 2004 14:52:00 -0000
From: Brian Ford <ford@vss.fsi.com>
To: cygwin-patches@cygwin.com
Subject: wingdi.h (ENUMLOGFONTEXDV[AW]): breaks Cygwin (fwd)
Message-ID: <Pine.CYG.4.58.0404200945330.1912@fordpc.vss.fsi.com>
Reply-To.: cygwin-patches@cygwin.com
MIME-Version: 1.0
Content-Type: MULTIPART/Mixed; BOUNDARY="-559023410-476519575-1082414628=:2244"
Content-ID: <Pine.CYG.4.58.0404200945331.1912@fordpc.vss.fsi.com>
X-SW-Source: 2004-q2/txt/msg00041.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-476519575-1082414628=:2244
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.CYG.4.58.0404200945332.1912@fordpc.vss.fsi.com>
Content-length: 2301

I sent this to mingw-patches yesterday, but it got stuck waiting on
moderator approval because I am not subscribed.  As such, I thought I'd
forward it here as well.

I assume mingw-patches is the preferred list for w32api patches?  Does
anyone know if there is a subscribe for posting only option?  Thanks.

-- 
Brian Ford
Senior Realtime Software Engineer
VITAL - Visual Simulation Systems
FlightSafety International
Phone: 314-551-8460
Fax:   314-551-8444

---------- Forwarded message ----------
Date: Mon, 19 Apr 2004 17:43:48 -0500
To: mingw-patches=lists.sourceforge.net
Cc: Filip Navara <xnavara=volny.cz>
Subject: wingdi.h (ENUMLOGFONTEXDV[AW]): breaks Cygwin

2004-04-19  Brian Ford  <ford@vss.fsi.com>

	* include/wingdi.h (ENUMLOGFONTEXDV[AW]): Only define if
	_WIN32_WINNT >= 0x0500.

gcc -L/home/ford/downloads/cygb2/i686-pc-cygwin/winsup
-L/home/ford/downloads/cygb2/i686-pc-cygwin/winsup/cygwin
-L/home/ford/downloads/cygb2/i686-pc-cygwin/winsup/w32api/lib -isystem
/home/ford/downloads/cygwin/winsup/include -isystem
/home/ford/downloads/cygwin/winsup/cygwin/include -isystem
/home/ford/downloads/cygwin/winsup/w32api/include
-B/home/ford/downloads/cygb2/i686-pc-cygwin/newlib/ -isystem
/home/ford/downloads/cygb2/i686-pc-cygwin/newlib/targ-include -isystem
/home/ford/downloads/cygwin/newlib/libc/include -c -O2 -g -O2
-I../../../../../cygwin/winsup/w32api/lib/../include
-I../../../../../cygwin/winsup/w32api/lib/../../include
-I../../../../../cygwin/winsup/w32api/lib/../../../newlib/libc/include
-I../../../../../cygwin/winsup/w32api/lib/../../../newlib/libc/sys/cygwin
-o scrnsave.o ../../../../../cygwin/winsup/w32api/lib/scrnsave.c
In file included from
/home/ford/downloads/cygwin/winsup/w32api/include/windows.h:52,
                 from
../../../../../cygwin/winsup/w32api/lib/scrnsave.c:10:
/home/ford/downloads/cygwin/winsup/w32api/include/wingdi.h:2953: error:
syntax error before "ENUMLOGFONTEXDV"
/home/ford/downloads/cygwin/winsup/w32api/include/wingdi.h:2954: error:
syntax error before "PENUMLOGFONTEXDV"
/home/ford/downloads/cygwin/winsup/w32api/include/wingdi.h:2955: error:
syntax error before "LPENUMLOGFONTEXDV"

-- 
Brian Ford
Senior Realtime Software Engineer
VITAL - Visual Simulation Systems
FlightSafety International
Phone: 314-551-8460
Fax:   314-551-8444
---559023410-476519575-1082414628=:2244
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="wingdi.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.CYG.4.58.0404191743480.2244@fordpc.vss.fsi.com>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="wingdi.patch"
Content-length: 1912

SW5kZXg6IHdpbmdkaS5oDQo9PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQpSQ1Mg
ZmlsZTogL2N2cy9zcmMvc3JjL3dpbnN1cC93MzJhcGkvaW5jbHVkZS93aW5n
ZGkuaCx2DQpyZXRyaWV2aW5nIHJldmlzaW9uIDEuMzMNCmRpZmYgLXUgLXAg
LXIxLjMzIHdpbmdkaS5oDQotLS0gd2luZ2RpLmgJMTggQXByIDIwMDQgMDc6
MDc6NTYgLTAwMDAJMS4zMw0KKysrIHdpbmdkaS5oCTE5IEFwciAyMDA0IDIy
OjI5OjUyIC0wMDAwDQpAQCAtMjg3OCw5ICsyODc4LDExIEBAIHR5cGVkZWYg
VEVYVE1FVFJJQ1cgVEVYVE1FVFJJQywqUFRFWFRNRVQNCiAjZGVmaW5lIElD
TUVOVU1QUk9DIElDTUVOVU1QUk9DVw0KICNkZWZpbmUgRk9OVEVOVU1QUk9D
IEZPTlRFTlVNUFJPQ1cNCiB0eXBlZGVmIERFVk1PREVXIERFVk1PREUsKlBE
RVZNT0RFLCpMUERFVk1PREU7DQorI2lmIF9XSU4zMl9XSU5OVCA+PSAweDA1
MDANCiB0eXBlZGVmIEVOVU1MT0dGT05URVhEVlcgRU5VTUxPR0ZPTlRFWERW
Ow0KIHR5cGVkZWYgUEVOVU1MT0dGT05URVhEVlcgUEVOVU1MT0dGT05URVhE
VjsNCiB0eXBlZGVmIExQRU5VTUxPR0ZPTlRFWERWVyBMUEVOVU1MT0dGT05U
RVhEVjsNCisjZW5kaWYNCiB0eXBlZGVmIEVYVExPR0ZPTlRXIEVYVExPR0ZP
TlQsKlBFWFRMT0dGT05ULCpMUEVYVExPR0ZPTlQ7DQogdHlwZWRlZiBHQ1Bf
UkVTVUxUU1cgR0NQX1JFU1VMVFMsKkxQR0NQX1JFU1VMVFM7DQogdHlwZWRl
ZiBPVVRMSU5FVEVYVE1FVFJJQ1cgT1VUTElORVRFWFRNRVRSSUMsKlBPVVRM
SU5FVEVYVE1FVFJJQywqTFBPVVRMSU5FVEVYVE1FVFJJQzsNCkBAIC0yOTUw
LDkgKzI5NTIsMTEgQEAgdHlwZWRlZiBURVhUTUVUUklDQSBURVhUTUVUUklD
LCpQVEVYVE1FVA0KICNkZWZpbmUgSUNNRU5VTVBST0MgSUNNRU5VTVBST0NB
DQogI2RlZmluZSBGT05URU5VTVBST0MgRk9OVEVOVU1QUk9DQQ0KIHR5cGVk
ZWYgREVWTU9ERUEgREVWTU9ERSwqUERFVk1PREUsKkxQREVWTU9ERTsNCisj
aWYgX1dJTjMyX1dJTk5UID49IDB4MDUwMA0KIHR5cGVkZWYgRU5VTUxPR0ZP
TlRFWERWQSBFTlVNTE9HRk9OVEVYRFY7DQogdHlwZWRlZiBQRU5VTUxPR0ZP
TlRFWERWQSBQRU5VTUxPR0ZPTlRFWERWOw0KIHR5cGVkZWYgTFBFTlVNTE9H
Rk9OVEVYRFZBIExQRU5VTUxPR0ZPTlRFWERWOw0KKyNlbmRpZg0KIHR5cGVk
ZWYgRVhUTE9HRk9OVEEgRVhUTE9HRk9OVCwqUEVYVExPR0ZPTlQsKkxQRVhU
TE9HRk9OVDsNCiB0eXBlZGVmIEdDUF9SRVNVTFRTQSBHQ1BfUkVTVUxUUywq
TFBHQ1BfUkVTVUxUUzsNCiB0eXBlZGVmIE9VVExJTkVURVhUTUVUUklDQSBP
VVRMSU5FVEVYVE1FVFJJQywqUE9VVExJTkVURVhUTUVUUklDLCpMUE9VVExJ
TkVURVhUTUVUUklDOw0K

---559023410-476519575-1082414628=:2244--
