Return-Path: <cygwin-patches-return-3366-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2290 invoked by alias); 10 Jan 2003 08:54:33 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1226 invoked from network); 10 Jan 2003 08:54:28 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Date: Fri, 10 Jan 2003 08:54:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Make sleep and usleep a cancellation point
Message-ID: <Pine.WNT.4.44.0301100943530.299-200000@algeria.intern.net>
X-X-Sender: pfaff@antarctica.intern.net
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="602334-206-1042188828=:299"
X-SW-Source: 2003-q1/txt/msg00015.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--602334-206-1042188828=:299
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-length: 223

This patch will make sleep and usleep a pthread cancellation point.

2003-01-10  Thomas Pfaff  <tpfaff@gmx.net>

	* signal.cc (sleep): Add pthread_testcancel call.
	Wait for signal and cancellation event.
	(usleep): Ditto.

--602334-206-1042188828=:299
Content-Type: TEXT/plain; name="sleep-cancel.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.WNT.4.44.0301100953480.299@algeria.intern.net>
Content-Description: 
Content-Disposition: attachment; filename="sleep-cancel.patch"
Content-length: 1513

ZGlmZiAtdXJwIHNyYy5vbGQvd2luc3VwL2N5Z3dpbi9zaWduYWwuY2Mgc3Jj
L3dpbnN1cC9jeWd3aW4vc2lnbmFsLmNjCi0tLSBzcmMub2xkL3dpbnN1cC9j
eWd3aW4vc2lnbmFsLmNjCTIwMDItMTEtMjMgMDQ6MDc6MTAuMDAwMDAwMDAw
ICswMTAwCisrKyBzcmMvd2luc3VwL2N5Z3dpbi9zaWduYWwuY2MJMjAwMy0w
MS0wOSAwOTo0MjoyOS4wMDAwMDAwMDAgKzAxMDAKQEAgLTc0LDEyICs3NCwx
NCBAQCBzbGVlcCAodW5zaWduZWQgaW50IHNlY29uZHMpCiAgIHNpZ2ZyYW1l
IHRoaXNmcmFtZSAobWFpbnRocmVhZCk7CiAgIERXT1JEIG1zLCBzdGFydF90
aW1lLCBlbmRfdGltZTsKIAorICBwdGhyZWFkX3Rlc3RjYW5jZWwgKCk7CisK
ICAgbXMgPSBzZWNvbmRzICogMTAwMDsKICAgc3RhcnRfdGltZSA9IEdldFRp
Y2tDb3VudCAoKTsKICAgZW5kX3RpbWUgPSBzdGFydF90aW1lICsgKHNlY29u
ZHMgKiAxMDAwKTsKICAgc3lzY2FsbF9wcmludGYgKCJzbGVlcCAoJWQpIiwg
c2Vjb25kcyk7CiAKLSAgcmMgPSBXYWl0Rm9yU2luZ2xlT2JqZWN0IChzaWdu
YWxfYXJyaXZlZCwgbXMpOworICByYyA9IHB0aHJlYWQ6OmNhbmNlbGFibGVf
d2FpdCAoc2lnbmFsX2Fycml2ZWQsIG1zKTsKICAgRFdPUkQgbm93ID0gR2V0
VGlja0NvdW50ICgpOwogICBpZiAocmMgPT0gV0FJVF9USU1FT1VUIHx8IG5v
dyA+PSBlbmRfdGltZSkKICAgICBtcyA9IDA7CkBAIC05Nyw5ICs5OSwxMSBA
QCBzbGVlcCAodW5zaWduZWQgaW50IHNlY29uZHMpCiBleHRlcm4gIkMiIHVu
c2lnbmVkIGludAogdXNsZWVwICh1bnNpZ25lZCBpbnQgdXNlY29uZHMpCiB7
CisgIHB0aHJlYWRfdGVzdGNhbmNlbCAoKTsKKwogICBzaWdfZGlzcGF0Y2hf
cGVuZGluZyAoMCk7CiAgIHN5c2NhbGxfcHJpbnRmICgidXNsZWVwICglZCki
LCB1c2Vjb25kcyk7Ci0gIFdhaXRGb3JTaW5nbGVPYmplY3QgKHNpZ25hbF9h
cnJpdmVkLCAodXNlY29uZHMgKyA1MDApIC8gMTAwMCk7CisgIHB0aHJlYWQ6
OmNhbmNlbGFibGVfd2FpdCAoc2lnbmFsX2Fycml2ZWQsICh1c2Vjb25kcyAr
IDUwMCkgLyAxMDAwKTsKICAgc3lzY2FsbF9wcmludGYgKCIwID0gdXNsZWVw
ICglZCkiLCB1c2Vjb25kcyk7CiAgIHJldHVybiAwOwogfQo=

--602334-206-1042188828=:299--
