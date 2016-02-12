Return-Path: <cygwin-patches-return-8302-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 41552 invoked by alias); 12 Feb 2016 10:21:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 41441 invoked by uid 89); 12 Feb 2016 10:21:27 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2 spammy=rounds, stdinth, stdint.h, UD:stdint.h
X-HELO: mail-wm0-f48.google.com
Received: from mail-wm0-f48.google.com (HELO mail-wm0-f48.google.com) (74.125.82.48) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Fri, 12 Feb 2016 10:21:25 +0000
Received: by mail-wm0-f48.google.com with SMTP id c200so13662880wme.0        for <cygwin-patches@cygwin.com>; Fri, 12 Feb 2016 02:21:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20130820;        h=x-gm-message-state:to:from:subject:message-id:date:user-agent         :mime-version:content-type;        bh=x2KzpIL1ZGYNCSW5CCguqY4SxTtKWCOaf/RTRj8E4rc=;        b=i/eT8NPli9fzfpswyUVn0ek0gJG4a/YLsGPh9VrOTs9Ofuj3eqNIljC/B7HDrVkN8S         7ocM53UXmh7R/9M+3EzRLDMrCXqr3fSPZ+2jorfCRzFm03dC74MXhuJH42Jz5B0YG1im         o+XodeA4sQcBkfr7SX/gjFubquHCbJKFyWKWLIJ+9bsUoXvpuU4vZhzgKOj0pOW3qe/H         545IMVt1UU/jvgecc6I1QH0w4IZsYYMLf+FbA17xzSVrHMsnKJ50EhVz0EjP9j7+Sbse         B/qidb5F9Fb1/+Rh2GBgOB0oGoBK6gWrs0iMk9fobKtkEHkY2AH8o2tEU3z+WXRc5/VN         UyCg==
X-Gm-Message-State: AG10YOQVVV7twSJDK2feDbz7hklzH9PU9nDjPDlTx35nB2mciCihx/DmilflvOPjB1q4eA==
X-Received: by 10.194.95.40 with SMTP id dh8mr948350wjb.146.1455272482233;        Fri, 12 Feb 2016 02:21:22 -0800 (PST)
Received: from [10.0.0.1] (27.228.broadband3.iol.cz. [85.70.228.27])        by smtp.googlemail.com with ESMTPSA id 198sm1703151wml.22.2016.02.12.02.21.20        (version=TLSv1/SSLv3 cipher=OTHER);        Fri, 12 Feb 2016 02:21:20 -0800 (PST)
To: cygwin-patches@cygwin.com
From: =?UTF-8?Q?V=c3=a1clav_Haisman?= <vhaisman@gmail.com>
Subject: [PATCH] POSIX barrier implementation, take 2
X-Enigmail-Draft-Status: N1110
Message-ID: <56BDB206.9090101@gmail.com>
Date: Fri, 12 Feb 2016 10:21:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101 Thunderbird/38.5.1
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512; protocol="application/pgp-signature"; boundary="hm0N22c5xLji04RVTDHEajmvLK0kmEtIb"
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00008.txt.bz2

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hm0N22c5xLji04RVTDHEajmvLK0kmEtIb
Content-Type: multipart/mixed;
 boundary="------------040805060600040109030903"

This is a multi-part message in MIME format.
--------------040805060600040109030903
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-length: 1164

Hi.

Here is a second take on the POSIX barrier API. This time it is tested
with the attached barrier.c file. Here is a change log.


Newlib:

	* libc/include/sys/features.h (_POSIX_BARRIERS): Define for Cygwin.
	* libc/include/sys/types.h (pthread_barrier_t)
	(pthread_barrierattr_t): Do not define for Cygwin.

Cygwin:

	* common.din (pthread_barrierattr_init)
	(pthread_barrierattr_setpshared, pthread_barrierattr_getpshared)
	(pthread_barrierattr_destroy, pthread_barrier_init)
	(pthread_barrier_destroy, pthread_barrier_wait): Export.
	* include/cygwin/types.h (pthread_barrierattr_t)
	(pthread_barrier_t): Declare.
	* include/pthread.h (PTHREAD_BARRIER_SERIAL_THREAD)
	(pthread_barrierattr_init, pthread_barrierattr_setpshared)
	(pthread_barrierattr_getpshared, pthread_barrierattr_destroy)
	(pthread_barrier_init, pthread_barrier_destroy)
	(pthread_barrier_wait): Declare.
	* cygwin/thread.h (PTHREAD_BARRIER_MAGIC)
	(PTHREAD_BARRIERATTR_MAGIC): Define.
	(class pthread_barrierattr, class pthread_barrier): Declare.
	* cygwin/thread.cc (delete_and_clear): New local helper function.
	(class pthread_barrierattr, class pthread_barrier): Implement.

--=20
VH

--------------040805060600040109030903
Content-Type: text/x-csrc;
 name="barrier.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="barrier.c"
Content-length: 2913

#include <pthread.h>
#include <stdlib.h>
#include <stddef.h>
#include <stdint.h>
#include <unistd.h>
#include <stdio.h>
#include <errno.h>


pthread_barrier_t barrier;


#define ROUNDS 5

void *
thread_routine (void * arg)
{
  int myid =3D (ptrdiff_t)arg;

  for (int round =3D 0; round !=3D ROUNDS; ++round)
    {
      printf ("Thread %d reporting for duty. Going to wait on barrier."
              " Round %d.\n", myid, round);
      int retval =3D pthread_barrier_wait (&barrier);
      if (retval =3D=3D PTHREAD_BARRIER_SERIAL_THREAD)
        printf ("I, number %d, was the last thread to make it to the barrie=
r."
                " Round %d.\n",
                myid, round);
      else if (retval !=3D 0)
        printf ("I, number %d, got error %d on barrier. Round %d.\n",
                myid, retval, round);
      else
        printf ("I, number %d, got released by the barrier. Round %d.\n",
                myid, round);

    }

  return NULL;
}


#define COUNT 5

pthread_t threads[COUNT];


