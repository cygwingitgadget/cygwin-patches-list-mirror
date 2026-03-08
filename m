Return-Path: <SRS0=dH/q=BI=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w09.mail.nifty.com (mta-snd-w09.mail.nifty.com [106.153.227.41])
	by sourceware.org (Postfix) with ESMTPS id 77AF14BA2E1C
	for <cygwin-patches@cygwin.com>; Sun,  8 Mar 2026 11:46:34 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 77AF14BA2E1C
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 77AF14BA2E1C
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.41
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1772970395; cv=none;
	b=sNxNylfRq9KON9hvyXkNVRkR4O8Wh3qx87T7sLesufuQF8u9atblMyaooKUhRjIQ75E20gzbIy6lhwSyU6jM0Qvob1p3ckyDQZzpwYfTCzUmBWenPTQly9SR3LqBbfnvq4Qfv4jJp0TCXcrf1XdAlwef5qIyzMhHwSS2t3nEX10=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1772970395; c=relaxed/simple;
	bh=S1E+87x7VocWtyBcLFozxOSLyYdaAxueLBGuLsUgbxQ=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=KMrYuuW4mHIaRp/9yu9hRlVQi1s5Atq0eBQbqNBaKnoP3Y2JZfknV0OeUSG+hpxO96i3W9yKJ/S2gyPU1aYyNkCDQfOZc19nXFkHA0oMyURF43aMcBeHr8geCQu/PrQg5TNuc/KJzuUS9vUUBvyWxgOrFtE4zq3S7plw5z7Dmag=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 77AF14BA2E1C
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=FbOtCWEp
Received: from HP-Z230 by mta-snd-w09.mail.nifty.com with ESMTP
          id <20260308114632516.FEER.116672.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Sun, 8 Mar 2026 20:46:32 +0900
Date: Sun, 8 Mar 2026 20:46:30 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Make Ctrl-C work for non-cygwin app in GDB
Message-Id: <20260308204630.1783c799b67d9495f5f8dab8@nifty.ne.jp>
In-Reply-To: <de0c0ac5-a266-804c-79fe-08726ce4f969@gmx.de>
References: <20260228090219.2551-1-takashi.yano@nifty.ne.jp>
	<20260228090219.2551-2-takashi.yano@nifty.ne.jp>
	<de0c0ac5-a266-804c-79fe-08726ce4f969@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1772970392;
 bh=fcS/e1g+jewKHYMe/Gsa1mi31TTWvmy2rmEGV1xiuUI=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=FbOtCWEpIpIvAA4KXR1MhFkQ3qltble+VNn+Cy34EppqpvfHXyctd17NGat9K7gUHk+oj24e
 9LnIgNuFuk7/a6+t6tGCzhTftggvW8P4GLF4zVd7N3LXFWLtPWb3YjbFBOR5Ww/OBUib3nv3Yv
 J5v8e4vpeSyHgtWsXhMBSLC5SdjVD+kBb3xEBRHFI26J01YcBnDecdItSCbUvRw+praX3P+GYs
 Wpn29Qt8H1WpN4uZSjWMcD3WURnvym9aAJvwOBaDSMTVL6vR8Cz7TtuoS9HAqP3xGr7Z+mWtap
 EJQNsVgon6BPKntttdAUpiYV9V7BcgfcA56raH6FbDfKxZKA==
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

Thanks for reviewing.

On Sat, 7 Mar 2026 10:51:39 +0100 (CET)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> On Sat, 28 Feb 2026, Takashi Yano wrote:
> 
> > At some point in the past, GDB sets its own pgid to inferior pid
> > when the inferior is running.
> 
> I _guess_ by "inferior" you refer to the program debugged in GDB? But no,
> that cannot be true, as GDB is the parent process of that and shouldn't
> _also_ be a child at the same time (which setting pgid in that way would
> imply).

IIUC, the word "inferior" is used as a "debuggee" in the GDB context.

