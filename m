From: egor duda <deo@logos-m.ru>
To: "Robert Collins" <robert.collins@itdomain.com.au>
Cc: cygwin-patches@cygwin.com
Subject: Re: PTHREAD_COND_INITIALIZER support
Date: Thu, 15 Nov 2001 03:26:00 -0000
Message-ID: <17285934467.20011115142602@logos-m.ru>
References: <EA18B9FA0FE4194AA2B4CDB91F73C0EF08F28E@itdomain002.itdomain.net.au> <92602986318.20011109105819@logos-m.ru>
X-SW-Source: 2001-q4/msg00224.html
Message-ID: <20011115032600.r5RGrxkKNmkQ-INdCr6TrrJNsPMayxt_33ccBlmelZo@z>

Hi!

Friday, 09 November, 2001 egor duda deo@logos-m.ru wrote:

ed> well, since it's "feature added" rather than "bug fixed" kind of patch
ed> i think it should wait after 1.3.5 release.

done.

RC>> Have you got a test case for pthread_cond_initializer support
RC>> currently?

ed> yes. i'm going to add a bunch of pthread tests after this checkin.

done too.

Robert, can you please take a look at winsup.api/pthread/condvar3_1.c
test? it looks like when condition variable is signalled, two threads
wake on it instead of one. it's quite stable effect, so i don't think
we have a race here.

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19
