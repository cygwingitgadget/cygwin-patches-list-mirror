Return-Path: <cygwin-patches-return-4348-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27786 invoked by alias); 10 Nov 2003 11:23:43 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27776 invoked from network); 10 Nov 2003 11:23:42 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Date: Mon, 10 Nov 2003 11:23:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
To: cygwin-patches@cygwin.com
Subject: [PATCH] stdio initialization
Message-ID: <Pine.WNT.4.44.0311101211450.1520-200000@algeria.intern.net>
X-X-Sender: pfaff@antarctica.intern.net
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="717558-15327-1068463415=:1520"
X-SW-Source: 2003-q4/txt/msg00067.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--717558-15327-1068463415=:1520
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-length: 418

Attached patch fixes the memory leak reported by Arash Partow by
initializing stdio during startup and setting __sdidinit from thread
local clib appropriately.

Thomas

2003-11-10  Thomas Pfaff  <tpfaff@gmx.net>

	* dcrt0.cc: Add prototype for __sinit.
	(dll_crt0_1): Initialize stdio.
	* thread.cc (pthread::exit): Cleanup on thread exit.
	(__reent_t::init_clib): Set thread local clib __sdidinit var
	appropriately.

--717558-15327-1068463415=:1520
Content-Type: TEXT/plain; name="sinit.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.WNT.4.44.0311101223350.1520@algeria.intern.net>
Content-Description: 
Content-Disposition: attachment; filename="sinit.patch"
Content-length: 1639

ZGlmZiAtdXJwIHNyYy5vcmcvZGNydDAuY2Mgc3JjL2RjcnQwLmNjCi0tLSBz
cmMub3JnL2RjcnQwLmNjCTIwMDMtMTEtMTAgMTI6MTA6MDcuMjc5MTUwNDAw
ICswMTAwCisrKyBzcmMvZGNydDAuY2MJMjAwMy0xMS0xMCAxMjoxMDo1Ny42
NDE1NjgwMDAgKzAxMDAKQEAgLTc2LDYgKzc2LDEwIEBAIHVuc2lnbmVkIE5P
X0NPUFkgX2N5Z3dpbl90ZXN0aW5nX21hZ2ljOwogCiBjaGFyIE5PX0NPUFkg
YWxtb3N0X251bGxbMV07CiAKKworZXh0ZXJuICJDIiB2b2lkIF9fc2luaXQg
KHN0cnVjdCBfcmVlbnQgKnMpOworCisKIGV4dGVybiAiQyIKIHsKICAgLyog
VGhpcyBpcyBhbiBleHBvcnRlZCBjb3B5IG9mIGVudmlyb24gd2hpY2ggY2Fu
IGJlIHVzZWQgYnkgRExMcwpAQCAtNjQwLDYgKzY0NCw5IEBAIGRsbF9jcnQw
XzEgKCkKICAgICAgIHB0aHJlYWQ6OmluaXRfbWFpbnRocmVhZCAoKTsKICAg
ICB9CiAKKyAgLyogSW5pdGlhbGl6ZSBzdGRpbyAqLworICBfX3Npbml0IChf
aW1wdXJlX3B0cik7CisKICNpZmRlZiBERUJVR0dJTkcKICAgc3RyYWNlLm1p
Y3Jvc2Vjb25kcyAoKTsKICNlbmRpZgpkaWZmIC11cnAgc3JjLm9yZy90aHJl
YWQuY2Mgc3JjL3RocmVhZC5jYwotLS0gc3JjLm9yZy90aHJlYWQuY2MJMjAw
My0xMS0xMCAxMjowOTo1MS4zNzYyODMyMDAgKzAxMDAKKysrIHNyYy90aHJl
YWQuY2MJMjAwMy0xMS0xMCAxMjoxMDo1Ny43NzE3NTUyMDAgKzAxMDAKQEAg
LTM3Nyw2ICszNzcsOSBAQCBwdGhyZWFkOjpleGl0ICh2b2lkICp2YWx1ZV9w
dHIpCiAgICAgICBtdXRleC51bmxvY2sgKCk7CiAgICAgfQogCisgIGlmIChf
UkVFTlQtPl9fY2xlYW51cCkKKyAgICAoKl9SRUVOVC0+X19jbGVhbnVwKSAo
X1JFRU5UKTsKKwogICBpZiAoSW50ZXJsb2NrZWREZWNyZW1lbnQgKCZNVF9J
TlRFUkZBQ0UtPnRocmVhZGNvdW50KSA9PSAwKQogICAgIDo6ZXhpdCAoMCk7
CiAgIGVsc2UKQEAgLTE4NzgsNiArMTg4MSw3IEBAIF9fcmVlbnRfdDo6aW5p
dF9jbGliIChzdHJ1Y3QgX3JlZW50JiB2YXIKICAgdmFyLl9zdGRpbiA9IF9H
TE9CQUxfUkVFTlQtPl9zdGRpbjsKICAgdmFyLl9zdGRvdXQgPSBfR0xPQkFM
X1JFRU5ULT5fc3Rkb3V0OwogICB2YXIuX3N0ZGVyciA9IF9HTE9CQUxfUkVF
TlQtPl9zdGRlcnI7CisgIHZhci5fX3NkaWRpbml0ID0gX0dMT0JBTF9SRUVO
VC0+X19zZGlkaW5pdDsKICAgX2NsaWIgPSAmdmFyOwogfTsKIAo=

--717558-15327-1068463415=:1520--
