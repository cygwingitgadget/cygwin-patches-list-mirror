Return-Path: <SRS0=IQA0=2D=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w01.mail.nifty.com (mta-snd-w01.mail.nifty.com [106.153.227.33])
	by sourceware.org (Postfix) with ESMTPS id 247643858D1E
	for <cygwin-patches@cygwin.com>; Tue, 22 Jul 2025 12:10:26 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 247643858D1E
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 247643858D1E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.33
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1753186228; cv=none;
	b=VY0k//oWBmqrEYcnRLDu2nKCNWzZu5caybQyL8ZAFIO/rTLGr7VhxcfKk1ywckEyEUsKln/qzYHlIWCfKI0Z/5pcwxVb9kbZ/i3+MgczMj4ZYHYQwV+H1w3xvipnr+ZcZLUwTlZCU+yolua10zRBzNjNPT+ndvr78DDny4U0vsk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1753186228; c=relaxed/simple;
	bh=yC+4+xz7HNazzvT9TkN+BioLGD7ED6MbnsDrKOFmV7s=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=Nw47Tm8eMAYGe3xXBhYsWkolZNOUpHEdsktEY/+wOOdWHmmWJswt+j6dxoe0FXY873DDhzpL5FNkeMNiN3fYAEzuHyeqx6BbLzX0+TJ3zo4rY1fnmYeOxW0AMTCU87mk0rZnbvf5MiHrhUKipLdcufZefye+qhUXzZPz1G5enPM=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 247643858D1E
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=mQTMeAua
Received: from HP-Z230 by mta-snd-w01.mail.nifty.com with ESMTP
          id <20250722121025077.OBGH.69071.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 22 Jul 2025 21:10:25 +0900
Date: Tue, 22 Jul 2025 21:10:24 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v5 2/3] Cygwin: spawn: Lock cygheap from
 refresh_cygheap() until child_copy()
Message-Id: <20250722211024.ee95c6cc1524e494162261be@nifty.ne.jp>
In-Reply-To: <aH9OkvKh_qsBRC5T@calimero.vinschen.de>
References: <20250722003142.4722-1-takashi.yano@nifty.ne.jp>
	<20250722003142.4722-3-takashi.yano@nifty.ne.jp>
	<aH9OkvKh_qsBRC5T@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1753186225;
 bh=7T56LbPHX7rfa34WSwraPXXPJDW1HbxLr+iiVIk4jXs=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=mQTMeAua0l2quRyGuqQLHmEZBGWoPtyhFRpcaxjblu2RO3VhTL8B9oLmUefTadj/wV2jOtba
 66iUe8yeodHc18hALe39tziR8RHnFYBRUtU/K+HhIEcvDLNkka2GNSNrEGhej6t4n/AqyT68US
 lzIwsPRf/9cWOILuXf8iuISX3Tlk9E7a1UMdoNNItjmmbEYG+gWurEeBqweSXs9ZHuYdKmBuOx
 jrixgDH2w7URwZaYmwwDLSnQefThgDznAuoY0W/0rLtSx1GJQnNNmscXM8yp0X1iXPy/kBIMjC
 LVWT3lONBF2yfWTzWNX3trbldF1YYYl5bkUhHOiw2Ah7q+pw==
X-Spam-Status: No, score=-11.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 22 Jul 2025 10:40:50 +0200
Corinna Vinschen wrote:
> Hi Takashi,
> 
> On Jul 22 09:31, Takashi Yano wrote:
> > ...completion in child process because the cygheap should not be
> > changed to avoid mismatch between child_info::cygheap_max and
> > ::cygheap_max. Otherwise, child_copy() might copy cygheap being
> > modified by other process. However, do not lock cygheap if the
> > child process is non-cygwin process, because child_copy() will
> > not be called in it. Not only it is unnecessary, it can also fall
> > into deadlock in close_all_files() while cygheap is already locked.
> > 
> > Fixes: 977ad5434cc0 ("* spawn.cc (spawn_guts): Call refresh_cygheap before creating a new process to ensure that cygheap_max is up-to-date.")
> > Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > ---
> 
> When you create a new patch version, it would be nice if you could
> add version info after the three dashes, kind of like
> 
>   v3: add cygheap_init::lock method
>   v4: inline cygheap_init::lock method
>   v5: don't lock cygheap for non-cygwin child
>   v6: add spawn_cygheap_lock
> 
> Otherwise it's a bit tricky to review because one has to first find
> out why a new version exists at all.
> 
> >  winsup/cygwin/spawn.cc | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> > 
> > diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
> > index cb58b6eed..cf344d382 100644
> > --- a/winsup/cygwin/spawn.cc
> > +++ b/winsup/cygwin/spawn.cc
> > @@ -542,7 +542,6 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
> >  	::cygheap->ctty ? ::cygheap->ctty->tc_getpgid () : 0;
> >        if (!iscygwin () && ctty_pgid && ctty_pgid != myself->pgid)
> >  	c_flags |= CREATE_NEW_PROCESS_GROUP;
> > -      refresh_cygheap ();
> >  
> >        if (mode == _P_DETACH)
> >  	/* all set */;
> > @@ -611,6 +610,9 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
> >  
> >        cygpid = (mode != _P_OVERLAY) ? create_cygwin_pid () : myself->pid;
> >  
> > +      if (iscygwin ())
> > +	cygheap->lock ();
> > +      refresh_cygheap ();
> 
> I compared v5 and v6, and I think we should not introduce the
> spawn_cygheap_lock() method.  It hides a crucial problem.
> 
> Assuming no further change, I'd prefer v5, BUT with a comment preceeding
> the `if (iscygwin ())' condition, along the lines of
> 
>    /* Lock the cygheap here to make sure the child doesn't copy a
>       cygheap while it's being modified in parallel.  Don't lock if
>       the child is a non-Cygwin child to avoid a deadlock in
>       close_all_files(). */
> 
> However, IIUC this situation only occurs if a non-Cygwin child is
> execve'd, and we're talking about the close_all_files() call in line 768
> in origin/main, which potentially occurs while the cygheap would be
> locked by your patch, right?
> 
> I see two different ways out:
> 
> - Either convert the SRWLOCK to a muto to allow a recursive cygheap lock.
> 
> - Or move the close_all_files() call.
> 
> The latter seems to me like the way to go here.
> 
> The close_all_files() call was introduced by commit 2f415d5efae5a
> ("Cygwin: pty: Disable FreeConsole() on close for non cygwin process.")
> 
> Why not move it out of the locked region?

Thanks for the advice. I'll apply your idea and submit v7 patch.
-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
