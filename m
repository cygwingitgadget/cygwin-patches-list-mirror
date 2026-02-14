Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 0B70E4BAD148; Sat, 14 Feb 2026 19:16:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0B70E4BAD148
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1771096610;
	bh=HZwolIwyfk3rQLnXBg3NhMdObxM+BkHD2pxcqrkjZu8=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=gy29lLxLKgfrMwCoEK4op3FNF3fkfB8Tfvs0ucg37YPEtoHQVmI1iRMMGKbju4nvl
	 b0acPwFq/nlYd25ZrolS4PEglzOiYOfYbR+S5V4vq8Dl3AjOMIT5EyMMbJhf2uypE4
	 JLwzlVtuQVrFLjPlPg6vKXe5mNWLJyaEueAh2TQ0=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id DBA43A80850; Sat, 14 Feb 2026 20:16:47 +0100 (CET)
Date: Sat, 14 Feb 2026 20:16:47 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: PEHeaderFromHModule: allow only images matching
 build architecture
Message-ID: <aZDKHwzU8NQIP6AL@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <aY9Ky2rJmDLyRqt7@calimero.vinschen.de>
 <20260213193535.2983506-1-corinna-cygwin@cygwin.com>
 <7354dd51-7ee2-45ef-85d2-9a100e24a551@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7354dd51-7ee2-45ef-85d2-9a100e24a551@dronecode.org.uk>
List-Id: <cygwin-patches.cygwin.com>

On Feb 14 15:01, Jon Turney wrote:
> On 13/02/2026 19:35, Corinna Vinschen wrote:
> > From: Corinna Vinschen <corinna@vinschen.de>
> > 
> > This makes sure that we only ever handle images which can be executed
> > on the current architecture.
> > 
> > Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
> > ---
> >   winsup/cygwin/hookapi.cc | 3 +++
> >   1 file changed, 3 insertions(+)
> > 
> > diff --git a/winsup/cygwin/hookapi.cc b/winsup/cygwin/hookapi.cc
> > index b0126ac04e3e..5b25443c8365 100644
> > --- a/winsup/cygwin/hookapi.cc
> > +++ b/winsup/cygwin/hookapi.cc
> > @@ -43,10 +43,13 @@ PEHeaderFromHModule (HMODULE hModule)
> >     /* Return valid PIMAGE_NT_HEADERS only for supported architectures. */
> >     switch (pNTHeader->FileHeader.Machine)
> >       {
> > +#if defined(__x86_64__)
> >       case IMAGE_FILE_MACHINE_AMD64:
> >         break;
> > +#elif defined (__aarch64__)
> >       case IMAGE_FILE_MACHINE_ARM64:
> >         break;
> 
> This needs to be followed by
> 
> #else
> #error "u wot?"
> 
> > +#endif
> >       default:
> >         return NULL;
> 
> From Igor's analysis, ever returning NULL here seems like a bad idea, as it
> causes apparently unrelated things to stop working.

It's just the iscygwin() test going wrong, but yeah, that has unwelcome
side-effects.

> Maybe we should just abort there instead?
> 
> I've forgotten all the details of exactly what hookapi is doing, so I'm not
> sure if that kind of mixing can ever happen (It seems like not - does the OS
> even let us load DLLs of a different machine type to that of the process?)

I actually had to look this up and it turns out that we really can't
load a DLL from another architecture.

Unless you build the Cygwin executable as ARM64EC binary, which also
allows to load AMD64 DLLs.  The DLLs are then running in a x86_64
emulation.

I just don't think we should support this, or, should we?


Corinna
