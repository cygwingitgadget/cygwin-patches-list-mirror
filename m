Return-Path: <cygwin-patches-return-2602-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 15622 invoked by alias); 5 Jul 2002 07:12:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15607 invoked from network); 5 Jul 2002 07:12:22 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Date: Fri, 05 Jul 2002 00:12:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
To: Robert Collins <robert.collins@syncretize.net>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] pthread_key patch
In-Reply-To: <011b01c223f2$d31d3640$2300a8c0@LAPTOP>
Message-ID: <Pine.WNT.4.44.0207050910250.276-200000@algeria.intern.net>
X-X-Sender: pfaff@antarctica.intern.net
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="178266-30183-1025853124=:276"
X-SW-Source: 2002-q3/txt/msg00050.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--178266-30183-1025853124=:276
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-length: 1558


This time it was my fault.
Sorry.

Thomas

On Fri, 5 Jul 2002, Robert Collins wrote:

> Thomas, I can't see the patch again :[.
>
> Rob
>
> ----- Original Message -----
> From: "Thomas Pfaff" <tpfaff@gmx.net>
> To: <cygwin-patches@cygwin.com>
> Sent: Friday, July 05, 2002 4:50 PM
> Subject: [PATCH] pthread_key patch
>
>
> >
> >
> > If somebody is interested why if find this patch neccessary with a posix
> > threaded gcc could read
> > http://cygwin.com/ml/cygwin-patches/2002-q2/msg00214.html
> >
> > At least the changes in pthread_key::get should be applied, peoble would
> > be very surprised if the value of errno or Win32LastError will be set to 0
> > behind her back.
> >
> > Thomas
> >
> > Changelog:
> >
> > 2002-07-05  Thomas Pfaff  <tpfaff@gmx.net>
> >
> > * init.cc (dll_entry): Run the pthread_key destructors on thread
> > and process detach. This will make sure that regardless a thread
> > is created with pthread_create or CreateThread its eh context
> > will be freed.
> > * thread.cc: Moved #define MT_INTERFACE from thread.cc to
> > thread.h.
> > (pthread_key_destructor_list::IterateNull): Run
> > destructor only if value is not NULL.
> > (pthread_key::get): Save and restore WIN32 LastError to avoid
> > that Lasterror is cleared in the exception handling code.
> > set_errno (0) removed.
> > (__pthread_exit): Removed IterateNull call. This will be done
> > during thread detach.
> > * thread.h (pthread::cleanup_stack): Moved #define MT_INTERFACE
> > user_data->threadinterface from thread.cc to this location.
> >
> >
> >
> >
>

--178266-30183-1025853124=:276
Content-Type: TEXT/plain; name="pthread_key.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.WNT.4.44.0207050912040.276@algeria.intern.net>
Content-Description: 
Content-Disposition: attachment; filename="pthread_key.patch"
Content-length: 3026

