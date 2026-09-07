Return-Path: <SRS0=/fae=G7=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.227.117])
	by sourceware.org (Postfix) with ESMTPS id A1F714BA2E0D
	for <cygwin-patches@cygwin.com>; Mon,  7 Sep 2026 11:54:52 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A1F714BA2E0D
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A1F714BA2E0D
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.117
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1788782094; cv=none;
	b=WE+EAQEBlR5z+wzlbOui57Sb7499HODH3o1xwG881ZFo6eZAxtpBjn48wHuWqc8roWERCKcOxuZ2AfuhhbakBjo6biOkzd3Ak+QrPBnvdQ2XwMqRDJ6oBmb7rZT6QONVg0/rdn857wL8QzNqFou1C05Zju43D/Q2/Hs5iYwmz7k=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1788782094; c=relaxed/simple;
	bh=UX3JeldIvmujX2jyzoHKtLwg2y15EXYG9jhXi6FZv+4=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=e5tSpgJT0MZTEWFCT8LjAs4GTLUqDn/99Cel7erHDhyqKwxTpSuzzVqnfKlqYS9bRC59PGAqLkJiDN7p3eq5pl2zIwyoylMVHZr8oIAk2vsEif/543/7rF5WgYdpV9a3vRrkaYjZpvXn4sUmom9bRWjFOIB4k8U6EBBSvjdxxx4=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=bHvxNq6j
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A1F714BA2E0D
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=bHvxNq6j
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20260907115448832.DUGT.102121.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Mon, 7 Sep 2026 20:54:48 +0900
Date: Mon, 7 Sep 2026 20:54:46 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: proc: Cache system process information
Message-Id: <20260907205446.c14fdc7e8ac3a4589529bec6@nifty.ne.jp>
In-Reply-To: <57dbcbba-2fcc-43a6-8c82-5f0b6488bee1@maxrnd.com>
References: <20260906111103.102115-1-takashi.yano@nifty.ne.jp>
	<57dbcbba-2fcc-43a6-8c82-5f0b6488bee1@maxrnd.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1788782088;
 bh=0yzUAyWlnQKy/hRmVlIRpIjYyZRCr2B3OxBZk/eyuTw=;
 h=Date:From:To:Subject:In-Reply-To;
 b=bHvxNq6jYZkVnadeCulHmcd2BS9QnqJtjzhZVMx7u3fPc9J6PbHot9vUkPMvqEutucOr+u17
 0WyTCHD1JHj58futvGSQuHxR5KtJAYEJn0XRYbqThi6WZ9pwJumpe/PaUVdWZjy4vSNMXE/VVt
 qAFAbIY6XDgLRi0VZUZIGHwoW3fYPCiUvG0rTcV531j+5JMPES0JCesYvQsz6pNvf2IbHqEjcl
 NjIe5pnJegz89xeSCE/al+KhzZokOIUzFdQbWojI6TzTwmbxuypwfZYOqhdWOfZr3fUHpWWmKX
 iHXUIyZjWrrxH18prLw088HSTvWvHEaO1V+k13JTotoVAoWw==
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Sun, 6 Sep 2026 22:28:36 -0700
Mark Geisert <mark@maxrnd.com> wrote:
> Hi Takashi,
> 
> This v2 patch LGTM.  Thanks for investigating!

Thanks! Pushed.

> Regards,
> 
> ..mark
> 
> On 9/6/2026 4:10 AM, Takashi Yano wrote:
> > If a process reads /proc/<pid>/stat for multiple PIDs, current code
> > every time calls NtQuerySystemInformation(SystemProcessInformation).
> > In addition, the buffer size is estimated by calling that function
> > with increasing buffer size. This takes 15 - 20 msec. This looks
> > short time, however it is not negligible in some situation. If the
> > number of processes is 100, reading /proc/<pid>/stat takes 1.5 - 2.0
> > sec. Due to this behaviour, process pane of the btop is very heavy.
> > 
> > With this patch, system process information is cached per process
> > for a short time (20 msec) to improve efficiency. The buffer is
> > allocated first time when the corresponding /proc file system is
> > read, and held until process exits. If the buffer size needed by
> > NtQuerySystemInformation() is increased, the buffer will be re-
> > allocated, however never freed. The buffer pointer and the buffer
> > size are stored in the static area, so that the number of the
> > function call is reduced much. As a result, the process pane of
> > btop becomes significantly light. It takes only ~15 msec for 100
> > processes.
> > 
> > Fixes: 9ba913a56dd6 ("* fhandler_process.cc (process_listing): Add 'stat' and 'statm'.")
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > Reviewed-by: Mark Geisert <mark@maxrnd.com>
> > ---
> >   winsup/cygwin/fhandler/process.cc | 22 +++++++++++++++++-----
> >   1 file changed, 17 insertions(+), 5 deletions(-)
> > 
> > diff --git a/winsup/cygwin/fhandler/process.cc b/winsup/cygwin/fhandler/process.cc
> > index 537a4b370..404668661 100644
> > --- a/winsup/cygwin/fhandler/process.cc
> > +++ b/winsup/cygwin/fhandler/process.cc
> > @@ -1524,14 +1524,24 @@ get_process_state (DWORD dwProcessId, DWORD *num_threads)
> >   {
> >     /* This isn't really heavy magic - just go through the processes' threads
> >        one by one and return a value accordingly.  Errors are silently ignored. */
> > +  const ULONGLONG cache_time = 20;
> > +  static NO_COPY muto cache_guard;
> >     NTSTATUS status;
> > -  PSYSTEM_PROCESS_INFORMATION p, sp;
> > -  ULONG n = 0x4000;
> > +  static PSYSTEM_PROCESS_INFORMATION p = NULL;
> > +  static ULONGLONG t0 = 0;
> > +  PSYSTEM_PROCESS_INFORMATION sp;
> > +  static ULONG n = 0x4000;
> >     int state =' ';
> >   
> > -  p = (PSYSTEM_PROCESS_INFORMATION) malloc (n);
> > +  cache_guard.init ("get_process_state")->acquire ();
> > +
> > +  if (GetTickCount64 () - t0 < cache_time && p)
> > +    goto reuse_query;
> > +
> > +  if (!p)
> > +    p = (PSYSTEM_PROCESS_INFORMATION) malloc (n);
> >     if (!p)
> > -    return state;
> > +    goto out;
> >     while (true)
> >       {
> >         status = NtQuerySystemInformation (SystemProcessInformation,
> > @@ -1550,6 +1560,8 @@ get_process_state (DWORD dwProcessId, DWORD *num_threads)
> >   		    status, RtlNtStatusToDosError (status));
> >         goto out;
> >       }
> > +  t0 = GetTickCount64 ();
> > +reuse_query:
> >     state = 'Z';
> >     sp = p;
> >     for (;;)
> > @@ -1579,7 +1591,7 @@ get_process_state (DWORD dwProcessId, DWORD *num_threads)
> >         sp = (PSYSTEM_PROCESS_INFORMATION) ((char *) sp + sp->NextEntryOffset);
> >       }
> >   out:
> > -  free (p);
> > +  cache_guard.release ();
> >     return state;
> >   }
> >   
> 


-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
