Return-Path: <cygwin-patches-return-3382-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11208 invoked by alias); 13 Jan 2003 12:43:51 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11198 invoked from network); 13 Jan 2003 12:43:49 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Date: Mon, 13 Jan 2003 12:43:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Make wait4 a pthread cancellation point
Message-ID: <Pine.WNT.4.44.0301131330030.237-300000@algeria.intern.net>
X-X-Sender: pfaff@antarctica.intern.net
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="806685-23053-1042461803=:237"
X-SW-Source: 2003-q1/txt/msg00031.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--806685-23053-1042461803=:237
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-length: 292

Attached is a patch and a test case for wait4 (used by wait, wait3 and
waitpid).

2003-01-13  Thomas Pfaff  <tpfaff@gmx.net>

	* wait.cc: Include thread.h
	(wait4): Add pthread_testcancel call.
	Wait for child process and cancellation event.
	* thread.cc: Update list of cancellation points.

--806685-23053-1042461803=:237
Content-Type: TEXT/plain; name="cancel9.c"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.WNT.4.44.0301131343230.237@algeria.intern.net>
Content-Description: 
Content-Disposition: attachment; filename="cancel9.c"
Content-length: 1570

LyoKICogRmlsZTogY2FuY2VsOS5jCiAqCiAqIFRlc3QgU3lub3BzaXM6IFRl
c3QgaWYgd2FpdHBpZCBpcyBhIGNhbmNlbGxhdGlvbiBwb2ludC4KICoKICog
VGVzdCBNZXRob2QgKFZhbGlkYXRpb24gb3IgRmFsc2lmaWNhdGlvbik6CiAq
IC0gCiAqCiAqIFJlcXVpcmVtZW50cyBUZXN0ZWQ6CiAqIC0KICoKICogRmVh
dHVyZXMgVGVzdGVkOgogKiAtIAogKgogKiBDYXNlcyBUZXN0ZWQ6CiAqIC0g
CiAqCiAqIERlc2NyaXB0aW9uOgogKiAtIAogKgogKiBFbnZpcm9ubWVudDoK
ICogLSAKICoKICogSW5wdXQ6CiAqIC0gTm9uZS4KICoKICogT3V0cHV0Ogog
KiAtIEZpbGUgbmFtZSwgTGluZSBudW1iZXIsIGFuZCBmYWlsZWQgZXhwcmVz
c2lvbiBvbiBmYWlsdXJlLgogKiAtIE5vIG91dHB1dCBvbiBzdWNjZXNzLgog
KgogKiBBc3N1bXB0aW9uczoKICogLSBoYXZlIHdvcmtpbmcgcHRocmVhZF9j
cmVhdGUsIHB0aHJlYWRfY2FuY2VsLCBwdGhyZWFkX3NldGNhbmNlbHN0YXRl
CiAqICAgcHRocmVhZF9qb2luCiAqCiAqIFBhc3MgQ3JpdGVyaWE6CiAqIC0g
UHJvY2VzcyByZXR1cm5zIHplcm8gZXhpdCBzdGF0dXMuCiAqCiAqIEZhaWwg
Q3JpdGVyaWE6CiAqIC0gUHJvY2VzcyByZXR1cm5zIG5vbi16ZXJvIGV4aXQg
c3RhdHVzLgogKi8KCiNpbmNsdWRlICJ0ZXN0LmgiCgpzdGF0aWMgdm9pZCAq
VGhyZWFkKHZvaWQgKnB1bnVzZWQpCnsKICBpbnQgcmVzOwogIHBpZF90IHBp
ZCA9IGZvcmsgKCk7CgogIGFzc2VydCAocGlkICE9IC0xKTsKICBzd2l0Y2gg
KHBpZCkKICAgIHsKICAgIGNhc2UgMDoKICAgICAgc2xlZXAgKDEwKTsKICAg
ICAgYnJlYWs7CiAgICBkZWZhdWx0OgogICAgICBhc3NlcnQgKHdhaXRwaWQg
KHBpZCwgJnJlcywgMCkgIT0gLTEpOwogICAgfQoKICByZXR1cm4gTlVMTDsK
fQoKaW50IG1haW4gKHZvaWQpCnsKICB2b2lkICogcmVzdWx0OwogIHB0aHJl
YWRfdCB0OwoKICBhc3NlcnQgKHB0aHJlYWRfY3JlYXRlICgmdCwgTlVMTCwg
VGhyZWFkLCBOVUxMKSA9PSAwKTsKICBzbGVlcCAoNSk7CiAgYXNzZXJ0IChw
dGhyZWFkX2NhbmNlbCAodCkgPT0gMCk7CiAgYXNzZXJ0IChwdGhyZWFkX2pv
aW4gKHQsICZyZXN1bHQpID09IDApOwogIGFzc2VydCAocmVzdWx0ID09IFBU
SFJFQURfQ0FOQ0VMRUQpOwoKICByZXR1cm4gMDsKfQo=