int
main ()
{
  pthread_barrierattr_t battr;
  int retval =3D pthread_barrierattr_init (&battr);
  if (retval !=3D 0)
    {
      printf ("Failed to initialize barrier attribute: %d", retval);
      return retval;
    }

  retval =3D pthread_barrierattr_setpshared (&battr,
                                                PTHREAD_PROCESS_SHARED);
  if (retval !=3D 0)
    {
      printf ("Failed to set PTHREAD_PROCESS_SHARED on barrier attribute:"
              " %d\n",
              retval);
      return retval;
    }

  retval =3D pthread_barrierattr_setpshared (&battr,
                                                PTHREAD_PROCESS_PRIVATE);
  if (retval !=3D 0)
    {
      printf ("Failed to set PTHREAD_PROCESS_PRIVATE on barrier attribute:"
              " %d\n",
              retval);
      return retval;
    }

  retval =3D pthread_barrier_init (&barrier, &battr, COUNT);
  if (retval !=3D 0)
    {
      printf ("Failed to init barrier: %d\n", retval);
      return retval;
    }

  retval =3D pthread_barrierattr_destroy (&battr);
  if (retval !=3D 0)
    {
      printf ("Failed to destroy barrier attribute: %d\n", retval);
      return retval;
    }

  for (int i =3D 0; i !=3D COUNT; ++i)
    {
      retval =3D pthread_create(&threads[i], NULL, thread_routine,
                              (void*)(ptrdiff_t)i);
      if (retval !=3D 0)
        {
          printf ("Failed to create thread %d, error %d.\n", i, retval);
          return retval;
        }
    }

  for (int i =3D 0; i !=3D COUNT; ++i)
    {
      retval =3D pthread_join (threads[i], NULL);
      if (retval !=3D 0)
        {
          printf ("Failed to join thread %d, error %d.\n", i, retval);
          return retval;
        }
    }

  retval =3D pthread_barrier_destroy (&barrier);
  if (retval !=3D 0)
    {
      printf ("Failed to destroy barrier: %d\n", retval);
      return retval;
    }

  return 0;
}

--------------040805060600040109030903
Content-Type: text/plain; charset=UTF-8;
 name="barrier02.patch.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="barrier02.patch.txt"
Content-length: 16995

