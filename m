Return-Path: <cygwin-patches-return-7053-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20710 invoked by alias); 3 Aug 2010 08:11:27 -0000
Received: (qmail 20694 invoked by uid 22791); 3 Aug 2010 08:11:26 -0000
X-SWARE-Spam-Status: No, hits=-0.6 required=5.0	tests=BAYES_00,RCVD_IN_RP_RNBL,T_RP_MATCHES_RCVD
X-Spam-Check-By: sourceware.org
Received: from service2.sh.cvut.cz (HELO service2.sh.cvut.cz) (147.32.127.218)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 03 Aug 2010 08:11:21 +0000
Received: from localhost (localhost [127.0.0.1])	by service2.sh.cvut.cz (Postfix) with ESMTP id 374FE13A20F;	Tue,  3 Aug 2010 10:11:19 +0200 (CEST)
Received: from service2.sh.cvut.cz ([127.0.0.1])	by localhost (service2.sh.cvut.cz [127.0.0.1]) (amavisd-new, port 10024)	with ESMTP id 14994-07; Tue, 3 Aug 2010 10:10:47 +0200 (CEST)
Received: from shell.sh.cvut.cz (shell.sh.cvut.cz [IPv6:2001:718:2::212])	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))	(No client certificate requested)	by service2.sh.cvut.cz (Postfix) with ESMTP id 8867713A20E;	Tue,  3 Aug 2010 10:10:41 +0200 (CEST)
Received: by shell.sh.cvut.cz (Postfix, from userid 50017)	id 4D7D2B839; Tue,  3 Aug 2010 10:10:41 +0200 (CEST)
To: =?UTF-8?Q?V=C3=A1clav_Haisman?= <v.haisman@sh.cvut.cz>
Subject: Re: [PATCH] POSIX monotonic clock
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Aug 2010 08:11:00 -0000
From: =?UTF-8?Q?V=C3=A1clav_Haisman?= <v.haisman@sh.cvut.cz>
Cc: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>,	cygwin-patches <cygwin-patches@cygwin.com>
In-Reply-To: <e9a284aade1fca8f1132eb866f4f7224@shell.sh.cvut.cz>
References: <1280782148.6756.81.camel@YAAKOV04> <e9a284aade1fca8f1132eb866f4f7224@shell.sh.cvut.cz>
Message-ID: <c390af91f3ff4d6725d2dc5268b8776b@shell.sh.cvut.cz>
X-Sender: v.haisman@sh.cvut.cz
User-Agent: RoundCube Webmail/0.4-beta
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q3/txt/msg00013.txt.bz2

On Tue, 03 Aug 2010 09:32:47 +0200, V=C3=A1clav Haisman
wrote:
> On Mon, 02 Aug 2010 15:49:08 -0500, "Yaakov (Cygwin/X)" wrote:
>> Here is an attempt to implement POSIX.1-2004+ Monotonic Clock:
>>=20
>>
>
http://www.opengroup.org/onlinepubs/9699919799/functions/clock_getres.html
>>=20
>> In summary, I took hires_us and changed the resolution to nanoseconds.
I
>> dropped systime() because the only place hires_us was being used is in
>> strace.cc which ignored it, and WRT POSIX monotonic clocks the absolute
>> value of the clock is meaningless.  Since systime() has only 100ns
>> precision, using it would either force a loss in resolution or (if
>> multiplied by 100 to get ns) an early overflow.  I also switched from
>> ENOSYS to EINVAL, as POSIX.1-2004 and 2008 dropped references to the
>> former (as noted in Change History).
>>=20
>> Patches for newlib, winsup/cygwin and winsup/doc attached.
>>=20
>> I have also attached an STC for the new functionality.  FWIW, on my
>> machine, QueryPerformanceFrequency() returns just over 2.9 million,
>> resulting in a clock_getres(CLOCK_MONOTONIC) of 340ns.
>>=20
>> I would appreciate a careful review of this patch, both from the Cygwin
>> API and POSIX POVs.
> Is it really ok to use QueryPerformanceCounter() to implement this?
Quote
> from <http://msdn.microsoft.com/en-us/library/ms644904%28VS.85%29.aspx>:
>=20
> "On a multiprocessor computer, it should not matter which processor is
> called. However, you can get different results on different processors
due
> to bugs in the basic input/output system (BIOS) or the hardware
abstraction
> layer (HAL). To specify processor affinity for a thread, use the
> SetThreadAffinityMask function."
>=20
> This looks like you could get monotonic clock going backwards.
See also <http://www.virtualdub.org/blog/pivot/entry.php?id=3D106>.

--=20
VH
