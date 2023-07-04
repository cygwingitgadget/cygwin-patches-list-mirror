Return-Path: <SRS0=st34=CW=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	by sourceware.org (Postfix) with ESMTPS id 153803858D35
	for <cygwin-patches@cygwin.com>; Tue,  4 Jul 2023 15:59:52 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 153803858D35
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1688486383; x=1689091183; i=johannes.schindelin@gmx.de;
 bh=qKe0DJrI+cPGEPZU+MbIExY/bYQKs8DXIZEjSIQCZ0M=;
 h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
 b=j5/xh+O0Y8qkMRqi5w2PYzj8/4Q/NJbzdNJNkpjPrERgfpX64K68pLEtAbkuKI3PnsRN570
 xSrenzoZjm4T64XZEERQwsCYEz2N0AHAHaqDMiPpkr0omwSSRiZXeintg+CAxPwEfGjceUJ++
 E1SPRvKhBVKMOj5DKHuElS9VlUlND4M5Ifx4oeZBK2Lg4M4nalq3l/gjUmrHLl5isTSKZAKa2
 9feIwoIFxF6/odDKQRsO1m1AG0+utaf4A6Sf/Zl0hJJ2puSJvhIUbhL76SMBQ1eawnLXjnBGQ
 Bkn8eCpH0v/s5rKchFSDuUHreOsOwpUSGtFHwX0NQzMCQ7BGBfBA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.221]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N6KYb-1pxJpu0VQn-016eGJ; Tue, 04
 Jul 2023 17:59:43 +0200
Date: Tue, 4 Jul 2023 17:59:41 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: dtable: Delete old kludge code for /dev/tty.
In-Reply-To: <20230704185811.484bec81a144b726c0b54e25@nifty.ne.jp>
Message-ID: <2346de89-b679-4463-1937-61e1f9f76c51@gmx.de>
References: <20230627132826.9321-1-takashi.yano@nifty.ne.jp> <ZKKoaQlqEXjBjNV7@calimero.vinschen.de> <20230704185811.484bec81a144b726c0b54e25@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:WrHN9R8iL4b8vcOZHEkMaFWKpP84FjESAkC/Q2je5zcJznzf4PA
 /77BkTXojPFFerpekYP6k9Uj13hhoQQQkZVtK0NiAh7fCkWN3+EcafA1GHhDh3GjwVqHo+m
 pZKhQHJDqy03NeMvnJhJBnUnLIukOkD3hlGzZSYiuLg74Zyi/SKtX0mmjf6RQ8TVc99vBx6
 +5/mcKPfLdgdjqAbbwa4g==
