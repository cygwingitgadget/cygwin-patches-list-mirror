Return-Path: <SRS0=xgHh=BD=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e09.mail.nifty.com (mta-snd-e09.mail.nifty.com [106.153.226.41])
	by sourceware.org (Postfix) with ESMTPS id D3FBF4BAD148
	for <cygwin-patches@cygwin.com>; Tue,  3 Mar 2026 11:37:51 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D3FBF4BAD148
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D3FBF4BAD148
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.41
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1772537872; cv=none;
	b=EFrggN+9C0n469nwE7IyrWi1gu/4pSSxPjBhJ5eQYW5u5oFL+C0flyDKvh96zHSZKi+pci1lzBXpYMsHj9FBcf5OPy4mzaoYC+bkrW3sAFrN5qxv596byTGU1FzkbSsLvbL313uB9V8hiSREsFLg4SzzNkcdL2gd/bsPllRUUSg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1772537872; c=relaxed/simple;
	bh=dWeDlgtvsyEFIitbQW8BY3UuqULRbfwUc8MMnkheReY=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=a4o9sa6ynM7JATJJju+w47lO8ZuFqifQ8de3uUsyZZ5hPlekj7LbO0RAe3W2GkmWOfkJz3dvYfCwsUMpjV1uh/77J0i2pXeeU8BlaJEiWcylKqLXX1L8bApVUQDVv2gjc2x4NSQPyJQYtqaSbxkrJZo4U0bN68oe1YfLa+70gKM=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D3FBF4BAD148
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=X7E6xK54
Received: from HP-Z230 by mta-snd-e09.mail.nifty.com with ESMTP
          id <20260303113749868.TCWB.84842.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 3 Mar 2026 20:37:49 +0900
Date: Tue, 3 Mar 2026 20:37:47 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: pty: Fix handling of data after CSI6n
 response
Message-Id: <20260303203747.87aaee4d9fd65e19e856230b@nifty.ne.jp>
In-Reply-To: <b783d055-4785-4bff-c924-eaa67c0f502c@gmx.de>
References: <20260228090107.2529-1-takashi.yano@nifty.ne.jp>
	<b783d055-4785-4bff-c924-eaa67c0f502c@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1772537869;
 bh=8VXclKf9CbWpgP0dEYN9P6z4P5QOgz6+1QymeHRhqdQ=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=X7E6xK54cMZNrHKtF7aZXC8h7mYh7ucHBwtxYa36F0v8pVaMVIQkFBxk7ZonhAsPTuvoZ0ib
 2AdipB8aI2H2whkAoOakkG1uiArf1copSzDmyw5Rdbg2LISDQqjzp2rBbSMrjMJiuID4BRT5mn
 I46h/MBIaDot1LF1TTq/wlbQ6Ena84TbbJkMKz774ZVFwV9q/hhYkDlxdnn5ZokHRlXNm6oRv5
 jD8G9yBoxGU+cUQKMeMYVHDf77McypIm45+KGXKDw63awNA5BsbG/1V1U5FSb2qCJriRxpinP+
 WFbL+fKAZ1bBmCNJWd37zr1TRsCST7i74H358wLgaXCde71w==
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