--806685-23053-1042461803=:237
Content-Type: TEXT/plain; name="wait-cancel.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.WNT.4.44.0301131343231.237@algeria.intern.net>
Content-Description: 
Content-Disposition: attachment; filename="wait-cancel.patch"
Content-length: 1761

ZGlmZiAtdXJwIHNyYy5vbGQvd2luc3VwL2N5Z3dpbi90aHJlYWQuY2Mgc3Jj
L3dpbnN1cC9jeWd3aW4vdGhyZWFkLmNjCi0tLSBzcmMub2xkL3dpbnN1cC9j
eWd3aW4vdGhyZWFkLmNjCTIwMDMtMDEtMTAgMDk6NDI6MzcuMDAwMDAwMDAw
ICswMTAwCisrKyBzcmMvd2luc3VwL2N5Z3dpbi90aHJlYWQuY2MJMjAwMy0w
MS0xMyAxMTo1MDozMC4wMDAwMDAwMDAgKzAxMDAKQEAgLTQ4MSwxMCArNDgx
LDEwIEBAIHNpZ3dhaXRpbmZvICgpCiBzeXN0ZW0gKCkKIHRjZHJhaW4gKCkK
ICp1c2xlZXAgKCkKLXdhaXQgKCkKLXdhaXQzKCkKKyp3YWl0ICgpCisqd2Fp
dDMoKQogd2FpdGlkICgpCi13YWl0cGlkICgpCisqd2FpdHBpZCAoKQogd3Jp
dGUgKCkKIHdyaXRldiAoKQogCmRpZmYgLXVycCBzcmMub2xkL3dpbnN1cC9j
eWd3aW4vd2FpdC5jYyBzcmMvd2luc3VwL2N5Z3dpbi93YWl0LmNjCi0tLSBz
cmMub2xkL3dpbnN1cC9jeWd3aW4vd2FpdC5jYwkyMDAyLTExLTI3IDE4OjIy
OjQ2LjAwMDAwMDAwMCArMDEwMAorKysgc3JjL3dpbnN1cC9jeWd3aW4vd2Fp
dC5jYwkyMDAzLTAxLTEzIDExOjU3OjQ2LjAwMDAwMDAwMCArMDEwMApAQCAt
MTUsNiArMTUsNyBAQCBkZXRhaWxzLiAqLwogI2luY2x1ZGUgImN5Z2Vycm5v
LmgiCiAjaW5jbHVkZSAic2lncHJvYy5oIgogI2luY2x1ZGUgInBlcnRocmVh
ZC5oIgorI2luY2x1ZGUgInRocmVhZC5oIgogCiAvKiBUaGlzIGlzIGNhbGxl
ZCBfd2FpdCBhbmQgbm90IHdhaXQgYmVjYXVzZSB0aGUgcmVhbCB3YWl0IGlz
IGRlZmluZWQKICAgIGluIGxpYmMvc3lzY2FsbHMvc3lzd2FpdC5jLiAgSXQg
Y2FsbHMgdXMuICAqLwpAQCAtNTEsNiArNTIsOCBAQCB3YWl0NCAoaW50IGlu
dHBpZCwgaW50ICpzdGF0dXMsIGludCBvcHRpCiAgIEhBTkRMRSB3YWl0Zm9y
OwogICBib29sIHNhd3NpZzsKIAorICBwdGhyZWFkX3Rlc3RjYW5jZWwgKCk7
CisKICAgd2hpbGUgKDEpCiAgICAgewogICAgICAgc2lnX2Rpc3BhdGNoX3Bl
bmRpbmcgKDApOwpAQCAtODQsNyArODcsNyBAQCB3YWl0NCAoaW50IGludHBp
ZCwgaW50ICpzdGF0dXMsIGludCBvcHRpCiAgICAgICBpZiAoKHdhaXRmb3Ig
PSB3LT5ldikgPT0gTlVMTCkKIAlnb3RvIG5vY2hpbGRyZW47CiAKLSAgICAg
IHJlcyA9IFdhaXRGb3JTaW5nbGVPYmplY3QgKHdhaXRmb3IsIElORklOSVRF
KTsKKyAgICAgIHJlcyA9IHB0aHJlYWQ6OmNhbmNlbGFibGVfd2FpdCAod2Fp
dGZvciwgSU5GSU5JVEUpOwogCiAgICAgICBzaWdwcm9jX3ByaW50ZiAoIiVk
ID0gV2FpdEZvclNpbmdsZU9iamVjdCAoLi4uKSIsIHJlcyk7CiAK

--806685-23053-1042461803=:237--
