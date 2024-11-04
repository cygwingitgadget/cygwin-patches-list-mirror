Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 87E293858C5F; Mon,  4 Nov 2024 14:34:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 87E293858C5F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1730730883;
	bh=sopGa4eTbrgwenZ/Mf692bwNiHHBu2nXF+u9f+JB8Ik=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=hRF5J8ducp6QLWkX9DQgcO9QMFftRSPuTJ179en2KY/zip3zLb0d0bSasAodJhYAx
	 GKZwLLZlNI0W802Meeky1zvcArxH4zYdaaeaycIJajVd9gjJ2eH2Nvxt49qiG5JIbM
	 zMpPQTN0nXcr5IBU1Zu8o+GAVjn85ovhnYlvDrpg=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 78056A80C4D; Mon,  4 Nov 2024 15:34:41 +0100 (CET)
Date: Mon, 4 Nov 2024 15:34:41 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: Change pthread_sigqueue() to accept thread id
Message-ID: <ZyjbgeaHuJEZmP3m@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20240919091331.1534-1-mark@maxrnd.com>
 <Zxe6gsvAQp7HaeO7@calimero.vinschen.de>
 <c86bcce2-e705-41e2-a918-d97debc7362b@maxrnd.com>
 <ec6ec704-67d1-72fd-0041-87e7372b58f3@t-online.de>
 <ZyiinKXESiXU4AvU@calimero.vinschen.de>
 <683a0e8b-9a8c-4729-0594-353ff5e04ac6@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <683a0e8b-9a8c-4729-0594-353ff5e04ac6@t-online.de>
List-Id: <cygwin-patches.cygwin.com>

On Nov  4 12:50, Christian Franke wrote:
> Corinna Vinschen wrote:
> > ...
> > > - Invent a #define that allows to use the old function.
> > We don't need this.  We only want backward compat to keep existing
> > executables running.  So we need The old and wrong pthread_sigqueue only
> > as exported symbol.  On recompiling the affected project, the bug
> > hopefully shows up and can be easily fixed.
> 
> Providing such a feature (only) for a few upcoming Cygwin releases would
> allow maintainers (e.g. me maintaining stress-ng) to easily provide packages
> which are backward compatible with still available [prev] versions of the
> DLL.

We never did that yet.  Going forward, we try to maintain backward
compatibility for new versions of Cygwin to existing executables, but we
never promised or maintained backward compatibility for newly built
executables to old versions of Cygwin.  That's setting an uncomfortable
new precedent.

*Iff* we do this, then it should be least intrusive for the header,
i. e., add a new entry point and use that in the backward compat case,
kind of like this:

-------------------------------------------------------------

int pthread_sigqueue (pthread_t, int, const union sigval)

#ifdef _CYGWIN_USE_BUGGY_PTHREAD_SIGQUEUE

// TODO: Add some comment explaining this hack :-)
int __pthread_sigqueue_buggy (pthread_t *, int, const union sigval)
  __attribute__((__warning__("Using old version of pthread_sigqueue()")))
  ;
#define pthread_sigqueue(a,b,c)	__pthread_sigqueue_buggy ((a),(b),(c))

#endif
-------------------------------------------------------------


Corinna
