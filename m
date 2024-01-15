Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 3DD60385DC0B; Mon, 15 Jan 2024 12:08:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3DD60385DC0B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1705320529;
	bh=gcNzfhaq0aCcS/kWThQ5LdsrIazvzwpFUa5tWtI8g5g=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=sFtCqTACnP4WcFEDP4EfhJN4o44kqCA//2NkSb8sA3ya7UdMU+CMIYMnGDfHDIFkt
	 Oi/+zMrdDdotQp42Rwu7RmpVgJqIot3B3btY4gv9+PvXufZYJ4fXMlr5/1r+SJNhgE
	 7kOxQyeEtWO3ULJ5ViE97ZWcXLF2/6ZP9lCEEff8=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 6BE9BA8096D; Mon, 15 Jan 2024 13:08:47 +0100 (CET)
Date: Mon, 15 Jan 2024 13:08:47 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: introduce close_range
Message-ID: <ZaUgT0rfS8syRRyP@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <83cfd6b3-6824-fd9f-794b-7fc428f8c80d@t-online.de>
 <3ab13e94-fd3a-41c8-8392-fcd72042d0e9@dronecode.org.uk>
 <6b1723b1-12b1-a240-ff22-1f0f5ba73214@t-online.de>
 <2443ab23-4c2f-bf99-c38e-8410e642fe1f@t-online.de>
 <ZaUMpz2oUXpokdAk@calimero.vinschen.de>
 <7e7efac7-95fe-6d2c-db78-6dd892f93030@t-online.de>
 <ZaUgFoxmOliv6Cok@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZaUgFoxmOliv6Cok@calimero.vinschen.de>
List-Id: <cygwin-patches.cygwin.com>

On Jan 15 13:07, Corinna Vinschen wrote:
> Sorry Christian, but..
> 
> I was just going to push this patch when I realized that we now have
> two lines of debug output per affected file descriptor:
> 
> On Jan 15 12:19, Christian Franke wrote:
> > +  for (unsigned int i = firstfd; i < size; i++)
> > +    {
> > +      cygheap_fdget cfd ((int) i, false, false);
> > +      if (cfd < 0)
> > +	continue;
> > +
> > +      if (flags & CLOSE_RANGE_CLOEXEC)
> > +	{
> > +	  syscall_printf ("set FD_CLOEXEC on fd %u", i);
> > +	  cfd->fcntl (F_SETFD, FD_CLOEXEC);
> 
> fhandler::set_close_on_exec() already prints this:
> 
>   debug_printf ("set close_on_exec for %s to %d", get_name (), val);
> 
> > +	}
> > +      else
> > +	{
> > +	  syscall_printf ("closing fd %u", i);
> > +	  cfd->close_with_arch ();
> 
> fhandler::close() already prints this:
> 
>   syscall_printf ("closing '%s' handle %p", get_name (), get_handle ());
> 
> Shan't we drop the syscall calls from close_range()?
                     ^^^^^^^
                   syscall_printf
