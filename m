Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 8C8AD3858428; Wed,  7 Aug 2024 14:18:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 8C8AD3858428
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1723040310;
	bh=TIIeKyCsSFvJDpiZ/CMn4dj+as2OtJcBpYXaFr5r3u4=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=rSiSEhroVMZhez2tuK57ZBWtuPRLAjIrJ1ZrbmTYfi0XH469lIXS0ZIpIDa//AC6j
	 qD7sc0kBLyBzkh+/PEgi+p0xi/B1F1BhmaGTpKzhIo2scRZKmHDhhnjLXp9LkQVU/u
	 Z6tg2YkOzPPPYOmG0FgLMTnkILYBi/x+2gpxmbmQ=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 40890A8045B; Wed,  7 Aug 2024 16:18:28 +0200 (CEST)
Date: Wed, 7 Aug 2024 16:18:28 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 6/6] Cygwin: Suppress false positive use-after-free
 warnings in __set_lc_time_from_win()
Message-ID: <ZrOCNMbkYKAq4E94@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20240804214829.43085-1-jon.turney@dronecode.org.uk>
 <20240804214829.43085-7-jon.turney@dronecode.org.uk>
 <239efff0-ca0b-45f6-98ae-4d0518fea9b6@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <239efff0-ca0b-45f6-98ae-4d0518fea9b6@dronecode.org.uk>
List-Id: <cygwin-patches.cygwin.com>

On Aug  6 20:03, Jon Turney wrote:
> On 04/08/2024 22:48, Jon Turney wrote:
> > Supress new use-after-free warnings about realloc(), seen with gcc 12, e.g.:
> > 
> > > In function ‘void rebase_locale_buf(const void*, const void*, const char*, const char*, const char*)’,
> > >      inlined from ‘int __set_lc_time_from_win(const char*, const lc_time_T*, lc_time_T*, char**, wctomb_p, const char*)’ at ../../../../src/winsup/cygwin/nlsfuncs.cc:705:25:
> > > ../../../../src/winsup/cygwin/nlsfuncs.cc:338:24: error: pointer ‘new_lc_time_buf’ may be used after ‘void* realloc(void*, size_t)’ [-Werror=use-after-free]
> > >    338 |       *ptrs += newbase - oldbase;
> > >        |                ~~~~~~~~^~~~~~~~~
> > > ../../../../src/winsup/cygwin/nlsfuncs.cc: In function ‘int __set_lc_time_from_win(const char*, const lc_time_T*, lc_time_T*, char**, wctomb_p, const char*)’:
> > > ../../../../src/winsup/cygwin/nlsfuncs.cc:699:44: note: call to ‘void* realloc(void*, size_t)’ here
> > >    699 |               char *tmp = (char *) realloc (new_lc_time_buf, len);
> > 
> > We do some calculations using the pointer passed to realloc(), but do
> > not not dereference it, so this seems safe?
>  Since this is less than ideal, here's the version where we explicitly
> malloc() the new buffer, adjust things, then free() the old buffer.
> 
> This is all quite hairy, though, and I have no idea how to begin to test
> this, so if you have some pointers to share, that would be good.

No pointers as such, but tcsh uses it's own allocator, while bash
doesn't. So testing involves running bash and tcsh and then changing
LC_ALL to any odd (but existing) locale, e.g.

  en_US, de_DE.utf8, fa_IR, fa_IR.utf8, zh_HK, zh_HK.utf8, you name it

  bash$ export LC_ALL=foo
  tcsh$ setenv LC_ALL foo

This shoudn't crash bash nor tcsh.

FWIW, your patch looks right to me.


Thanks,
Corinna
