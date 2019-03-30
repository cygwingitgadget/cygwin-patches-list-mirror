Return-Path: <cygwin-patches-return-9277-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 118886 invoked by alias); 30 Mar 2019 13:31:30 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 118783 invoked by uid 89); 30 Mar 2019 13:31:18 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-14.5 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,URIBL_BLOCKED autolearn=ham version=3.3.1 spammy=2017-03, Client, ph, 201703
X-HELO: conssluserg-05.nifty.com
Received: from conssluserg-05.nifty.com (HELO conssluserg-05.nifty.com) (210.131.2.90) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 30 Mar 2019 13:31:15 +0000
Received: from Express5800-S70 (ntsitm424054.sitm.nt.ngn.ppp.infoweb.ne.jp [219.97.74.54]) (authenticated)	by conssluserg-05.nifty.com with ESMTP id x2UDUorT020600	for <cygwin-patches@cygwin.com>; Sat, 30 Mar 2019 22:30:50 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x2UDUorT020600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1553952650;	bh=zsmfbq9xoPyE0ceZgGBk9vRBZJF8mP/SZ09GV/zhHH0=;	h=Date:From:To:Subject:In-Reply-To:References:From;	b=LecB9n28YwHaS9oFoLU20/9IguJWs4/N/j/KUfEVXhKLKBz0785G9gbG02uLmMHzm	 pYV2RO4egqVoY/leDvRAK0Y9PR3o+66Eg4/QNGFkca4qGPE78TZtlEkgVMxIVfpAe3	 XFkDE7eb/9lQ2p6l7brW28TK1eYJpYSs0tdhTvvHk9NyUeJA1Q7AQE1I77uz2mMHSN	 RJqQKAyMYmaGnk2ZXhgsD1Zp/O/odg8O2yWMdtJKZarJHHw9uzDlpoxdVmpfqRKL10	 dY8XUDfCZ1a0sYnXjYfgB4X41bc84cW8wo7hKd9p3G4BBuTG81knRczV/ysgpeN08w	 vpvaJ5+qv+PiQ==
Date: Sat, 30 Mar 2019 13:31:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH fifo 2/2] Cygwin: FIFO: add support for the duplex case
Message-Id: <20190330223059.443ad27b2c59de6372ff1eb8@nifty.ne.jp>
In-Reply-To: <20190325230556.2219-3-kbrown@cornell.edu>
References: <20190325230556.2219-1-kbrown@cornell.edu>	<20190325230556.2219-3-kbrown@cornell.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2019-q1/txt/msg00087.txt.bz2

Hi Ken,

Do these patches enable to open FIFO multiple times with O_RDWR?
mc (midnight commander) tries to open FIFO twice with O_RDWR if
SHELL=/bin/tcsh, but fails.
https://cygwin.com/ml/cygwin/2017-03/msg00188.html

