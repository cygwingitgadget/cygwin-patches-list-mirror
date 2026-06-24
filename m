Return-Path: <SRS0=3SWy=EU=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w05.mail.nifty.com (mta-snd-w05.mail.nifty.com [106.153.227.37])
	by sourceware.org (Postfix) with ESMTPS id 939834BA2E18
	for <cygwin-patches@cygwin.com>; Wed, 24 Jun 2026 12:12:54 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 939834BA2E18
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 939834BA2E18
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1782303186; cv=none;
	b=DgNepPlcb5Hha67Yta+ac/W2dG164G64aNg0cZjkuP8pCvMKoKt1Tzu40hVYK0W9C6Rg7+RUs4XS8kiZiPZ2cVqtvcC3A/9CUHkxjJM/zagSs93ueAlRhs4z8mubS+qClg5+0RksQsy1TBPdzyde4kwBs87+yydAqPy4RQYrBF8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1782303186; c=relaxed/simple;
	bh=Vc5alNG5xC4CTviXaTNGESqxjd1TwNA6sglV4ug/CaA=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=emsZMczZoiU7KQ16WWGImfjFbAsAs+cZrDkc3IrkvsIFiaR5WfFCAfcglMmfon9qsDdhLSXAkQN1vcm1WOcI7mA14SH2DEBZxwQhT7Rdu75wBma7lDDpVWaHy3YU+tFKu+0eQGa16RIO4Z++GlEtmWTF4gNF9BvFi3dE2rWwSXM=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=dfzwoAxe
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 939834BA2E18
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=dfzwoAxe
Received: from HP-Z230 by mta-snd-w05.mail.nifty.com with ESMTP
          id <20260624121252337.HIZJ.117312.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Wed, 24 Jun 2026 21:12:52 +0900
Date: Wed, 24 Jun 2026 21:12:49 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/3] Cygwin: console: Ensure the master thread runs only
 when it is supposed to
Message-Id: <20260624211249.7d0d817b564cf5ee717e070e@nifty.ne.jp>
In-Reply-To: <88edad1a-5ae6-4ba4-989d-1e26491353bb@maxrnd.com>
References: <20260610163533.10187-1-takashi.yano@nifty.ne.jp>
	<20260610163533.10187-2-takashi.yano@nifty.ne.jp>
	<88edad1a-5ae6-4ba4-989d-1e26491353bb@maxrnd.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1782303172;
 bh=k2SbHFpUMM2mr5+1Nw7cAmPsr13McZk07wyjizGUAwQ=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=dfzwoAxePZZ5bMFK697Nn3VzMynhRoqU+lH45S6RTbf8iPPTtAjH96qhM0lUoUUb0MuSeNFR
 /BnN8YwvCQbrgOt+PdCVNJSx3o+1367HwzqmifmDc01hdA8fGPF5Kg1goulrmUSX87dD8zpE47
 Y4Zib7YNCwQfLyMWvWtKYfvaZNhxW7Za0bb/iBnu+vN9PSiaFrfrhZKjjl9hxIGm0GQsvEGI3I
 Jb2JHVj8hgWHDT3nlBnM3j8bQfovp+j1+CyS+L1l29J3cU238ihFzRLdjtk13uKhZCWAZfJT/h
 Jt7lR+R2DKjjAZDIz/KNMvyp+/Tpy0vjDPzP2qrf5xiPiRyg==
X-Spam-Status: No, score=-12.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Thanks Mark,

On Wed, 24 Jun 2026 01:02:32 -0700
Mark Geisert wrote:
> Hi Takashi,
> 
> On 6/10/2026 9:35 AM, Takashi Yano wrote:
> > Currently, disabling cons_master_thread is done by just setting the
> > flag disable_master_thread. In fact, actual suspension of master
> > thread is delayed a bit. Therefore, non-cygwin program where the
> > master thread should be disabled may run even though the master
> > thread is running in a short time. This patch ensure that the master
> > thread is suspended when non-cygwin app is running. In addition,
> > while master thread is running, console mode should not be changed.
> > Therefore, the order of set_input_mode() call and disabling/enabling
> > master thread is swapped.
> > 
> > Fixes: d2b14c303c04 ("Cygwin: console: Redesign handling of special keys.")
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > Reviewed-by:
> > ---
> >   winsup/cygwin/fhandler/console.cc | 15 +++++++++------
> >   1 file changed, 9 insertions(+), 6 deletions(-)
> > 
> > diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
> > index 45eff6efe..a5e6cd89d 100644
> > --- a/winsup/cygwin/fhandler/console.cc
> > +++ b/winsup/cygwin/fhandler/console.cc
> > @@ -439,6 +439,7 @@ fhandler_console::cons_master_thread (handle_set_t *p, tty *ttyp)
> >   
> >         if (con.disable_master_thread)
> >   	{
> > +	  con.master_thread_suspended = true;
> >   	  cygwait (40);
> >   	  continue;
> >   	}
> [...]
> 
> The only question I have for this patch is whether you need to set
>      con.master_thread_suspended = false
> right after the cygwait(40) call.  Can't tell if that's an omission or 
> it's intentional to 'continue' into the main body of the function with 
> that flag still true.

It's intentional. While disable_master_thread is true, master_thread is
suspended. master_thread checks disable_master_thread every 40msec, and
if disable_master_thread becomes false, set master_thread_suspended
false and starts working again.

> Other than that, LGTM.  OK to push.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
