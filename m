Return-Path: <SRS0=EoNB=QP=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e03.mail.nifty.com (mta-snd-e03.mail.nifty.com [106.153.227.115])
	by sourceware.org (Postfix) with ESMTPS id 044C73858C3A
	for <cygwin-patches@cygwin.com>; Tue, 17 Sep 2024 13:49:04 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 044C73858C3A
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 044C73858C3A
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.115
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1726580948; cv=none;
	b=OjmY30+f9S5FNnrAViDB4UQu2VUYL67XF0x15Cu8IsN5jg37A0Ryv+62KsG/XutBYlgQ5fXJrhhpLxF6IWMi0vVgMJFPtt/HnJ4TlsbupN3AnR68NWTU8YR6EdsoJgHkxbMGNfV6bSI8LNb+feupaPeCyiB/N3rKF9iVm4JXGwA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1726580948; c=relaxed/simple;
	bh=p525Rkgo0tIKnWOUDLK8UvSQHXPKBCe345gRCrkPA00=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=t8LmNM0L6m9rw3DvNjrSmtu9DW29yNFLhFq0p1wjscwBczaACwDyKubWCzYhsxTKGoYNSy6gUqWOKGSxHvB6+qbXc35ypap8b0zLYRc6GJTP1UN4MTJ32C6TL3ETel2QtE/iDsDH5GBJb9kQ/HwMhmDOSO5Uzu0ZlQtliB6muhM=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from HP-Z230 by mta-snd-e03.mail.nifty.com with ESMTP
          id <20240917134903019.WHSK.51700.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 17 Sep 2024 22:49:03 +0900
Date: Tue, 17 Sep 2024 22:49:01 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4.2] Cygwin: pipe: Switch pipe mode to blocking mode by
 defaut
Message-Id: <20240917224901.b2569f125ffd15efd1992126@nifty.ne.jp>
In-Reply-To: <d197495e-b91e-4cfb-bc5e-84fbea62e6cb@cornell.edu>
References: <20240907024725.123-1-takashi.yano@nifty.ne.jp>
	<d197495e-b91e-4cfb-bc5e-84fbea62e6cb@cornell.edu>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1726580943;
 bh=ch79kLG7Mk/hmXsOEq72UkubntYYG807j63qLsurT4o=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=pWC8xy3Jk1K5cwga4u6Dpnli8axZalkp4hf4pzt30AkCJMV0V4RH1nKvRxkuTnSDGFvEjV6a
 wqOXBOY+SLVBET8XnvSAybj0qg/BaUkgd4w2yoLosOahMmk9L17zpnwV17GP3JTI8UvwlmZSdC
 L6N/W3Ebkde+gbqCKiWvLmILm+/G6HUZrQDbuuXA31KAfOLZT86Dnd2AzlKDOgrtO2n2/5mzCc
 HNFiRtFFELtcLtaqwkzPCP4w94sQjFJbite5E6gP4irwuqQqhHrDJvG69JstkOCXM/DGXkazbz
 VkoNuflt1YYAeAVtuhXX9C51CivxCHvtAdhHb6QvZ+hnLP7w==
X-Spam-Status: No, score=-11.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Ken,

Thanks for reviewing!

