Return-Path: <cygwin-patches-return-2556-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 7369 invoked by alias); 1 Jul 2002 11:12:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7283 invoked from network); 1 Jul 2002 11:12:47 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Date: Mon, 01 Jul 2002 04:12:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
To: cygwin-patches@cygwin.com
Subject: [PATCH] interruptable accept
Message-ID: <Pine.WNT.4.44.0207011223180.359-200000@algeria.intern.net>
X-X-Sender: pfaff@antarctica.intern.net
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1256998-28050-1025520247=:359"
Content-ID: <Pine.WNT.4.44.0207011248380.363@algeria.intern.net>
X-SW-Source: 2002-q3/txt/msg00004.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1256998-28050-1025520247=:359
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.WNT.4.44.0207011248381.363@algeria.intern.net>
Content-length: 657


This patch is not 100% perfect and could be done better (faster response
on incoming signal) with async Events but this would require a much larger
patch (Call AsyncEventSelect, WaitForMultipleObjects (socket and signal),
check for pending connection and set socket back to blocking mode).
Therefore i decided to use select and check for signal every 100ms. IMHO a
max of 100 ms delay for a pending signal is acceptable here and is at
least better than the current implementation.

Thomas

Changelog

2002-07-01  Thomas Pfaff  <tpfaff@gmx.net>

	*net.cc: Include select.h
	(cygwin_accept): If socket is nonblocking check for a pending
	signal every 100ms.

--1256998-28050-1025520247=:359
Content-Type: TEXT/PLAIN; NAME="accept_intr.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.WNT.4.44.0207011249010.363@algeria.intern.net>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="accept_intr.patch"
Content-length: 2745

