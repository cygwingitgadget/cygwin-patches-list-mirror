Return-Path: <SRS0=VUiZ=CW=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from dmta1009.nifty.com (mta-snd01012.nifty.com [106.153.227.44])
	by sourceware.org (Postfix) with ESMTPS id 153883858D35
	for <cygwin-patches@cygwin.com>; Tue,  4 Jul 2023 09:58:13 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 153883858D35
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from HP-Z230 by dmta1009.nifty.com with ESMTP
          id <20230704095811825.CCZW.19111.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 4 Jul 2023 18:58:11 +0900
Date: Tue, 4 Jul 2023 18:58:11 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: dtable: Delete old kludge code for /dev/tty.
Message-Id: <20230704185811.484bec81a144b726c0b54e25@nifty.ne.jp>
In-Reply-To: <ZKKoaQlqEXjBjNV7@calimero.vinschen.de>
References: <20230627132826.9321-1-takashi.yano@nifty.ne.jp>
	<ZKKoaQlqEXjBjNV7@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.3 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Corinna,

Thanks for reviewing the patch.

On Mon, 3 Jul 2023 12:52:25 +0200
Corinna Vinschen wrote:
> Hi Takashi,
> 
> On Jun 27 22:28, Takashi Yano wrote:
> > This old kludge code assigns fhandler_console for /dev/tty even
> > if the CTTY is not a console when stat() has been called. Due to
> > this, the problem reported in
> > https://cygwin.com/pipermail/cygwin/2023-June/253888.html
> > occurs after the commit 3721a756b0d8 ("Cygwin: console: Make the
> > console accessible from other terminals.").
> > 
> > This patch fixes the issue by dropping the old kludge code.
> > 
> > Reported-by: Bruce Jerrick <bmj001@gmail.com>
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> 
> Please add a "Fixes:" tag line.
> 
> > ---
> >  winsup/cygwin/dtable.cc | 7 +------
> >  1 file changed, 1 insertion(+), 6 deletions(-)
> > 
> > diff --git a/winsup/cygwin/dtable.cc b/winsup/cygwin/dtable.cc
> > index 18e0f3097..9427e238e 100644
> > --- a/winsup/cygwin/dtable.cc
> > +++ b/winsup/cygwin/dtable.cc
> > @@ -598,12 +598,7 @@ fh_alloc (path_conv& pc)
> >  	  fh = cnew (fhandler_mqueue);
> >  	  break;
> >  	case FH_TTY:
> > -	  if (!pc.isopen ())
> > -	    {
> > -	      fhraw = cnew_no_ctor (fhandler_console, -1);
> > -	      debug_printf ("not called from open for /dev/tty");
> > -	    }
> 
> This is ok-ish.  The problem is that the original patch 23771fa1f7028
> does not explain *why* it assigned a console fhandler if the file is not
> open.  Given that, it's not clear what side-effects we might encounter
> if we change this.  Do you understand the situation here can you explain
> why dropping this kludge will do the right thing now?  If so, it would
> be great to have a good description of the original idea behind the
> code and why we don't need it anymore in the commit message.

I am not really sure the reason why the kludge code was needed.
However, I noticed stat() fails before the commit 6ae28c22639d
without the kludge code if the program calls setsid(). After the
commit 6ae28c22639d, this does not happen. Therefore, I think
this kludge code is no longer necessary.

I will submit v2 patch where the commit message is updated.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
