Return-Path: <cygwin-patches-return-2825-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 13604 invoked by alias); 15 Aug 2002 20:00:29 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13524 invoked from network); 15 Aug 2002 20:00:26 -0000
Date: Thu, 15 Aug 2002 13:00:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Fixed CYGWIN_GUARD
Message-ID: <Pine.WNT.4.44.0208152141330.-376009@thomas.kefrig-pfaff.de>
X-X-Sender: thomas@gw.kefrig-pfaff.de
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="7606690-31591-1029440682=:-376009"
Content-ID: <Pine.WNT.4.44.0208152144550.-376009@thomas.kefrig-pfaff.de>
X-AntiVirus: scanned for viruses by NGI Next Generation Internet (http://www.ngi.de/)
X-SW-Source: 2002-q3/txt/msg00273.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--7606690-31591-1029440682=:-376009
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.WNT.4.44.0208152144551.-376009@thomas.kefrig-pfaff.de>
Content-length: 1100


The CYGWIN_GUARD define in dcrt0.cc does not work on WIN98 where
PAGE_GUARD is not available.

Normally this does not occur but i ran into this when i forked in a thread
other than the man thread. I got:

T:\FORK\FORK.EXE: *** fork: couldn't allocate new stack guard page
0x112ADFFF, Win32 error 87
   1334 [unknown (0xFFFA6E1F)] fork 388757 sync_with_child: child
-186165(0x11C) died before initialization with status code 0x1
   1609 [unknown (0xFFFA6E1F)] fork 388757 sync_with_child: *** child
state waiting for longjmp

with this test program:

#include <pthread.h>

static void * TestThread( void * );

int main(void)
{
  pthread_t t;

  pthread_create(&t, NULL, TestThread, NULL);
  pthread_join(t, NULL);

  return 0;
}

static void * TestThread( void *not_used )
{
  switch (fork())
    {
    case -1:
      return NULL;
    case 0:
      break;
    default:
      wait (NULL);
    }

  return NULL;
}

I have attached a small patch.


2002-08-15  Thomas Pfaff  <tpfaff@gmx.net>

	* dcrt0.cc: Modified define for CYGWIN_GUARD
	(alloc_stack_hard_way): Fixed arguments for VirtualAlloc call.

--7606690-31591-1029440682=:-376009
Content-Type: TEXT/PLAIN; NAME="CYGWIN_GUARD.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.WNT.4.44.0208152144420.-376009@thomas.kefrig-pfaff.de>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="CYGWIN_GUARD.patch"
Content-length: 1261

ZGlmZiAtdXJwIHNyYy5vbGQvd2luc3VwL2N5Z3dpbi9kY3J0MC5jYyBzcmMv
d2luc3VwL2N5Z3dpbi9kY3J0MC5jYwotLS0gc3JjLm9sZC93aW5zdXAvY3ln
d2luL2RjcnQwLmNjCVN1biBKdW4gMzAgMDQ6MTg6MzcgMjAwMgorKysgc3Jj
L3dpbnN1cC9jeWd3aW4vZGNydDAuY2MJVHVlIEF1ZyAxMyAxNjo0NTozNyAy
MDAyCkBAIC00NTYsNyArNDU2LDggQEAgY2hlY2tfc2FuaXR5X2FuZF9zeW5j
IChwZXJfcHJvY2VzcyAqcCkKIGNoaWxkX2luZm8gTk9fQ09QWSAqY2hpbGRf
cHJvY19pbmZvID0gTlVMTDsKIHN0YXRpYyBNRU1PUllfQkFTSUNfSU5GT1JN
QVRJT04gTk9fQ09QWSBzbTsKIAotI2RlZmluZSBDWUdXSU5fR1VBUkQgKCh3
aW5jYXAuaGFzX3BhZ2VfZ3VhcmQgKCkpID8gUEFHRV9HVUFSRCA6IFBBR0Vf
Tk9BQ0NFU1MpCisjZGVmaW5lIENZR1dJTl9HVUFSRCAoKHdpbmNhcC5oYXNf
cGFnZV9ndWFyZCAoKSkgPyBcCisgICAgICAgICAgICAgICAgICAgICBQQUdF
X0VYRUNVVEVfUkVBRFdSSVRFfFBBR0VfR1VBUkQgOiBQQUdFX05PQUNDRVNT
KQogCiAvLyBfX2lubGluZV9fIHZvaWQKIGV4dGVybiB2b2lkCkBAIC00OTcs
NyArNDk4LDcgQEAgYWxsb2Nfc3RhY2tfaGFyZF93YXkgKGNoaWxkX2luZm9f
Zm9yayAqYwogICAgIHsKICAgICAgIG0uQmFzZUFkZHJlc3MgPSAoTFBWT0lE
KSgoRFdPUkQpbS5CYXNlQWRkcmVzcyAtIDEpOwogICAgICAgaWYgKCFWaXJ0
dWFsQWxsb2MgKChMUFZPSUQpIG0uQmFzZUFkZHJlc3MsIDEsIE1FTV9DT01N
SVQsCi0JCQkgUEFHRV9FWEVDVVRFX1JFQURXUklURXxDWUdXSU5fR1VBUkQp
KQorCQkJIENZR1dJTl9HVUFSRCkpCiAJYXBpX2ZhdGFsICgiZm9yazogY291
bGRuJ3QgYWxsb2NhdGUgbmV3IHN0YWNrIGd1YXJkIHBhZ2UgJXAsICVFIiwK
IAkJICAgbS5CYXNlQWRkcmVzcyk7CiAgICAgfQo=

--7606690-31591-1029440682=:-376009--
