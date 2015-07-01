Return-Path: <cygwin-patches-return-8218-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 73806 invoked by alias); 1 Jul 2015 01:39:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 72843 invoked by uid 89); 1 Jul 2015 01:38:59 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.7 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2
X-HELO: mail-ig0-f173.google.com
Received: from mail-ig0-f173.google.com (HELO mail-ig0-f173.google.com) (209.85.213.173) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Wed, 01 Jul 2015 01:38:59 +0000
Received: by igcsj18 with SMTP id sj18so122276233igc.1        for <cygwin-patches@cygwin.com>; Tue, 30 Jun 2015 18:38:57 -0700 (PDT)
MIME-Version: 1.0
X-Received: by 10.50.30.196 with SMTP id u4mr958584igh.11.1435714737482; Tue, 30 Jun 2015 18:38:57 -0700 (PDT)
Received: by 10.36.77.15 with HTTP; Tue, 30 Jun 2015 18:38:57 -0700 (PDT)
Reply-To: noloader@gmail.com
Date: Wed, 01 Jul 2015 01:39:00 -0000
Message-ID: <CAH8yC8mUrhuR2vPhqSSLKmrA82nW3JhvcRnFVO1nFccy337y_g@mail.gmail.com>
Subject: Using g++ and -m32 option on x86_64 broken
From: Jeffrey Walton <noloader@gmail.com>
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-SW-Source: 2015-q3/txt/msg00000.txt.bz2

Cygwin's GCC responds to the -m32 option, but it causes a compile error:

   expected unqualified-id before =E2=80=98__int128=E2=80=99
       inline __int128

If the project does not support the -m32 option, then it should be
removes so that using it causes a compile error.

Below is the changed needed to get through the compile with -m32:

$ diff /usr/lib/gcc/x86_64-pc-cygwin/4.9.2/include/c++/x86_64-pc-cygwin/bit=
s/c++config.h
/usr/lib/gcc/x86_64-pc-cygwin/4.9.2/include/c++/x86_64-pc-cygwin/bits/c++co=
nfig.h.bu
1306,1308c1306
< #ifndef __CYGWIN32__      /* -m32 used on x86_64 */
< # define _GLIBCXX_USE_INT128 1
< #endif
---
> #define _GLIBCXX_USE_INT128 1

************

And this project really needs a bug tracker...
