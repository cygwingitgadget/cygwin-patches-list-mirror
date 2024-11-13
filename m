Return-Path: <SRS0=YazL=SI=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	by sourceware.org (Postfix) with ESMTPS id EAD223858D26
	for <cygwin-patches@cygwin.com>; Wed, 13 Nov 2024 10:50:43 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org EAD223858D26
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org EAD223858D26
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.17.20
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1731495049; cv=none;
	b=QWajWB99ib73zdEGXL2TU5kop5FRFY6rae9hAyRW80W+6CQkzpwioMz9TDH7aiquWH5yXA860i/JuIgRt5P01uOZ/Om4Ov08RHP6O6LYz33/XkrSwruH2kd8Phlr7atS4Pww987SWiJlbLzfjdPzQmY93iNz3bxTSvIwPQ/7RzA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1731495049; c=relaxed/simple;
	bh=aaOxtikn6RlcSTSGftEtJyH3uI8iiXVtJm35L/Zph8Q=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=tNK+nUFUwRFxB7vssxDd458iknKLuj1tkYKysPJRKwFq6D/ui2AG+fldtCK27gbjkKzBTr4Ygiu2GmcHbWsD0c9LzKT1+DVMZoRe0ZJRYGEkHFzKhsgWgY0JG6lAmmxkXbgoFUP3xDsTj55MyOuizWcb9VbwN5KnWu4vbuqLwe4=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1731495040; x=1732099840;
	i=johannes.schindelin@gmx.de;
	bh=0dl8AOO7akcZ/WVM1dqseNIdTQAPBouZqCXW1SyKsAM=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=mORSPTTnC/wYxpe8FsCS8PUPOSCyBB5tg2SD5f29/Jg2Tg9rSmUpypcjXVvSCK8u
	 f0J8xcIF6czeC8g44F0tItgrxjOLcM+LvAPZe0Px09wHd5RjPFMnyd8UF6CrliJ5/
	 4MUUS3/h6/YPUH8wfYNkJYtqy6enHpO5DsYHCEH/fyOmagZUe3+yLLE6DVlEpeVTg
	 IxrazZodcVlt6U9tzGd5efv/AYjq2+ydDE9a6HDNQv6k5lwLatKJGT0PivnxZXT/3
	 GSVmLvKyjQ8jEuZH+oPWpMXH+Owg0VjMbrvq0ynNAQFnv3Qc1J8RlfXe1yOpt7zEU
	 EXIBeqLTG3i1p5UMVQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.215.196]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N0G1n-1txFF12u07-00zGxE; Wed, 13
 Nov 2024 11:50:40 +0100
Date: Wed, 13 Nov 2024 11:50:39 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jeremy Drake <cygwin@jdrake.com>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygthread: suspend thread before terminating.
In-Reply-To: <2c68d6fe-5493-b7e0-6335-de5a68d3cd3f@jdrake.com>
Message-ID: <eee61bf2-edfe-c06c-bf80-188b7cdf22df@gmx.de>
References: <2c68d6fe-5493-b7e0-6335-de5a68d3cd3f@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:le7RsxMfkS+ZauDNILLutQMRx8bGZXqUrjtKmIHGabzLIvK4QdW
 bFbiYkdGfWX1iHdZkFECS1gpXAEHIL7F7pIFD7ejMBoQB2vQwoubshckLKyQKqXZGtUBbWH
 o04/2di1NzzrFrNTnwwHyaNzg0ZqLJgghKSZA39G/1nWAYEn+qWHv6jewUo8eUPaU/kSxII
 aoGcN0FMjNH8Vhm/DtJtg==
UI-OutboundReport: notjunk:1;M01:P0:ACc8KrwPCag=;JdIjPI4x8dOHjUa3xtnbQWyIXwT
 G1uX6lLYw7uW8A23A/SrDPpWWEAGbM++ep1/twFXrv7OgMlpfh2UMSpHiN/6UDdx0JyVAU1rp
 KqeeTdLoeH5duVn4K4aNIFXPlkdF8UKN2WreOLSKFH5hjhvH3MYLl2bJ9cev1r8R920Ov+9l8
 57ynqNOX1yQsrTx88nnmXZNjjnqZIfQc6AbW0hdkzNDVHv++JUwbGGKvGhya5tesmurFqNofZ
 JQXQWo/27wSkiZ0js2zuvjzz7LKQtJjwA58y9hy4xB/M/Hyl6KWOhzgFgz8ERPio4z9JBy2U2
 35ctENDFYj+4RIfp+3ydML8kQJHBeH1wsBof7plKWUJU/APjAWrOp7a81VsJPzNhdvD9Y2nGf
 d9JXo9gsBi5XEoZ6X/t7t4Y6gPKpAt0b4l+hH9cw7i4zfi7usf6zo4EYyRHhZFJn8PVDO7wHw
 TBQNvrBxM9jD7ucTBVWfYLPo+CXFoCt/yaEznEPGJLRrqOjQdZNAj5Dkb4UE+cJ3pkqMaM+aM
 9xPQTZ48fTm1B2kYRDSgHK9j+/ei8BlD4cOcSPgFV/PYmhbw1baz13GFHAE7D27XoWJwP6m0B
 GVAjYQzxTtC4N8JkBUFUnELqeecVa+bK1lrmUgPRWZGMh0qJM5gSCbS651fEbYrjoY+5XSyIj
 mUKBhFMYmK0zj5ZuZCStK5mNvWvKOu49XzpYJ/IHi9+X4ejSJbPBhknyV9q5uXs1ty9J29zpZ
 3BOTODrXB/ItgNJPOz72pphDMKi6ulwikfR6hbb4wRT2HwUkP2WJLl9LNVDDiUoFC3VkvgWFt
 BqkuCmd+LdEvBKhaBk1r5C2e/ip+SY6mkbhWnDysd/NNGfqRHMXpvEgdZEycj1vzCNreJAtH/
 zlp1065xJ8E+TJNSi+eKbDiaHwvdXd/cC00Dscc5jQAbGUq4wnr2eFHpO
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-12.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Jeremy,