On Mon, 2 Mar 2026 14:24:39 +0100 (CET)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> On Sat, 28 Feb 2026, Takashi Yano wrote:
> 
> > Previously, CSI6n was not handled correctly if the some sequences
> > are appended after the response for CSI6n. Especially, if the
> > appended sequence is a ESC sequence, which is longer than the
> > expected maximum length of the CSI6n response, the sequence will
> > not be written atomically.
> > 
> > Moreover, when the terminal's CSI 6n response and subsequent data
> > (e.g. keystrokes) arrive in the same write buffer, master::write()
> > processes all of it inside the pcon_start loop and returns early.
> > Bytes after the 'R' terminator go through per-byte line_edit() in
> > that loop instead of falling through to the `nat` pipe fast path
> > or the normal bulk `line_edit()` call. Due to this behaviour,
> > the chance of code conversion to the terminal code page for the
> > subsequent data in `to_be_read_from_nat_pipe()` case, will be lost.
> > 
> > Fix this by breaking out of the loop when 'R' is found and letting
> > the remaining data fall through to the normal write paths, which
> > are now reachable because `pcon_start` has been cleared.
> > 
> > Fixes: f20641789427 ("Cygwin: pty: Reduce unecessary input transfer.")
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > Co-authored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> 
> Heh, I would have been fine with a mere Reviewed-by ;-)
> 
> > Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > ---
> >  winsup/cygwin/fhandler/pty.cc | 47 +++++++++++++++++++----------------
> >  1 file changed, 25 insertions(+), 22 deletions(-)
> > 
> > diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
> > index 838be4a2b..34a87c6dc 100644
> > --- a/winsup/cygwin/fhandler/pty.cc
> > +++ b/winsup/cygwin/fhandler/pty.cc
> > @@ -2137,6 +2137,8 @@ fhandler_pty_master::close (int flag)
> >  ssize_t
> >  fhandler_pty_master::write (const void *ptr, size_t len)
> >  {
> > +  size_t towrite = len;
> > +
> >    ssize_t ret;
> >    char *p = (char *) ptr;
> >    termios &ti = tc ()->ti;
> > @@ -2160,6 +2162,7 @@ fhandler_pty_master::write (const void *ptr, size_t len)
> >  
> >        DWORD n;
> >        WaitForSingleObject (input_mutex, mutex_timeout);
> > +      towrite = 0;
> 
> I originally suggested to initialize `towrite` to 0 instead of `len`
> above.
> 
> The reason why it needs to be initialized to `len`, and only be zeroed
> inside the `if (get_ttyp ()->pcon_start)` block is that you are using
> `towrite` instead of `len` in the "fall-through" block _after_ the `if
> (get_ttyp ()->pcon_start)` block, which you now fall through if the `R`
> was encountered.
> 
> And you use `towrite` instead of `len` there in that fall-through block in
> the UTF-8/code page conversion, but you still use the original `len` as
> return value from that method as well as for the `line_edit()` fall-back.
> 
> I found this a bit hard to follow.
> 
> Wouldn't it be easier to introduce a new variable `size_t orig_ret = len`
> instead of `towrite`, return `orig_ret` instead of len (and using it in
> the `line_edit()` call, too), and then adjust `len` instead of assigning
> `towrite`?

Using len in line_edit() fall-through was a bug. Thanks for pointing this
out. I'll submit a fixed version as v3 patch.

> >        for (size_t i = 0; i < len; i++)
> >  	{
> >  	  if (p[i] == '\033')
> > @@ -2171,32 +2174,33 @@ fhandler_pty_master::write (const void *ptr, size_t len)
> >  	    }
> >  	  if (state == 1)
> >  	    {
> > -	      if (ixput < wpbuf_len)
> > -		wpbuf[ixput++] = p[i];
> > -	      else
> > +	      if (ixput == wpbuf_len)
> >  		{
> >  		  if (!get_ttyp ()->req_xfer_input)
> >  		    WriteFile (to_slave_nat, wpbuf, ixput, &n, NULL);
> >  		  ixput = 0;
> > -		  wpbuf[ixput++] = p[i];
> >  		}
> > +	      wpbuf[ixput++] = p[i];
> 
> Okay, this is correct, a simple refactoring. But it does distract from the
> purpose of the patch a bit (and makes reviewing slightly more confusing
> than necessary), as it is unrelated.

Yeah, indeed. I'll remove this refactoring from this patch.

> >  	    }
> >  	  else
> >  	    line_edit (p + i, 1, ti, &ret);
> >  	  if (state == 1 && p[i] == 'R')
> >  	    state = 2;
> > -	}
> > -      if (state == 2)
> > -	{
> > -	  /* req_xfer_input is true if "ESC[6n" was sent just for
> > -	     triggering transfer_input() in master. In this case,
> > -	     the responce sequence should not be written. */
> > -	  if (!get_ttyp ()->req_xfer_input)
> > -	    WriteFile (to_slave_nat, wpbuf, ixput, &n, NULL);
> > -	  ixput = 0;
> > -	  state = 0;
> > -	  get_ttyp ()->req_xfer_input = false;
> > -	  get_ttyp ()->pcon_start = false;
> > +	  if (state == 2)
> > +	    {
> > +	      /* req_xfer_input is true if "ESC[6n" was sent just for
> > +		 triggering transfer_input() in master. In this case,
> > +		 the response sequence should not be written. */
> > +	      if (!get_ttyp ()->req_xfer_input)
> > +		WriteFile (to_slave_nat, wpbuf, ixput, &n, NULL);
> > +	      towrite = len - i - 1;
> > +	      ptr = p + i + 1;
> > +	      ixput = 0;
> > +	      state = 0;
> > +	      get_ttyp ()->req_xfer_input = false;
> > +	      get_ttyp ()->pcon_start = false;
> > +	      break;
> > +	    }
> 
> Okay, that makes sense to me, in case we reach state 2, we want to change
> `towrite` and no longer `return len` below, but instead move on to writing
> the remainder to the `nat` pipe. It is a bit unfortunate that this
> refactor makes the diff a bit harder to read than I like.

To me, breaking on 'state == 2' makes more sense than before...
This might just come down to personal preference, though.

As for readability of the patch, I agree with you.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