UI-OutboundReport: notjunk:1;M01:P0:dsYB/7Jplsg=;x86aaQMPrZ9SKPpucF2bEfacQ1K
 c77tK5Kkx0nXMCj2RVxJygSF1sjmGTY5QbxO7btT5bmdylD8F/HI+3meYdhv7S6cF9chjT0df
 yXL1Mq70U4pRcWzgrfbC6X7bB0GOXkeWXB14V8kEeXgv/Lr1uYJkmIlummbx7Io90ACUuQHht
 ZfUrEt4sz1O8mF+MGFKOBNqKB/EJMusJif6yJWVItfDHNYBzU1YKNJKBRPKY4/5PS8lsh6UQA
 uH8f+dsq9F6qe0XBLjZ0n3sGa1sBttdWq5O+zmYYEbehM6A+ktShIMW+Q4Eix4D6dGnpdPDGG
 FbE8SrsUrXH7yIgu7XKggBTsQX9oJs5eRdw8cucOv5I9eJCLlp46J6D0JD5PFIrfU2G/QkGB1
 Y7+1oqcLHPFW2KeLe2OChHLP+bd5GoaJSPGwUy+l1DECeKYgXrC/lBO4cCowujOk/qDVOx+ES
 fu/r9qX7ftfkdRhuu/IAjNcILqlr5AsiY98lgQDnhfVeIumXesghwy3Lq9SHFzUg/wH8V9hNb
 Md2PEOaMS1V84QHv/dp7RJnXe2g9wdteeLYcuGZS46ctPba5jJ8kOsALrdRJbWpc0WQ8obLKB
 sNFLFceIvk3WF6r6MEo8fyB+Ed6Dofnk9SFiYkNf8aIDQqx0oYwIjk27uRTH/UdPbb8Am3Jol
 65qJMDE3UK7GIqqg5x8YmIu1UU2lwM5gHBEgMlROpqGfhctuvDqTdqYuTRzkKzyI2HyUZJbnJ
 Udg+lUWGBsC+TG30pltldJiChanAjwIdgEnU4qA7OGiXWPxZ5vVsLP6dPzmYg2csU6XrZ6zEB
 mk1ouYwBWA40dDs7q/2TzB8w5W+HFSrzcT69qFkuzFwkwUoaL2cHBC8Zdz5Wxz/uymRoyr7+T
 PzDdHQTOqsHAfBwFFImrtk71XuuCYwSM+yPq7sgWFPu5SGZR1lvw//1ZuKJ2ccL3h0r9Di4f/
 Jkpgmdv9w//A8RsFoGxNWuLYong=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Tue, 4 Jul 2023, Takashi Yano wrote:

> On Mon, 3 Jul 2023 12:52:25 +0200
> Corinna Vinschen wrote:
> >
> > On Jun 27 22:28, Takashi Yano wrote:
> > >
> > > diff --git a/winsup/cygwin/dtable.cc b/winsup/cygwin/dtable.cc
> > > index 18e0f3097..9427e238e 100644
> > > --- a/winsup/cygwin/dtable.cc
> > > +++ b/winsup/cygwin/dtable.cc
> > > @@ -598,12 +598,7 @@ fh_alloc (path_conv& pc)
> > >  	  fh =3D cnew (fhandler_mqueue);
> > >  	  break;
> > >  	case FH_TTY:
> > > -	  if (!pc.isopen ())
> > > -	    {
> > > -	      fhraw =3D cnew_no_ctor (fhandler_console, -1);
> > > -	      debug_printf ("not called from open for /dev/tty");
> > > -	    }
> >
> > This is ok-ish.  The problem is that the original patch 23771fa1f7028
> > does not explain *why* it assigned a console fhandler if the file is n=
ot
> > open.  Given that, it's not clear what side-effects we might encounter
> > if we change this.  Do you understand the situation here can you expla=
in
> > why dropping this kludge will do the right thing now?  If so, it would
> > be great to have a good description of the original idea behind the
> > code and why we don't need it anymore in the commit message.
>
> I am not really sure the reason why the kludge code was needed.
> However, I noticed stat() fails before the commit 6ae28c22639d
> without the kludge code if the program calls setsid(). After the
> commit 6ae28c22639d, this does not happen. Therefore, I think
> this kludge code is no longer necessary.

FWIW this is the exact kind of issue I keep pointing out with these commit
messages.

It is quite often totally unclear what the issues are, there are sometimes
links to threads where one could potentially go and hunt and guess what
the outcome of that discussion was.

And more often than not, these commit messages talk vaguely about "This
fixes the issue by dropping a kludge" or something similar, instead of
giving a clear and comprehensive description as to what the problem is,
why the code was faulty, what is done instead, and what alternatives were
considered and the reasons why they were rejected.

This leaves a lot of room for improvement without which we're prone to
repeat these increasingly frustrating exchanges.

Once again, I would highly recommend to read
https://github.blog/2022-06-30-write-better-commits-build-better-projects/
and craft commit messages based on the provided guidance. I promise you
that you will no longer have to say "I am not really sure the reason why
the kludge code was needed", like, ever again, if you follow that
article's advice.

Ciao,
Johannes
