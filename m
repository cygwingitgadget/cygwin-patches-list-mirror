Return-Path: <cygwin-patches-return-4505-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18139 invoked by alias); 15 Dec 2003 13:03:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18130 invoked from network); 15 Dec 2003 13:03:40 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Date: Mon, 15 Dec 2003 13:03:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
To: cygwin-patches@cygwin.com
Subject: [PATCH]: Error checking in init_main_thread
Message-ID: <Pine.WNT.4.44.0312151357380.1836-200000@algeria.intern.net>
X-X-Sender: pfaff@antarctica.intern.net
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="353808-14054-1071493402=:1836"
X-SW-Source: 2003-q4/txt/msg00224.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--353808-14054-1071493402=:1836
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-length: 332

Chris,

while the cancel event creation looks good now i would make sure that
the process is created only when the handles are valid.

Thomas

2003-15-15  Thomas Pfaff  <tpfaff@gmx.net>

	* thread.cc (pthread::init_main_thread): Make sure that the
	main thread has valid handles.
	(pthread::create_cancel_event): Fix error message.

--353808-14054-1071493402=:1836
Content-Type: TEXT/plain; name="initmainthread.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.WNT.4.44.0312151403220.1836@algeria.intern.net>
Content-Description: 
Content-Disposition: attachment; filename="initmainthread.patch"
Content-length: 1408

ZGlmZiAtdXJwIHNyYy5vbGQvdGhyZWFkLmNjIHNyYy90aHJlYWQuY2MKLS0t
IHNyYy5vbGQvdGhyZWFkLmNjCTIwMDMtMTItMTUgMDk6MDM6NDQuOTM0Mzc5
MjAwICswMTAwCisrKyBzcmMvdGhyZWFkLmNjCTIwMDMtMTItMTUgMTM6MTU6
NTAuODI2OTk1MjAwICswMTAwCkBAIC0yMzEsOSArMjMxLDEwIEBAIHB0aHJl
YWQ6OmluaXRfbWFpbnRocmVhZCAoKQogICBpZiAoIUR1cGxpY2F0ZUhhbmRs
ZSAoR2V0Q3VycmVudFByb2Nlc3MgKCksIEdldEN1cnJlbnRUaHJlYWQgKCks
CiAJCQlHZXRDdXJyZW50UHJvY2VzcyAoKSwgJnRocmVhZC0+d2luMzJfb2Jq
X2lkLAogCQkJMCwgRkFMU0UsIERVUExJQ0FURV9TQU1FX0FDQ0VTUykpCi0g
ICAgdGhyZWFkLT53aW4zMl9vYmpfaWQgPSBOVUxMOworICAgIGFwaV9mYXRh
bCAoImZhaWxlZCB0byBjcmVhdGUgbWFpbnRocmVhZCBoYW5kbGUiKTsKICAg
dGhyZWFkLT5zZXRfdGxzX3NlbGZfcG9pbnRlciAoKTsKLSAgKHZvaWQpIHRo
cmVhZC0+Y3JlYXRlX2NhbmNlbF9ldmVudCAoKTsKKyAgaWYgKCF0aHJlYWQt
PmNyZWF0ZV9jYW5jZWxfZXZlbnQgKCkpCisgICAgYXBpX2ZhdGFsICgiY291
bGRuJ3QgY3JlYXRlIGNhbmNlbCBldmVudCBmb3IgbWFpbiB0aHJlYWQiKTsK
ICAgdGhyZWFkLT5wb3N0Y3JlYXRlICgpOwogfQogCkBAIC0yODksNyArMjkw
LDcgQEAgcHRocmVhZDo6Y3JlYXRlX2NhbmNlbF9ldmVudCAoKQogICBjYW5j
ZWxfZXZlbnQgPSA6OkNyZWF0ZUV2ZW50ICgmc2VjX25vbmVfbmloLCBUUlVF
LCBGQUxTRSwgTlVMTCk7CiAgIGlmICghY2FuY2VsX2V2ZW50KQogICAgIHsK
LSAgICAgIHN5c3RlbV9wcmludGYgKCJjb3VsZG4ndCBjcmVhdGUgY2FuY2Vs
IGV2ZW50IGZvciBtYWluIHRocmVhZCwgJUUiKTsKKyAgICAgIHN5c3RlbV9w
cmludGYgKCJjb3VsZG4ndCBjcmVhdGUgY2FuY2VsIGV2ZW50IGZvciB0aHJl
YWQsICVFIik7CiAgICAgICAvKiB3ZSBuZWVkIHRoZSBldmVudCBmb3IgY29y
cmVjdCBiZWhhdmlvdXIgKi8KICAgICAgIHJldHVybiBmYWxzZTsKICAgICB9
Cg==

--353808-14054-1071493402=:1836--
