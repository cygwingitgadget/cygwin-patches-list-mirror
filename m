Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 805093858CD1; Wed, 27 Nov 2024 16:37:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 805093858CD1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1732725478;
	bh=ugBlCJnql4NfB+cj7xJjojyt7EHdILYlIRqreXsczZc=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=iRMYki4n6RI26b6dd7WbElS2S3q7UTXXO5RmEjQiwmFLIKfgRuBu6LUkrLWp1sTgT
	 DnbuQMnv9/ZAJ/J/bRWKXTAvTEtPN/WSBgfClN85zdimHBImAMMDSGngMkU7A1x1M4
	 tLEg68vY5vazjLmoJxMnaEt5vf1kULipYm67OK3k=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id A3157A80E4D; Wed, 27 Nov 2024 17:37:55 +0100 (CET)
Date: Wed, 27 Nov 2024 17:37:55 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 3/7] Cygwin: signal: Cleanup signal queue after
 processing it
Message-ID: <Z0dK41-dW1BnMlqe@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20241126085521.49604-1-takashi.yano@nifty.ne.jp>
 <20241126085521.49604-4-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241126085521.49604-4-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Nov 26 17:55, Takashi Yano wrote:
> The queue is once cleaned up, however, sigpacket::process() may set
> si_signo in the queue to 0 by calling sig_clear(). This patch adds
> another loop for cleanup after calling sigpacket::process().
> 
> Addresses: https://cygwin.com/pipermail/cygwin/2024-November/256744.html
> Fixes: 9d2155089e87 ("(wait_sig): Define variable q to be the start of the signal queue.  Just iterate through sigq queue, deleting processed or zeroed signals")
> Reported-by: Christian Franke <Christian.Franke@t-online.de>
> Reviewed-by:
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>  winsup/cygwin/sigproc.cc | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
> index 8f46a80ab..b8d961a07 100644
> --- a/winsup/cygwin/sigproc.cc
> +++ b/winsup/cygwin/sigproc.cc
> @@ -1463,6 +1463,17 @@ wait_sig (VOID *)
>  		      qnext->si.si_signo = 0;
>  		    }
>  		}
> +	      /* Cleanup sigq chain. Remove entries having si_signo == 0.
> +		 There were once cleaned obeve, however sigpacket::process()
> +		 may set si_signo to 0 using sig_clear(). */
> +	      q = &sigq.start;
> +	      while ((qnext = q->next))
> +		{
> +		  if (qnext->si.si_signo)
> +		    q = qnext;
> +		  else
> +		    q->next = qnext->next;
> +		}

I'm not quite sure, but wouldn't it make more sense to change
sig_clear() so that it actually removes the entries from the queue
immediately?  Using Interlocked functions on the queue may even
avoid locking...


Thanks,
Corinna
