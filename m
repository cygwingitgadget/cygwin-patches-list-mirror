Return-Path: <SRS0=8gjk=QE=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e04.mail.nifty.com (mta-snd-e04.mail.nifty.com [106.153.226.36])
	by sourceware.org (Postfix) with ESMTPS id 679613858CDA
	for <cygwin-patches@cygwin.com>; Fri,  6 Sep 2024 10:21:30 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 679613858CDA
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 679613858CDA
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.36
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1725618094; cv=none;
	b=vUD835WeJrB/PEZnhOLWklDKDH1XvMgEv/kWWDODeac6c8RX86vB5Qa6ANJzQO5/FG9fVzMzjgKi3ScXLFjKxBUCGZrhCMM6UsrmFErolfT0d6fegOpD1I0O3Q9pK/QdDWsSMFGvskxFVOhaoD0fOR/qeGLF9mXHjSrZwbImEfk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1725618094; c=relaxed/simple;
	bh=IhzUHN44cpgYH+Jexzj8dZR1Mrd1V/hvezmaU3WRTlE=;
	h=Date:From:To:Message-Id:Mime-Version:DKIM-Signature:Subject; b=fho4O3LFP94/AHfOPMcPxL+tlKQlnL6vJX7xgIxZfTZQySk7mDWIRogMTyWdUboYE7GVwtXdP2+x7cx0vilCDGjM4NSiu9sjDel0xhzvMfxH4nDjBkEHOoXuL19wBQYHzctlMlxO5FOfLsb5lLYeRzjsdkTFD7+BzY9kFrYcWGs=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from HP-Z230 by mta-snd-e04.mail.nifty.com with ESMTP
          id <20240906102128272.KHLO.84424.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Fri, 6 Sep 2024 19:21:28 +0900
Authentication-Results: nifty.com; spf=pass
	 smtp.mailfrom=takashi.yano@nifty.ne.jp; sender-id=pass
	 header.From=takashi.yano@nifty.ne.jp; dkim=pass header.i=@nifty.ne.jp;
	 dkim-adsp=pass header.from=takashi.yano@nifty.ne.jp
Date: Fri, 6 Sep 2024 19:18:19 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
Message-Id: <20240906191819.99f04d53ae315fd2abfe3d7f@nifty.ne.jp>
In-Reply-To: <20240906090116.59-1-takashi.yano@nifty.ne.jp>
References: <20240906090116.59-1-takashi.yano@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1725617899;
 bh=+jBpe3u4BI0ujDUW2aqEs967v0zX4zqBxlPBou6mrBM=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=m5a+FXcxeyqBpiXq0dxfkK2ibiLLKxAAXXVHwwFGV2Rzicg7UtrkspFemL2DoC295ktSU95z
 qNcSOun+WRkrZWWbt9Uue1ivPvzYzYkuYwaZ/XPHfpeuKGDjjP4jtK26mXSH6ENIAqCn4zksS/
 SsFVRyLGruIdJ9lHR6DE1WGhHcqW+gj1WSuNwRDj6hVRJEDnNSEhykkYlScqH3UQ9jG4ERkOWc
 lSMCTPaLHztDfLNC+1jI8YI4Th2AFrHJd9Fo6xlDxBhCBvai/36R4m7QlMN8Swk9yhL7DeaxtT
 cdjl6btvwgpwohta2iPRJGR2tUYBwCsdbwbQZoQsjvhHv3Uw==
Resent-Date: Fri, 6 Sep 2024 19:21:27 +0900
Resent-From: Takashi Yano <takashi.yano@nifty.ne.jp>
Resent-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: pipe: Switch pipe mode to blocking mode by
 defaut
Resent-Message-Id: <20240906192127.89eba67eb39b8c81f561cca0@nifty.ne.jp>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Fri,  6 Sep 2024 18:01:08 +0900
Takashi Yano wrote:
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
of cource...
>  	}
>        if (fpli.WriteQuotaAvailable > 0)
>  	{


-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
