Return-Path: <SRS0=tMiW=KR=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e07.mail.nifty.com (mta-snd-e07.mail.nifty.com [106.153.226.39])
	by sourceware.org (Postfix) with ESMTPS id 03ED13858C98
	for <cygwin-patches@cygwin.com>; Mon, 11 Mar 2024 11:42:40 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 03ED13858C98
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 03ED13858C98
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1710157364; cv=none;
	b=Tj65SssiEG7S7T/XdVDRfkNjF6ucRnnsoLuH294/35YxscUA7lqbzS9K2MagW7Q6lk8SwQigmLR1d+kWsihcyHYOLPsvfz6r9hmXBP1fVP5TI298uPIqgVNtn3a4Ys7z5LP+8mFVqI5ICAxkmt6o863RICq7EfoTX9ytwZb25dM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1710157364; c=relaxed/simple;
	bh=hzNwBsa6auUsIBK96m1bnhrQw1Za9kJzR0HjmETPpUk=;
	h=Date:From:To:Subject:Message-Id:Mime-Version; b=S7GtPbfbc7Y+EnlNsn6gHDb8eX9qKwBj4k9CjP2mtAr+ML8cGArRHK8P0GDYMJkpU0Tg7C2YwHuHDLCc5V3Wqsp/I7RIzrYK/Gay2QKP+bmXd1U9T16P90yekggaD4psCyS/uHk5wkmmYrMbG22t5mI5Zv65eBffuyr4JNbBkdE=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from HP-Z230 by dmta0007.nifty.com with ESMTP
          id <20240311114238584.QTLN.1140.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Mon, 11 Mar 2024 20:42:38 +0900
Date: Mon, 11 Mar 2024 20:42:37 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pipe: Restore non-blocking mode which was reset
 for non-cygwin app.
Message-Id: <20240311204237.bb2ffef477328542a63b148d@nifty.ne.jp>
In-Reply-To: <Ze7hRBVYCClZg-Kq@calimero.vinschen.de>
References: <20240310103202.3753-1-takashi.yano@nifty.ne.jp>
	<Ze7hRBVYCClZg-Kq@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mon, 11 Mar 2024 11:47:32 +0100
Corinna Vinschen wrote:
> Hi Takashi,
> 
> On Mar 10 19:31, Takashi Yano wrote:
> > @@ -590,6 +591,10 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
> >  	      {
> >  		fhandler_pipe *pipe = (fhandler_pipe *)(fhandler_base *) cfd;
> >  		pipe->set_pipe_non_blocking (false);
> > +		pipew_duped = (fhandler_pipe *)
> > +			ccalloc (HEAP_FHANDLER, 1, sizeof (fhandler_pipe));
> > +		pipew_duped = new (pipew_duped) fhandler_pipe;
> > +		pipe->dup (pipew_duped, 0);
> >  		if (pipe->request_close_query_hdl ())
> >  		  need_send_sig = true;
> >  	      }
> 
> The code setting up pipes and the dummy_tty is sufficiently complex,
> so that I wonder if it shouldn't have
> 
> - its own methods and
> - comments to describe why this stuff is necessary.
> 
> What about adding two methods, kind of like (the names are only
> suggestion, albeit bad ones):
> 
>   child_info_spawn::noncygwin_child_pre_fork()
> 
> to keep the above stuff together (plus comments) and
> 
>   child_info_spawn::noncygwin_child_post_fork()
> 
> for the below code?
> 
> > @@ -597,6 +602,10 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
> >  	      {
> >  		fhandler_pipe *pipe = (fhandler_pipe *)(fhandler_base *) cfd;
> >  		pipe->set_pipe_non_blocking (false);
> > +		piper_duped = (fhandler_pipe *)
> > +			ccalloc (HEAP_FHANDLER, 1, sizeof (fhandler_pipe));
> > +		piper_duped = new (piper_duped) fhandler_pipe;
> > +		pipe->dup (piper_duped, 0);
> >  	      }
> >  
> >  	  if (need_send_sig)
> > @@ -905,6 +914,19 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
> >  	      term_spawn_worker.cleanup ();
> >  	      term_spawn_worker.close_handle_set ();
> >  	    }
> > +	  if (pipew_duped)
> > +	    {
> > +	      bool is_nonblocking = pipew_duped->is_nonblocking ();
> > +	      pipew_duped->set_pipe_non_blocking (is_nonblocking);
> 
> Is that really right?  You're asking pipew_duped for its
> nonblocking flag and then set pipew_duped to the same value...?
> 
> > +	      pipew_duped->close ();
> > +	      cfree (pipew_duped);
> > +	    }

Thanks for the reviewing and advice. I'll work for v2 patch. Please wait a while.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
