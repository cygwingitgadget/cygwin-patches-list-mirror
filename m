Return-Path: <cygwin-patches-return-2617-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 31185 invoked by alias); 8 Jul 2002 08:13:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31106 invoked from network); 8 Jul 2002 08:13:40 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Date: Mon, 08 Jul 2002 01:13:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Modified pthread types; From: cygwin-patches@cygwin.com
In-Reply-To: <000601c225b0$a68ceac0$0100a8c0@lony>
Message-ID: <Pine.WNT.4.44.0207080956570.118-200000@algeria.intern.net>
X-X-Sender: pfaff@antarctica.intern.net
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="2646463-11378-1026115325=:118"
Content-ID: <Pine.WNT.4.44.0207081002190.118@algeria.intern.net>
X-SW-Source: 2002-q3/txt/msg00065.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--2646463-11378-1026115325=:118
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.WNT.4.44.0207081002191.118@algeria.intern.net>
Content-length: 2498


I have attached a new patch with your changes but with one exception:
PTHREAD_COND_INITIALIZER should be (pthread_cond_t)21

If you see memory leaks should depend on your gcc version. gcc 3.x will
use another exception handling code that does not use pthread keys to
store the exception handling context.

Thomas

Changelog:

2002-07-08  Thomas Pfaff  <tpfaff@gmx.net>

	* include/semaphore.h: Modified typedef for sem_t.
	* include/cygwin/types.h: Modified typedefs for pthread_t,
	pthread_mutex_t, pthread_key_t, pthread_attr_t,
	pthread_mutexattr_t, pthread_condattr_t, pthread_cond_t,
	pthread_rwlock_t and pthread_rwlockattr_t.
	* include/pthread.h: Modified PTHREAD_COND_INITIALIZER and
	PTHREAD_MUTEX_INITIALIZER


On Sun, 7 Jul 2002, Christoph wrote:

> > From: Thomas Pfaff
> > To: cygwin-patches.cygwin.com
>
> http://cygwin.com/ml/cygwin-patches/2002-q3/msg00052.html
>
> >
> > I have attached a patch with modified (dummy) pthread typedefs.
> >
> > This should give the compiler a chance to do some type validations,
> > for example:
> >
> > pthread_t t;
> > pthread_create(t,...) //wrong
> > pthread_create(&t,...) // right
> >
> > pthread_cancel(t) //right
> > pthread_cancel(&t)//wrong
>
>
> Using your patch I needed to tweak /usr/include/pthreads.h
> when compiling libstdc++.  Also I don't think that I saw a
> memory leak when running your test program from the
> cygwin-patch mailing list.
>
> http://cygwin.com/ml/cygwin-patches/2002-q2/msg00214.html
>
> Note I linked the CYGWIN dll to the gcc libraries generated
> by a pthreads + exception enabled compile.
>
>
> /Christoph
>
>
> --- /usr/include/pthread.h.old	2002-07-04 17:01:18.000000000 +0200
> +++ /usr/include/pthread.h	2002-07-05 20:48:12.000000000 +0200
> @@ -44,7 +44,7 @@
>  #define PTHREAD_CANCEL_DISABLE 1
>  #define PTHREAD_CANCELED ((void *)-1)
>  /* this should be a value that can never be a valid address */
> -#define PTHREAD_COND_INITIALIZER (void *)21
> +#define PTHREAD_COND_INITIALIZER (pthread_mutex_t)21
>  #define PTHREAD_CREATE_DETACHED 1
>  /* the default : joinable */
>  #define PTHREAD_CREATE_JOINABLE 0
> @@ -54,7 +54,7 @@
>  #define PTHREAD_MUTEX_ERRORCHECK 1
>  #define PTHREAD_MUTEX_NORMAL 2
>  /* this should be too low to ever be a valid address */
> -#define PTHREAD_MUTEX_INITIALIZER (void *)20
> +#define PTHREAD_MUTEX_INITIALIZER (pthread_mutex_t)20
>  #define PTHREAD_MUTEX_RECURSIVE 0
>  #define PTHREAD_ONCE_INIT { PTHREAD_MUTEX_INITIALIZER, 0 }
>  #define PTHREAD_PRIO_INHERIT
>

