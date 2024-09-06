Return-Path: <SRS0=8gjk=QE=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e04.mail.nifty.com (mta-snd-e04.mail.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:24])
	by sourceware.org (Postfix) with ESMTPS id 8DA743858408
	for <cygwin-patches@cygwin.com>; Fri,  6 Sep 2024 08:59:22 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 8DA743858408
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 8DA743858408
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2001:268:fa04:731:6a:99:e2:24
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1725613165; cv=none;
	b=oNBzZnVuv0suaECo252cIBByfr3XRDtnf0qLhXKz8+cpc2SKOngepMo3tfwbykUsUBx7E6VWpVNRYJwecSKtZGMdv0PftFQXJdL4tDnD1NrLj1S26ctV2srcAf8mUApPFDcFpAVuc/gxP8nYANwFk9mls62nxZmJIRJL6bz5yhs=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1725613165; c=relaxed/simple;
	bh=DoHAR+FnF8arwC/ZEok+VpvqB7FDusBT/xkeFTPKecw=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=uQnE3xzSa+KAB+E/hHAPCn0XID1LnVHu1qM8YxB8lVffpq6ipOMRfdFVaMpekg/xfue6Q8Q++5kToGxJlad6PzWpNdEtOMtReSUYeN24RGG8fVfTbi+nnFxExOo2jx+sqRZcNrSfP2pRI7nUG7DDeOlWJ4/EUjFgG9gQgv9Oq/Y=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from HP-Z230 by mta-snd-e04.mail.nifty.com with ESMTP
          id <20240906085920422.KBNC.84424.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Fri, 6 Sep 2024 17:59:20 +0900
Date: Fri, 6 Sep 2024 17:59:18 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pipe: Switch pipe mode to blocking mode by
 defaut
Message-Id: <20240906175918.02083a40e35642ed775e8f7a@nifty.ne.jp>
In-Reply-To: <ZtnLR1gSsDop_nCK@calimero.vinschen.de>
References: <20240905131857.385-1-takashi.yano@nifty.ne.jp>
	<ZtnLR1gSsDop_nCK@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1725613160;
 bh=iIsFu1ZYUq5VXMoMLQNXA1/ZNuwescANgo8QDSWYNts=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=m9DBsGpq1ujBmS4Xttkd+DxsI5tKbOqbprXntf3bdPQWFIeRCeD/GJOu59EO/9wlVRczVAcM
 ifyrqy00JGuDkYCW4iaCP9p2q2Ql4v7TPVYCYb7HfDYSZKrd5xJxZv8taSlwErirzSJeCg8yQR
 gHV3FaZRxlQdWLQDSCAwOC8efqs0nY63hL5mYGa9iSXrjfA3doY9GOB6ZHZCItXvPyGKmSOkXD
 m0e5qX1kIWfrCSTrV7WbM7YFq2Mcu6DSs3vZEsl48LQFwtm5tkNpaPJuyw4GusPXbZWrgtziaa
 F6pwHGQeU2O8BckDJNUTJFK2yBu/6uvCZdMezf4AVSWxiaBg==
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Thu, 5 Sep 2024 17:16:23 +0200
Corinna Vinschen wrote:
> thanks for this patch.  Two points:

Thanks for reviewing so quickly!

> On Sep  5 22:18, Takashi Yano wrote:
> > @@ -446,12 +441,20 @@ fhandler_pipe_fifo::raw_write (const void *ptr, size_t len)
> >        return -1;
> >      }
> >  
> > -  if (len <= pipe_buf_size || pipe_buf_size == 0)
> > +  bool query_hdl_available = true;
> > +  ssize_t avail = pipe_buf_size;
> > +  if (is_nonblocking ())
> > +    avail = pipe_data_available (-1, this, get_handle (), PDA_WRITE);
> > +  if (avail == 0)
> > +    {
> > +      set_errno (EAGAIN);
> > +      return -1;
> > +    }
> 
> avail can only be 0 in nonblocking mode, so this should be checked only
> for nonblocking pipes.  However, isn't pipe_data_available() a bit
> costly to be called all the time in nonblocking mode?  The current
> strategy is to write first and only if that fails, call
> pipe_data_available().  Also, doesn't this circumvent the mechanism
> chosing the chunk size to act POSIX-like as per the lengthy comment
> preceeding the write loop?

