Return-Path: <cygwin-patches-return-2099-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 13187 invoked by alias); 24 Apr 2002 10:18:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13166 invoked from network); 24 Apr 2002 10:18:49 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Date: Wed, 24 Apr 2002 03:18:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
To: cygwin-patches@cygwin.com
Subject: [PATCH] pthread_join fix
Message-ID: <F0E13277A26BD311944600500454CCD0513601-101000@antarctica.intern.net>
X-X-Sender: pfaff@antarctica.intern.net
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="4617279-5635-1019643282=:289"
Content-ID: <Pine.WNT.4.44.0204241214460.289@algeria.intern.net>
X-SW-Source: 2002-q2/txt/msg00083.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--4617279-5635-1019643282=:289
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-ID: <Pine.WNT.4.44.0204241214461.289@algeria.intern.net>
Content-length: 498

Rob,

this is an incremental update to my pthread patches. It will fix a problem
when a thread is joined before the creation completed.

BTW, i have not added any locks yet (the actual implementation had no),
but IMHO they are required in the exit,join,cancel code. I will add locks
if you agree.

Greetings,
Thomas

2002-04-24  Thomas Pfaff  <tpfaff@gmx.net>

	* thread.cc (thread_init_wrapper): Check if thread is alreay
	joined
	(__pthread_join): Set joiner first.
	(__pthread_detach): Ditto.



--4617279-5635-1019643282=:289
Content-Type: APPLICATION/OCTET-STREAM; name="pthread_join.patch"
Content-Transfer-Encoding: BASE64
Content-ID: Pine.WNT.4.44.0204241214420.289@algeria.intern.net
Content-Description: 
Content-Disposition: attachment; filename="pthread_join.patch"
Content-length: 1643

ZGlmZiAtdXJwIHNyYy5vbGQvd2luc3VwL2N5Z3dpbi90aHJlYWQuY2Mgc3Jj
L3dpbnN1cC9jeWd3aW4vdGhyZWFkLmNjCi0tLSBzcmMub2xkL3dpbnN1cC9j
eWd3aW4vdGhyZWFkLmNjCVdlZCBBcHIgMjQgMTA6MTQ6MTQgMjAwMgorKysg
c3JjL3dpbnN1cC9jeWd3aW4vdGhyZWFkLmNjCVdlZCBBcHIgMjQgMTA6MjQ6
MDEgMjAwMgpAQCAtOTA5LDcgKzkwOSw3IEBAIHRocmVhZF9pbml0X3dyYXBw
ZXIgKHZvaWQgKl9hcmcpCiAgIFRsc1NldFZhbHVlIChNVF9JTlRFUkZBQ0Ut
PnRocmVhZF9zZWxmX2R3VGxzSW5kZXgsIHRocmVhZCk7CiAKICAgLy8gaWYg
dGhyZWFkIGlzIGRldGFjaGVkIGZvcmNlIGNsZWFudXAgb24gZXhpdAotICBp
ZiAodGhyZWFkLT5hdHRyLmpvaW5hYmxlID09IFBUSFJFQURfQ1JFQVRFX0RF
VEFDSEVEKQorICBpZiAodGhyZWFkLT5hdHRyLmpvaW5hYmxlID09IFBUSFJF
QURfQ1JFQVRFX0RFVEFDSEVEICYmIHRocmVhZC0+am9pbmVyID09IE5VTEwp
CiAgICAgdGhyZWFkLT5qb2luZXIgPSBfX3B0aHJlYWRfc2VsZigpOwogCiAj
aWZkZWYgX0NZR19USFJFQURfRkFJTFNBRkUKQEAgLTE1MzUsOCArMTUzNSw4
IEBAIF9fcHRocmVhZF9qb2luIChwdGhyZWFkX3QgKnRocmVhZCwgdm9pZCAK
IAogICBlbHNlCiAgICAgewotICAgICAgKCp0aHJlYWQpLT5hdHRyLmpvaW5h
YmxlID0gUFRIUkVBRF9DUkVBVEVfREVUQUNIRUQ7CiAgICAgICAoKnRocmVh
ZCktPmpvaW5lciA9IGpvaW5lcjsKKyAgICAgICgqdGhyZWFkKS0+YXR0ci5q
b2luYWJsZSA9IFBUSFJFQURfQ1JFQVRFX0RFVEFDSEVEOwogICAgICAgV2Fp
dEZvclNpbmdsZU9iamVjdCAoKCp0aHJlYWQpLT53aW4zMl9vYmpfaWQsIElO
RklOSVRFKTsKICAgICAgIGlmIChyZXR1cm5fdmFsKQogICAgICAgICAgKnJl
dHVybl92YWwgPSAoKnRocmVhZCktPnJldHVybl9wdHI7CkBAIC0xNTYwLDkg
KzE1NjAsOSBAQCBfX3B0aHJlYWRfZGV0YWNoIChwdGhyZWFkX3QgKnRocmVh
ZCkKICAgICAgIHJldHVybiBFSU5WQUw7CiAgICAgfQogCi0gICgqdGhyZWFk
KS0+YXR0ci5qb2luYWJsZSA9IFBUSFJFQURfQ1JFQVRFX0RFVEFDSEVEOwog
ICAvLyBmb3JjZSBjbGVhbnVwIG9uIGV4aXQKICAgKCp0aHJlYWQpLT5qb2lu
ZXIgPSAqdGhyZWFkOworICAoKnRocmVhZCktPmF0dHIuam9pbmFibGUgPSBQ
VEhSRUFEX0NSRUFURV9ERVRBQ0hFRDsKIAogICByZXR1cm4gMDsKIH0K

--4617279-5635-1019643282=:289--
