Return-Path: <cygwin-patches-return-3846-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6351 invoked by alias); 6 May 2003 13:25:15 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6243 invoked from network); 6 May 2003 13:25:14 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Date: Tue, 06 May 2003 13:25:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Fix nanosleep 
Message-ID: <Pine.WNT.4.44.0305061513150.1572-200000@algeria.intern.net>
X-X-Sender: pfaff@antarctica.intern.net
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="709017-14272-1052227496=:1572"
X-SW-Source: 2003-q2/txt/msg00073.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--709017-14272-1052227496=:1572
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-length: 448


While i am investigating some problems with threads and signals i have
found a bug in nanosleep where signal_arrived is unnecessary checked
twice. This will lead to problems if the event is reset between the two
checks. I can provide a testcase if someone is interested in details.
AFAICT this problem occurs only in multithreaded apps.

2002-05-06  Thomas Pfaff  <tpfaff@gmx.net>

	* signal.cc (nanosleep): Do not wait twice for signal arrival.


--709017-14272-1052227496=:1572
Content-Type: TEXT/plain; name="nanosleep.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.WNT.4.44.0305061524560.1572@algeria.intern.net>
Content-Description: 
Content-Disposition: attachment; filename="nanosleep.patch"
Content-length: 688

LS0tIHNpZ25hbC5jYy5vcmcJMjAwMy0wNS0wNiAxNToxMDowMy4wMDAwMDAw
MDAgKzAyMDAKKysrIHNpZ25hbC5jYwkyMDAzLTA1LTA2IDE1OjExOjA0LjAw
MDAwMDAwMCArMDIwMApAQCAtODgsNyArODgsNyBAQCBuYW5vc2xlZXAgKGNv
bnN0IHN0cnVjdCB0aW1lc3BlYyAqcnF0cCwgCiAgIGludCByYyA9IHB0aHJl
YWQ6OmNhbmNlbGFibGVfd2FpdCAoc2lnbmFsX2Fycml2ZWQsIHJlcSk7CiAg
IERXT1JEIG5vdyA9IEdldFRpY2tDb3VudCAoKTsKICAgRFdPUkQgcmVtID0g
KHJjID09IFdBSVRfVElNRU9VVCB8fCBub3cgPj0gZW5kX3RpbWUpID8gMCA6
IGVuZF90aW1lIC0gbm93OwotICBpZiAoV2FpdEZvclNpbmdsZU9iamVjdCAo
c2lnbmFsX2Fycml2ZWQsIDApID09IFdBSVRfT0JKRUNUXzApCisgIGlmIChy
YyA9PSBXQUlUX09CSkVDVF8wKQogICAgIHsKICAgICAgICh2b2lkKSB0aGlz
ZnJhbWUuY2FsbF9zaWduYWxfaGFuZGxlciAoKTsKICAgICAgIHNldF9lcnJu
byAoRUlOVFIpOwo=

--709017-14272-1052227496=:1572--
