Return-Path: <SRS0=Xkk+=B2=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w09.mail.nifty.com (mta-snd-w09.mail.nifty.com [106.153.227.41])
	by sourceware.org (Postfix) with ESMTPS id 3451B4BA23CC
	for <cygwin-patches@cygwin.com>; Thu, 26 Mar 2026 11:37:50 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3451B4BA23CC
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 3451B4BA23CC
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.41
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1774525071; cv=none;
	b=Y+zYlyZEyqOgME6xx7LKitIp/RTjXy/3h7JDx3MHjjLwUAjz1W1qLAPDfOp3vr0sbJFWw8knTvp0Rj1mpa6P1Ctnx+k3MYbd5RBDI21BCbWt1LVmeYJtzElfFHtFsQjuYBH3UTUQF/yibNuqFD2fIjNe+9kc27k2/E73srwNhbc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1774525071; c=relaxed/simple;
	bh=uAeuZ5spJvw0PwGZ758CrJJXbHmHaKl6be/qf6inNhI=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=wjKIU5L8G/R0VHM9ZlUjR/W/teihJDgkLsRBVKyz6FovqFNrZmTDNNixxesI1kJnY3iLArq52vQdKQe3XF5aZQumFnhcPUuIEV4vBylHGNBkP7w1+YkubZZnCyX7NoJr0fRONI94X2UyIUNqpFPYUQSrg4bc4ug4Q9iEa3uYDSo=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3451B4BA23CC
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=n9r1keiL
Received: from HP-Z230 by mta-snd-w09.mail.nifty.com with ESMTP
          id <20260326113748358.JLLZ.116672.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Thu, 26 Mar 2026 20:37:48 +0900
Date: Thu, 26 Mar 2026 20:37:46 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Release pipe_sw_mutex in
 pcon_hand_over_proc()
Message-Id: <20260326203746.48c94dbbd8a9c6988e989622@nifty.ne.jp>
In-Reply-To: <acT6lwMeLiPIuxUD@calimero.vinschen.de>
References: <20260325130644.64948-1-takashi.yano@nifty.ne.jp>
	<acT6lwMeLiPIuxUD@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1774525068;
 bh=xsD7WOsmxDi0e6zOO5PgGzIuD8RkrMMe8uithftbek0=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=n9r1keiLGaS1Tm1rZv3dpM2CAY92HgM5FERYzQ58phhHBha4qXzD2yr0L/rwh8CH9D+LPitp
 ZEv3dTLQy2fSZ/qT9jjvP3LSMD0j0KP9xgEFWB25IGZA2RUeEfu+jCxu4DYv6hb8hvtolt9buU
 GhVy+kkG1mjx7zLwP7HPsLeyeowOx5Mtn9q1IYP5Wo9kgjTIShKtOuMSBdHMsHFpsWDQnucuqS
 QzhxPAaqtX3i9Wn6bGHp5EjG2W+9mFPC9XoVG3gXqv0U/P7A7AygAX5uJNFKU24gRW0uJx8jeM
 infcqXGvGAczLnZjc4bXDMQ1h4w/TeQZ4gC/Q0RBLtb51fuA==
X-Spam-Status: No, score=-12.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Thu, 26 Mar 2026 10:21:27 +0100
Corinna Vinschen wrote:
> On Mar 25 22:06, Takashi Yano wrote:
> > Currently, pipe_sw_mutex is held in the process which is running
> > in console inherited from pseudo console until the process ends.
> > Due to this behaviour, the process may cause deadlock when it
> > attempts to acuqire input_mutex in set_input_mode() called via
>               acquire
> 
> > close_ctty(). This deadlock occurs because the pty master
> > acuires input_mutex first and acuire pipe_sw_mutex next while
>   acquire                       acquire
> 
> > the process exiting acuire pipe_sw_mutex first.
>                       acquire
> 
> > To avoid this deadlock, this patch releases pipe_sw_mutex in
> > pcon_hand_over_proc(). In addition, pointless pipe_sw_mutex
> > acquire/release is drppped in pcon_hand_over_proc().
> > 
> > Fixes: 04f386e9af99 ("Cygwin: console: Inherit pcon hand over from parent pty")
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > Reviewed-by:
> > ---
> >  winsup/cygwin/fhandler/console.cc | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> > 
> > diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
> > index 29cdba0d3..1dd5dfa1d 100644
> > --- a/winsup/cygwin/fhandler/console.cc
> > +++ b/winsup/cygwin/fhandler/console.cc
> > @@ -1994,8 +1994,6 @@ fhandler_console::pcon_hand_over_proc (void)
> >    char buf[MAX_PATH];
> >    shared_name (buf, PIPE_SW_MUTEX, parent_pty);
> >    HANDLE mtx = OpenMutex (MAXIMUM_ALLOWED, FALSE, buf);
> > -  WaitForSingleObject (mtx, INFINITE);
> > -  ReleaseMutex (mtx);
> >    DWORD res = WaitForSingleObject (mtx, INFINITE);
> >    if (res == WAIT_OBJECT_0 || res == WAIT_ABANDONED)
> >      {
> > @@ -2006,9 +2004,8 @@ fhandler_console::pcon_hand_over_proc (void)
> >      }
> >    else
> >      system_printf("Acquiring pcon_ho_mutex failed.");
> > +  ReleaseMutex (mtx);
> >    CloseHandle (parent_pty_input_mutex);
> > -  /* Do not release the mutex.
> > -     Hold onto the mutex until this process completes. */
> >  }
> >  
> >  bool
> > -- 
> > 2.51.0
> 
> Other than that, LGTM.

Thanks for the review. Pushed.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