On Sat, 14 Sep 2024 16:09:19 -0400
Ken Brown wrote:
> On 9/6/2024 10:47 PM, Takashi Yano wrote:
> 
> defaut should be default in the subject.
> 
> > Previously, cygwin read pipe used non-blocking mode althogh non-
>                                                        although
> 
> > cygwin app uses blocking-mode by default. Despite this requirement,
> > if a cygwin app is executed from a non-cygwwin app and the cygwin
>                                            cygwin
> 
> > app exits, read pipe remains on non-blocking mode because of the
> > commit fc691d0246b9. Due to this behaviour, the non-cygwin app
> > cannot read the pipe correctly after that. Similarly, if a non-
> > cygwin app is executed from a cygwin app and the non-cygwin app
> > exits, the read pipe mode remains on blocking mode although cygwin
> > read pipe should be non-blocking mode.
> > 
> > These bugs were provoked by pipe mode toggling between cygwin and
> > non-cygwin apps. To make management of pipe mode simpler, this
> > patch has re-designed the pipe implementation. In this new
> > implementation, both read and wrie pipe basically use only blocking
>                                 write
> 
> > mode and the behaviour corresponding to the pipe mode is simulated
> > in raw_read() and raw_write(). Only when NtQueryInformationFile(
>                                            put the ( on the next line
> 
> > FilePipeLocalInformation) fails for some reasons, the raw_write()
> > cannot simulate non-blocking access. Therefore, the pipe mode is
> > temporarily changed to non-blocking mode.
> > 
> > Moreover, because the fact that NtSetInformationFile() in
> > set_pipe_non_blocking(true) fails with STATUS_PIPE_BUSY if the pipe
> > is not empty has been founhd, query handle is not necessary anymore.
>                          found

Fixed above typos.

> > This allows the implementation much simpler than before.
> 
> Yes.  Great work!

Thanks!

> > Addresses: https://github.com/git-for-windows/git/issues/5115
> > Fixes: fc691d0246b9 ("Cygwin: pipe: Make sure to set read pipe non-blocking for cygwin apps.");
> > Reported-by: isaacag, Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > ---
> >   winsup/cygwin/dtable.cc                 |   5 +-
> >   winsup/cygwin/fhandler/pipe.cc          | 482 ++++--------------------
> >   winsup/cygwin/local_includes/fhandler.h |  42 +--
> >   winsup/cygwin/local_includes/sigproc.h  |   1 -
> >   winsup/cygwin/select.cc                 |  25 +-
> >   winsup/cygwin/sigproc.cc                |  10 -
> >   winsup/cygwin/spawn.cc                  |   4 -
> >   7 files changed, 95 insertions(+), 474 deletions(-)
> 
> [...]
> 
> > diff --git a/winsup/cygwin/fhandler/pipe.cc b/winsup/cygwin/fhandler/pipe.cc
> > index c686df650..f99cbbc56 100644
> > --- a/winsup/cygwin/fhandler/pipe.cc
> > +++ b/winsup/cygwin/fhandler/pipe.cc
> 
> [...]
> 
> > @@ -339,37 +306,11 @@ fhandler_pipe::raw_read (void *ptr, size_t& len)
> >   				       FilePipeLocalInformation);
> >         if (NT_SUCCESS (status))
> >   	{
> > -	  if (fpli.ReadDataAvailable == 0 && nbytes != 0)
> > -	    break;
> > -	}
> > -      else if (nbytes != 0)
> > -	break;
> > -      status = NtReadFile (get_handle (), NULL, NULL, NULL, &io, ptr,
> > -			   len1, NULL, NULL);
> > -      if (isclosed ())  /* A signal handler might have closed the fd. */
> > -	{
> > -	  set_errno (EBADF);
> > -	  nbytes = (size_t) -1;
> > -	}
> > -      else if (NT_SUCCESS (status) || status == STATUS_BUFFER_OVERFLOW)
> > -	{
> > -	  nbytes_now = io.Information;
> > -	  ptr = ((char *) ptr) + nbytes_now;
> > -	  nbytes += nbytes_now;
> > -	  if (select_sem && nbytes_now > 0)
> > -	    release_select_sem ("raw_read");
> > -	}
> > -      else
> > -	{
> > -	  /* Some errors are not really errors.  Detect such cases here.  */
> > -	  switch (status)
> > +	  if (fpli.ReadDataAvailable == 0)
> >   	    {
> > -	    case STATUS_END_OF_FILE:
> > -	    case STATUS_PIPE_BROKEN:
> > -	      /* This is really EOF.  */
> > -	      break;
> > -	    case STATUS_PIPE_LISTENING:
> > -	    case STATUS_PIPE_EMPTY:
> > +	      if (fpli.NamedPipeState == FILE_PIPE_CLOSING_STATE)
> > +		/* Broken pipe ? */
> 
> Doesn't "broken pipe" only make sense for writers?  For a reader, 
> wouldn't this be EOF?

The comment fixed.

> > +		break;
> >   	      if (nbytes != 0)
> >   		break;
> >   	      if (is_nonblocking ())
> > @@ -399,6 +340,34 @@ fhandler_pipe::raw_read (void *ptr, size_t& len)
> >   		  break;
> >   		}
> >   	      continue;
> > +	    }
> > +	}
> > +      else if (nbytes != 0)
> > +	break;
> 
> What if the call to NtQueryInformationFile failed and nbytes == 0?  In 
> the non-blocking case, I think you need to temporarily set the pipe to 
> be non-blocking before calling NtReadFile.

You are right. Added fallback.