ZGlmZiAtdXJwIHNyYy5vbGQvd2luc3VwL2N5Z3dpbi9pbml0LmNjIHNyYy93
aW5zdXAvY3lnd2luL2luaXQuY2MKLS0tIHNyYy5vbGQvd2luc3VwL2N5Z3dp
bi9pbml0LmNjCU1vbiBKdW4gMjQgMTA6NTE6NDMgMjAwMgorKysgc3JjL3dp
bnN1cC9jeWd3aW4vaW5pdC5jYwlNb24gSnVuIDI0IDExOjA4OjQ5IDIwMDIK
QEAgLTMzLDYgKzMzLDcgQEAgV0lOQVBJIGRsbF9lbnRyeSAoSEFORExFIGgs
IERXT1JEIHJlYXNvbgogCX0KICAgICAgIGJyZWFrOwogICAgIGNhc2UgRExM
X1BST0NFU1NfREVUQUNIOgorICAgICAgTVRfSU5URVJGQUNFLT5kZXN0cnVj
dG9ycy5JdGVyYXRlTnVsbCAoKTsKICAgICAgIGJyZWFrOwogICAgIGNhc2Ug
RExMX1RIUkVBRF9ERVRBQ0g6CiAjaWYgMCAvLyBGSVhNRTogUkVJTlNUQVRF
IFNPT04KQEAgLTQ4LDYgKzQ5LDcgQEAgV0lOQVBJIGRsbF9lbnRyeSAoSEFO
RExFIGgsIERXT1JEIHJlYXNvbgogCX0KIAkvLyBGSVhNRTogTmVlZCB0byBh
ZGQgb3RoZXIgcGVyX3RocmVhZCBzdHVmZiBoZXJlCiAjZW5kaWYKKyAgICAg
IE1UX0lOVEVSRkFDRS0+ZGVzdHJ1Y3RvcnMuSXRlcmF0ZU51bGwgKCk7CiAg
ICAgICBicmVhazsKICAgICB9CiAgIHJldHVybiAxOwpkaWZmIC11cnAgc3Jj
Lm9sZC93aW5zdXAvY3lnd2luL3RocmVhZC5jYyBzcmMvd2luc3VwL2N5Z3dp
bi90aHJlYWQuY2MKLS0tIHNyYy5vbGQvd2luc3VwL2N5Z3dpbi90aHJlYWQu
Y2MJTW9uIEp1biAyNCAxMTowODoyMSAyMDAyCisrKyBzcmMvd2luc3VwL2N5
Z3dpbi90aHJlYWQuY2MJTW9uIEp1biAyNCAxMTowODo0OSAyMDAyCkBAIC0x
MjYsMTQgKzEyNiwxNyBAQCBwdGhyZWFkX2tleV9kZXN0cnVjdG9yX2xpc3Q6
Okl0ZXJhdGVOdWxsCiAgIHB0aHJlYWRfa2V5X2Rlc3RydWN0b3IgKnRlbXAg
PSBoZWFkOwogICB3aGlsZSAodGVtcCkKICAgICB7Ci0gICAgICB0ZW1wLT5k
ZXN0cnVjdG9yICgodGVtcC0+a2V5KS0+Z2V0ICgpKTsKKyAgICAgIHZvaWQg
KnZhbHVlID0gKHRlbXAtPmtleSktPmdldCAoKTsKKyAgICAgIGlmICh2YWx1
ZSkKKyAgICAgICAgeworICAgICAgICAgIHRlbXAtPmRlc3RydWN0b3IgKHZh
bHVlKTsKKyAgICAgICAgICAodGVtcC0+a2V5KS0+c2V0IChOVUxMKTsKKyAg
ICAgICAgfQogICAgICAgdGVtcCA9IHRlbXAtPk5leHQgKCk7CiAgICAgfQog
fQogCiAKLSNkZWZpbmUgTVRfSU5URVJGQUNFIHVzZXJfZGF0YS0+dGhyZWFk
aW50ZXJmYWNlCi0KIHN0cnVjdCBfcmVlbnQgKgogX3JlZW50X2NsaWIgKCkK
IHsKQEAgLTQzMyw4ICs0MzYsNiBAQCBwdGhyZWFkOjpleGl0ICh2b2lkICp2
YWx1ZV9wdHIpCiAgIC8vIHJ1biBjbGVhbnVwIGhhbmRsZXJzCiAgIHBvcF9h
bGxfY2xlYW51cF9oYW5kbGVycyAoKTsKIAotICBNVF9JTlRFUkZBQ0UtPmRl
c3RydWN0b3JzLkl0ZXJhdGVOdWxsICgpOwotCiAgIG11dGV4LkxvY2sgKCk7
CiAgIC8vIGNsZWFudXAgaWYgdGhyZWFkIGlzIGluIGRldGFjaGVkIHN0YXRl
IGFuZCBub3Qgam9pbmVkCiAgIGlmKCBfX3B0aHJlYWRfZXF1YWwoJmpvaW5l
ciwgJnRocmVhZCApICkKQEAgLTk5MSw4ICs5OTIsMTMgQEAgcHRocmVhZF9r
ZXk6OnNldCAoY29uc3Qgdm9pZCAqdmFsdWUpCiB2b2lkICoKIHB0aHJlYWRf
a2V5OjpnZXQgKCkKIHsKLSAgc2V0X2Vycm5vICgwKTsKLSAgcmV0dXJuIFRs
c0dldFZhbHVlIChkd1Rsc0luZGV4KTsKKyAgdm9pZCAqcmVzdWx0OworICBp
bnQgbGFzdF9lcnJvciA9IEdldExhc3RFcnJvciAoKTsKKworICByZXN1bHQg
PSBUbHNHZXRWYWx1ZSAoZHdUbHNJbmRleCk7CisgIFNldExhc3RFcnJvciAo
bGFzdF9lcnJvcik7CisKKyAgcmV0dXJuIHJlc3VsdDsKIH0KIAogLypwc2hh
cmVkIG11dGV4czoKZGlmZiAtdXJwIHNyYy5vbGQvd2luc3VwL2N5Z3dpbi90
aHJlYWQuaCBzcmMvd2luc3VwL2N5Z3dpbi90aHJlYWQuaAotLS0gc3JjLm9s
ZC93aW5zdXAvY3lnd2luL3RocmVhZC5oCU1vbiBKdW4gMjQgMTE6MDg6MjEg
MjAwMgorKysgc3JjL3dpbnN1cC9jeWd3aW4vdGhyZWFkLmgJTW9uIEp1biAy
NCAxMTowODo0OSAyMDAyCkBAIC01MjksNiArNTI5LDggQEAgaW50IF9fc2Vt
X3RyeXdhaXQgKHNlbV90ICogc2VtKTsKIGludCBfX3NlbV9wb3N0IChzZW1f
dCAqIHNlbSk7CiB9OwogCisjZGVmaW5lIE1UX0lOVEVSRkFDRSB1c2VyX2Rh
dGEtPnRocmVhZGludGVyZmFjZQorCiAjZW5kaWYgLy8gTVRfU0FGRQogCiAj
ZW5kaWYgLy8gX0NZR05VU19USFJFQURTXwo=

--178266-30183-1025853124=:276--