ZGlmZiAtdXJwIHNyYy5vbGQvd2luc3VwL2N5Z3dpbi9uZXQuY2Mgc3JjL3dp
bnN1cC9jeWd3aW4vbmV0LmNjCi0tLSBzcmMub2xkL3dpbnN1cC9jeWd3aW4v
bmV0LmNjCVR1ZSBKdW4gMTEgMDQ6NTI6MDcgMjAwMgorKysgc3JjL3dpbnN1
cC9jeWd3aW4vbmV0LmNjCU1vbiBKdWwgIDEgMTI6NDc6MzEgMjAwMgpAQCAt
MjMsNiArMjMsNyBAQCBkZXRhaWxzLiAqLwogI2luY2x1ZGUgPG5ldGRiLmg+
CiAjZGVmaW5lIFVTRV9TWVNfVFlQRVNfRkRfU0VUCiAjaW5jbHVkZSA8d2lu
c29jazIuaD4KKyNpbmNsdWRlICJzZWxlY3QuaCIKICNpbmNsdWRlICJjeWdl
cnJuby5oIgogI2luY2x1ZGUgInNlY3VyaXR5LmgiCiAjaW5jbHVkZSAiZmhh
bmRsZXIuaCIKQEAgLTEyMDMsNiArMTIwNCw0NCBAQCBjeWd3aW5fYWNjZXB0
IChpbnQgZmQsIHN0cnVjdCBzb2NrYWRkciAqCiAgICAgICAgKi8KICAgICAg
IGlmIChsZW4gJiYgKCh1bnNpZ25lZCkgKmxlbiA8IHNpemVvZiAoc3RydWN0
IHNvY2thZGRyX2luKSkpCiAJKmxlbiA9IHNpemVvZiAoc3RydWN0IHNvY2th
ZGRyX2luKTsKKworICAgICAgaWYgKCFzb2NrLT5pc19ub25ibG9ja2luZygp
KQorICAgICAgICB7CisgICAgICAgICAgZm9yICg7OykKKyAgICAgICAgICAg
IHsKKyAgICAgICAgICAgICAgc3RydWN0IHRpbWV2YWwgdGltZW91dDsKKyAg
ICAgICAgICAgICAgd2luc29ja19mZF9zZXQgcmVhZF9mZF9zZXQ7CisKKyAg
ICAgICAgICAgICAgLy8gY2hlY2sgZm9yIHNpZ25hbCBldmVyeSAxMDAgbXMK
KyAgICAgICAgICAgICAgdGltZW91dC50dl9zZWMgPSAwOworICAgICAgICAg
ICAgICB0aW1lb3V0LnR2X3VzZWMgPSAxMDAgKiAxMDAwOworCisgICAgICAg
ICAgICAgIFdJTlNPQ0tfRkRfWkVSTyAoJnJlYWRfZmRfc2V0KTsKKyAgICAg
ICAgICAgICAgV0lOU09DS19GRF9TRVQgKChIQU5ETEUpc29jay0+Z2V0X3Nv
Y2tldCAoKSwgJnJlYWRfZmRfc2V0KTsKKyAgICAgICAgICAgICAgCisgICAg
ICAgICAgICAgIHJlcyA9IFdJTlNPQ0tfU0VMRUNUICgwLCAmcmVhZF9mZF9z
ZXQsIE5VTEwsIE5VTEwsICZ0aW1lb3V0KTsKKyAgICAgICAgICAgICAgaWYo
IHJlcyA9PSBTT0NLRVRfRVJST1IgKQorICAgICAgICAgICAgICAgIHsKKyAg
ICAgICAgICAgICAgICAgIC8vIEVycm9yIG9jY3VyZWQ6IHN0b3Agc2VsZWN0
IGxvb3AKKyAgICAgICAgICAgICAgICAgIGRlYnVnX3ByaW50ZiAoIldpblNv
Y2sgc2VsZWN0IGZhaWxlZCIpOworICAgICAgICAgICAgICAgICAgYnJlYWs7
CisgICAgICAgICAgICAgICAgfQorICAgICAgICAgICAgICBlbHNlIGlmIChy
ZXMgPT0gMCkKKyAgICAgICAgICAgICAgICB7CisgICAgICAgICAgICAgICAg
ICAvLyBUaW1lb3V0OiBjaGVjayBmb3IgcGVuZGluZyBzaWduYWwKKyAgICAg
ICAgICAgICAgICAgIGlmIChXYWl0Rm9yU2luZ2xlT2JqZWN0IChzaWduYWxf
YXJyaXZlZCwgMCkgPT0gV0FJVF9PQkpFQ1RfMCkKKyAgICAgICAgICAgICAg
ICAgICAgeworICAgICAgICAgICAgICAgICAgICAgIGRlYnVnX3ByaW50ZiAo
InNpZ25hbCByZWNlaXZlZCBkdXJpbmcgYWNjZXB0Iik7CisgICAgICAgICAg
ICAgICAgICAgICAgc2V0X2Vycm5vIChFSU5UUik7CisgICAgICAgICAgICAg
ICAgICAgICAgcmVzID0gLTE7CisgICAgICAgICAgICAgICAgICAgICAgZ290
byBkb25lOworICAgICAgICAgICAgICAgICAgICB9ICAgICAgICAgICAgICAg
ICAgCisgICAgICAgICAgICAgICAgfQorICAgICAgICAgICAgICBlbHNlIGlm
IChXSU5TT0NLX0ZEX0lTU0VUICgoSEFORExFKXNvY2stPmdldF9zb2NrZXQg
KCksICZyZWFkX2ZkX3NldCkpCisgICAgICAgICAgICAgICAgLy8gY29ubmVj
dCBpcyBwZW5kaW5nCisgICAgICAgICAgICAgICAgYnJlYWs7CisgICAgICAg
ICAgICB9ICAgICAgICAgICAgICAKKyAgICAgICAgfQogCiAgICAgICByZXMg
PSBhY2NlcHQgKHNvY2stPmdldF9zb2NrZXQgKCksIHBlZXIsIGxlbik7ICAv
LyBjYW4ndCB1c2UgYSBibG9ja2luZyBjYWxsIGluc2lkZSBhIGxvY2sKIAo=

--1256998-28050-1025520247=:359--