> > +      status = NtReadFile (get_handle (), NULL, NULL, NULL, &io, ptr,
> > +			   len1, NULL, NULL);
> > +      if (isclosed ())  /* A signal handler might have closed the fd. */
> > +	{
> > +	  set_errno (EBADF);
> > +	  nbytes = (size_t) -1;
> > +	}
> > +      else if (NT_SUCCESS (status) || status == STATUS_BUFFER_OVERFLOW)
> > +	{
> > +	  nbytes_now = io.Information;
> > +	  ptr = ((char *) ptr) + nbytes_now;
> > +	  nbytes += nbytes_now;
> > +	  if (select_sem && nbytes_now > 0)
> > +	    release_select_sem ("raw_read");
> > +	}
> > +      else
> > +	{
> > +	  /* Some errors are not really errors.  Detect such cases here.  */
> > +	  switch (status)
> > +	    {
> > +	    case STATUS_END_OF_FILE:
> > +	    case STATUS_PIPE_BROKEN:
> > +	      /* This is really EOF.  */
> > +	      break;
> >   	    default:
> >   	      __seterrno_from_nt_status (status);
> >   	      nbytes = (size_t) -1 > @@ -414,18 +383,6 @@ fhandler_pipe::raw_read (void *ptr, size_t& len)
> >     len = nbytes;
> >   }
> >   
> > -bool
> > -fhandler_pipe::reader_closed ()
> > -{
> > -  if (!query_hdl)
> > -    return false;
> > -  WaitForSingleObject (hdl_cnt_mtx, INFINITE);
> > -  int n_reader = get_obj_handle_count (query_hdl);
> > -  int n_writer = get_obj_handle_count (get_handle ());
> > -  ReleaseMutex (hdl_cnt_mtx);
> > -  return n_reader == n_writer;
> > -}
> > -
> 
> Some of the changes below only make sense for pipes, not fifos.  Maybe 
> we need separate fhandler_pipe::raw_write and fhandle_fifo::raw_write?

Indeed. Let me consider.

> >   ssize_t
> >   fhandler_pipe_fifo::raw_write (const void *ptr, size_t len)
> >   {
> > @@ -439,19 +396,45 @@ fhandler_pipe_fifo::raw_write (const void *ptr, size_t len)
> >     if (!len)
> >       return 0;
> >   
> > -  if (reader_closed ())
> > +  ssize_t avail = pipe_buf_size;
> > +  bool real_non_blocking_mode = false;
> > +  if (is_nonblocking ())
> >       {
> > -      set_errno (EPIPE);
> > -      raise (SIGPIPE);
> > -      return -1;
> > +      FILE_PIPE_LOCAL_INFORMATION fpli;
> > +      status = NtQueryInformationFile (get_handle (), &io, &fpli, sizeof fpli,
> > +				       FilePipeLocalInformation);
> > +      if (NT_SUCCESS (status))
> > +	{
> > +	  if (fpli.WriteQuotaAvailable != 0)
> > +	    avail = fpli.WriteQuotaAvailable;
> > +	  else /* WriteQuotaAvailable == 0 */
> > +	    { /* Refer to the comment in select.cc: pipe_data_available(). */
> > +	      /* NtSetInformationFile() in set_pipe_non_blocking(true) seems
> > +		 to fail with STATUS_PIPE_BUSY if the pipe is not empty.
> > +		 In this case, the pipe is really full if WriteQuotaAvailable
> > +		 is zero. Otherwise, the pipe is empty. */
> > +	      if (!((fhandler_pipe *)this)->set_pipe_non_blocking (true))
> > +		{
> > +		  /* Full */
> > +		  set_errno (EAGAIN);
> > +		  return -1;
> > +		}
> > +	      /* Restore the pipe mode to blocking. */
> > +	      ((fhandler_pipe *)this)->set_pipe_non_blocking (false);
> > +	      /* Pipe should be empty because reader is waiting the data. */
> > +	    }
> > +	}
> > +      else if (((fhandler_pipe *)this)->set_pipe_non_blocking (true))
> > +	/* The pipe space is unknown. */
> > +	real_non_blocking_mode = true;
> 
> What if set_pipe_non_blocking (true) fails.  Do we really want to 
> continue, in which case we'll do a blocking write below?

If we want to return an error for this case, what errno is appropriate,
do you think? EIO?

> >       }
> >   
> > -  if (len <= pipe_buf_size || pipe_buf_size == 0)
> > +  if (len <= (size_t) avail || pipe_buf_size == 0)
> >       chunk = len;
> >     else if (is_nonblocking ())
> > -    chunk = len = pipe_buf_size;
> > +    chunk = len = avail;
> >     else
> > -    chunk = pipe_buf_size;
> > +    chunk = avail;
> >   
> >     if (!(evt = CreateEvent (NULL, false, false, NULL)))
> >       {
> 
> [...]
> 
> > diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
> > index bc02c3f9d..9d47ff3b0 100644
> > --- a/winsup/cygwin/select.cc
> > +++ b/winsup/cygwin/select.cc
> > @@ -642,7 +642,7 @@ pipe_data_available (int fd, fhandler_base *fh, HANDLE h, int flags)
> >           Consequentially, the only reliable information is available on the
> >           read side, so fetch info from the read side via the pipe-specific
> >           query handle.  Use fpli.WriteQuotaAvailable as storage for the actual
> > -        interesting value, which is the InboundQuote on the write side,
> > +        interesting value, which is the InboundQuota on the write side,
> >           decremented by the number of bytes of data in that buffer. */
> >         /* Note: Do not use NtQueryInformationFile() for query_hdl because
> >   	 NtQueryInformationFile() seems to interfere with reading pipes
> 
> The whole comment needs to be rewritten to reflect the fact that there's 
> no longer a query handle.

I will.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