On Mon, 25 Mar 2019 23:06:10 +0000 Ken Brown wrote:
> If a FIFO is opened with O_RDWR access, create the pipe with
> read/write access, and make the first client have the handle of that
> pipe as its I/O handle.
> 
> Adjust fhandler_fifo::raw_read to account for the result of trying to
> read from that client if there's no data.
> ---
>  winsup/cygwin/fhandler.h       |  5 +++
>  winsup/cygwin/fhandler_fifo.cc | 79 +++++++++++++++++++++++++++++-----
>  2 files changed, 73 insertions(+), 11 deletions(-)
> 
> diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
> index ef34f9c40..3398cc625 100644
> --- a/winsup/cygwin/fhandler.h
> +++ b/winsup/cygwin/fhandler.h
> @@ -1253,6 +1253,10 @@ struct fifo_client_handler
>    HANDLE dummy_evt;		/* Never signaled. */
>    fifo_client_handler () : fh (NULL), state (fc_unknown), connect_evt (NULL),
>  			   dummy_evt (NULL) {}
> +  fifo_client_handler (fhandler_base *_fh, fifo_client_connect_state _state,
> +		       HANDLE _connect_evt, HANDLE _dummy_evt)
> +    : fh (_fh), state (_state), connect_evt (_connect_evt),
> +      dummy_evt (_dummy_evt) {}
>    int connect ();
>    int close ();
>  };
> @@ -1268,6 +1272,7 @@ class fhandler_fifo: public fhandler_base
>    fifo_client_handler client[MAX_CLIENTS];
>    int nclients, nconnected;
>    af_unix_spinlock_t _fifo_client_lock;
> +  bool _duplexer;
>    bool __reg2 wait (HANDLE);
>    NTSTATUS npfs_handle (HANDLE &);
>    HANDLE create_pipe_instance (bool);
> diff --git a/winsup/cygwin/fhandler_fifo.cc b/winsup/cygwin/fhandler_fifo.cc
> index 2c20444c6..7847cca82 100644
> --- a/winsup/cygwin/fhandler_fifo.cc
> +++ b/winsup/cygwin/fhandler_fifo.cc
> @@ -33,7 +33,7 @@ STATUS_PIPE_EMPTY simply means there's no data to be read. */
>  fhandler_fifo::fhandler_fifo ():
>    fhandler_base (), read_ready (NULL), write_ready (NULL),
>    listen_client_thr (NULL), lct_termination_evt (NULL), nclients (0),
> -  nconnected (0)
> +  nconnected (0), _duplexer (false)
>  {
>    pipe_name_buf[0] = L'\0';
>    need_fork_fixup (true);
> @@ -224,6 +224,8 @@ fhandler_fifo::create_pipe_instance (bool first)
>      }
>    access = GENERIC_READ | FILE_READ_ATTRIBUTES | FILE_WRITE_ATTRIBUTES
>      | SYNCHRONIZE;
> +  if (first && _duplexer)
> +    access |= GENERIC_WRITE;
>    sharing = FILE_SHARE_READ | FILE_SHARE_WRITE;
>    hattr = OBJ_INHERIT;
>    if (first)
> @@ -437,7 +439,7 @@ fhandler_fifo::open (int flags, mode_t)
>      case O_RDWR:
>        reader = true;
>        writer = false;
> -      duplexer = true;
> +      duplexer = _duplexer = true;
>        break;
>      default:
>        set_errno (EINVAL);
> @@ -447,7 +449,7 @@ fhandler_fifo::open (int flags, mode_t)
>  
>    debug_only_printf ("reader %d, writer %d, duplexer %d", reader, writer, duplexer);
>    set_flags (flags);
> -  if (reader)
> +  if (reader && !duplexer)
>      nohandle (true);
>  
>    /* Create control events for this named pipe */
> @@ -472,6 +474,48 @@ fhandler_fifo::open (int flags, mode_t)
>        goto out;
>      }
>  
> +  /* If we're a duplexer, create the pipe and the first client. */
> +  if (duplexer)
> +    {
> +      HANDLE ph, connect_evt, dummy_evt;
> +      fhandler_base *fh;
> +
> +      ph = create_pipe_instance (true);
> +      if (!ph)
> +	{
> +	  res = error_errno_set;
> +	  goto out;
> +	}
> +      set_io_handle (ph);
> +      set_pipe_non_blocking (ph, true);
> +      if (!(fh = build_fh_dev (dev ())))
> +	{
> +	  set_errno (EMFILE);
> +	  res = error_errno_set;
> +	  goto out;
> +	}
> +      fh->set_io_handle (ph);
> +      fh->set_flags (flags);
> +      if (!(connect_evt = create_event ()))
> +	{
> +	  res = error_errno_set;
> +	  fh->close ();
> +	  delete fh;
> +	  goto out;
> +	}
> +      if (!(dummy_evt = create_event ()))
> +	{
> +	  res = error_errno_set;
> +	  delete fh;
> +	  fh->close ();
> +	  CloseHandle (connect_evt);
> +	  goto out;
> +	}
> +      client[0] = fifo_client_handler (fh, fc_connected, connect_evt,
> +				       dummy_evt);
> +      nconnected = nclients = 1;
> +    }
> +
>    /* If we're reading, start the listen_client thread (which should
>       signal read_ready), and wait for a writer. */
>    if (reader)
> @@ -482,8 +526,8 @@ fhandler_fifo::open (int flags, mode_t)
>  	  res = error_errno_set;
>  	  goto out;
>  	}
> -      /* Wait for the listen_client thread to create the pipe and
> -	 signal read_ready.  This should be quick.  */
> +      /* Wait for the listen_client thread to signal read_ready.  This
> +	 should be quick.  */
>        HANDLE w[2] = { listen_client_thr, read_ready };
>        switch (WaitForMultipleObjects (2, w, FALSE, INFINITE))
>  	{
> @@ -703,12 +747,25 @@ fhandler_fifo::raw_read (void *in_ptr, size_t& len)
>  		fifo_client_unlock ();
>  		return;
>  	      }
> -	    else if (nread < 0 && GetLastError () != ERROR_NO_DATA)
> -	      {
> -		fifo_client_unlock ();
> -		goto errout;
> -	      }
> -	    else if (nread == 0) /* Client has disconnected. */
> +	    /* In the duplex case with no data, we seem to get nread
> +	       == -1 with ERROR_PIPE_LISTENING on the first attempt to
> +	       read from the duplex pipe (client[0]), and nread == 0
> +	       on subsequent attempts. */
> +	    else if (nread < 0)
> +	      switch (GetLastError ())
> +		{
> +		case ERROR_NO_DATA:
> +		  break;
> +		case ERROR_PIPE_LISTENING:
> +		  if (_duplexer && i == 0)
> +		    break;
> +		  /* Fall through. */
> +		default:
> +		  fifo_client_unlock ();
> +		  goto errout;
> +		}
> +	    else if (nread == 0 && (!_duplexer || i > 0))
> +	      /* Client has disconnected. */
>  	      {
>  		client[i].state = fc_invalid;
>  		nconnected--;
> -- 
> 2.17.0
> 


-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