> > Due to this behaviour, Ctrl-C does not work if the inferior is a
> > non-cygwin app.
> 
> Wait, what? Setting pgid breaks Ctrl+C? _How_?

The inferior in GDB is not a normal cygwin process. That is executed
used CreateProcessW() other than exec(). So the parent process of
the inferior is not GDB. In the windows context, it is indeed a child
process of GDB, but in the cygwin context, it is not.

> > This is because, the current code sends Ctrl-C to GDB only when GDB's
> > pgid equeals to terminal pgid. This patch omit checking pgid when
> > recognizing GDB process whose inferior is non-cygwin app.
> 
> Okay, that's a lot to unpack here, especially because the diff context
> below is way too small to give the full picture.
> 
> > 
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > Reviewed-by:
> > ---
> >  winsup/cygwin/fhandler/termios.cc | 18 +++++++++---------
> >  winsup/cygwin/tty.cc              |  4 ++--
> >  2 files changed, 11 insertions(+), 11 deletions(-)
> > 
> > diff --git a/winsup/cygwin/fhandler/termios.cc b/winsup/cygwin/fhandler/termios.cc
> > index 694a5c20f..00700aed8 100644
> > --- a/winsup/cygwin/fhandler/termios.cc
> > +++ b/winsup/cygwin/fhandler/termios.cc
> > @@ -346,11 +346,11 @@ fhandler_termios::process_sigs (char c, tty* ttyp, fhandler_termios *fh)
> >  		     a marker for GDB with non-cygwin inferior in pty code.
> >  	 !PID_CYGPARENT: check this for GDB with cygwin inferior or
> >  			 cygwin apps started from non-cygwin shell. */
> > -      if (c == '\003' && p && p->ctty == ttyp->ntty && p->pgid == pgid
> > -	  && ((p->process_state & PID_NOTCYGWIN)
> > +      if (c == '\003' && p && p->ctty == ttyp->ntty
> > +	  && ((p->pgid == pgid && ((p->process_state & PID_NOTCYGWIN)
> > +				   || !(p->process_state & PID_CYGPARENT)))
> >  	      || ((p->exec_dwProcessId == p->dwProcessId)
> > -		  && ttyp->pty_input_state_eq (tty::to_nat))
> > -	      || !(p->process_state & PID_CYGPARENT)))
> > +		  && ttyp->pty_input_state_eq (tty::to_nat))))
> 
> This is one complex change of logic. Primarily because the logic was
> already complicated before this patch, and it is still complicated after
> the patch, but in a different way. And therefore it is very hard for me to
> confirm that it is correct, not without further help.
> 
> The `p->pgid == pgid` condition (whose purpose is hard to understand
> without being given any context) now no longer guards the `to_nat` check,
> before this change, it did.
> 
> That's all I understand after pouring over this diff for 10 minutes, and I
> do not feel any closer to being able to confirm that this change is correct.
> 
> >  	{
> >  	  /* Ctrl-C event will be sent only to the processes attaching
> >  	     to the same console. Therefore, attach to the console to
> > @@ -403,12 +403,12 @@ fhandler_termios::process_sigs (char c, tty* ttyp, fhandler_termios *fh)
> >  	  if (!p->cygstarted && !(p->process_state & PID_NOTCYGWIN)
> >  	      && (p->process_state & PID_DEBUGGED))
> >  	    with_debugger = true; /* inferior is cygwin app */
> > -	  if (!(p->process_state & PID_NOTCYGWIN)
> > -	      && (p->exec_dwProcessId == p->dwProcessId) /* Check marker */
> > -	      && ttyp->pty_input_state_eq (tty::to_nat)
> > -	      && p->pid == pgid)
> > -	    with_debugger_nat = true; /* inferior is non-cygwin app */
> >  	}
> > +      if (p &&  p->ctty == ttyp->ntty
> > +	  && !(p->process_state & PID_NOTCYGWIN)
> > +	  && (p->exec_dwProcessId == p->dwProcessId) /* Check marker */
> > +	  && ttyp->pty_input_state_eq (tty::to_nat))
> > +	with_debugger_nat = true; /* inferior is non-cygwin app */
> 
> Okay, so now this lengthy `if` statement was moved outside of a block, but
> the three diff context line are too few to help us here. So I looked it
> up: it is a block guarded by:
> 
> 	if (p && p->ctty == ttyp->ntty && p->pgid == pgid)
> 
> Which means that the new code skips both `p->pgid == pgid` and `p->pid ==
> pgid` checks.
> 
> But here, we're outside of the big `PID_NOTCYGWIN: check this for
> non-cygwin process` block, so it is conceivable that this change
> introduces unintended side effects for the non-GDB cases.
> 
> >      }
> >    if ((with_debugger || with_debugger_nat) && need_discard_input)
> >      {
> > diff --git a/winsup/cygwin/tty.cc b/winsup/cygwin/tty.cc
> > index 0c49dc2bd..3ab30c0a7 100644
> > --- a/winsup/cygwin/tty.cc
> > +++ b/winsup/cygwin/tty.cc
> > @@ -340,8 +340,8 @@ tty::nat_fg (pid_t pgid)
> >    for (unsigned i = 0; i < pids.npids; i++)
> >      {
> >        _pinfo *p = pids[i];
> > -      if (p->ctty == ntty && p->pgid == pgid
> > -	  && ((p->process_state & PID_NOTCYGWIN)
> > +      if (p->ctty == ntty
> > +	  && (((p->process_state & PID_NOTCYGWIN) && p->pgid == pgid)
> 
> This change is slightly less gnarly than the first one in this patch, and
> it recapitulates the idea that I _believe_ to understand to be behind that
> first change: to stop guarding the GDB check behind a `p->pgid == pgid`,
> but keep that guard for the other condition(s).
> 
> So now I am starting to understand the connection between the diff and the
> explanation in the commit message. But I have to say that I am highly
> suspicious of unintentional side effects: The commit message talks about a
> specific GDB behavior change that was introduced "[a]t some point in the
> past", and then describes a very specific pgid scenario. The diff,
> however, does not add that scenario to the guards, it takes the pgid guard
> away completely. This leaves a lot of room for scenarios that do not
> involve GDB at all to run into unintentional & unwanted behavioral
> changes.
> 
> In general, I would expect this patch to benefit greatly from wrappers
> around the conditions that are currently in place verbatim: reading
> 
> 	(p->process_state & PID_NOTCYGWIN) && p->pgid == pgid
> 
> tells me very, very little, while reading
> 
> 	!p->is_foreground_process_a_cygwin_process ()
> 
> would immediately give me enough context to understand the intention of
> the condition.

I agree.

> Please consider refactoring especially these gnarly, deeply nested
> conditions to a more readable form by wrapping them in simple, small
> helper methods whose names refer to the intention more than to the
> implementation details ("is this a GDB child process", "is Cygwin in the
> foreground", etc instead of "in which process state are we in", "does the
> current pgid match the pgid of `p`", etc).
> 
> It is okay for inlined conditions to duplicate sub-conditions. If you end
> up with `a () || b () || c ()` conditions where all of `a ()`, `b ()` and
> `c ()` start with the same, say, `p->pgid == pgid &&` guard, the compiler
> will simplify the machine code. If the actual names of those methods are
> descriptive, it will make the code a lot more readable, and hence much
> easier to review, and hence much less likely to be buggy.
> 
> Just to make myself clear: I do not fully understand this patch in the
> current shape, and therefore cannot confirm whether or not it is correct.

Indeed, these 'if' clauses are complicated enough to make the intent
of the code hard to understand (even for me...).

I'll fix the issue while also trying to improve the readability of the
code.
 

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
