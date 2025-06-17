Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 0D92A382F7EF; Tue, 17 Jun 2025 09:06:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0D92A382F7EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1750151212;
	bh=fiwcgIX/kpK9qnm7zTJmCrSg5+84anOVZW2e46CBiWo=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=dRelC7uRjUGEzwTknpy2xy51Ozzq4Ac0XeurBlUqiO/OeSrHXGZOdyRLT6Gzm/LoC
	 6FSCvarAl7/zlzGv+d6rCeb6TcJzzNkdf3ivCfMx9DhaysNBReI9Zme8GlyzPVF5Xj
	 WssPBpCmWIAYiv2OyXlFvB45NnCsFEGSPYq0+RnY=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id DB1BAA80961; Tue, 17 Jun 2025 11:06:49 +0200 (CEST)
Date: Tue, 17 Jun 2025 11:06:49 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: signal: Prevent unexpected crash on frequent
 SIGSEGV
Message-ID: <aFEwKctHcO9qtp61@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20250528125222.2347-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250528125222.2347-1-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On May 28 21:52, Takashi Yano wrote:
> +#ifdef __x86_64__
> +      /* When the Rip points to an instruction that causes an exception,
> +	 modifying Rip and calling ResumeThread() may sometimes result in
> +	 a crash. To prevent this, advance execution by a single instruction
> +	 by setting the trap flag (TF) before calling ResumeThread(). This
> +	 will trigger either STATUS_SINGLE_STEP or the exception caused by
> +	 the instruction that Rip originally pointed to.  By suspending the
> +	 targeted thread within exception::handle(), Rip no longer points
> +	 to the problematic instruction, allowing safe handling of the
> +	 interrupt. As a result, Rip can be adjusted appropriately, and the
> +	 thread can resume execution without unexpected crashes.  */
> +      if (!inside_kernel (cx, true))
> +	{
> +	  cx->EFlags |= 0x100; /* Set TF (setup single step execution) */
> +	  SetThreadContext (*this, cx);
> +	  suspend_on_exception = true;
> +	  ResumeThread (*this);
> +	  ULONG cnt = 0;
> +	  NTSTATUS status;
> +	  do
> +	    {
> +	      yield ();
> +	      status = NtQueryInformationThread (*this, ThreadSuspendCount,
> +						 &cnt, sizeof (cnt), NULL);
> +	    }
> +	  while (NT_SUCCESS (status) && cnt == 0);
> +	  GetThreadContext (*this, cx);

Doesn't this return cx->EFlags with the single step flag set?  Otherwise
this looks ok.

Thanks,
Corinna