ZGlmZiAtLWdpdCBhL25ld2xpYi9saWJjL2luY2x1ZGUvc3lzL2ZlYXR1cmVz
LmggYi9uZXdsaWIvbGliYy9pbmNsdWRlL3N5cy9mZWF0dXJlcy5oCmluZGV4
IDRhZDdmYmQuLjBjNjA0M2MgMTAwNjQ0Ci0tLSBhL25ld2xpYi9saWJjL2lu
Y2x1ZGUvc3lzL2ZlYXR1cmVzLmgKKysrIGIvbmV3bGliL2xpYmMvaW5jbHVk
ZS9zeXMvZmVhdHVyZXMuaApAQCAtMTE4LDEwICsxMTgsMTAgQEAgZXh0ZXJu
ICJDIiB7CiAKICNkZWZpbmUgX1BPU0lYX0FEVklTT1JZX0lORk8JCQkyMDAx
MTJMCiAvKiAjZGVmaW5lIF9QT1NJWF9BU1lOQ0hST05PVVNfSU8JCSAgICAt
MSAqLwotLyogI2RlZmluZSBfUE9TSVhfQkFSUklFUlMJCQkgICAgLTEgKi8K
KyNkZWZpbmUgX1BPU0lYX0JBUlJJRVJTCQkJCTIwMDExMkwKICNkZWZpbmUg
X1BPU0lYX0NIT1dOX1JFU1RSSUNURUQJCQkgICAgIDEKICNkZWZpbmUgX1BP
U0lYX0NMT0NLX1NFTEVDVElPTgkJCTIwMDExMkwKLSNkZWZpbmUgX1BPU0lY
X0NQVVRJTUUJCQkgICAgCTIwMDExMkwKKyNkZWZpbmUgX1BPU0lYX0NQVVRJ
TUUJCQkJMjAwMTEyTAogI2RlZmluZSBfUE9TSVhfRlNZTkMJCQkJMjAwMTEy
TAogI2RlZmluZSBfUE9TSVhfSVBWNgkJCQkyMDAxMTJMCiAjZGVmaW5lIF9Q
T1NJWF9KT0JfQ09OVFJPTAkJCSAgICAgMQpAQCAtMTQwLDcgKzE0MCw3IEBA
IGV4dGVybiAiQyIgewogI2RlZmluZSBfUE9TSVhfUkVHRVhQCQkJCSAgICAg
MQogI2RlZmluZSBfUE9TSVhfU0FWRURfSURTCQkJICAgICAxCiAjZGVmaW5l
IF9QT1NJWF9TRU1BUEhPUkVTCQkJMjAwMTEyTAotI2RlZmluZSBfUE9TSVhf
U0hBUkVEX01FTU9SWV9PQkpFQ1RTCQkyMDAxMTJMIAorI2RlZmluZSBfUE9T
SVhfU0hBUkVEX01FTU9SWV9PQkpFQ1RTCQkyMDAxMTJMCiAjZGVmaW5lIF9Q
T1NJWF9TSEVMTAkJCQkgICAgIDEKIC8qICNkZWZpbmUgX1BPU0lYX1NQQVdO
CQkJCSAgICAtMSAqLwogI2RlZmluZSBfUE9TSVhfU1BJTl9MT0NLUwkJCSAg
ICAyMDAxMTJMCmRpZmYgLS1naXQgYS9uZXdsaWIvbGliYy9pbmNsdWRlL3N5
cy90eXBlcy5oIGIvbmV3bGliL2xpYmMvaW5jbHVkZS9zeXMvdHlwZXMuaApp
bmRleCA1ZGQ2Yzc1Li5iZmU5M2ZhIDEwMDY0NAotLS0gYS9uZXdsaWIvbGli
Yy9pbmNsdWRlL3N5cy90eXBlcy5oCisrKyBiL25ld2xpYi9saWJjL2luY2x1
ZGUvc3lzL3R5cGVzLmgKQEAgLTQzMSw2ICs0MzEsNyBAQCB0eXBlZGVmIHN0
cnVjdCB7CiAKIC8qIFBPU0lYIEJhcnJpZXIgVHlwZXMgKi8KIAorI2lmICFk
ZWZpbmVkKF9fQ1lHV0lOX18pCiAjaWYgZGVmaW5lZChfUE9TSVhfQkFSUklF
UlMpCiB0eXBlZGVmIF9fdWludDMyX3QgcHRocmVhZF9iYXJyaWVyX3Q7ICAg
ICAgICAvKiBQT1NJWCBCYXJyaWVyIE9iamVjdCAqLwogdHlwZWRlZiBzdHJ1
Y3QgewpAQCAtNDQwLDYgKzQ0MSw3IEBAIHR5cGVkZWYgc3RydWN0IHsKICNl
bmRpZgogfSBwdGhyZWFkX2JhcnJpZXJhdHRyX3Q7CiAjZW5kaWYgLyogZGVm
aW5lZChfUE9TSVhfQkFSUklFUlMpICovCisjZW5kaWYgLyogX19DWUdXSU5f
XyAqLwogCiAvKiBQT1NJWCBTcGluIExvY2sgVHlwZXMgKi8KIApkaWZmIC0t
Z2l0IGEvd2luc3VwL2N5Z3dpbi9jb21tb24uZGluIGIvd2luc3VwL2N5Z3dp
bi9jb21tb24uZGluCmluZGV4IGQ3ZjRkMjQuLjE4ZTAxMGEgMTAwNjQ0Ci0t
LSBhL3dpbnN1cC9jeWd3aW4vY29tbW9uLmRpbgorKysgYi93aW5zdXAvY3ln
d2luL2NvbW1vbi5kaW4KQEAgLTg4Miw2ICs4ODIsMTMgQEAgcHRocmVhZF9j
b25kYXR0cl9nZXRwc2hhcmVkIFNJR0ZFCiBwdGhyZWFkX2NvbmRhdHRyX2lu
aXQgU0lHRkUKIHB0aHJlYWRfY29uZGF0dHJfc2V0Y2xvY2sgU0lHRkUKIHB0
aHJlYWRfY29uZGF0dHJfc2V0cHNoYXJlZCBTSUdGRQorcHRocmVhZF9iYXJy
aWVyYXR0cl9pbml0IFNJR0ZFCitwdGhyZWFkX2JhcnJpZXJhdHRyX3NldHBz
aGFyZWQgU0lHRkUKK3B0aHJlYWRfYmFycmllcmF0dHJfZ2V0cHNoYXJlZCBT
SUdGRQorcHRocmVhZF9iYXJyaWVyYXR0cl9kZXN0cm95IFNJR0ZFCitwdGhy
ZWFkX2JhcnJpZXJfaW5pdCBTSUdGRQorcHRocmVhZF9iYXJyaWVyX2Rlc3Ry
b3kgU0lHRkUKK3B0aHJlYWRfYmFycmllcl93YWl0IFNJR0ZFCiBwdGhyZWFk
X2NvbnRpbnVlIFNJR0ZFCiBwdGhyZWFkX2NyZWF0ZSBTSUdGRQogcHRocmVh
ZF9kZXRhY2ggU0lHRkUKZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vaW5j
bHVkZS9jeWd3aW4vdHlwZXMuaCBiL3dpbnN1cC9jeWd3aW4vaW5jbHVkZS9j
eWd3aW4vdHlwZXMuaAppbmRleCA4NWVlN2M3Li5iMDFhZTk1IDEwMDY0NAot
LS0gYS93aW5zdXAvY3lnd2luL2luY2x1ZGUvY3lnd2luL3R5cGVzLmgKKysr
IGIvd2luc3VwL2N5Z3dpbi9pbmNsdWRlL2N5Z3dpbi90eXBlcy5oCkBAIC0x
ODQsNiArMTg0LDggQEAgdHlwZWRlZiBzdHJ1Y3QgX19wdGhyZWFkX2F0dHJf
dCB7Y2hhciBfX2R1bW15O30gKnB0aHJlYWRfYXR0cl90OwogdHlwZWRlZiBz
dHJ1Y3QgX19wdGhyZWFkX211dGV4YXR0cl90IHtjaGFyIF9fZHVtbXk7fSAq
cHRocmVhZF9tdXRleGF0dHJfdDsKIHR5cGVkZWYgc3RydWN0IF9fcHRocmVh
ZF9jb25kYXR0cl90IHtjaGFyIF9fZHVtbXk7fSAqcHRocmVhZF9jb25kYXR0
cl90OwogdHlwZWRlZiBzdHJ1Y3QgX19wdGhyZWFkX2NvbmRfdCB7Y2hhciBf
X2R1bW15O30gKnB0aHJlYWRfY29uZF90OwordHlwZWRlZiBzdHJ1Y3QgX19w
dGhyZWFkX2JhcnJpZXJhdHRyX3Qge2NoYXIgX19kdW1teTt9ICpwdGhyZWFk
X2JhcnJpZXJhdHRyX3Q7Cit0eXBlZGVmIHN0cnVjdCBfX3B0aHJlYWRfYmFy
cmllcl90IHtjaGFyIF9fZHVtbXk7fSAqcHRocmVhZF9iYXJyaWVyX3Q7CiAK
ICAgLyogVGhlc2UgdmFyaWFibGVzIGFyZSBub3QgdXNlciBhbHRlcmFibGUu
IFRoaXMgbWVhbnMgeW91IS4gKi8KIHR5cGVkZWYgc3RydWN0CkBAIC0yMDcs
NiArMjA5LDggQEAgdHlwZWRlZiBjbGFzcyBwdGhyZWFkX2F0dHIgKnB0aHJl
YWRfYXR0cl90OwogdHlwZWRlZiBjbGFzcyBwdGhyZWFkX211dGV4YXR0ciAq
cHRocmVhZF9tdXRleGF0dHJfdDsKIHR5cGVkZWYgY2xhc3MgcHRocmVhZF9j
b25kYXR0ciAqcHRocmVhZF9jb25kYXR0cl90OwogdHlwZWRlZiBjbGFzcyBw
dGhyZWFkX2NvbmQgKnB0aHJlYWRfY29uZF90OwordHlwZWRlZiBjbGFzcyBw
dGhyZWFkX2JhcnJpZXIgKnB0aHJlYWRfYmFycmllcl90OwordHlwZWRlZiBj
bGFzcyBwdGhyZWFkX2JhcnJpZXJhdHRyICpwdGhyZWFkX2JhcnJpZXJhdHRy
X3Q7CiB0eXBlZGVmIGNsYXNzIHB0aHJlYWRfb25jZSBwdGhyZWFkX29uY2Vf
dDsKIHR5cGVkZWYgY2xhc3MgcHRocmVhZF9zcGlubG9jayAqcHRocmVhZF9z
cGlubG9ja190OwogdHlwZWRlZiBjbGFzcyBwdGhyZWFkX3J3bG9jayAqcHRo
cmVhZF9yd2xvY2tfdDsKZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vaW5j
bHVkZS9wdGhyZWFkLmggYi93aW5zdXAvY3lnd2luL2luY2x1ZGUvcHRocmVh
ZC5oCmluZGV4IDlhZDhiNjYuLjg0ZTBhMTQgMTAwNjQ0Ci0tLSBhL3dpbnN1
cC9jeWd3aW4vaW5jbHVkZS9wdGhyZWFkLmgKKysrIGIvd2luc3VwL2N5Z3dp
bi9pbmNsdWRlL3B0aHJlYWQuaApAQCAtNjIsNiArNjIsNyBAQCBleHRlcm4g
IkMiCiAvKiBwcm9jZXNzIGlzIHRoZSBkZWZhdWx0ICovCiAjZGVmaW5lIFBU
SFJFQURfU0NPUEVfUFJPQ0VTUyAwCiAjZGVmaW5lIFBUSFJFQURfU0NPUEVf
U1lTVEVNIDEKKyNkZWZpbmUgUFRIUkVBRF9CQVJSSUVSX1NFUklBTF9USFJF
QUQgKC0xKQogCiAvKiBSZWdpc3RlciBGb3JrIEhhbmRsZXJzICovCiBpbnQg
cHRocmVhZF9hdGZvcmsgKHZvaWQgKCopKHZvaWQpLCB2b2lkICgqKSh2b2lk
KSwgdm9pZCAoKikodm9pZCkpOwpAQCAtMTMzLDYgKzEzNCwxNyBAQCBpbnQg
cHRocmVhZF9jb25kYXR0cl9pbml0IChwdGhyZWFkX2NvbmRhdHRyX3QgKik7
CiBpbnQgcHRocmVhZF9jb25kYXR0cl9zZXRjbG9jayAocHRocmVhZF9jb25k
YXR0cl90ICosIGNsb2NraWRfdCk7CiBpbnQgcHRocmVhZF9jb25kYXR0cl9z
ZXRwc2hhcmVkIChwdGhyZWFkX2NvbmRhdHRyX3QgKiwgaW50KTsKIAorLyog
QmFycmllcnMgKi8KK2ludCBwdGhyZWFkX2JhcnJpZXJhdHRyX2luaXQgKHB0
aHJlYWRfYmFycmllcmF0dHJfdCAqKTsKK2ludCBwdGhyZWFkX2JhcnJpZXJh
dHRyX3NldHBzaGFyZWQgKHB0aHJlYWRfYmFycmllcmF0dHJfdCAqLCBpbnQp
OworaW50IHB0aHJlYWRfYmFycmllcmF0dHJfZ2V0cHNoYXJlZCAoY29uc3Qg
cHRocmVhZF9iYXJyaWVyYXR0cl90ICosIGludCAqKTsKK2ludCBwdGhyZWFk
X2JhcnJpZXJhdHRyX2Rlc3Ryb3kgKHB0aHJlYWRfYmFycmllcmF0dHJfdCAq
KTsKK2ludCBwdGhyZWFkX2JhcnJpZXJfaW5pdCAocHRocmVhZF9iYXJyaWVy
X3QgKiwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3QgcHRocmVh
ZF9iYXJyaWVyYXR0cl90ICosIHVuc2lnbmVkKTsKK2ludCBwdGhyZWFkX2Jh
cnJpZXJfZGVzdHJveSAocHRocmVhZF9iYXJyaWVyX3QgKik7CitpbnQgcHRo
cmVhZF9iYXJyaWVyX3dhaXQgKHB0aHJlYWRfYmFycmllcl90ICopOworCisv
KiBUaHJlYWRzICovCiBpbnQgcHRocmVhZF9jcmVhdGUgKHB0aHJlYWRfdCAq
LCBjb25zdCBwdGhyZWFkX2F0dHJfdCAqLAogCQkgICAgdm9pZCAqKCopKHZv
aWQgKiksIHZvaWQgKik7CiBpbnQgcHRocmVhZF9kZXRhY2ggKHB0aHJlYWRf
dCk7CmRpZmYgLS1naXQgYS93aW5zdXAvY3lnd2luL3RocmVhZC5jYyBiL3dp
bnN1cC9jeWd3aW4vdGhyZWFkLmNjCmluZGV4IDhmMjk5MDAuLjg4ZjQ4MmMg
MTAwNjQ0Ci0tLSBhL3dpbnN1cC9jeWd3aW4vdGhyZWFkLmNjCisrKyBiL3dp
bnN1cC9jeWd3aW4vdGhyZWFkLmNjCkBAIC01MCw2ICs1MCwxNyBAQCBjb25z
dCBwdGhyZWFkX3QgcHRocmVhZF9tdXRleDo6X25ld19tdXRleCA9IChwdGhy
ZWFkX3QpIDE7CiBjb25zdCBwdGhyZWFkX3QgcHRocmVhZF9tdXRleDo6X3Vu
bG9ja2VkX211dGV4ID0gKHB0aHJlYWRfdCkgMjsKIGNvbnN0IHB0aHJlYWRf
dCBwdGhyZWFkX211dGV4OjpfZGVzdHJveWVkX211dGV4ID0gKHB0aHJlYWRf
dCkgMzsKIAorCit0ZW1wbGF0ZSA8dHlwZW5hbWUgVD4KK3N0YXRpYyBpbmxp
bmUKK3ZvaWQKK2RlbGV0ZV9hbmRfY2xlYXIgKFQgKiAqIGNvbnN0IHB0cikK
K3sKKyAgZGVsZXRlICpwdHI7CisgICpwdHIgPSAwOworfQorCisKIGlubGlu
ZSBib29sCiBwdGhyZWFkX211dGV4Ojpub19vd25lcigpCiB7CkBAIC0yNjcs
NiArMjc4LDIzIEBAIHB0aHJlYWRfY29uZDo6aXNfaW5pdGlhbGl6ZXJfb3Jf
b2JqZWN0IChwdGhyZWFkX2NvbmRfdCBjb25zdCAqY29uZCkKICAgcmV0dXJu
IHRydWU7CiB9CiAKK2lubGluZSBib29sCitwdGhyZWFkX2JhcnJpZXJhdHRy
Ojppc19nb29kX29iamVjdCAocHRocmVhZF9iYXJyaWVyYXR0cl90IGNvbnN0
ICpjb25kKQoreworICBpZiAodmVyaWZ5YWJsZV9vYmplY3RfaXN2YWxpZCAo
Y29uZCwgUFRIUkVBRF9CQVJSSUVSQVRUUl9NQUdJQykKKyAgICAgICE9IFZB
TElEX09CSkVDVCkKKyAgICByZXR1cm4gZmFsc2U7CisgIHJldHVybiB0cnVl
OworfQorCitpbmxpbmUgYm9vbAorcHRocmVhZF9iYXJyaWVyOjppc19nb29k
X29iamVjdCAocHRocmVhZF9iYXJyaWVyX3QgY29uc3QgKmNvbmQpCit7Cisg
IGlmICh2ZXJpZnlhYmxlX29iamVjdF9pc3ZhbGlkIChjb25kLCBQVEhSRUFE
X0JBUlJJRVJfTUFHSUMpICE9IFZBTElEX09CSkVDVCkKKyAgICByZXR1cm4g
ZmFsc2U7CisgIHJldHVybiB0cnVlOworfQorCiAvKiBSVyBsb2NrcyAqLwog
aW5saW5lIGJvb2wKIHB0aHJlYWRfcndsb2NrOjppc19nb29kX29iamVjdCAo
cHRocmVhZF9yd2xvY2tfdCBjb25zdCAqcndsb2NrKQpAQCAtMTMwMCw2ICsx
MzI4LDI1IEBAIHB0aHJlYWRfY29uZDo6X2ZpeHVwX2FmdGVyX2ZvcmsgKCkK
ICAgICBhcGlfZmF0YWwgKCJwdGhyZWFkX2NvbmQ6Ol9maXh1cF9hZnRlcl9m
b3JrICgpIGZhaWxlZCB0byByZWNyZWF0ZSB3aW4zMiBzZW1hcGhvcmUiKTsK
IH0KIAorcHRocmVhZF9iYXJyaWVyYXR0cjo6cHRocmVhZF9iYXJyaWVyYXR0
ciAoKQorICA6IHZlcmlmeWFibGVfb2JqZWN0IChQVEhSRUFEX0JBUlJJRVJB
VFRSX01BR0lDKQorICAsIHNoYXJlZCAoUFRIUkVBRF9QUk9DRVNTX1BSSVZB
VEUpCit7Cit9CisKK3B0aHJlYWRfYmFycmllcmF0dHI6On5wdGhyZWFkX2Jh
cnJpZXJhdHRyICgpCit7Cit9CisKK3B0aHJlYWRfYmFycmllcjo6cHRocmVh
ZF9iYXJyaWVyICgpCisgIDogdmVyaWZ5YWJsZV9vYmplY3QgKFBUSFJFQURf
QkFSUklFUl9NQUdJQykKK3sKK30KKworcHRocmVhZF9iYXJyaWVyOjp+cHRo
cmVhZF9iYXJyaWVyICgpCit7Cit9CisKIHB0aHJlYWRfcndsb2NrYXR0cjo6
cHRocmVhZF9yd2xvY2thdHRyICgpOnZlcmlmeWFibGVfb2JqZWN0CiAgIChQ
VEhSRUFEX1JXTE9DS0FUVFJfTUFHSUMpLCBzaGFyZWQgKFBUSFJFQURfUFJP
Q0VTU19QUklWQVRFKQogewpAQCAtMzg2OSwzICszOTE2LDIyMyBAQCBwdGhy
ZWFkX251bGw6OmdldHNlcXVlbmNlX25wICgpCiB9CiAKIHB0aHJlYWRfbnVs
bCBwdGhyZWFkX251bGw6Ol9pbnN0YW5jZTsKKworCisKKyNkZWZpbmUgTElL
RUxZKFgpIF9fYnVpbHRpbl9leHBlY3QgKCEhKFgpLCAxKQorI2RlZmluZSBV
TkxJS0VMWShYKSBfX2J1aWx0aW5fZXhwZWN0ICghIShYKSwgMCkKKworCitl
eHRlcm4gIkMiCitpbnQKK3B0aHJlYWRfYmFycmllcmF0dHJfaW5pdCAocHRo
cmVhZF9iYXJyaWVyYXR0cl90ICogYmF0dHIpCit7CisgIGlmIChVTkxJS0VM
WSAoYmF0dHIgPT0gTlVMTCkpCisgICAgcmV0dXJuIEVJTlZBTDsKKworICAq
YmF0dHIgPSBuZXcgcHRocmVhZF9iYXJyaWVyYXR0cjsKKyAgKCpiYXR0cikt
PnNoYXJlZCA9IFBUSFJFQURfUFJPQ0VTU19QUklWQVRFOworCisgIHJldHVy
biAwOworfQorCisKK2V4dGVybiAiQyIKK2ludAorcHRocmVhZF9iYXJyaWVy
YXR0cl9zZXRwc2hhcmVkIChwdGhyZWFkX2JhcnJpZXJhdHRyX3QgKiBiYXR0
ciwgaW50IHNoYXJlZCkKK3sKKyAgaWYgKFVOTElLRUxZICghIHB0aHJlYWRf
YmFycmllcmF0dHI6OmlzX2dvb2Rfb2JqZWN0IChiYXR0cikpKQorICAgIHJl
dHVybiBFSU5WQUw7CisKKyAgaWYgKFVOTElLRUxZIChzaGFyZWQgIT0gUFRI
UkVBRF9QUk9DRVNTX1NIQVJFRAorICAgICAgICAgICAgICAgICYmIHNoYXJl
ZCAhPSBQVEhSRUFEX1BST0NFU1NfUFJJVkFURSkpCisgICAgcmV0dXJuIEVJ
TlZBTDsKKworICAoKmJhdHRyKS0+c2hhcmVkID0gc2hhcmVkOworICByZXR1
cm4gMDsKK30KKworCitleHRlcm4gIkMiCitpbnQKK3B0aHJlYWRfYmFycmll
cmF0dHJfZ2V0cHNoYXJlZCAoY29uc3QgcHRocmVhZF9iYXJyaWVyYXR0cl90
ICogYmF0dHIsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlu
dCAqIHNoYXJlZCkKK3sKKyAgaWYgKFVOTElLRUxZICghIHB0aHJlYWRfYmFy
cmllcmF0dHI6OmlzX2dvb2Rfb2JqZWN0IChiYXR0cikKKyAgICAgICAgICAg
ICAgICB8fCBzaGFyZWQgPT0gTlVMTCkpCisgICAgcmV0dXJuIEVJTlZBTDsK
KworICAqc2hhcmVkID0gKCpiYXR0ciktPnNoYXJlZDsKKyAgcmV0dXJuIDA7
Cit9CisKKworZXh0ZXJuICJDIgoraW50CitwdGhyZWFkX2JhcnJpZXJhdHRy
X2Rlc3Ryb3kgKHB0aHJlYWRfYmFycmllcmF0dHJfdCAqIGJhdHRyKQorewor
ICBpZiAoVU5MSUtFTFkgKCEgcHRocmVhZF9iYXJyaWVyYXR0cjo6aXNfZ29v
ZF9vYmplY3QgKGJhdHRyKSkpCisgICAgcmV0dXJuIEVJTlZBTDsKKworICBk
ZWxldGVfYW5kX2NsZWFyIChiYXR0cik7CisgIHJldHVybiAwOworfQorCisK
K2V4dGVybiAiQyIKK2ludAorcHRocmVhZF9iYXJyaWVyX2luaXQgKHB0aHJl
YWRfYmFycmllcl90ICogYmFyLAorICAgICAgICAgICAgICAgICAgICAgIGNv
bnN0IHB0aHJlYWRfYmFycmllcmF0dHJfdCAqIGF0dHIsIHVuc2lnbmVkIGNv
dW50KQoreworICBpZiAoVU5MSUtFTFkgKGJhciA9PSBOVUxMKSkKKyAgICBy
ZXR1cm4gRUlOVkFMOworCisgICpiYXIgPSBuZXcgcHRocmVhZF9iYXJyaWVy
OworICByZXR1cm4gKCpiYXIpLT5pbml0IChhdHRyLCBjb3VudCk7Cit9CisK
KworaW50CitwdGhyZWFkX2JhcnJpZXI6OmluaXQgKGNvbnN0IHB0aHJlYWRf
YmFycmllcmF0dHJfdCAqIGF0dHIsIHVuc2lnbmVkIGNvdW50KQoreworICBw
dGhyZWFkX211dGV4X3QgKiBtdXRleCA9IE5VTEw7CisKKyAgaWYgKFVOTElL
RUxZICgoYXR0ciAhPSBOVUxMCisgICAgICAgICAgICAgICAgICYmICghIHB0
aHJlYWRfYmFycmllcmF0dHI6OmlzX2dvb2Rfb2JqZWN0IChhdHRyKQorICAg
ICAgICAgICAgICAgICAgICAgfHwgKCphdHRyKS0+c2hhcmVkID09IFBUSFJF
QURfUFJPQ0VTU19TSEFSRUQpKQorICAgICAgICAgICAgICAgIHx8IGNvdW50
ID09IDApKQorICAgIHJldHVybiBFSU5WQUw7CisKKyAgaW50IHJldHZhbCA9
IHB0aHJlYWRfbXV0ZXhfaW5pdCAoJm10eCwgTlVMTCk7CisgIGlmIChVTkxJ
S0VMWSAocmV0dmFsICE9IDApKQorICAgIHJldHVybiByZXR2YWw7CisKKyAg
cmV0dmFsID0gcHRocmVhZF9jb25kX2luaXQgKCZjb25kLCBOVUxMKTsKKyAg
aWYgKFVOTElLRUxZIChyZXR2YWwgIT0gMCkpCisgICAgeworICAgICAgaW50
IHJldCA9IHB0aHJlYWRfbXV0ZXhfZGVzdHJveSAobXV0ZXgpOworICAgICAg
aWYgKHJldCAhPSAwKQorICAgICAgICBhcGlfZmF0YWwgKCJwdGhyZWFkX211
dGV4X2Rlc3Ryb3kgKCVwKSA9ICVkIiwgbXV0ZXgsIHJldCk7CisKKyAgICAg
IG10eCA9IE5VTEw7CisgICAgICByZXR1cm4gcmV0dmFsOworICAgIH0KKwor
ICBjbnQgPSBjb3VudDsKKyAgY3ljID0gMDsKKyAgd3QgPSAwOworCisgIHJl
dHVybiAwOworfQorCisKK2V4dGVybiAiQyIKK2ludAorcHRocmVhZF9iYXJy
aWVyX2Rlc3Ryb3kgKHB0aHJlYWRfYmFycmllcl90ICogYmFyKQoreworICBp
ZiAoVU5MSUtFTFkgKCEgcHRocmVhZF9iYXJyaWVyOjppc19nb29kX29iamVj
dCAoYmFyKSkpCisgICAgcmV0dXJuIEVJTlZBTDsKKworICBpbnQgcmV0Owor
ICByZXQgPSAoKmJhciktPmRlc3Ryb3kgKCk7CisgIGlmIChyZXQgPT0gMCkK
KyAgICBkZWxldGVfYW5kX2NsZWFyIChiYXIpOworCisgIHJldHVybiByZXQ7
Cit9CisKKworaW50CitwdGhyZWFkX2JhcnJpZXI6OmRlc3Ryb3kgKCkKK3sK
KyAgaWYgKFVOTElLRUxZICh3dCAhPSAwKSkKKyAgICByZXR1cm4gRUJVU1k7
CisKKyAgaW50IHJldHZhbCA9IHB0aHJlYWRfY29uZF9kZXN0cm95ICgmY29u
ZCk7CisgIGlmIChVTkxJS0VMWSAocmV0dmFsICE9IDApKQorICAgIHJldHVy
biByZXR2YWw7CisgIGVsc2UKKyAgICBjb25kID0gTlVMTDsKKworICByZXR2
YWwgPSBwdGhyZWFkX211dGV4X2Rlc3Ryb3kgKCZtdHgpOworICBpZiAoVU5M
SUtFTFkgKHJldHZhbCAhPSAwKSkKKyAgICByZXR1cm4gcmV0dmFsOworICBl
bHNlCisgICAgbXR4ID0gTlVMTDsKKworICBjbnQgPSAwOworICBjeWMgPSAw
OworICB3dCA9IDA7CisKKyAgcmV0dXJuIDA7Cit9CisKKworZXh0ZXJuICJD
IgoraW50CitwdGhyZWFkX2JhcnJpZXJfd2FpdCAocHRocmVhZF9iYXJyaWVy
X3QgKiBiYXIpCit7CisgIGlmIChVTkxJS0VMWSAoISBwdGhyZWFkX2JhcnJp
ZXI6OmlzX2dvb2Rfb2JqZWN0IChiYXIpKSkKKyAgICByZXR1cm4gRUlOVkFM
OworCisgIHJldHVybiAoKmJhciktPndhaXQgKCk7Cit9CisKKworaW50Citw
dGhyZWFkX2JhcnJpZXI6OndhaXQgKCkKK3sKKyAgaW50IHJldHZhbCA9IHB0
aHJlYWRfbXV0ZXhfbG9jayAoJm10eCk7CisgIGlmIChVTkxJS0VMWSAocmV0
dmFsICE9IDApKQorICAgIHJldHVybiByZXR2YWw7CisKKyAgaWYgKFVOTElL
RUxZICh3dCA+PSBjbnQpKQorICAgIHsKKyAgICAgIGFwaV9mYXRhbCAoInd0
ID49IGNudCAoJXUgPj0gJXUpIiwgd3QsIGNudCk7CisgICAgICByZXR1cm4g
RUlOVkFMOworICAgIH0KKworICBpZiAoVU5MSUtFTFkgKCsrd3QgPT0gY250
KSkKKyAgICB7CisgICAgICArK2N5YzsKKyAgICAgIC8qIFRoaXMgaXMgdGhl
IGxhc3QgdGhyZWFkIHRvIHJlYWNoIHRoZSBiYXJyaWVyLiBTaWduYWwgdGhl
IHdhaXRpbmcKKyAgICAgICAgIHRocmVhZHMgdG8gd2FrZSB1cCBhbmQgY29u
dGludWUuICAqLworICAgICAgcmV0dmFsID0gcHRocmVhZF9jb25kX2Jyb2Fk
Y2FzdCAoJmNvbmQpOworICAgICAgaWYgKFVOTElLRUxZIChyZXR2YWwgIT0g
MCkpCisgICAgICAgIGdvdG8gY29uZF9lcnJvcjsKKworICAgICAgd3QgPSAw
OworICAgICAgcmV0dmFsID0gcHRocmVhZF9tdXRleF91bmxvY2sgKCZtdHgp
OworICAgICAgaWYgKFVOTElLRUxZIChyZXR2YWwgIT0gMCkpCisgICAgICAg
IGFib3J0ICgpOworCisgICAgICByZXR1cm4gUFRIUkVBRF9CQVJSSUVSX1NF
UklBTF9USFJFQUQ7CisgICAgfQorICBlbHNlCisgICAgeworICAgICAgdWlu
dDY0X3QgY3ljbGUgPSBjeWM7CisgICAgICBkbworICAgICAgICB7CisgICAg
ICAgICAgcmV0dmFsID0gcHRocmVhZF9jb25kX3dhaXQgKCZjb25kLCAmbXR4
KTsKKyAgICAgICAgICBpZiAoVU5MSUtFTFkgKHJldHZhbCAhPSAwKSkKKyAg
ICAgICAgICAgIGdvdG8gY29uZF9lcnJvcjsKKyAgICAgICAgfQorICAgICAg
d2hpbGUgKFVOTElLRUxZIChjeWNsZSA9PSBjeWMpKTsKKworICAgICAgcmV0
dmFsID0gcHRocmVhZF9tdXRleF91bmxvY2sgKCZtdHgpOworICAgICAgaWYg
KFVOTElLRUxZIChyZXR2YWwgIT0gMCkpCisgICAgICAgIGFwaV9mYXRhbCAo
InB0aHJlYWRfbXV0ZXhfdW5sb2NrICglcCkgPSAlZCIsICZtdHgsIHJldHZh
bCk7CisKKyAgICAgIHJldHVybiAwOworICAgIH0KKworIGNvbmRfZXJyb3I6
CisgIHsKKyAgICAtLXd0OworICAgIGludCByZXQgPSBwdGhyZWFkX211dGV4
X3VubG9jayAoJm10eCk7CisgICAgaWYgKFVOTElLRUxZIChyZXQgIT0gMCkp
CisgICAgICAgIGFwaV9mYXRhbCAoInB0aHJlYWRfbXV0ZXhfdW5sb2NrICgl
cCkgPSAlZCIsICZtdHgsIHJldCk7CisKKyAgICByZXR1cm4gcmV0dmFsOwor
ICB9Cit9CmRpZmYgLS1naXQgYS93aW5zdXAvY3lnd2luL3RocmVhZC5oIGIv
d2luc3VwL2N5Z3dpbi90aHJlYWQuaAppbmRleCBhNmM3MzU4Li5mN2JjZTE4
IDEwMDY0NAotLS0gYS93aW5zdXAvY3lnd2luL3RocmVhZC5oCisrKyBiL3dp
bnN1cC9jeWd3aW4vdGhyZWFkLmgKQEAgLTEsMyArMSw0IEBACisvLyAtKi0g
QysrIC0qLQogLyogdGhyZWFkLmg6IExvY2tpbmcgYW5kIHRocmVhZGluZyBt
b2R1bGUgZGVmaW5pdGlvbnMKIAogICAgQ29weXJpZ2h0IDE5OTgsIDE5OTks
IDIwMDAsIDIwMDEsIDIwMDIsIDIwMDMsIDIwMDQsIDIwMDUsIDIwMDcsIDIw
MDgsIDIwMDksCkBAIC04NCw2ICs4NSw4IEBAIGNsYXNzIHBpbmZvOwogI2Rl
ZmluZSBQVEhSRUFEX1JXTE9DS19NQUdJQyBQVEhSRUFEX01BR0lDKzkKICNk
ZWZpbmUgUFRIUkVBRF9SV0xPQ0tBVFRSX01BR0lDIFBUSFJFQURfTUFHSUMr
MTAKICNkZWZpbmUgUFRIUkVBRF9TUElOTE9DS19NQUdJQyBQVEhSRUFEX01B
R0lDKzExCisjZGVmaW5lIFBUSFJFQURfQkFSUklFUl9NQUdJQyBQVEhSRUFE
X01BR0lDKzEyCisjZGVmaW5lIFBUSFJFQURfQkFSUklFUkFUVFJfTUFHSUMg
UFRIUkVBRF9NQUdJQysxMwogCiAjZGVmaW5lIE1VVEVYX09XTkVSX0FOT05Z
TU9VUyAoKHB0aHJlYWRfdCkgLTEpCiAKQEAgLTUyMCw2ICs1MjMsMzggQEAg
cHJpdmF0ZToKICAgc3RhdGljIGZhc3RfbXV0ZXggY29uZF9pbml0aWFsaXph
dGlvbl9sb2NrOwogfTsKIAorCitjbGFzcyBwdGhyZWFkX2JhcnJpZXJhdHRy
OiBwdWJsaWMgdmVyaWZ5YWJsZV9vYmplY3QKK3sKK3B1YmxpYzoKKyAgc3Rh
dGljIGJvb2wgaXNfZ29vZF9vYmplY3QocHRocmVhZF9iYXJyaWVyYXR0cl90
IGNvbnN0ICopOworICBpbnQgc2hhcmVkOworCisgIHB0aHJlYWRfYmFycmll
cmF0dHIgKCk7CisgIH5wdGhyZWFkX2JhcnJpZXJhdHRyICgpOworfTsKKwor
CitjbGFzcyBwdGhyZWFkX2JhcnJpZXI6IHB1YmxpYyB2ZXJpZnlhYmxlX29i
amVjdAoreworcHVibGljOgorICBzdGF0aWMgYm9vbCBpc19nb29kX29iamVj
dChwdGhyZWFkX2JhcnJpZXJfdCBjb25zdCAqKTsKKworICBwdGhyZWFkX211
dGV4X3QgbXR4OyAvKiBNdXRleCBwcm90ZWN0aW5nIGV2ZXJ5dGhpbmcgYmVs
b3cuICovCisgIHB0aHJlYWRfY29uZF90IGNvbmQ7IC8qIENvbmRpdGlvbmFs
IHZhcmlhYmxlIHRvIHdhaXQgb24uICovCisgIHVuc2lnbmVkIGNudDsgLyog
QmFycmllciBjb3VudC4gVGhyZWFkcyB0byB3YWl0IGZvci4gKi8KKyAgdWlu
dDY0X3QgY3ljOyAvKiBDeWNsZSBjb3VudC4gKi8KKyAgdW5zaWduZWQgd3Q7
IC8qIEFscmVhZHkgd2FpdGluZyB0aHJlYWRzIGNvdW50LiAqLworCisgIGlu
dCBpbml0IChjb25zdCBwdGhyZWFkX2JhcnJpZXJhdHRyX3QgKiwgdW5zaWdu
ZWQpOworICBpbnQgd2FpdCgpOworICBpbnQgZGVzdHJveSAoKTsKKworICBw
dGhyZWFkX2JhcnJpZXIgKCk7CisgIH5wdGhyZWFkX2JhcnJpZXIgKCk7Cit9
OworCisKIGNsYXNzIHB0aHJlYWRfcndsb2NrYXR0cjogcHVibGljIHZlcmlm
eWFibGVfb2JqZWN0CiB7CiBwdWJsaWM6Cg==

--------------040805060600040109030903--

--hm0N22c5xLji04RVTDHEajmvLK0kmEtIb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-length: 213

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iF4EAREKAAYFAla9sh8ACgkQlv+b6dkC1zbRHwD/Zb50g8FaPMv8sYT5wQUWE1Xp
B5JG7+zgZj83FqpKmf0BAKt5J/+z+m5srweir7weUQZmZkXhOHWfy+ZTNAl7fOCm
=XeYp
-----END PGP SIGNATURE-----

--hm0N22c5xLji04RVTDHEajmvLK0kmEtIb--
