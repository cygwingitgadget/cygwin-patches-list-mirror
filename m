Return-Path: <cygwin-patches-return-2604-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 28900 invoked by alias); 5 Jul 2002 08:38:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28886 invoked from network); 5 Jul 2002 08:38:48 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Date: Fri, 05 Jul 2002 01:38:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Modified pthread types
Message-ID: <Pine.WNT.4.44.0207051023340.304-200000@algeria.intern.net>
X-X-Sender: pfaff@antarctica.intern.net
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1391277-17919-1025858313=:304"
X-SW-Source: 2002-q3/txt/msg00052.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1391277-17919-1025858313=:304
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-length: 685


I have attached a patch with modified (dummy) pthread typedefs.

This should give the compiler a chance to do some type validations,
for example:

pthread_t t;
pthread_create(t,...) //wrong
pthread_create(&t,...) // right

pthread_cancel(t) //right
pthread_cancel(&t)//wrong

With the actual typedefs as void * the compiler will treat all versions
valid.

Thomas

Changelog

2002-07-05  Thomas Pfaff  <tpfaff@gmx.net>

	* include/semaphore.h: Modified typedef for sem_t.
	* include/cygwin/types.h: Modified typedefs for pthread_t,
	pthread_mutex_t, pthread_key_t, pthread_attr_t,
	pthread_mutexattr_t, pthread_condattr_t, pthread_cond_t,
	pthread_rwlock_t and pthread_rwlockattr_t.



--1391277-17919-1025858313=:304
Content-Type: TEXT/plain; name="pthread_types.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.WNT.4.44.0207051038330.304@algeria.intern.net>
Content-Description: 
Content-Disposition: attachment; filename="pthread_types.patch"
Content-length: 2843

