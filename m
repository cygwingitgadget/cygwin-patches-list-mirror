Return-Path: <SRS0=yf1H=ZA=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e03.mail.nifty.com (mta-snd-e03.mail.nifty.com [106.153.227.115])
	by sourceware.org (Postfix) with ESMTPS id 8D26F3843B76
	for <cygwin-patches@cygwin.com>; Tue, 17 Jun 2025 12:07:02 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 8D26F3843B76
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 8D26F3843B76
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.115
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750162023; cv=none;
	b=hEHHf57QtK/4eLeU8mQO27hiLwgAW45+P9iEm4E29zW23N2lBpaaQfSquS0CsK/ykZkew6niebiBZsY1sAXpJyZVbx1B8VBVAIQb715COHDwHjk+kdEy+zqRU98yfedUMMkfth5ER235T4b1WdX0sSkntfrJzn0eYhullqwtVnQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750162023; c=relaxed/simple;
	bh=D57M8WZnGecQf1EPNRQDgBT8PS1leEFri5S8uXcxhOQ=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=HJJ6Dp1MmUhjoYa67bl3Z5ZslKvmug4jzYVvYperJQ8TIaKnRIOHEfi9vEyccYbxOTlHS7eZePL+Z+wUGW3XFByTnQbCnQ+KGLiIywziwFumNDq7gUQmFCXMxXxwvSIGkBQ/V5wMTAM6qIPBHtu7j13eEPNNf4KvLK/4UWHCqjQ=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 8D26F3843B76
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=rBgoa6LW
Received: from HP-Z230 by mta-snd-e03.mail.nifty.com with ESMTP
          id <20250617120700287.CAUQ.110778.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 17 Jun 2025 21:07:00 +0900
Date: Tue, 17 Jun 2025 21:06:59 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: signal: Prevent unexpected crash on frequent
 SIGSEGV
Message-Id: <20250617210659.68de6c2de5ba4a3a76e395be@nifty.ne.jp>
In-Reply-To: <aFEwKctHcO9qtp61@calimero.vinschen.de>
References: <20250528125222.2347-1-takashi.yano@nifty.ne.jp>
	<aFEwKctHcO9qtp61@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1750162020;
 bh=zYgB76a3AfgAycdn0a/sk3ymx7GWNZZLaxLXvX2c8TQ=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=rBgoa6LWh/RzvxTGj4ee/79uGtRZdPnKrL9jq3TM/rCKsjtdxStz4LC26/nRuVHcG6fr/Cf2
 9kVS8PANCY7bjNMJnq7GS2qSyyTwUGcpP4xEsDyJu6w5zTXV+ziVBL8j0n8z3QLdVTK4otdYc9
 88V5nzDN3EC/qN8mngm/BMAs5LyCcYi0KVnEkF6pr7rJOxcSSr1xWQMqTBiKGEOp4sPolq/6Nb
 XYzr+FPuELvRTeLaVTe5K5NwdVd5bersJ0uoisAoCc2PDAqLVSMjBPyUMjYI5xlBVkg9ykIIPn
 v4rHlhL8+xr/tyPQQBGf4HeKm3X0x95UcNiAtZJCnpA+SVzw==
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 17 Jun 2025 11:06:49 +0200
Corinna Vinschen wrote:
> Hi Takashi,
> 
> On May 28 21:52, Takashi Yano wrote:
> > +#ifdef __x86_64__
> > +      /* When the Rip points to an instruction that causes an exception,
> > +	 modifying Rip and calling ResumeThread() may sometimes result in
> > +	 a crash. To prevent this, advance execution by a single instruction
> > +	 by setting the trap flag (TF) before calling ResumeThread(). This
> > +	 will trigger either STATUS_SINGLE_STEP or the exception caused by
> > +	 the instruction that Rip originally pointed to.  By suspending the
> > +	 targeted thread within exception::handle(), Rip no longer points
> > +	 to the problematic instruction, allowing safe handling of the
> > +	 interrupt. As a result, Rip can be adjusted appropriately, and the
> > +	 thread can resume execution without unexpected crashes.  */
> > +      if (!inside_kernel (cx, true))
> > +	{
> > +	  cx->EFlags |= 0x100; /* Set TF (setup single step execution) */
> > +	  SetThreadContext (*this, cx);
> > +	  suspend_on_exception = true;
> > +	  ResumeThread (*this);
> > +	  ULONG cnt = 0;
> > +	  NTSTATUS status;
> > +	  do
> > +	    {
> > +	      yield ();
> > +	      status = NtQueryInformationThread (*this, ThreadSuspendCount,
> > +						 &cnt, sizeof (cnt), NULL);
> > +	    }
> > +	  while (NT_SUCCESS (status) && cnt == 0);
> > +	  GetThreadContext (*this, cx);
> 
> Doesn't this return cx->EFlags with the single step flag set?  Otherwise
> this looks ok.

Thanks for reviewing.
IIUC, TF flag is automatically cleard when single step inturrupt is triggered.
I also checked the cx->EFlags at above GetThreadContext(), and the TF flag was
not set at that point.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
