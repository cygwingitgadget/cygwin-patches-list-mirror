Return-Path: <SRS0=oHIC=ET=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e07.mail.nifty.com (mta-snd-e07.mail.nifty.com [106.153.226.39])
	by sourceware.org (Postfix) with ESMTPS id 62F094BA2E24
	for <cygwin-patches@cygwin.com>; Tue, 23 Jun 2026 13:51:49 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 62F094BA2E24
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 62F094BA2E24
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.226.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1782222710; cv=none;
	b=q5SXuIuChPyIv7UP1TjV/fKS/b6+esMTglAGd4/AwkLcUMXl0pQxpjt5QzLoK1jGCtwxEDJ0L0qP5Z9c5f+FczzoMAMcWfeRECW39kc+uKo0ZfjtB0yjms1qgfqRSQAUPfXb1OCCFWn0CNy/H4GZAMUwfxpuUpf2CiFc+crSU0g=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1782222710; c=relaxed/simple;
	bh=4wUWneBzBr5GVBInF9AZf6407Xbmte2Jn1vzvDoECZ8=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=hHAn8p5qifvbD238t/spP2N2MVSnGYQQ8KHLwR7i64Oy2wJ2J6EqdQ3l1kVWYmzfAsgTrvS1lHI+9EFZ27gYQzT7m68FrjjqJfse9eqeGDMgaC9A5DoBX5mFWB+VG603pR+waipLDF2Hhp2AC4nBbJk4nb2sN7TMZePWneJokD4=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=jbEho3fu
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 62F094BA2E24
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=jbEho3fu
Received: from HP-Z230 by mta-snd-e07.mail.nifty.com with ESMTP
          id <20260623135147491.MLBK.17441.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 23 Jun 2026 22:51:47 +0900
Date: Tue, 23 Jun 2026 22:51:46 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 2/3] Cygwin: pty: Discard pcon input buffer when
 discard_input is called.
Message-Id: <20260623225146.a4fe06ed20090cbac5abfa28@nifty.ne.jp>
In-Reply-To: <ee4f59ef-f0e9-48ea-ada5-6eaa7f19bfb8@maxrnd.com>
References: <20260613140917.27155-1-takashi.yano@nifty.ne.jp>
	<20260613140917.27155-3-takashi.yano@nifty.ne.jp>
	<ee4f59ef-f0e9-48ea-ada5-6eaa7f19bfb8@maxrnd.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1782222707;
 bh=fW+dRaQb3e9vrGudthi5nxTG2azD8t62cYWdOd2Bfvo=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=jbEho3fu75ZRScD5bDb1rwcwyAR5iYu98rCt6soeLQRI8CHLINeQD46MOWjVFOPWBqMb3XAP
 U5SNSufgJimUQuM6YPRqfIjUQEyG2wj4GyW+vazLT/EC72Qm1DvPqLCssnKKAdd2r8ctOVOOep
 rWBfQbXmAsQ2YPgczxjmJ0MWMbyxYzD7O0vID+rJKMX6abmpcOarAqpBkamHEKiO15EvpEWxBz
 zlmvHCsTtIO0KrmplxM8Lrr7SMDOU7zlpjIZrx623lMr2UpVazKfJrg35zxLnLsyjLa6IRMwXt
 SvoLcTcn1/J1nvbWbfJIQcDI9FafhxxFF5zWUieTCTFNCUZA==
X-Spam-Status: No, score=-12.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Mark,

On Tue, 23 Jun 2026 00:50:43 -0700
Mark Geisert wrote:
> Hi Takashi,
> 
> On 6/13/2026 7:09 AM, Takashi Yano wrote:
> > Previously, the process on pty could not be a child of non-cygwin
> > process. So, it is not necessary to flush pcon input buffer even
>             ^^^^ replace "So" with "In that case"
> 
> > when discard_input() is called. However, now, the child process
> > of non-cygwin app on pseudo console is running on pty. So,
> > discard_input() should affect to the pcon input buffer as well.
> > 
> > This prevents the probelm:
>                      ^^^^^^^
> >    1) Run 'sleep 10' in cmd.exe
> >    2) Enter 'ps\n' while sleeping
> >    3) Press Ctrl-C
> >    4) 'ps' will be executed after terminating 'sleep' by Ctrl-C.
> > 
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > Reviwed-by:
> > ---
> >   winsup/cygwin/fhandler/pty.cc | 11 ++++++++++-
> >   1 file changed, 10 insertions(+), 1 deletion(-)
> > 
> > diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
> > index d625ff9df..b3a8d57cc 100644
> > --- a/winsup/cygwin/fhandler/pty.cc
> > +++ b/winsup/cygwin/fhandler/pty.cc
> > @@ -583,6 +583,14 @@ fhandler_pty_master::discard_input ()
> >     if (!get_ttyp ()->pcon_activated)
> >       while (::bytes_available (bytes_in_pipe, from_master_nat) && bytes_in_pipe)
> >         ReadFile (from_master_nat, buf, sizeof(buf), &n, NULL);
> > +  else
> > +    {
> > +      DWORD target_pid = get_ttyp ()->nat_pipe_owner_pid;
> > +      DWORD resume_pid =
> > +	fhandler_pty_common::attach_console_temporarily (target_pid);
> > +      FlushConsoleInputBuffer (h_pcon_in_dupped);
> > +      fhandler_pty_common::resume_from_temporarily_attach (resume_pid);
> > +    }
> >     get_ttyp ()->discard_input = true;
> >     ReleaseMutex (input_mutex);
> >   }
> > @@ -2585,7 +2593,8 @@ fhandler_pty_master::write (const void *ptr, size_t len)
> >         for (size_t i = 0, j = 0; i < len; i++)
> >   	{
> >   	  process_sig_state r = process_sigs (buf[i], get_ttyp (), this);
> > -	  if (r != done_with_debugger)
> > +	  if (r != done_with_debugger &&
> > +	      (r != signalled || (ti.c_lflag & NOFLSH) || buf[i] == '\003'))
> >   	    {
> >   	      char c = buf[i];
> >   	      /* Workaround for pseudo console in Windows 11 */
> 
> Other than the minor commentary changes, this LGTM.

I'll push the version revised after GTG for the other patch
in this patch series.

Thanks!

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
