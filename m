Return-Path: <cygwin-patches-return-7410-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19152 invoked by alias); 29 May 2011 04:38:16 -0000
Received: (qmail 18787 invoked by uid 22791); 29 May 2011 04:38:12 -0000
X-SWARE-Spam-Status: No, hits=-2.7 required=5.0	tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RFC_ABUSE_POST,T_TO_NO_BRKTS_FREEMAIL
X-Spam-Check-By: sourceware.org
Received: from mail-pz0-f43.google.com (HELO mail-pz0-f43.google.com) (209.85.210.43)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 29 May 2011 04:37:57 +0000
Received: by pzk1 with SMTP id 1so1530058pzk.2        for <cygwin-patches@cygwin.com>; Sat, 28 May 2011 21:37:57 -0700 (PDT)
Received: by 10.68.21.231 with SMTP id y7mr1451970pbe.493.1306643876962;        Sat, 28 May 2011 21:37:56 -0700 (PDT)
Received: from [192.168.1.2] (c-24-18-179-193.hsd1.wa.comcast.net [24.18.179.193])        by mx.google.com with ESMTPS id k4sm1798493pbl.75.2011.05.28.21.37.55        (version=TLSv1/SSLv3 cipher=OTHER);        Sat, 28 May 2011 21:37:55 -0700 (PDT)
Message-ID: <4DE1CD9D.20608@gmail.com>
Date: Sun, 29 May 2011 04:38:00 -0000
From: Daniel Colascione <dan.colascione@gmail.com>
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Problems with: Improvements to fork handling (2/5)
References: <4DCAD609.70106@cs.utoronto.ca> <20110528205000.GA30326@ednor.casa.cgf.cx> <4DE179DE.8040008@cs.utoronto.ca> <20110529002317.GA31865@ednor.casa.cgf.cx> <4DE1B101.4000603@cs.utoronto.ca>
In-Reply-To: <4DE1B101.4000603@cs.utoronto.ca>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="------------enig6FD0A0E4C1D19F030B1E5AE1"
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
X-SW-Source: 2011-q2/txt/msg00176.txt.bz2

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6FD0A0E4C1D19F030B1E5AE1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-length: 3310

On 5/28/11 7:35 PM, Ryan Johnson wrote:
> On 28/05/2011 8:23 PM, Christopher Faylor wrote:
>> On Sat, May 28, 2011 at 06:40:30PM -0400, Ryan Johnson wrote:
>>> On 28/05/2011 4:50 PM, Christopher Faylor wrote:
>>>> On Wed, May 11, 2011 at 02:31:37PM -0400, Ryan Johnson wrote:
>>>>> This patch has the parent sort its dll list topologically by
>>>>> dependencies. Previously, attempts to load a DLL_LOAD dll risked
>>>>> pulling
>>>>> in dependencies automatically, and the latter would then not benefit
>>>> >from the code which "encourages" them to land in the right places. The
>>>>> dependency tracking is achieved using a simple class which allows to
>>>>> introspect a mapped dll image and pull out the dependencies it lists.
>>>>> The code currently rebuilds the dependency list at every fork rather
>>>>> than attempt to update it properly as modules are loaded and unloaded.
>>>>> Note that the topsort optimization affects only cygwin dlls, so any
>>>>> windows dlls which are pulled in dynamically (directly or indirectly)
>>>>> will still impose the usual risk of address space clobbers.
>>>> Bad news.
>>>>
>>>> I applied this patch and the one after it but then noticed that zsh
>>>> started
>>>> producing:  "bad address: " errors.
>>>>
>>>> path:4: bad address: /share/bin/dopath
>>>> term:1: bad address: /bin/tee
>>>>
>>>> The errors disappear when I back this patch out.
>>>>
>>>> FWIW, I was running "zsh -l".  I have somewhat complicated
>>>> .zshrc/.zlogin/.zshenv files.  I'll post them if needed.
>>>>
>>>> Until this is fixed, this patch and the subsequent ones which rely on
>>>> it, can't go in.  I did commit this fix but it has been backed out now.
>>> Hmm. I also see bad address errors in bash sometimes. However, when I
>>> searched through the cygwin mailing list archives I saw that other
>>> people have reported this problem in the past [1], so I figured it was
>>> some existing, sporadic issue rather than my patch...
>>>
>>> Could you tell me what a 'bad address' error is? I'd be happy to debug
>>> this, but really don't know what kind of bug I'm hunting here, except
>>> that it might be a problem wow64 and suspending threads [2]. Whatever
>>> became of these bad address errors the last time(s) they cropped up? I
>>> can't find any resolution with Google, at least.
>> If I had any insight beyond "It works without the patch and it doesn't
>> work with it" I would have shared it.

> Let me rephrase a bit... The error happens too early in fork for gdb to
> be any help, and I was hoping you could tell me what part(s) of cygwin
> are capable of "raising" this error -- it seems to be a linux (not
> Windows) flavor of error message, but the case-insensitive regexp
> 'bad.address' does not match anything in the cygwin sources.

The actual string is in strerror.c in newlib, which is why you didn't
find it with a grep on winsup/cygwin. The error code is EFAULT. There
are 127 places in the cygwin1.dll where EFAULT can raised, according to
grep '\bEFAULT\b' *.cc. In most of them, EFAULT is raised after
something called san has detected that to Windows raised an unexpected
structured exception. My hunch would be to look in spawn.cc first, in
spawn_guts, but I haven't read your patch in enough detail to narrow the
problem down further. strace might be handy.


--------------enig6FD0A0E4C1D19F030B1E5AE1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-length: 195

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (Darwin)

iEYEARECAAYFAk3hzaAACgkQ17c2LVA10VucDgCfYqUClV2jZiz/6xphs+Ihn28M
s64An3Awg32c0pPUE0P7ad+sAq3u+/sq
=pMr5
-----END PGP SIGNATURE-----

--------------enig6FD0A0E4C1D19F030B1E5AE1--
