Return-Path: <SRS0=MpmZ=CZ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from dmta0020.nifty.com (mta-snd00013.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:2d])
	by sourceware.org (Postfix) with ESMTPS id 3433D3858D38
	for <cygwin-patches@cygwin.com>; Fri,  7 Jul 2023 03:30:23 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3433D3858D38
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from HP-Z230 by dmta0020.nifty.com with ESMTP
          id <20230707033021001.TYZT.104723.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Fri, 7 Jul 2023 12:30:21 +0900
Date: Fri, 7 Jul 2023 12:30:21 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: dtable: Delete old kludge code for /dev/tty.
Message-Id: <20230707123021.f125d63930f89b0416a430d5@nifty.ne.jp>
In-Reply-To: <2346de89-b679-4463-1937-61e1f9f76c51@gmx.de>
References: <20230627132826.9321-1-takashi.yano@nifty.ne.jp>
	<ZKKoaQlqEXjBjNV7@calimero.vinschen.de>
	<20230704185811.484bec81a144b726c0b54e25@nifty.ne.jp>
	<2346de89-b679-4463-1937-61e1f9f76c51@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.4 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 4 Jul 2023 17:59:41 +0200 (CEST)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> On Tue, 4 Jul 2023, Takashi Yano wrote:
> 
> > On Mon, 3 Jul 2023 12:52:25 +0200
> > Corinna Vinschen wrote:
> > >
> > > On Jun 27 22:28, Takashi Yano wrote:
> > > >
> > > > diff --git a/winsup/cygwin/dtable.cc b/winsup/cygwin/dtable.cc
> > > > index 18e0f3097..9427e238e 100644
> > > > --- a/winsup/cygwin/dtable.cc
> > > > +++ b/winsup/cygwin/dtable.cc
> > > > @@ -598,12 +598,7 @@ fh_alloc (path_conv& pc)
> > > >  	  fh = cnew (fhandler_mqueue);
> > > >  	  break;
> > > >  	case FH_TTY:
> > > > -	  if (!pc.isopen ())
> > > > -	    {
> > > > -	      fhraw = cnew_no_ctor (fhandler_console, -1);
> > > > -	      debug_printf ("not called from open for /dev/tty");
> > > > -	    }
> > >
> > > This is ok-ish.  The problem is that the original patch 23771fa1f7028
> > > does not explain *why* it assigned a console fhandler if the file is not
> > > open.  Given that, it's not clear what side-effects we might encounter
> > > if we change this.  Do you understand the situation here can you explain
> > > why dropping this kludge will do the right thing now?  If so, it would
> > > be great to have a good description of the original idea behind the
> > > code and why we don't need it anymore in the commit message.
> >
> > I am not really sure the reason why the kludge code was needed.
> > However, I noticed stat() fails before the commit 6ae28c22639d
> > without the kludge code if the program calls setsid(). After the
> > commit 6ae28c22639d, this does not happen. Therefore, I think
> > this kludge code is no longer necessary.
> 
> FWIW this is the exact kind of issue I keep pointing out with these commit
> messages.
> 
> It is quite often totally unclear what the issues are, there are sometimes
> links to threads where one could potentially go and hunt and guess what
> the outcome of that discussion was.
> 
> And more often than not, these commit messages talk vaguely about "This
> fixes the issue by dropping a kludge" or something similar, instead of
> giving a clear and comprehensive description as to what the problem is,
> why the code was faulty, what is done instead, and what alternatives were
> considered and the reasons why they were rejected.
> 
> This leaves a lot of room for improvement without which we're prone to
> repeat these increasingly frustrating exchanges.
> 
> Once again, I would highly recommend to read
> https://github.blog/2022-06-30-write-better-commits-build-better-projects/
> and craft commit messages based on the provided guidance. I promise you
> that you will no longer have to say "I am not really sure the reason why
> the kludge code was needed", like, ever again, if you follow that
> article's advice.

Thanks for the advice. I will keep your adivce in mind.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