ZGlmZiAtdXJwIHNyYy5vbGQvd2luc3VwL2N5Z3dpbi9pbmNsdWRlL2N5Z3dp
bi90eXBlcy5oIHNyYy93aW5zdXAvY3lnd2luL2luY2x1ZGUvY3lnd2luL3R5
cGVzLmgKLS0tIHNyYy5vbGQvd2luc3VwL2N5Z3dpbi9pbmNsdWRlL2N5Z3dp
bi90eXBlcy5oCVR1ZSBKdW4gMTEgMDQ6NTI6MTggMjAwMgorKysgc3JjL3dp
bnN1cC9jeWd3aW4vaW5jbHVkZS9jeWd3aW4vdHlwZXMuaAlGcmkgSnVsICA1
IDEwOjAyOjMxIDIwMDIKQEAgLTYxLDE0ICs2MSwyMSBAQCB0eXBlZGVmIF9f
Z2lkMTZfdCBnaWRfdDsKIAogI2lmICFkZWZpbmVkKF9fSU5TSURFX0NZR1dJ
Tl9fKSB8fCAhZGVmaW5lZChfX2NwbHVzcGx1cykKIAotdHlwZWRlZiB2b2lk
ICpwdGhyZWFkX3Q7Ci10eXBlZGVmIHZvaWQgKnB0aHJlYWRfbXV0ZXhfdDsK
K3R5cGVkZWYgc3RydWN0IHtjaGFyIF9fZHVtbXk7fSBfX3B0aHJlYWRfdDsK
K3R5cGVkZWYgX19wdGhyZWFkX3QgKnB0aHJlYWRfdDsKK3R5cGVkZWYgc3Ry
dWN0IHtjaGFyIF9fZHVtbXk7fSBfX3B0aHJlYWRfbXV0ZXhfdDsKK3R5cGVk
ZWYgX19wdGhyZWFkX211dGV4X3QgKnB0aHJlYWRfbXV0ZXhfdDsKIAotdHlw
ZWRlZiB2b2lkICpwdGhyZWFkX2tleV90OwotdHlwZWRlZiB2b2lkICpwdGhy
ZWFkX2F0dHJfdDsKLXR5cGVkZWYgdm9pZCAqcHRocmVhZF9tdXRleGF0dHJf
dDsKLXR5cGVkZWYgdm9pZCAqcHRocmVhZF9jb25kYXR0cl90OwotdHlwZWRl
ZiB2b2lkICpwdGhyZWFkX2NvbmRfdDsKK3R5cGVkZWYgc3RydWN0IHtjaGFy
IF9fZHVtbXk7fSBfX3B0aHJlYWRfa2V5X3Q7Cit0eXBlZGVmIF9fcHRocmVh
ZF9rZXlfdCAqcHRocmVhZF9rZXlfdDsKK3R5cGVkZWYgc3RydWN0IHtjaGFy
IF9fZHVtbXk7fSBfX3B0aHJlYWRfYXR0cl90OwordHlwZWRlZiBfX3B0aHJl
YWRfYXR0cl90ICpwdGhyZWFkX2F0dHJfdDsKK3R5cGVkZWYgc3RydWN0IHtj
aGFyIF9fZHVtbXk7fSBfX3B0aHJlYWRfbXV0ZXhhdHRyX3Q7Cit0eXBlZGVm
IF9fcHRocmVhZF9tdXRleGF0dHJfdCAqcHRocmVhZF9tdXRleGF0dHJfdDsK
K3R5cGVkZWYgc3RydWN0IHtjaGFyIF9fZHVtbXk7fSBfX3B0aHJlYWRfY29u
ZGF0dHJfdDsKK3R5cGVkZWYgX19wdGhyZWFkX2NvbmRhdHRyX3QgKnB0aHJl
YWRfY29uZGF0dHJfdDsKK3R5cGVkZWYgc3RydWN0IHtjaGFyIF9fZHVtbXk7
fSBfX3B0aHJlYWRfY29uZF90OwordHlwZWRlZiBfX3B0aHJlYWRfY29uZF90
ICpwdGhyZWFkX2NvbmRfdDsKIAogICAvKiBUaGVzZSB2YXJpYWJsZXMgYXJl
IG5vdCB1c2VyIGFsdGVyYWJsZS4gVGhpcyBtZWFucyB5b3UhLiAqLwogdHlw
ZWRlZiBzdHJ1Y3QKQEAgLTc3LDggKzg0LDEwIEBAIHR5cGVkZWYgc3RydWN0
CiAgIGludCBzdGF0ZTsKIH0KIHB0aHJlYWRfb25jZV90OwotdHlwZWRlZiB2
b2lkICpwdGhyZWFkX3J3bG9ja190OwotdHlwZWRlZiB2b2lkICpwdGhyZWFk
X3J3bG9ja2F0dHJfdDsKK3R5cGVkZWYgc3RydWN0IHtjaGFyIF9fZHVtbXk7
fSBfX3B0aHJlYWRfcndsb2NrX3Q7Cit0eXBlZGVmIF9fcHRocmVhZF9yd2xv
Y2tfdCAqcHRocmVhZF9yd2xvY2tfdDsKK3R5cGVkZWYgc3RydWN0IHtjaGFy
IF9fZHVtbXk7fSBfX3B0aHJlYWRfcndsb2NrYXR0cl90OwordHlwZWRlZiBf
X3B0aHJlYWRfcndsb2NrYXR0cl90ICpwdGhyZWFkX3J3bG9ja2F0dHJfdDsK
IAogI2Vsc2UKIApkaWZmIC11cnAgc3JjLm9sZC93aW5zdXAvY3lnd2luL2lu
Y2x1ZGUvc2VtYXBob3JlLmggc3JjL3dpbnN1cC9jeWd3aW4vaW5jbHVkZS9z
ZW1hcGhvcmUuaAotLS0gc3JjLm9sZC93aW5zdXAvY3lnd2luL2luY2x1ZGUv
c2VtYXBob3JlLmgJV2VkIE1hciAyMSAxNjowNjoyMiAyMDAxCisrKyBzcmMv
d2luc3VwL2N5Z3dpbi9pbmNsdWRlL3NlbWFwaG9yZS5oCUZyaSBKdWwgIDUg
MTA6MDI6MzIgMjAwMgpAQCAtMjEsNyArMjEsOCBAQCBleHRlcm4gIkMiCiAj
ZW5kaWYKIAogI2lmbmRlZiBfX0lOU0lERV9DWUdXSU5fXwotICB0eXBlZGVm
IHZvaWQgKnNlbV90OworICB0eXBlZGVmIHN0cnVjdCB7Y2hhciBfX2R1bW15
O30gX19zZW1fdDsKKyAgdHlwZWRlZiBfX3NlbV90ICpzZW1fdDsKICNlbmRp
ZgogCiAjZGVmaW5lIFNFTV9GQUlMRUQgMAo=

--1391277-17919-1025858313=:304--
