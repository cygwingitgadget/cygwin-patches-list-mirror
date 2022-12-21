Return-Path: <SRS0=tR/4=4T=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com [210.131.2.83])
	by sourceware.org (Postfix) with ESMTPS id 2D0793858D1E
	for <cygwin-patches@cygwin.com>; Wed, 21 Dec 2022 10:24:07 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 2D0793858D1E
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from HP-Z230 (aj135041.dynamic.ppp.asahi-net.or.jp [220.150.135.41]) (authenticated)
	by conssluserg-04.nifty.com with ESMTP id 2BLANcjh014440
	for <cygwin-patches@cygwin.com>; Wed, 21 Dec 2022 19:23:38 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 2BLANcjh014440
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
	s=dec2015msa; t=1671618218;
	bh=ffIuB+GnByqlU/k16cyupR4u+2kpQHczfNI7J+FDMw8=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=lLnLXIUITe6pFHbocPjjInPhsbdK41xla0RrlBRGvnC9MFqQSDIockXo46Gl68lB9
	 NoqaweGWBhHtYt3dDFAHhQEcL4UMF91xUBNHvmSL0M6+guNfdeRxsBUwFvC1vUweYe
	 wj+8/QSdFFziVkuwqoFYSDUJc8KhULjz9kHKLXzDPJ8T3fM9gpXP/xwfiFMS4/TBA0
	 cB9RRH/xbfrv4zyafjlFWPuL7PcGF2CZpJ8wOOjDFFMSStts/Ug8TVIrAZbZFsWLCx
	 2Xb5aMpfVoMjIn0RXQqfxZL09mfnaEOfjblyqyvyaT7JEUp/vbUp4v2JcFQlCXSKmG
	 sZ/Ytl6HSilpA==
X-Nifty-SrcIP: [220.150.135.41]
Date: Wed, 21 Dec 2022 19:23:38 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pinfo: Align CTTY behavior to the statement of
 POSIX.
Message-Id: <20221221192338.bac11d3e2455e6eef19d1c8a@nifty.ne.jp>
In-Reply-To: <Y6H7i5J+C2B179KX@calimero.vinschen.de>
References: <20221220124106.487-1-takashi.yano@nifty.ne.jp>
	<Y6H7i5J+C2B179KX@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 20 Dec 2022 19:14:35 +0100
Corinna Vinschen wrote:
> Hi Takashi,
> 
> On Dec 20 21:41, Takashi Yano wrote:
> > POSIX states "A terminal may be the controlling terminal for at most
> > one session."
> > https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap11.html
> > 
> > However, in cygwin, multiple sessions could be associated with the
> > same TTY. This patch aligns CTTY behavior to the statement of POSIX.
> > 
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > ---
> >  winsup/cygwin/fhandler/termios.cc | 6 +++++-
> >  winsup/cygwin/mm/cygheap.cc       | 2 ++
> >  winsup/cygwin/pinfo.cc            | 4 +++-
> >  3 files changed, 10 insertions(+), 2 deletions(-)
> 
> Do you want to handle this as bug (3.4) or extension (3.5)?

I think this is bug fix (3.4).

> > diff --git a/winsup/cygwin/pinfo.cc b/winsup/cygwin/pinfo.cc
> > index e086ab9a8..749a4064c 100644
> > --- a/winsup/cygwin/pinfo.cc
> > +++ b/winsup/cygwin/pinfo.cc
> > @@ -528,7 +528,9 @@ _pinfo::set_ctty (fhandler_termios *fh, int flags)
> >  {
> >    tty_min& tc = *fh->tc ();
> >    debug_printf ("old %s, ctty device number %y, tc.ntty device number %y flags & O_NOCTTY %y", __ctty (), ctty, tc.ntty, flags & O_NOCTTY);
> > -  if (fh && (ctty <= 0 || ctty == tc.ntty) && !(flags & O_NOCTTY))
> > +  if (tc.getsid () && tc.getsid () != pid)
> > +    ; /* Do not attach if another session already attached to the CTTY. */
> 
> I'm sure I'm missing something, but I'm a bit puzzled about the
> 
>   tc.getsid () != pid
> 
> test here.  If that's not the case, this process is the process group
> leader and already has a controlling tty, isn't it?

You are right. But, it seems that set_cttt() procedure other
than setting pinfo::ctty and cygpeap->ctty is necessary even
in that case. So, I revised the patch. Please see v2 patch.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
