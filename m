Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id B30893858D33; Wed, 27 Nov 2024 15:24:30 +0000 (GMT)
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 6FE9EA80E4D; Wed, 27 Nov 2024 16:24:28 +0100 (CET)
Date: Wed, 27 Nov 2024 16:24:28 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 1/2] Cygwin: cache IsWow64Process2 host arch in wincap.
Message-ID: <Z0c5rFZNulvQU5bE@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <9d0630f7-e8d6-b4f6-116b-1df6095877c3@jdrake.com>
 <Z0XK-JE0c950m0um@calimero.vinschen.de>
 <a943634d-7c63-9383-442c-d9162497b516@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a943634d-7c63-9383-442c-d9162497b516@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Nov 26 10:16, Jeremy Drake via Cygwin-patches wrote:
> On Tue, 26 Nov 2024, Corinna Vinschen wrote:
> 
> > On Nov 25 11:21, Jeremy Drake via Cygwin-patches wrote:
> > > +extern const IMAGE_DOS_HEADER
> > > +dosheader __asm__ ("__image_base__");
> >
> > On second thought, shouldn't we just use GetModuleHandle ("cygwin1.dll")
> > instead of going asm here?
> 
> I was hoping to avoid another place where MSYS2 would have to patch the
> name change to msys-2.0.dll.  I almost went with GetModuleHandleEx
> (GET_MODULE_HANDLE_EX_FLAG_FROM_ADDRESS|GET_MODULE_HANDLE_EX_FLAG_UNCHANGED_REFCOUNT)
> but the overhead of either call seemed silly when the linker already knows
> the address...

Got it.

> If the __asm__ setting the symbol name is an issue, pseudo-reloc.cc also
> accesses __image_base__ like so:
> #ifndef __MINGW_LSYMBOL
> #define __MINGW_LSYMBOL(sym) sym
> #endif
> 
> extern char __MINGW_LSYMBOL(_image_base__);
> 
> &__MINGW_LSYMBOL(_image_base__)
> 
> I found the __asm__ method cleaner.  But I could name the extern
> __MINGW_LSYMBOL(_image_base__) instead of dosheader to avoid __asm__.

No, that's not necessary.  Actually, this code is only used in the
non-Cygwin (Mingw-w64) case.  For Cygwin, it refers to
per_process::image_base, which is the image base of the executable, not
the image base of the Cygwin DLL.

But you don't really need the asm.  Just define extern const
IMAGE_DOS_HEADER __image_base__ and use it in the expression extracting
FileHeader.Machine.

Another point: Theoretically we want wincap to contain static data,
which will get inherited by child processes.

So, would you mind to add a member cygwin_mach and change
cygwin_machine() to an inline function just returning cygwin_mach?


Thanks,
Corinna