Please reffer the comment later.

> > @@ -459,6 +462,28 @@ fhandler_pipe_fifo::raw_write (const void *ptr, size_t len)
> >        return -1;
> >      }
> >  
> > +  if (is_nonblocking ())
> > +    {
> > +      fhandler_pipe *fh = (fhandler_pipe *) this;
> > +      query_hdl_available =
> > +	fh->get_query_handle () || fh->temporary_query_hdl ();
> > +      if (avail > 1 || query_hdl_available)
> > +	len = chunk;
> > +      else if (avail == 0) /* The pipe is really full. */
> > +	{
> > +	  set_errno (EAGAIN);
> > +	  return -1;
> > +	}
> > +      else if (!fh->set_pipe_non_blocking (true))
> > +	/* NtSetInformationFile() in set_pipe_non_blocking(true)
> > +	   fails for unknown reasons if the pipe is not empty.
> 
> Which NTSTATUS code does NtSetInformationFile() return in this case?
> 
> This sounds pretty ominous. If we can't set the pipe to non-blocking
> under all circumstances, isn't this bound to fail again, just differently?

NTSTATUS is STATUS_PIPE_BUSY. As far as I tested, this causes if
the pipe is not empty. In current implementaion, pipe mode is
set at the initializing, so the pipe is supposed to be empty.

Based on this behaviour of fail and success, I come up with new idea
that does not need query handle at all. When WriteQuotaAvailable is 0,
two cases are possible.
1) The pipe is really full.
2) The pipe is being read for larger size than pipe size and it is blocked.
In the case 1), pipe is not empty so NtSetInformationFile() will fail.
In the case 2), reading is blocked, so the pipe is empty. Therefore,
NtSetInformationFile() will succeed.

So, we can distinguish these cases by calling NtSetInformationFile().
Therefore, query handle is not necessary in above cases.
Currently, query handle is used only when WriteQuotaAvailable is 0,
so we can drop query handle entirely.

In fact, query handle has meaning when reader requests smaller
data size than pipe size, however, we do not use query handle
in such way.

Please review v2 patch. This is much simpler than current implementation.

> > +	   In this case, no pipe reader should be reading the pipe,
> > +	   so pipe_data_available() has returned correct value. */
> 
> I don't understand the conclusion here. The pipe could have 12K data but
> the pipe reader only reads in 4K chunks. In that case `avail' would be
> incorrect.

Yeah, you are right. Important thing here is avail is not zero and not
lager than real pipe space, isn't it?

> > @@ -916,6 +964,11 @@ is_running_as_service (void)
> >     simplicity, nt_create will omit the 'open_mode' and 'name'
> >     parameters, which aren't needed for our purposes.  */
> >  
> > +/* Regardless of above comment, the current nt_create() is reverted to just
> > +   call fhandler_pipe::create() to allow adding FILE_FLAG_OVERLAPPED flag.
> > +   This is needed for query_hdl so that PeekNamedPipe() and NtQueryObject()
> > +   are not blocked even while reader is reading the pipe. */
> 
> Specifying FILE_FLAG_OVERLAPPED on the Win32 API level is the same thing
> as dropping the FILE_SYNCHRONOUS_IO_NONALERT flag from
> NtCreateNamedPipeFile.  Perhaps in conjunction with dropping
> SYNCHRONIZE, but that's theoretically just a way to make the
> file handle synchronizable, so, may or may not be necessary.

That's too bad. :(

> The other advantage of NtCreateNamedPipeFile is
> that you can specify exact permission, like FILE_WRITE_ATTRIBUTES,
> without having to specify the pipe as PIPE_ACCESS_OUTBOUND pipe.
> This may even explain why
> NtSetInformationFile() in set_pipe_non_blocking() failed for you.
> 
> Either way, *iff* you just call fhandler_pipe::create() from
> nt_create(), we should drop nt_create entirely.  But actually I'd prefer
> the NT method, if possible and rather remove fhandler_pipe::create() in
> the long run.

I'll revert regarding FILE_FLAG_OVERLAPPED changes and revive original
nt_create().

> > --- a/winsup/cygwin/select.cc
> > +++ b/winsup/cygwin/select.cc
> > @@ -642,7 +642,7 @@ pipe_data_available (int fd, fhandler_base *fh, HANDLE h, int flags)
> >          Consequentially, the only reliable information is available on the
> >          read side, so fetch info from the read side via the pipe-specific
> >          query handle.  Use fpli.WriteQuotaAvailable as storage for the actual
> > -        interesting value, which is the InboundQuote on the write side,
> > +        interesting value, which is the OutboundQuota on the write side,
> >          decremented by the number of bytes of data in that buffer. */
> 
> >        /* Note: Do not use NtQueryInformationFile() for query_hdl because
> >  	 NtQueryInformationFile() seems to interfere with reading pipes
> 
> Btw., this could be a result of having a SYNCHRONIZE or
> FILE_SYNCHRONOUS_IO_NONALERT handle.  Maybe something to check at some
> later point...

Yes. This seems due to FILE_SYNCHRONOUS_IO_NONALERT. If FILE_FLAG_OVERLAPPED
is specified, this problem does not occur.

> > @@ -659,7 +659,20 @@ pipe_data_available (int fd, fhandler_base *fh, HANDLE h, int flags)
> >  	  if (!query_hdl)
> >  	    query_hdl = ((fhandler_pipe *) fh)->temporary_query_hdl ();
> >  	  if (!query_hdl) /* We cannot know actual write pipe space. */
> > -	    return (flags & PDA_SELECT) ? PIPE_BUF : 1;
> > +	    {
> > +	      /* NtSetInformationFile() in set_pipe_non_blocking(true)
> > +		 fails for unknown reasons if the pipe is not empty.
> > +		 In this case, no pipe reader should be reading the pipe,
> > +		 so the pipe is really full if WriteQuotaAvailable
> > +		 is zero.*/
> 
> Same questions as before.  This sounds still like a big problem.

Same answer as before. :)

> > +	      if (!((fhandler_pipe *) fh)->set_pipe_non_blocking (true))
> > +		return 0;
> > +	      /* Restore pipe mode to blocking mode */
> > +	      ((fhandler_pipe *) fh)->set_pipe_non_blocking (false);
> > +	      /* The pipe is empty here because set_pipe_non_blocking(true)
> > +		 has succeeded. */
> > +	      return fpli.OutboundQuota;;
> 
> Two semicolons
> 
> > +	    }
> >  	  DWORD nbytes_in_pipe;
> >  	  BOOL res =
> >  	    PeekNamedPipe (query_hdl, NULL, 0, NULL, &nbytes_in_pipe, NULL);
> > @@ -667,7 +680,7 @@ pipe_data_available (int fd, fhandler_base *fh, HANDLE h, int flags)
> >  	    CloseHandle (query_hdl); /* Close temporary query_hdl */
> >  	  if (!res) /* We cannot know actual write pipe space. */
> >  	    return (flags & PDA_SELECT) ? PIPE_BUF : 1;
> > -	  fpli.WriteQuotaAvailable = fpli.InboundQuota - nbytes_in_pipe;
> > +	  fpli.WriteQuotaAvailable = fpli.OutboundQuota - nbytes_in_pipe;
> 
> Didn't we use InboundQuota for a reason here?

Yes. We used InboundQuota here, but I thought this should be
OutboundQuota because, used here is pipe write side.

For testing, I tried to decrease OutboundQuota in read side as follows.
      status = NtCreateNamedPipeFile (&r, access, &attr, &io,
                      FILE_SHARE_READ | FILE_SHARE_WRITE,
                      FILE_CREATE,
                      FILE_SYNCHRONOUS_IO_NONALERT, pipe_type,
                      FILE_PIPE_BYTE_STREAM_MODE,
                      0, 1, psize, psize/4, &timeout); // <====
Then, the OutboundQuota in write side is decreased!
Moreover, pipe is full when psize data is written.

So, you are right.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
