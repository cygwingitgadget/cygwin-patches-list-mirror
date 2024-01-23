Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 0DFC83858C50; Tue, 23 Jan 2024 14:29:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0DFC83858C50
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1706020162;
	bh=NdsJ7ye0lcm1xCrZfTi37MlgFVIjv0MdgA4zaMwo+ns=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=P+EcBAS1MdW817IkcJpOnWxahZlojJpZLnwmaPz3YT58YQGu9YExkw6RBoD30vqa5
	 JPX//6GP01fpQ+WXcZZyXDQ4Bn+hMLRg0YMnYsEwi471Gg8WYAwcJwH9tIeapctRNm
	 EOfQ9t7VDEUNC9duQsXjwdYL3YDCobfPgg1hh8K4=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 405FDA8066E; Tue, 23 Jan 2024 15:29:20 +0100 (CET)
Date: Tue, 23 Jan 2024 15:29:20 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/5] Cygwin: Make 'ulimit -c' control writing a coredump
Message-ID: <Za_NQNPhRNU7fRv0@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20240112140958.1694-1-jon.turney@dronecode.org.uk>
 <20240112140958.1694-2-jon.turney@dronecode.org.uk>
 <238901bf-db88-4d99-bb82-2b98ff6ebdf6@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <238901bf-db88-4d99-bb82-2b98ff6ebdf6@dronecode.org.uk>
List-Id: <cygwin-patches.cygwin.com>

On Jan 23 14:20, Jon Turney wrote:
> On 12/01/2024 14:09, Jon Turney wrote:
> > Pre-format a command to be executed on a fatal error to run 'dumper'
> > (using an absolute path).
> > 
> > Factor out executing a pre-formatted command, so we can use that for
> > invoking the JIT debugger in try_to_debug() (if error_start is present
> > in the CYGWIN env var) and to invoke dumper when a fatal error occurs.
> > 
> 
> So, there is a small problem with this change: because dumper itself
> terminates the dumped process, it doesn't go on to exit with the signal+128
> exit status.
> 
> (In fact, it seems to exit with status 0 when terminated by an attached
> debugger terminating, which isn't great)
> 
> That's relatively easy to fix: just use the '-n' option to dumper so it
> detaches before exiting, to prevent that terminating the dumped process, but
> then we run into the difficulties of reliably detecting that dumper has
> attached and done it's work, so it's safe for us to exit.
> 
> Attached patch does that, and documents the expectations on the error_start
> command a bit more clearly.

Please push.

> Even then this is clearly not totally bullet-proof. Maybe the right thing to
> do is add a suitable timeout here, so even if we fail to notice the
> DebugActiveProcess() (or there's a custom JIT debugger which just writes the
> fact a process crashed to a logfile or something), we'll exit eventually?

Timeouts are just that tiny little bit more bullet-proof, they still
aren't totally bullet-proof.

What timeout were you thinking of?  milliseconds?


Corinna
