Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 7B7343858D20; Tue, 16 Jan 2024 13:54:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 7B7343858D20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1705413246;
	bh=SXs5No7BvY/5/19VydzvBbooAFGEb5qg8wAcnu8YfsE=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=P12RRJc/O7H4X5eECynDlGiGJUcvmpKfB6xyW232nww4o3QsyFbCV8EFIxUDiMlkV
	 MP1AaUgYNIKo0LH/A03RRlXc8uO5tYfoTQJIovh7F4OzS4wzvoHjUxHWjnN9mMvqTi
	 I46KOpj7ki7YPxA6I8LvtKsKU/8RxiHBVINTXUEo=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 6A485A80D11; Tue, 16 Jan 2024 14:54:04 +0100 (CET)
Date: Tue, 16 Jan 2024 14:54:04 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/5] Cygwin: Make 'ulimit -c' control writing a coredump
Message-ID: <ZaaKfD31uphAvDFV@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20240112140958.1694-1-jon.turney@dronecode.org.uk>
 <20240112140958.1694-2-jon.turney@dronecode.org.uk>
 <0e5b64f3-9d36-438d-96ad-20d231bccfeb@dronecode.org.uk>
 <ZaT-_Prh2gnn9v9y@calimero.vinschen.de>
 <3dafa845-a583-4b47-b0d6-3b16f46c8a67@dronecode.org.uk>
 <ZaVBHu-dY8_FOvm0@calimero.vinschen.de>
 <dde2da5f-7f91-4f71-9a6f-dbedb05e1298@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dde2da5f-7f91-4f71-9a6f-dbedb05e1298@dronecode.org.uk>
List-Id: <cygwin-patches.cygwin.com>

On Jan 16 13:52, Jon Turney wrote:
> On 15/01/2024 14:28, Corinna Vinschen wrote:
> > On Jan 15 13:27, Jon Turney wrote:
> > > On 15/01/2024 09:46, Corinna Vinschen wrote:
> > > > On Jan 13 14:20, Jon Turney wrote:
> > > > > On 12/01/2024 14:09, Jon Turney wrote:
> > > > > > +
> > > > > > +  PWCHAR cp = dumper_command;
> > > > > > +  cp = wcpcpy (cp, L"\"");
> > > > > > +  cp = wcpcpy (cp, dll_dir);
> > > > > > +  cp = wcpcpy (cp, L"\\dumper.exe");
> > > > > > +  cp = wcpcpy (cp, L"\" ");
> > > > > > +  cp = wcpcpy (cp, L"\"");
> > > > > > +  cp = wcpcpy (cp, global_progname);
> > > > > 
> > > > > I wonder if this should be program_invocation_short_name, so that the
> > > > > coredump is created in the cwd, rather than next to the executable.
> 
> So, when I actually look further into this, what I wrote is utter nonsense.
> dumper/minidumper includes the following:
> 
> >       ssize_t len = cygwin_conv_path (CCP_POSIX_TO_WIN_A | CCP_RELATIVE,
> >                                       *(argv + optind), NULL, 0);
> >       char *win32_name = (char *) alloca (len);
> >       cygwin_conv_path (CCP_POSIX_TO_WIN_A | CCP_RELATIVE,  *(argv + optind),
> >                         win32_name, len);
> >       if ((p = strrchr (win32_name, '\\')))
> >         p++;
> >       else
> >         p = win32_name;
> 
> My eyes moving over this lightly, my brain assumes it just converts from a
> Win32 path to a POSIX path, but actually it does:
> 
> 1) convert from POSIX path to Windows path (assuming it's a no-op if the
> path is already in a Windows form
> 2) (now having a consistent path delimiter) use the part after the last
> delimiter (if any), as the basename.
> 
> So: no problem here, after all. coredump file is already created in the cwd.

:+1:
