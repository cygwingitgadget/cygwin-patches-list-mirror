Return-Path: <SRS0=iP9N=BR=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w09.mail.nifty.com (mta-snd-w09.mail.nifty.com [106.153.227.41])
	by sourceware.org (Postfix) with ESMTPS id 0FED74BBC0EA
	for <cygwin-patches@cygwin.com>; Tue, 17 Mar 2026 13:56:41 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0FED74BBC0EA
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 0FED74BBC0EA
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.41
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1773755804; cv=none;
	b=AOM7XaqhzhVbjEGrgiCRgpbp+nK322OyMKFuQV+KjzykdstzhnwQBLDjVnT1l1aedBwfqdfzP7mDzFrTbVkt4v66Kk7iiH9C0vnoM1xNSLE6+QR/Ub3B/JuIjPAbWT14wYEPiJr4c41fgMUI3rQWtGSu6vl4JsagxTkhltufvH4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1773755804; c=relaxed/simple;
	bh=wmNv5iIXw0HIYFKxDyBfRG0Q1Xgj5sPnYszfUnFbbLw=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=dycDikJPwBdzIrMFETDusgGJNPJ2Ay1ujJIv0PI7UbSF9bPidnfGO1Y5smNfTVIVDspAuW1KWr6pCoRk9Qveoo5R7XY5IVYpPAYLUEQU8eniEnZX4qm6YhbB06jQfh1We6nSnIjgh/nLp8Tqw9rA9WR0v289ECy/IukchoW+Y8w=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0FED74BBC0EA
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=YORftUOv
Received: from HP-Z230 by mta-snd-w09.mail.nifty.com with ESMTP
          id <20260317135640142.CROD.116672.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 17 Mar 2026 22:56:40 +0900
Date: Tue, 17 Mar 2026 22:56:38 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 4/6] Cygwin: pty: Apply line_edit() for transferred
 input to to_cyg
Message-Id: <20260317225638.78c2ec70ace4585823340212@nifty.ne.jp>
In-Reply-To: <20260317122433.721-5-takashi.yano@nifty.ne.jp>
References: <22f45be0-3a22-f9c6-6d91-a7c2484621ef@gmx.de>
	<20260317122433.721-1-takashi.yano@nifty.ne.jp>
	<20260317122433.721-5-takashi.yano@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1773755800;
 bh=jLIymFWqBdJwAAl61z0op+ldlOgcAZ99pEhKo05C7J8=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=YORftUOv9L68zwXCEz+abujaHqUG7o6ybBv4UCTQcq3Flm6bOC21Di8L5HEN8p9h7MMYCDwY
 QFMcZ8ntoqhsP0S9/962kE7ggPsZnw5xJVeqo+eCphPVgFkIRVdzXCvGZxK03erutF0WA+d5ew
 3V0BqZ0OFX4PdNtSaG4JO/FEa7f4xf469I0ZrNRDXBdEWFL1lv1GDjKfSpc+lxgX55aE49TL6N
 5XHDeeRk4rFcFfX6q6EBO7iNGeArRZy15FlO/sTayrxjtGxoeHbNQMDODVvZulH6bnOQEe0L7t
 A9cpsIZx92VXAV8iBE0kJj/j+qQsqj5wD82vslVsCLIbMikQ==
X-Spam-Status: No, score=-10.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Sorry, this patch has a bug. Please wait a while...

On Tue, 17 Mar 2026 21:23:08 +0900
Takashi Yano wrote:
> The typeahead input while non-cygwin app is running is put into
> the pipe directly by transfer_input(). So, if the shell sets the
> terminal canonical mode, erase char (such as backspace) fails to
> erase chars transferred by transfer_input(). With this patch,
> transferred input in the pipe is read and passed to line_edit()
> to handle erase chars such as VERASE, VKILL, etc.
> 
> Fixes: 10d083c745dd ("Cygwin: pty: Inherit typeahead data between two input pipes.")
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by:
> ---
>  winsup/cygwin/fhandler/pty.cc           | 40 +++++++++++++++++++++++--
>  winsup/cygwin/local_includes/fhandler.h |  2 ++
>  winsup/cygwin/local_includes/tty.h      |  1 +
>  winsup/cygwin/tty.cc                    |  1 +
>  4 files changed, 41 insertions(+), 3 deletions(-)
> 
> diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
> index bde88ab0e..1be853993 100644
> --- a/winsup/cygwin/fhandler/pty.cc
> +++ b/winsup/cygwin/fhandler/pty.cc
> @@ -2734,6 +2734,28 @@ reply:
>    return 0;
>  }
>  
> +void
> +fhandler_pty_master::apply_line_edit_to_transferred_input ()
> +{
> +  const size_t pipesize = fhandler_pty_common::pipesize;
> +  if (get_ttyp ()->input_transferred_to_cyg)
> +    {
> +      char buf[pipesize];
> +      DWORD n;
> +      ReadFile (from_master, buf, pipesize, &n, NULL);
> +      char *p = buf;
> +      while (n)
> +	{
> +	  ssize_t ret;
> +	  line_edit (p, n, get_ttyp ()->ti, &ret);
> +	  n -= ret;
> +	  p += ret;
> +	}
> +      SetEvent (input_available_event);
> +      get_ttyp ()->input_transferred_to_cyg = false;
> +    }
> +}
> +
>  static DWORD
>  pty_master_thread (VOID *arg)
>  {
> @@ -2924,8 +2946,15 @@ fhandler_pty_master::pty_master_fwd_thread (const master_fwd_thread_param_t *p)
>      {
>        p->ttyp->fwd_last_time = GetTickCount64 ();
>        DWORD n;
> -      p->ttyp->fwd_not_empty =
> -	::bytes_available (n, p->from_slave_nat) && n;
> +      while (true)
> +	{
> +	  p->ttyp->fwd_not_empty =
> +	    ::bytes_available (n, p->from_slave_nat) && n;
> +	  if (p->ttyp->fwd_not_empty || p->ttyp->stop_fwd_thread)
> +	    break;
> +	  p->master->apply_line_edit_to_transferred_input ();
> +	  Sleep (1);
> +	}
>        if (!ReadFile (p->from_slave_nat, outbuf, NT_MAX_PATH, &rlen, NULL))
>  	{
>  	  termios_printf ("ReadFile for forwarding failed, %E");
> @@ -4005,6 +4034,7 @@ fhandler_pty_master::get_master_fwd_thread_param (master_fwd_thread_param_t *p)
>    p->from_slave_nat = from_slave_nat;
>    p->output_mutex = output_mutex;
>    p->ttyp = get_ttyp ();
> +  p->master = this;
>    SetEvent (thread_param_copied_event);
>  }
>  
> @@ -4193,7 +4223,11 @@ fhandler_pty_slave::transfer_input (tty::xfer_dir dir, HANDLE from, tty *ttyp,
>  			     so no data available in cyg pipe. */
>      ResetEvent (input_available_event);
>    else if (transfered) /* There is data transfered to cyg pipe. */
> -    SetEvent (input_available_event);
> +    {
> +      ttyp->input_transferred_to_cyg = true;
> +      while (ttyp->input_transferred_to_cyg)
> +	yield ();
> +    }
>    ttyp->pty_input_state = dir;
>    ttyp->discard_input = false;
>  }
> diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/local_includes/fhandler.h
> index 16f55b4f7..f24ae199e 100644
> --- a/winsup/cygwin/local_includes/fhandler.h
> +++ b/winsup/cygwin/local_includes/fhandler.h
> @@ -2551,6 +2551,7 @@ public:
>      HANDLE from_slave_nat;
>      HANDLE output_mutex;
>      tty *ttyp;
> +    fhandler_pty_master *master;
>    };
>  private:
>    int pktmode;			// non-zero if pty in a packet mode.
> @@ -2627,6 +2628,7 @@ public:
>    void get_master_thread_param (master_thread_param_t *p);
>    void get_master_fwd_thread_param (master_fwd_thread_param_t *p);
>    bool need_send_ctrl_c_event ();
> +  void apply_line_edit_to_transferred_input ();
>  };
>  
>  class fhandler_dev_null: public fhandler_base
> diff --git a/winsup/cygwin/local_includes/tty.h b/winsup/cygwin/local_includes/tty.h
> index 9485e24c5..6e4460e30 100644
> --- a/winsup/cygwin/local_includes/tty.h
> +++ b/winsup/cygwin/local_includes/tty.h
> @@ -141,6 +141,7 @@ private:
>    xfer_dir pty_input_state;
>    bool discard_input;
>    bool stop_fwd_thread;
> +  volatile bool input_transferred_to_cyg;
>  
>  public:
>    HANDLE from_master_nat () const { return _from_master_nat; }
> diff --git a/winsup/cygwin/tty.cc b/winsup/cygwin/tty.cc
> index acc21c0ca..046c02ad1 100644
> --- a/winsup/cygwin/tty.cc
> +++ b/winsup/cygwin/tty.cc
> @@ -255,6 +255,7 @@ tty::init ()
>    last_sig = 0;
>    discard_input = false;
>    stop_fwd_thread = false;
> +  input_transferred_to_cyg = false;
>  }
>  
>  HANDLE
> -- 
> 2.51.0
> 


-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
