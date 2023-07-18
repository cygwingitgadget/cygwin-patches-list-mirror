Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 8F0E338582B0; Tue, 18 Jul 2023 14:52:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 8F0E338582B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1689691958;
	bh=plHMFRS8Ia1ntroA1sRM/D2CoTf287NfltpKAgWKpF8=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=lL+PBpGAV2B7RxCw7USaFTUK3wttfyyDIPk2BXHPxq2BdbTdCBf8yVuzefT+SuMyJ
	 meASn46zoerxKKPgeR9Jg9bfomPZEbpCE8ULGrUUk8N5o3P/nMG4+cVaw/OWi+DmXF
	 nkkw1J/rI7/E5X6kqYPuQ0xeTppLhxc03SgvPjB0=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 378D6A80C36; Tue, 18 Jul 2023 16:52:36 +0200 (CEST)
Date: Tue, 18 Jul 2023 16:52:36 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 00/11] More testsuite fixes
Message-ID: <ZLanNBXPqJmhd4qv@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20230713113904.1752-1-jon.turney@dronecode.org.uk>
 <0a9d6f10-f26c-faf2-6fa1-c6a055570f5a@dronecode.org.uk>
 <ZLVKBcPUlt18BQoJ@calimero.vinschen.de>
 <b6c16cd8-3b02-fddd-966e-4dbe9ca430c4@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b6c16cd8-3b02-fddd-966e-4dbe9ca430c4@dronecode.org.uk>
List-Id: <cygwin-patches.cygwin.com>

On Jul 18 14:37, Jon Turney wrote:
> On 17/07/2023 15:02, Corinna Vinschen wrote:
> > 
> > > We can't neatly tuck the pthread_cleanup_push/pop inside the object, as
> > > they are implemented as macros which must appear in the same lexical
> > > scope.
> > 
> > You could do it if you call the underlying functions instead.
> > pthread_cleanup_push is just a convenience macro which initializes a
> > local __pthread_cleanup_handler, see include/pthread.h.  If you add a
> > __pthread_cleanup_handler to system_call_handle, you could use it the
> > same way as the macro and encapsulate the whole thing inside the object.
> > If you want to...
> 
> Good point.
> 
> Yeah, this seems preferable as it doesn't move the point where we restore
> the signal handlers in the normal flow of execution, which might be
> important, still happening when the system_call_handle object falls out of
> scope and is destroyed.
> 
> > 
> > Fixes and Signed-off-by tags?
> > 
> 
> Done.  Revised patch attached.

Great, looks good!


Thanks,
Corinna