On Tue, 12 Nov 2024, Jeremy Drake via Cygwin-patches wrote:

> From: Jeremy Drake <cygwin@jdrake.com>
>
> This addresses an extremely difficult to debug deadlock when running
> under emulation on ARM64.
>
> A relatively easy way to trigger this bug is to call `fork()`, then with=
in the
> child process immediately call another `fork()` and then `exit()` the
> intermediate process.
>
> It would seem that there is a "code emulation" lock on the wait thread a=
t
> this stage, and if the thread is terminated too early, that lock still e=
xists
> albeit without a thread, and nothing moves forward.
>
> It seems that a `SuspendThread()` combined with a `GetThreadContext()`
> (to force the thread to _actually_ be suspended, for more details see
> https://devblogs.microsoft.com/oldnewthing/20150205-00/?p=3D44743)
> makes sure the thread is "booted" from emulation before it is suspended.
>
> Hopefully this means it won't be holding any locks or otherwise leave
> emulation in a bad state when the thread is terminated.
>
> Also, attempt to use `CancelSynchonousIo()` (as seen in `flock.cc`) to a=
void
> the need for `TerminateThread()` altogether.  This doesn't always work,
> however, so was not a complete fix for the deadlock issue.
>
> Addresses: https://cygwin.com/pipermail/cygwin-developers/2024-May/01269=
4.html
> Signed-off-by: Jeremy Drake <cygwin@jdrake.com>

Excellent work! Thank you for your impressive tenacity to stick with this
problem. I built an MSYS2 runtime with the fix in
https://github.com/git-for-windows/msys2-runtime/pull/73, and then started
your reproducer from
https://inbox.sourceware.org/cygwin-developers/78f294de-4c94-242a-722e-fd9=
8e51edff9@jdrake.com/,
and it failed to dead-lock so far (it's been running for almost an hour).

In other words, I would like to offer my support for including this in
Cygwin so that these dead-locks on Windows/ARM64 will be a thing of the
past.

Thank you so, so much,
Johannes

> ---
>  winsup/cygwin/cygthread.cc | 14 ++++++++++++++
>  winsup/cygwin/sigproc.cc   |  3 ++-
>  2 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/winsup/cygwin/cygthread.cc b/winsup/cygwin/cygthread.cc
> index 54918e7677..4f16097531 100644
> --- a/winsup/cygwin/cygthread.cc
> +++ b/winsup/cygwin/cygthread.cc
> @@ -302,6 +302,20 @@ cygthread::terminate_thread ()
>    if (!inuse)
>      goto force_notterminated;
>
> +  if (_my_tls._ctinfo !=3D this)
> +    {
> +      CONTEXT context;
> +      context.ContextFlags =3D CONTEXT_CONTROL;
> +      /* SuspendThread makes sure a thread is "booted" from emulation b=
efore
> +	 it is suspended.  As such, the emulator hopefully won't be in a bad
> +	 state (aka, holding any locks) when the thread is terminated. */
> +      SuspendThread (h);
> +      /* We need to call GetThreadContext, even though we don't care ab=
out the
> +	 context, because SuspendThread is asynchronous and GetThreadContext
> +	 will make sure the thread is *really* suspended before returning */
> +      GetThreadContext (h, &context);
> +    }
> +
>    TerminateThread (h, 0);
>    WaitForSingleObject (h, INFINITE);
>    CloseHandle (h);
> diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
> index 81b6c31695..360bdac232 100644
> --- a/winsup/cygwin/sigproc.cc
> +++ b/winsup/cygwin/sigproc.cc
> @@ -410,7 +410,8 @@ proc_terminate ()
>  	  if (!have_execed || !have_execed_cygwin)
>  	    chld_procs[i]->ppid =3D 1;
>  	  if (chld_procs[i].wait_thread)
> -	    chld_procs[i].wait_thread->terminate_thread ();
> +	    if (!CancelSynchronousIo (chld_procs[i].wait_thread->thread_handle=
 ()))
> +	      chld_procs[i].wait_thread->terminate_thread ();
>  	  /* Release memory associated with this process unless it is 'myself'=
.
>  	     'myself' is only in the chld_procs table when we've execed.  We
>  	     reach here when the next process has finished initializing but we
> --
> 2.47.0.windows.2
>
>
