Return-Path: <SRS0=ZTWV=S4=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w06.mail.nifty.com (mta-snd-w06.mail.nifty.com [106.153.227.38])
	by sourceware.org (Postfix) with ESMTPS id 478663858D26
	for <cygwin-patches@cygwin.com>; Tue,  3 Dec 2024 14:07:56 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 478663858D26
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 478663858D26
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.38
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1733234876; cv=none;
	b=JiS0tO4WFlCpY8gTH4Yu0FX4rQ6Ma+ekQyLoXVI3RE5D4I5jAGTnIO9XlaT0LfUSIT85tNU3ds4lt8HtvuC1bz/snGrYDT9MqaLPxS7GQyMIChkS78Ttbi2Vm6g3zBYgEfr8Xs0kygFEtsJ/HKh7KmmSgsSgcT5FVtpLuw9QdYY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1733234876; c=relaxed/simple;
	bh=wtAyZNFE7ugld5JdGYbSYNRweX7xDl0R1kvoX95CeX8=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=w92JkhsG8YC5lMJCtJjCH5WXa4ObOd3DrorU6V6LOHnNmvzuQUg5ZTxr/EAlt648FJOo79r+SrYaNWNMnhrJa6pnX18vD9IPNtBHvvKZsLHk79eHGepvuBEy+I60YNtmmS+jnyzvaNcXAOuX5Xeh5kODZ/Iguu3GXK8HVJQyOpw=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 478663858D26
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=IG3Ptcw6
Received: from HP-Z230 by mta-snd-w06.mail.nifty.com with ESMTP
          id <20241203140754508.GQQN.13595.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 3 Dec 2024 23:07:54 +0900
Date: Tue, 3 Dec 2024 23:07:53 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3 4/9] Cygwin: signal: Optimize the priority of the sig
 thread
Message-Id: <20241203230753.22b5f868b213426216358f98@nifty.ne.jp>
In-Reply-To: <20241203213933.8a2c2d15027e63b887e7ed0b@nifty.ne.jp>
References: <20241129120007.14516-1-takashi.yano@nifty.ne.jp>
	<Z03PtxZzigl-xvU0@calimero.vinschen.de>
	<20241203213933.8a2c2d15027e63b887e7ed0b@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1733234874;
 bh=MXoV1cCrj15rrVl16cm01dl8ZwRzvFZLmiSUTwCcdNY=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=IG3Ptcw6WtNOQ5nuca7Ke79EuocL/N7WeGShXyxquN1J2Mz/l/FtmB4okA/tnIgAlHI9KKbT
 pvTtJG+e2CwqctoVCf8TgKpTbt3jMFXrYkf+rRld8qxC0cuKcx1P/LYF9EIpup13wSI4QoBLvb
 rnDJpD2BVeAho/+WllRevyL7nNP9n5H/0ZjSnoRwegfzUi67cgWbaXj2xhI3Z0zypQ0cyWJ9fi
 H1xRGbvLsN+xe5A3s+afid29H9/TngntmXMc2TJ3LicbWe4YJ/7QrjjYLJBdz2EpsL739EtaUG
 iejuMC/dB8KB/zgoXPjbDntxlS673t86YU377Ry3zYSq1CZg==
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 3 Dec 2024 21:39:33 +0900
Takashi Yano wrote:
> On Mon, 2 Dec 2024 16:18:15 +0100
> Corinna Vinschen wrote:
> > On Nov 29 20:59, Takashi Yano wrote:
> > > Previously, the sig thread ran in THREAD_PRIORITY_HIGHEST priority.
> > > This causes a critical delay in the signal handling in the main
> > > thread if too many signals are received rapidly and the CPU is very
> > > busy. In this case, most of the CPU time is allocated to the sig
> > > thread, so the main thread cannot have a chance of handling signals.
> > > With this patch, to avoid such a situation, the priority of the sig
> > > thread is set to THREAD_PRIORITY_NORMAL priority. Furthermore, if
> > > the signal is alerted to the main thread, but the main thread does
> > > not handle it yet, to increase the chance of handling it in the main
> > > thread, reduce the sig thread priority to THREAD_PRIORITY_LOWEST
> > > priority temporarily before calling _cygtls::handle_SIGCONT().
> > > 
> > > Addresses: https://cygwin.com/pipermail/cygwin/2024-November/256744.html
> > > Fixes: 53ad6f1394aa ("(cygthread::cygthread): Use three only arguments for detached threads, and start the thread via QueueUserAPC/async_create.")
> > > Reported-by: Christian Franke <Christian.Franke@t-online.de>
> > > Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
> > > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > > ---
> > >  winsup/cygwin/exceptions.cc | 6 ++++++
> > >  winsup/cygwin/sigproc.cc    | 1 +
> > >  2 files changed, 7 insertions(+)
> > > 
> > > diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
> > > index 0f8c21939..7fc644af1 100644
> > > --- a/winsup/cygwin/exceptions.cc
> > > +++ b/winsup/cygwin/exceptions.cc
> > > @@ -978,6 +978,9 @@ sigpacket::setup_handler (void *handler, struct sigaction& siga, _cygtls *tls)
> > >    CONTEXT cx;
> > >    bool interrupted = false;
> > >  
> > > +  for (int i = 0; i < 100 && tls->current_sig; i++)
> > > +    yield ();
> > > +
> > 
> > Is that a piece of stray code left from testing, or is that actually
> > part of the patch?  The commit message doesn't explain it...
> 
> Oops! Sorry, this is test code for another patch I tested now.
> I'll submit v4 patch as well as another patch signal-related.

With the patch ("another patch" above):
"Cygwin: signal: Increase chance of handling signal in main thread"
it seems that we do not need setting thread priority around
handle_SIGCONT() any more. I cannot explain why though...

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
