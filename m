Return-Path: <SRS0=8gjk=QE=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.226.37])
	by sourceware.org (Postfix) with ESMTPS id F1AF43858CDA
	for <cygwin-patches@cygwin.com>; Fri,  6 Sep 2024 10:34:13 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org F1AF43858CDA
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org F1AF43858CDA
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1725618856; cv=none;
	b=JcSWyS1beZbm054cLNKQKZoCX2qWVnpQbDd3ty5Mlx4o6VoJ1n1uShz8TEa1n8S7XsyoQx5GkmTwCRNBuY+JXyUj9utI2TtYpdH672aJz2tln1vBHodPxgR7td9rbItQ7+BatehLgWMdnDm1M+N2G0MQY+2I+4zzmKB2Ds4Igy4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1725618856; c=relaxed/simple;
	bh=F+xzEqZJ5BaV5EmDxd2vCZaRasgI4YbUv15ioPtt+BI=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=sJLZt6eb+XpjUYCqdFvq+J+rhl8D44oTvIUNxSPFBWne0z3R1oiOLW7lM0zlFS9FyejAXs3mHSwGuOGw0NgSY9jPEdTWWInbqN3i77f/VZVEJiOWit2WbvrUz/D7EcLxrf0tNL6/3sjFDiwuOJSUUHYt3zs8Bw91gos9s0J9JYk=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20240906103412129.MJIF.94949.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Fri, 6 Sep 2024 19:34:12 +0900
Date: Fri, 6 Sep 2024 19:34:11 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: pipe: Switch pipe mode to blocking mode by
 defaut
Message-Id: <20240906193411.b9af2afb16f9c79db4b4de1a@nifty.ne.jp>
In-Reply-To: <20240906090116.59-1-takashi.yano@nifty.ne.jp>
References: <20240906090116.59-1-takashi.yano@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1725618852;
 bh=wQ4iXK35kxu59L92g9LF0KQSInHbs4uT1QKg6cmt6yk=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=NMzCK2JnM8jY4+gGniHNIi7LGRd9ghS7eeT42pW+waibSCUuix1dLwSs8w8XyaKOva+fXynr
 WSwNcpAMomg3jGIvHzrFsPnkHUKE+XCXO1Rx0cOPqSq546BmR5PMJq7AgFAFnUvfeXH4oTlWWx
 ZrCVPmH7CjRwifna7X5WjJdfchbxRx/p6Fd/S819Az5K0aOYkXTRN9RhuQeLlGFhAU0/KGzNY/
 UFxKK0SihgVulXTnFYPyVDQBu0ejSYFJxJImwgSgT2XZD346TQ1gP0XWltZKD7jfbw1wQBOSlH
 AwtOQf3blqujmwtXaS/2nhdbIT9ExqrF79XXEcHHIFbTftKw==
X-Spam-Status: No, score=-11.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Fri,  6 Sep 2024 18:01:08 +0900
Takashi Yano wrote:
> diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
> index bc02c3f9d..9ddb9898c 100644
> --- a/winsup/cygwin/select.cc
> +++ b/winsup/cygwin/select.cc
> @@ -642,7 +642,7 @@ pipe_data_available (int fd, fhandler_base *fh, HANDLE h, int flags)
>          Consequentially, the only reliable information is available on the
>          read side, so fetch info from the read side via the pipe-specific
>          query handle.  Use fpli.WriteQuotaAvailable as storage for the actual
> -        interesting value, which is the InboundQuote on the write side,
> +        interesting value, which is the IutboundQuota on the write side,
>          decremented by the number of bytes of data in that buffer. */
>        /* Note: Do not use NtQueryInformationFile() for query_hdl because
>  	 NtQueryInformationFile() seems to interfere with reading pipes
> @@ -655,19 +655,17 @@ pipe_data_available (int fd, fhandler_base *fh, HANDLE h, int flags)
>  	 handling this fact. */
>        if (fh->get_device () == FH_PIPEW && fpli.WriteQuotaAvailable == 0)
>  	{
> -	  HANDLE query_hdl = ((fhandler_pipe *) fh)->get_query_handle ();
> -	  if (!query_hdl)
> -	    query_hdl = ((fhandler_pipe *) fh)->temporary_query_hdl ();
> -	  if (!query_hdl) /* We cannot know actual write pipe space. */
> -	    return (flags & PDA_SELECT) ? PIPE_BUF : 1;
> -	  DWORD nbytes_in_pipe;
> -	  BOOL res =
> -	    PeekNamedPipe (query_hdl, NULL, 0, NULL, &nbytes_in_pipe, NULL);
> -	  if (!((fhandler_pipe *) fh)->get_query_handle ())
> -	    CloseHandle (query_hdl); /* Close temporary query_hdl */
> -	  if (!res) /* We cannot know actual write pipe space. */
> -	    return (flags & PDA_SELECT) ? PIPE_BUF : 1;
> -	  fpli.WriteQuotaAvailable = fpli.InboundQuota - nbytes_in_pipe;
> +	  /* NtSetInformationFile() in set_pipe_non_blocking(true)
> +	     seems to fail for unknown reasons with STATUS_PIPE_BUSY
> +	     if no reader is reading the pipe. In this case, the pipe
> +	     is really full if WriteQuotaAvailable is zero. Otherwise,
> +	     the pipe is empty. */
> +	  if (!((fhandler_pipe *) fh)->set_pipe_non_blocking (true))
> +	    return 0; /* Full */
> +	  /* Restore pipe mode to blocking mode */
> +	  ((fhandler_pipe *) fh)->set_pipe_non_blocking (false);
> +	  /* Empty */
> +	  fpli.WriteQuotaAvailable = fpli.IutboundQuota;
                                          ^^^ In
Of cource...

>  	}
>        if (fpli.WriteQuotaAvailable > 0)
>  	{

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
