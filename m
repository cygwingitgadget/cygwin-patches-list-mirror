Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id C7D993857BA9; Mon, 25 Nov 2024 11:22:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C7D993857BA9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1732533724;
	bh=suUe3TimA+dhgU4b/62eF21X+u3u8hIUjgJGURTjzc8=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=ARt234AZ78M+GuiZ4oY2wsOhvE0PaKqmLQi7jwjt/giNbe306w89lTAIEU8ViHv1y
	 HElO0Lq2jF0CWLW8BecWefqTI03/pKLoS3nk4RB96Ie3fzdWlS5LbYRViUDq1mvHSk
	 pa8EV0frhFNjuIYTjZF0EDrUYikl7PYNH3kFui24=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 6DC1BA80C06; Mon, 25 Nov 2024 12:22:02 +0100 (CET)
Date: Mon, 25 Nov 2024 12:22:02 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/2] Cygwin: cache IsWow64Process2 host arch in wincap.
Message-ID: <Z0Rd2hqxXqhuG3UX@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <d544a3f1-3b6f-0392-aecf-65125cf5e8f7@jdrake.com>
 <Z0CAdVAJgJgvAONa@calimero.vinschen.de>
 <89834a6f-50c7-b851-76ce-b640e8821f23@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <89834a6f-50c7-b851-76ce-b640e8821f23@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Nov 22 08:54, Jeremy Drake via Cygwin-patches wrote:
> On Fri, 22 Nov 2024, Corinna Vinschen wrote:
> 
> > On Nov 21 11:42, Jeremy Drake via Cygwin-patches wrote:
> > > +#if defined (__x86_64__)
> > > +      host_mach = IMAGE_FILE_MACHINE_AMD64;
> > > +#elif defined (__i386__)
> > > +      host_mach = wow64 ? IMAGE_FILE_MACHINE_AMD64 : IMAGE_FILE_MACHINE_I386;
> > > +#else
> > > +      /* this should not happen */
> >
> > It should actually result in
> >
> >   #error unimplemented for this target
> 
> No, because this is the fallback case for when IsWow64Process2 fails.
> This should only happen on OS versions that don't support it, which in
> turn don't support anything other than i386 and x86_64.  However, OS
> versions that do support it also support ARM64.  If/when Cygwin has native
> ARM64 support, this should not be a compilation error.  If anything it may
> be a runtime error (assert?)

Aaaah, yeah, I see what you mean.  In that case, just set host_mach to
IMAGE_FILE_MACHINE_AMD64 and be done with it.  There's no other choice
in that case anyway.

> > > +extern const IMAGE_DOS_HEADER
> > > +dosheader __asm__ ("__image_base__");
> > > +
> > > +const USHORT
> > > +wincapc::current_module_machine () const
> > > +{
> > > +  PIMAGE_NT_HEADERS ntheader = (PIMAGE_NT_HEADERS)((LPBYTE) &dosheader
> > > +                                                   + dosheader.e_lfanew);
> > > +  return ntheader->FileHeader.Machine;
> > >  }
> >
> > Just scratch that.  First, we're using GetModuleHandle(NULL)
> > throughout to access the image base, but apart from that,
> > the info is already available in wincap via cpu_arch().
> 
> GetModuleHandle(NULL) is the exe, __image_base__ is the cygwin dll.
> Theoretically, with ARM64EC, you can mix-and-match x86_64 and ARM64 in the
> same process,

Oh, ok, I read about this a while ago but had completely forgotten.

> so the most correct answer to the question to "are we being
> emulated" is whether the current module's architecture matches the host
> system's architecture.
> 
> Yes, due to Windows already lying in Get(Native)SystemInfo, cpu_arch()
> will tell you this, but with *different* enums, which means you'll
> need a switch somewhere to translate between them, instead of just doing
> an == or != with the host like this function lets you do.

This OTOH is well known at compile time, so this is where an #ifdef
may be in order, i .e.

  #if defined __x86_64__
    current_mach = IMAGE_FILE_MACHINE_AMD64;
  #else
    #error unimplemented for this target
  #endif

but, yeah, your code is simpler.  I just don't like the name of the
function, wouldn't something like current_machine() or cygwin_machine()
be better?


Thanks,
Corinna

