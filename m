Return-Path: <cygwin-patches-return-2787-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 5544 invoked by alias); 7 Aug 2002 15:19:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5530 invoked from network); 7 Aug 2002 15:19:18 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Date: Wed, 07 Aug 2002 08:19:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
To: cygwin-patches@cygwin.com
Subject: [PATCH] check for valid pthread_self pointer
Message-ID: <Pine.WNT.4.44.0208071245020.353-200000@algeria.intern.net>
X-X-Sender: pfaff@antarctica.intern.net
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="817350-17277-1028717909=:353"
Content-ID: <Pine.WNT.4.44.0208071258560.353@algeria.intern.net>
X-SW-Source: 2002-q3/txt/msg00235.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--817350-17277-1028717909=:353
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.WNT.4.44.0208071258561.353@algeria.intern.net>
Content-length: 741


This patch should fix the problem with the ipc-daemon started as service
and threads that are not created by pthread_create.
Actually it will only check for a valid thread_self pointer in different
functions to avoid a SEGV.
The pthread functions therefore can not be used within a service main
thread or a thread started by CreateThread (but you can of course
start new threads with pthread_create that can make use of it).

Thomas

Changelog

2002-08-07  Thomas Pfaff  <tpfaff@gmx.net>

	* pthread.cc: Include errno.h.
	(pthread_exit): Check for a valid pthread_self pointer.
	(pthread_setcancelstate): Ditto.
	(pthread_setcanceltype): Ditto.
	(pthread_testcancel): Ditto.
	(_pthread_cleanup_push): Ditto.
	(_pthread_cleanup_pop): Ditto.

--817350-17277-1028717909=:353
Content-Type: TEXT/PLAIN; NAME="pthread_self.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.WNT.4.44.0208071258290.353@algeria.intern.net>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="pthread_self.patch"
Content-length: 2229

ZGlmZiAtdXJwIHNyYy5vbGQvd2luc3VwL2N5Z3dpbi9wdGhyZWFkLmNjIHNy
Yy93aW5zdXAvY3lnd2luL3B0aHJlYWQuY2MKLS0tIHNyYy5vbGQvd2luc3Vw
L2N5Z3dpbi9wdGhyZWFkLmNjCUZyaSBKdWwgIDUgMjE6MTQ6MDIgMjAwMgor
Kysgc3JjL3dpbnN1cC9jeWd3aW4vcHRocmVhZC5jYwlXZWQgQXVnICA3IDEy
OjM4OjQ3IDIwMDIKQEAgLTEyLDYgKzEyLDcgQEAKIAogI2luY2x1ZGUgIndp
bnN1cC5oIgogI2luY2x1ZGUgInRocmVhZC5oIgorI2luY2x1ZGUgPGVycm5v
Lmg+CiAKIGV4dGVybiAiQyIKIHsKQEAgLTE0MCw3ICsxNDEsOSBAQCBwdGhy
ZWFkX2F0dHJfZ2V0c3RhY2thZGRyIChjb25zdCBwdGhyZWFkCiB2b2lkCiBw
dGhyZWFkX2V4aXQgKHZvaWQgKnZhbHVlX3B0cikKIHsKLSAgcmV0dXJuIHB0
aHJlYWQ6OnNlbGYoKS0+ZXhpdCAodmFsdWVfcHRyKTsKKyAgcHRocmVhZCAq
dGhyZWFkID0gcHRocmVhZDo6c2VsZigpOworICBpZiAodGhyZWFkKQorICAg
IHRocmVhZC0+ZXhpdCAodmFsdWVfcHRyKTsKIH0KIAogaW50CkBAIC00Mjgs
MzEgKzQzMSwzOSBAQCBwdGhyZWFkX2NhbmNlbCAocHRocmVhZF90IHRocmVh
ZCkKIGludAogcHRocmVhZF9zZXRjYW5jZWxzdGF0ZSAoaW50IHN0YXRlLCBp
bnQgKm9sZHN0YXRlKQogewotICByZXR1cm4gcHRocmVhZDo6c2VsZigpLT5z
ZXRjYW5jZWxzdGF0ZSAoc3RhdGUsIG9sZHN0YXRlKTsKKyAgcHRocmVhZCAq
dGhyZWFkID0gcHRocmVhZDo6c2VsZigpOworICByZXR1cm4gdGhyZWFkID8g
dGhyZWFkLT5zZXRjYW5jZWxzdGF0ZSAoc3RhdGUsIG9sZHN0YXRlKSA6IEVJ
TlZBTDsKIH0KIAogaW50CiBwdGhyZWFkX3NldGNhbmNlbHR5cGUgKGludCB0
eXBlLCBpbnQgKm9sZHR5cGUpCiB7Ci0gIHJldHVybiBwdGhyZWFkOjpzZWxm
KCktPnNldGNhbmNlbHR5cGUgKHR5cGUsIG9sZHR5cGUpOworICBwdGhyZWFk
ICp0aHJlYWQgPSBwdGhyZWFkOjpzZWxmKCk7CisgIHJldHVybiB0aHJlYWQg
PyB0aHJlYWQtPnNldGNhbmNlbHR5cGUgKHR5cGUsIG9sZHR5cGUpIDogRUlO
VkFMOwogfQogCiB2b2lkCiBwdGhyZWFkX3Rlc3RjYW5jZWwgKHZvaWQpCiB7
Ci0gIHB0aHJlYWQ6OnNlbGYoKS0+dGVzdGNhbmNlbCAoKTsKKyAgcHRocmVh
ZCAqdGhyZWFkID0gcHRocmVhZDo6c2VsZigpOworICBpZiAodGhyZWFkKQor
ICAgIHRocmVhZC0+dGVzdGNhbmNlbCAoKTsKIH0KIAogdm9pZAogX3B0aHJl
YWRfY2xlYW51cF9wdXNoIChfX3B0aHJlYWRfY2xlYW51cF9oYW5kbGVyICpo
YW5kbGVyKQogewotICBwdGhyZWFkOjpzZWxmKCktPnB1c2hfY2xlYW51cF9o
YW5kbGVyIChoYW5kbGVyKTsKKyAgcHRocmVhZCAqdGhyZWFkID0gcHRocmVh
ZDo6c2VsZigpOworICBpZiAodGhyZWFkKQorICAgIHRocmVhZC0+cHVzaF9j
bGVhbnVwX2hhbmRsZXIgKGhhbmRsZXIpOwogfQogCiB2b2lkCiBfcHRocmVh
ZF9jbGVhbnVwX3BvcCAoaW50IGV4ZWN1dGUpCiB7Ci0gIHB0aHJlYWQ6OnNl
bGYoKS0+cG9wX2NsZWFudXBfaGFuZGxlciAoZXhlY3V0ZSk7CisgIHB0aHJl
YWQgKnRocmVhZCA9IHB0aHJlYWQ6OnNlbGYoKTsKKyAgaWYgKHRocmVhZCkK
KyAgICB0aHJlYWQtPnBvcF9jbGVhbnVwX2hhbmRsZXIgKGV4ZWN1dGUpOwog
fQogCiAvKiBTZW1hcGhvcmVzICovCg==

--817350-17277-1028717909=:353--