--2646463-11378-1026115325=:118
Content-Type: TEXT/PLAIN; NAME="pthread_types.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.WNT.4.44.0207081002050.118@algeria.intern.net>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="pthread_types.patch"
Content-length: 4169

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
Y2x1ZGUvcHRocmVhZC5oIHNyYy93aW5zdXAvY3lnd2luL2luY2x1ZGUvcHRo
cmVhZC5oCi0tLSBzcmMub2xkL3dpbnN1cC9jeWd3aW4vaW5jbHVkZS9wdGhy
ZWFkLmgJVHVlIEp1bCAgMiAxMDoxNzoxMCAyMDAyCisrKyBzcmMvd2luc3Vw
L2N5Z3dpbi9pbmNsdWRlL3B0aHJlYWQuaAlNb24gSnVsICA4IDA5OjUxOjQw
IDIwMDIKQEAgLTQ0LDcgKzQ0LDcgQEAgZXh0ZXJuICJDIgogI2RlZmluZSBQ
VEhSRUFEX0NBTkNFTF9ESVNBQkxFIDEKICNkZWZpbmUgUFRIUkVBRF9DQU5D
RUxFRCAoKHZvaWQgKiktMSkKIC8qIHRoaXMgc2hvdWxkIGJlIGEgdmFsdWUg
dGhhdCBjYW4gbmV2ZXIgYmUgYSB2YWxpZCBhZGRyZXNzICovCi0jZGVmaW5l
IFBUSFJFQURfQ09ORF9JTklUSUFMSVpFUiAodm9pZCAqKTIxCisjZGVmaW5l
IFBUSFJFQURfQ09ORF9JTklUSUFMSVpFUiAocHRocmVhZF9jb25kX3QpMjEK
ICNkZWZpbmUgUFRIUkVBRF9DUkVBVEVfREVUQUNIRUQgMQogLyogdGhlIGRl
ZmF1bHQgOiBqb2luYWJsZSAqLwogI2RlZmluZSBQVEhSRUFEX0NSRUFURV9K
T0lOQUJMRSAwCkBAIC01NCw3ICs1NCw3IEBAIGV4dGVybiAiQyIKICNkZWZp
bmUgUFRIUkVBRF9NVVRFWF9SRUNVUlNJVkUgMQogI2RlZmluZSBQVEhSRUFE
X01VVEVYX0RFRkFVTFQgUFRIUkVBRF9NVVRFWF9FUlJPUkNIRUNLCiAvKiB0
aGlzIHNob3VsZCBiZSB0b28gbG93IHRvIGV2ZXIgYmUgYSB2YWxpZCBhZGRy
ZXNzICovCi0jZGVmaW5lIFBUSFJFQURfTVVURVhfSU5JVElBTElaRVIgKHZv
aWQgKikyMAorI2RlZmluZSBQVEhSRUFEX01VVEVYX0lOSVRJQUxJWkVSIChw
dGhyZWFkX211dGV4X3QpMjAKICNkZWZpbmUgUFRIUkVBRF9PTkNFX0lOSVQg
eyBQVEhSRUFEX01VVEVYX0lOSVRJQUxJWkVSLCAwIH0KICNkZWZpbmUgUFRI
UkVBRF9QUklPX0lOSEVSSVQKICNkZWZpbmUgUFRIUkVBRF9QUklPX05PTkUK
ZGlmZiAtdXJwIHNyYy5vbGQvd2luc3VwL2N5Z3dpbi9pbmNsdWRlL3NlbWFw
aG9yZS5oIHNyYy93aW5zdXAvY3lnd2luL2luY2x1ZGUvc2VtYXBob3JlLmgK
LS0tIHNyYy5vbGQvd2luc3VwL2N5Z3dpbi9pbmNsdWRlL3NlbWFwaG9yZS5o
CVdlZCBNYXIgMjEgMTY6MDY6MjIgMjAwMQorKysgc3JjL3dpbnN1cC9jeWd3
aW4vaW5jbHVkZS9zZW1hcGhvcmUuaAlGcmkgSnVsICA1IDEwOjAyOjMyIDIw
MDIKQEAgLTIxLDcgKzIxLDggQEAgZXh0ZXJuICJDIgogI2VuZGlmCiAKICNp
Zm5kZWYgX19JTlNJREVfQ1lHV0lOX18KLSAgdHlwZWRlZiB2b2lkICpzZW1f
dDsKKyAgdHlwZWRlZiBzdHJ1Y3Qge2NoYXIgX19kdW1teTt9IF9fc2VtX3Q7
CisgIHR5cGVkZWYgX19zZW1fdCAqc2VtX3Q7CiAjZW5kaWYKIAogI2RlZmlu
ZSBTRU1fRkFJTEVEIDAK

--2646463-11378-1026115325=:118--
