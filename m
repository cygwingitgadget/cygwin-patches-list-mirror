Return-Path: <cygwin-patches-return-3386-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4279 invoked by alias); 14 Jan 2003 10:51:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4262 invoked from network); 14 Jan 2003 10:51:04 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Date: Tue, 14 Jan 2003 10:51:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Make system a pthread cancellation point
Message-ID: <Pine.WNT.4.44.0301141143200.319-200000@algeria.intern.net>
X-X-Sender: pfaff@antarctica.intern.net
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="439342-4766-1042541427=:319"
X-SW-Source: 2003-q1/txt/msg00035.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--439342-4766-1042541427=:319
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-length: 264


Sorry, no testcase for that patch (it is really to simple).

I will commit my outstanding patches today.

Thomas

2003-01-14  Thomas Pfaff  <tpfaff@gmx.net>

	* syscalls.cc (system): Add pthread_testcancel call.
	* thread.cc: Update list of cancellation points.


--439342-4766-1042541427=:319
Content-Type: TEXT/plain; name="system-cancel.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.WNT.4.44.0301141150270.319@algeria.intern.net>
Content-Description: 
Content-Disposition: attachment; filename="system-cancel.patch"
Content-length: 1233

ZGlmZiAtdXJwIHNyYy5vbGQvd2luc3VwL2N5Z3dpbi9zeXNjYWxscy5jYyBz
cmMvd2luc3VwL2N5Z3dpbi9zeXNjYWxscy5jYwotLS0gc3JjLm9sZC93aW5z
dXAvY3lnd2luL3N5c2NhbGxzLmNjCTIwMDItMTItMjMgMDA6MDI6NTMuMDAw
MDAwMDAwICswMTAwCisrKyBzcmMvd2luc3VwL2N5Z3dpbi9zeXNjYWxscy5j
YwkyMDAzLTAxLTE0IDExOjM1OjUxLjAwMDAwMDAwMCArMDEwMApAQCAtMTM3
NCw2ICsxMzc0LDggQEAgZG9uZToKIGV4dGVybiAiQyIgaW50CiBzeXN0ZW0g
KGNvbnN0IGNoYXIgKmNtZHN0cmluZykKIHsKKyAgcHRocmVhZF90ZXN0Y2Fu
Y2VsICgpOworCiAgIGlmIChjaGVja19udWxsX2VtcHR5X3N0cl9lcnJubyAo
Y21kc3RyaW5nKSkKICAgICByZXR1cm4gLTE7CiAKZGlmZiAtdXJwIHNyYy5v
bGQvd2luc3VwL2N5Z3dpbi90aHJlYWQuY2Mgc3JjL3dpbnN1cC9jeWd3aW4v
dGhyZWFkLmNjCi0tLSBzcmMub2xkL3dpbnN1cC9jeWd3aW4vdGhyZWFkLmNj
CTIwMDMtMDEtMTMgMTE6NTA6MzAuMDAwMDAwMDAwICswMTAwCisrKyBzcmMv
d2luc3VwL2N5Z3dpbi90aHJlYWQuY2MJMjAwMy0wMS0xNCAxMTo0MDozNC4w
MDAwMDAwMDAgKzAxMDAKQEAgLTQ2NCw3ICs0NjQsNyBAQCBwcmVhZCAoKQog
cHRocmVhZF9jb25kX3RpbWVkd2FpdCAoKQogcHRocmVhZF9jb25kX3dhaXQg
KCkKICpwdGhyZWFkX2pvaW4gKCkKLXB0aHJlYWRfdGVzdGNhbmNlbCAoKQor
KnB0aHJlYWRfdGVzdGNhbmNlbCAoKQogcHV0bXNnICgpCiBwdXRwbXNnICgp
CiBwd3JpdGUgKCkKQEAgLTQ3OCw3ICs0NzgsNyBAQCBzaWd0aW1lZHdhaXQg
KCkKIHNpZ3dhaXQgKCkKIHNpZ3dhaXRpbmZvICgpCiAqc2xlZXAgKCkKLXN5
c3RlbSAoKQorKnN5c3RlbSAoKQogdGNkcmFpbiAoKQogKnVzbGVlcCAoKQog
KndhaXQgKCkK

--439342-4766-1042541427=:319--
