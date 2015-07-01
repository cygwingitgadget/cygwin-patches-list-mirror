Return-Path: <cygwin-patches-return-8220-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 125310 invoked by alias); 1 Jul 2015 10:59:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 125300 invoked by uid 89); 1 Jul 2015 10:59:56 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.7 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2
X-HELO: mail-ig0-f170.google.com
Received: from mail-ig0-f170.google.com (HELO mail-ig0-f170.google.com) (209.85.213.170) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Wed, 01 Jul 2015 10:59:55 +0000
Received: by igrv9 with SMTP id v9so32005763igr.1        for <cygwin-patches@cygwin.com>; Wed, 01 Jul 2015 03:59:53 -0700 (PDT)
MIME-Version: 1.0
X-Received: by 10.50.61.241 with SMTP id t17mr4007505igr.34.1435748393468; Wed, 01 Jul 2015 03:59:53 -0700 (PDT)
Received: by 10.36.77.15 with HTTP; Wed, 1 Jul 2015 03:59:53 -0700 (PDT)
Reply-To: noloader@gmail.com
In-Reply-To: <20150701082901.GA7902@calimero.vinschen.de>
References: <CAH8yC8mUrhuR2vPhqSSLKmrA82nW3JhvcRnFVO1nFccy337y_g@mail.gmail.com>	<20150701082901.GA7902@calimero.vinschen.de>
Date: Wed, 01 Jul 2015 10:59:00 -0000
Message-ID: <CAH8yC8mAb_zt9GdyJz=F2wK4fcUsY38Gj4wExxDO2h28TuP5dg@mail.gmail.com>
Subject: Re: Using g++ and -m32 option on x86_64 broken
From: Jeffrey Walton <noloader@gmail.com>
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-SW-Source: 2015-q3/txt/msg00002.txt.bz2

On Wed, Jul 1, 2015 at 4:29 AM, Corinna Vinschen
<corinna-cygwin@cygwin.com> wrote:
> Hi Jeffrey,
>
> On Jun 30 21:38, Jeffrey Walton wrote:
>> Cygwin's GCC responds to the -m32 option, but it causes a compile error:
>>
>>    expected unqualified-id before =E2=80=98__int128=E2=80=99
>>        inline __int128
>>
>> If the project does not support the -m32 option, then it should be
>> removes so that using it causes a compile error.
>>
>> Below is the changed needed to get through the compile with -m32:
>>
>> $ diff /usr/lib/gcc/x86_64-pc-cygwin/4.9.2/include/c++/x86_64-pc-cygwin/=
bits/c++config.h
>> /usr/lib/gcc/x86_64-pc-cygwin/4.9.2/include/c++/x86_64-pc-cygwin/bits/c+=
+config.h.bu
>> 1306,1308c1306
>> < #ifndef __CYGWIN32__      /* -m32 used on x86_64 */
>> < # define _GLIBCXX_USE_INT128 1
>> < #endif
>> ---
>> > #define _GLIBCXX_USE_INT128 1
>>
>> ************
>
> Wrong mailing list.  cygwin-patches is for patches to the Cygwin
> sources, not patches to arbitrary packages in the Cygwin distro.
> See https://cygwin.com/lists.html

Yes, you got a patch.

> If you want to reach out to Cygwin package maintainers [GCC maintainer
> BCCed], use the cygwin AT cygwin DOT com mailing list.  If you want to
> report the bug to the GCC folks, see https://gcc.gnu.org/bugs/

No, I used Cygwin's package, and that makes it Cygwin's problem.

>> And this project really needs a bug tracker...
>
> As for -m32, it's not supported for a reason.

No, GCC responds to it. If you don't support it, then take it out and
produce a compile error.

Jeff
