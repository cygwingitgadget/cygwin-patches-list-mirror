Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 8DCD53854A8D; Tue, 17 Jun 2025 18:34:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 8DCD53854A8D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1750185256;
	bh=0EhhzIBW3XndM5U3F5G7t8FvI65+fn8bkIOPGZNU8r0=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=P+BMvPhB9BzMh3XJtioA/Hx1PrYjaN9yTJYaL2vHXAxF6XT33oorOeqxgr5BOySAF
	 wsPps9EKm7jNO4+C2JyQJdgWiimfCKfOQBa7/Bdp4bXtbh4CrnuoNY3OpAT6LR3gXE
	 j7R4OxjyyHi9tRiXzIqhiheL4USE8mtIlwTY7ye8=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id AF46CA80961; Tue, 17 Jun 2025 20:34:13 +0200 (CEST)
Date: Tue, 17 Jun 2025 20:34:13 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: make pthread initializer macros constinit
 compliant
Message-ID: <aFG1JSMtc83EWunf@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1277a22d-9beb-52b3-c9ea-7980f54fb84b@jdrake.com>
 <9f2971ca-114a-cfec-646a-a32eabfc3ac3@jdrake.com>
 <aFFNnpI5eBgSl805@calimero.vinschen.de>
 <413d1875-ed41-9ad0-3954-4df6bae666e7@jdrake.com>
 <aFGyoVdstMJOjEBD@calimero.vinschen.de>
 <aFG0H0f0zJj-4yOn@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aFG0H0f0zJj-4yOn@calimero.vinschen.de>
List-Id: <cygwin-patches.cygwin.com>

On Jun 17 20:29, Corinna Vinschen wrote:
> On Jun 17 20:23, Corinna Vinschen wrote:
> > Second, I'm puzzeling over the #if expression (cut for a simple example):
> > 
> >   #if !defined(__INSIDE_CYGWIN__) || !defined(__cplusplus)
> >   /* use symbols */
> >   #else
> >   /* use const int cast to pointer */
> >   #endif
> > 
> > So this is a problem in terms of constinit.  Constinit is a C++20
> > expression.  But the condition will only define PTHREAD_...  using the
> > symbols if this is either outside Cygwin, or if the Cygwin code is NOT
> > C++.
> > 
> > The usage inside Cygwin seems upside down to me.  Shouldn't it use the
> > symbols in C++ code but not in plain C?  Or am I misunderstanding the
> > condition entirely?
> 
> Actually Cygwin doesn't use the PTHREAD macros at all outside C++ code.

Scratch that, my search expression was flawed.
