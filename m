Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 5CC183858402; Mon, 29 Jan 2024 11:16:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5CC183858402
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1706527002;
	bh=JdvqiKksbWv2GngTWhT2x41A31kO5joteFfAT6FmO2k=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=IgYh8pxraGaOIyvCOi+Xxf0ItghustPZPUsjAktNGj+mnpRc37tsTtwWBzUGcaQ/h
	 olHw38BMcM2/DU7QqbclsOLS+MW4TVrRLfTI0qoIksJ15kjE5SSSlsVs7q2YMBB8Tv
	 OU9DnjH9oOF8r+UH5lEFN9HXsHUjUohNiJysErQs=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id AC8D2A80CD0; Mon, 29 Jan 2024 12:16:40 +0100 (CET)
Date: Mon, 29 Jan 2024 12:16:40 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/5] Cygwin: Make 'ulimit -c' control writing a coredump
Message-ID: <ZbeJGKPLN3glUo1k@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <238901bf-db88-4d99-bb82-2b98ff6ebdf6@dronecode.org.uk>
 <Za_NQNPhRNU7fRv0@calimero.vinschen.de>
 <c4cde4ee-f908-4944-8a77-8b86f3e51e8f@dronecode.org.uk>
 <ZbEhEP-MI7oX_2px@calimero.vinschen.de>
 <b140b902-8c5d-47f8-910e-f30d835bf185@dronecode.org.uk>
 <ZbKmwy7wKjAJvF1u@calimero.vinschen.de>
 <0613f2c3-4e1f-452a-8055-59d34d16c821@dronecode.org.uk>
 <ZbOTpaBfEZwAkxcf@calimero.vinschen.de>
 <ZbOc7C_3qSfjlT6x@calimero.vinschen.de>
 <d5fc9479-0882-417e-a047-752997eae0ad@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d5fc9479-0882-417e-a047-752997eae0ad@dronecode.org.uk>
List-Id: <cygwin-patches.cygwin.com>

On Jan 27 15:12, Jon Turney wrote:
> On 26/01/2024 11:52, Corinna Vinschen wrote:
> > > - Create a named mutex with a reproducible name (no need to use
> > >    the name as parameter) and immediately grab it.
> > > - Call CreateProcess to start the debugger with CREATE_SUSPENDED
> > >    flag.
> > > - Create a HANDLE array with the mutex and the process HANDLE.
> > 
> >      On second thought, it might be a good idea to make this
> >      interruptible as well, but given this is called from the
> >      exception handler this may have weird results...
> > > - Call ResumeThread on the primary debugger thread.
> > > - Call WFMO with timeout.
> > > 
> > > Later on, the debugger either fails and exits or it calls
> > > ReleaseMutex after having attached to the process.
> > > 
> > > - WFMO returns
> > > - If the mutex has triggered, we're being debugged (but check
> > >    IsDebuggerPresent() just to be sure)
> > > - If the process has triggered, the debugger exited
> > > - If the timeout triggers... oh well.
> 
> This seems like quite a lot of work, for very marginal benefit.
> 
> And doing lots of complex work inside the process when we're in the middle
> of handling a SEGV seems like asking for trouble.
> 
> I think I'll leave this alone for the moment, and we can see what (if any)
> problems surface.

Ok, no worries.


Corinna
