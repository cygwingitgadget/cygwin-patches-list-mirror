Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 794073858C20; Wed, 24 Jan 2024 14:39:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 794073858C20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1706107154;
	bh=0G24223aOQoGQfYn1N5PBD/LP0xGzZb1Kcv8zBQYSLk=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=IcAPbXXmJoKvwer2LVtYzJVbT5tK0VYue8VbM54gUZjqXwyGtxrr9Lg5+uUeBt502
	 Cut7vfpgvf9FkwxYJs3JWjWDlrY0wrsi1+5aCyd02BtRrJBKsekJOQW5RymDhL9DEW
	 ZCsfsEkdBt/xNlC3pry7TK5jnP63cjI9EdllRbLA=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 9377DA80B93; Wed, 24 Jan 2024 15:39:12 +0100 (CET)
Date: Wed, 24 Jan 2024 15:39:12 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/5] Cygwin: Make 'ulimit -c' control writing a coredump
Message-ID: <ZbEhEP-MI7oX_2px@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20240112140958.1694-1-jon.turney@dronecode.org.uk>
 <20240112140958.1694-2-jon.turney@dronecode.org.uk>
 <238901bf-db88-4d99-bb82-2b98ff6ebdf6@dronecode.org.uk>
 <Za_NQNPhRNU7fRv0@calimero.vinschen.de>
 <c4cde4ee-f908-4944-8a77-8b86f3e51e8f@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c4cde4ee-f908-4944-8a77-8b86f3e51e8f@dronecode.org.uk>
List-Id: <cygwin-patches.cygwin.com>

On Jan 24 13:28, Jon Turney wrote:
> On 23/01/2024 14:29, Corinna Vinschen wrote:
> > On Jan 23 14:20, Jon Turney wrote:
> > 
> > > Even then this is clearly not totally bullet-proof. Maybe the right thing to
> > > do is add a suitable timeout here, so even if we fail to notice the
> > > DebugActiveProcess() (or there's a custom JIT debugger which just writes the
> > > fact a process crashed to a logfile or something), we'll exit eventually?
> > 
> > Timeouts are just that tiny little bit more bullet-proof, they still
> > aren't totally bullet-proof.
> > 
> > What timeout were you thinking of?  milliseconds?
> 
> Oh no, tens of seconds or something, just as a fail-safe.

Uh, sounds a lot.  10 secs?  Not longer, I think.

If you want to do that for 3.5, please do it this week.  You can
push the change without waiting for approval.

> (Ofc, all this is working around the fact that Win32 API doesn't have a
> WaitForDebuggerPresent(timeout) function)

Yeah, and there's no alternative way using the native API afaics :(


Corinna
