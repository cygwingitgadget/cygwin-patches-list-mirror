Return-Path: <cygwin-patches-return-7571-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27456 invoked by alias); 23 Dec 2011 21:38:22 -0000
Received: (qmail 27444 invoked by uid 22791); 23 Dec 2011 21:38:21 -0000
X-SWARE-Spam-Status: No, hits=-1.0 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW
X-Spam-Check-By: sourceware.org
Received: from mail-wi0-f171.google.com (HELO mail-wi0-f171.google.com) (209.85.212.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 23 Dec 2011 21:38:09 +0000
Received: by wico1 with SMTP id o1so4111440wic.2        for <cygwin-patches@cygwin.com>; Fri, 23 Dec 2011 13:38:07 -0800 (PST)
MIME-Version: 1.0
Received: by 10.180.93.193 with SMTP id cw1mr1455767wib.5.1324676287958; Fri, 23 Dec 2011 13:38:07 -0800 (PST)
Received: by 10.227.165.4 with HTTP; Fri, 23 Dec 2011 13:38:07 -0800 (PST)
In-Reply-To: <20111220153404.GF23547@calimero.vinschen.de>
References: <CAL-4N9uVjoqNTXPQGvsjnT+q=KJx9_QNzT-m8U_K=46+zOyheQ@mail.gmail.com>	<20111205101715.GA13067@calimero.vinschen.de>	<CAL-4N9sx=asy0r3fcD65=WfvW0VHByv-Hn0CAJgaAFK3C8Vw_Q@mail.gmail.com>	<CAL-4N9v8QU-mZfE-4gtpjtybD8A1BYt8QJNGAHOOHv25fkF0Mg@mail.gmail.com>	<20111219155948.GA7148@calimero.vinschen.de>	<CAL-4N9tALgoad1K+BKH3UoC4_viooeyt9KNHAxm1kwHWw8KcEw@mail.gmail.com>	<20111220153404.GF23547@calimero.vinschen.de>
Date: Fri, 23 Dec 2011 21:38:00 -0000
Message-ID: <CAL-4N9tGWAK7nnGqcRMOgS8CTJoh7-nmrbinGndwxUEy5L-q2Q@mail.gmail.com>
Subject: Re: Add support for creating native windows symlinks
From: Russell Davis <russell.davis@gmail.com>
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
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
X-SW-Source: 2011-q4/txt/msg00061.txt.bz2

Sigh... I've already addressed all of these ponts (there are simple
ways to handle to all of them). I'm done fighting this battle.

Happy Festivus!


>> Huh? I think you're not fully understanding my suggested approach. As
>> I pointed out in my previous message, it should be 100%, fully usable
>> in the POSIX environment. Again: any path that might be problematic as
>> a Win32 path can just be stored as a POSIX path, and would fall into
>> the bucket of "works inside cygwin but not outside".
>
> How are you going to check the difference?
>
> Btw., you can write the Win32 and the POSIX path into the reparse point
> since the reparse data buffer contains two strings, the so called
> SubstituteName and the so called PrintName. =A0SubstituteName is the
> native NT path which is used internally to resolve the path, the
> PrintName is used by CMD or Explorer for printing purposes. =A0If you put
> the POSIX path into PrintName, CMD shows the POSIX path and Explorer
> shows an empty string as target location. =A0Of course you can't do that
> using the CreateSymbolicLink call.
>
> However, how do you make sure that the file vs directory flag is set
> correctly, given that the file or directory doesn't have to exist at the
> time the symlink gets created? =A0Neither CMD nor Explorer handle this
> situation gracefully.
>
> How do you handle the fact that remote symlinks only work if certain
> settings are made (fsutil)? =A0And how do you handle the situation that
> native symlinks don't work on pre-Vista machines, which also makes them
> unsuitable for remote shares? =A0Some symlinks on a share are created this
> way and some symlinks are created that way and depending on the machine
> from where you try to access them they are usable or not.
>
> As I said, I experimented a lot with native symlinks in the past and one
> way or the other they don't quite work as expected. =A0I'm not overly keen
> to support writing them. =A0The hassle with the required
> SE_CREATE_SYMBOLIC_LINK_NAME privilege, the extra hassle that they don't
> work on remote drives without explicitely enabling them via fsutil, the
> fact that remote pre-Vista machines don't get them transparently
> translated at all, the nonsense with the file/directory flag... =A0I'm
> quite content to read them in Cygwin on a local drive but otherwise
> leave them alone. =A0for those who really want them there are tools out
> there to create them, but in these cases the tool provider has to take
> the support burden.
>
>
> Corinna
