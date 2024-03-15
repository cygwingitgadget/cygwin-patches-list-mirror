Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 30C4A385C6F7; Fri, 15 Mar 2024 09:10:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 30C4A385C6F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1710493848;
	bh=1Ot0bNznwVkJnnPFlDClmcEDl9mVBEuRd0oEDsWWEyI=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=LUaBjib8gtDupLAM9KLBc3L/QZZ16zIc3FFRbmYkxj+JgZYDT6P0p8CK5v6Yr4gNV
	 Ew5dqFaY6S22xfYEQEfvM3ahGZZjQW6DFGnIasoDQHRLri3v2b6mvyKuMFKE22uWRO
	 7do2g6zwsS4Uh7hpq2WU5oawzadwOXxfZ5dp+WAA=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id D6B4FA804A4; Fri, 15 Mar 2024 10:10:45 +0100 (CET)
Date: Fri, 15 Mar 2024 10:10:45 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: newlib-cygwin build fails on dumper
Message-ID: <ZfQQld7O6NImhJBP@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <9599b8e1-6d67-4b00-b7af-c412298d78af@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9599b8e1-6d67-4b00-b7af-c412298d78af@SystematicSW.ab.ca>
List-Id: <cygwin-patches.cygwin.com>

On Mar 14 10:10, Brian Inglis wrote:
> Hi folks,
> 
> During newlib-cygwin build to test patches, with latest current stable
> packages as of last weekend, and yesterday's repo main/master, get a
> warning, then errors building dumper:
> 
> ...
> 
>   CC       libc/reent/libc_a-getentropyr.o
> /usr/src/newlib-cygwin/newlib/libc/reent/getentropyr.c: In function ‘_getentropy_r’:
> /usr/src/newlib-cygwin/newlib/libc/reent/getentropyr.c:48:14: warning:
> implicit declaration of function ‘_getentropy’; did you mean ‘getentropy’?
> [-Wimplicit-function-declaration]
>    48 |   if ((ret = _getentropy (buf, buflen)) == -1 && errno != 0)
>       |              ^~~~~~~~~~~
>       |              getentropy
> 
> ...
> 
>   CXX      dumper-dumper.o
> In file included from /usr/src/newlib-cygwin/winsup/utils/dumper.cc:23:
> /usr/include/bfd.h:2748:1: error: expected initializer before
> ‘ATTRIBUTE_WARN_UNUSED_RESULT’
>  2748 | ATTRIBUTE_WARN_UNUSED_RESULT;
>       | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /usr/include/bfd.h:2751:1: error: expected initializer before

I'm pretty sure this isn't the latest newlib-cygwin main.

The getentropy warning has been fixed on 2023-09-25 by commit
a9e8e3d1cb82 ("newlib: Add missing prototype for _getentropy")

The ATTRIBUTE_WARN_UNUSED_RESULT error message has been fixed on
2024-02-12 by commit 10c8c1cf4f94 ("include/ansidecl.h: import from
binutils-gdb")


Corinna
