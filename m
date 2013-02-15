Return-Path: <cygwin-patches-return-7799-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18841 invoked by alias); 15 Feb 2013 11:05:00 -0000
Received: (qmail 18787 invoked by uid 22791); 15 Feb 2013 11:04:45 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Fri, 15 Feb 2013 11:04:34 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id B420B520354; Fri, 15 Feb 2013 12:04:31 +0100 (CET)
Date: Fri, 15 Feb 2013 11:05:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 64bit] utils: port dumper to 64bit
Message-ID: <20130215110431.GB27934@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20130215020235.3f769e45@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20130215020235.3f769e45@YAAKOV04>
User-Agent: Mutt/1.5.21 (2010-09-15)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2013-q1/txt/msg00010.txt.bz2

On Feb 15 02:02, Yaakov wrote:
> I just uploaded cygwin64-libiconv, cygwin64-gettext, and
> cygwin64-libbfd to Ports, so that dumper.exe could be built.  It
> appears it hasn't been ported yet, so here's a first attempt.  Comments
> welcome.

Looks good, I just have a few style nits.

> Index: dumper.cc
> ===================================================================
> RCS file: /cvs/src/src/winsup/utils/dumper.cc,v
> retrieving revision 1.20.2.1
> diff -u -p -r1.20.2.1 dumper.cc
> --- dumper.cc	23 Nov 2012 15:14:40 -0000	1.20.2.1
> +++ dumper.cc	15 Feb 2013 07:53:24 -0000
> @@ -1,6 +1,6 @@
>  /* dumper.cc
>  
> -   Copyright 1999, 2001, 2002, 2004, 2006, 2007, 2011 Red Hat Inc.
> +   Copyright 1999, 2001, 2002, 2004, 2006, 2007, 2011, 2013 Red Hat Inc.
>  
>     Written by Egor Duda <deo@logos-m.ru>
>  
> @@ -84,7 +84,8 @@ dumper::dumper (DWORD pid, DWORD tid, co
>  			  pid);
>    if (!hProcess)
>      {
> -      fprintf (stderr, "Failed to open process #%lu, error %ld\n", pid, GetLastError ());
> +      fprintf (stderr, "Failed to open process #%lu, error %ld\n",
> +	       (unsigned long) pid, (long) GetLastError ());

In other cases I cast to unsigned int and used %u.  The reason being
that this matches the natural size of pid_t on both platforms.  I'd
prefer to that here as well.

>        return;
>      }
>  
> @@ -192,7 +193,7 @@ dumper::add_thread (DWORD tid, HANDLE hT
>  }
>  
>  int
> -dumper::add_mem_region (LPBYTE base, DWORD size)
> +dumper::add_mem_region (LPBYTE base, SIZE_T size)
>  {
>    if (!sane ())
>      return 0;
> @@ -209,14 +210,15 @@ dumper::add_mem_region (LPBYTE base, DWO
>    new_entity->u.memory.base = base;
>    new_entity->u.memory.size = size;
>  
> -  deb_printf ("added memory region %08x-%08x\n", (DWORD) base, (DWORD) base + size);
> +  deb_printf ("added memory region %0*zx-%0*zx\n", 2 * __SIZEOF_SIZE_T__,
> +	      (SIZE_T) base, 2 * __SIZEOF_SIZE_T__, (SIZE_T) base + size);

Instead of casting to SIZE_T, I'd suggest to use %p for pointers
throughout.  And maybe we should simply drop the length entirely.
16 digits, of which the upper 5 are always 0, are hard to read.

>  int
> -dumper::split_add_mem_region (LPBYTE base, DWORD size)
> +dumper::split_add_mem_region (LPBYTE base, SIZE_T size)
>  {
>    if (!sane ())
>      return 0;
> @@ -255,7 +257,7 @@ dumper::add_module (LPVOID base_address)
>    if (!sane ())
>      return 0;
>  
> -  char *module_name = psapi_get_module_name (hProcess, (DWORD) base_address);
> +  char *module_name = psapi_get_module_name (hProcess, (SIZE_T) base_address);

Shouldn't psapi_get_module_name take an LPVOID instead?  That would
also drop the need for the cast in psapi_get_module_name, like so:

> Index: module_info.cc
> [...]
> @@ -33,7 +33,7 @@ static tf_GetModuleFileNameExA *psapi_Ge
>     Uses psapi.dll. */
>  
>  char *
> -psapi_get_module_name (HANDLE hProcess, DWORD BaseAddress)
> +psapi_get_module_name (HANDLE hProcess, SIZE_T BaseAddress)

  +psapi_get_module_name (HANDLE hProcess, LPVOID BaseAddress)

>  {
>    DWORD len;
>    MODULEINFO mi;
> @@ -103,7 +103,7 @@ psapi_get_module_name (HANDLE hProcess, 
>  	  goto failed;
>  	}
>  
> -      if ((DWORD) (mi.lpBaseOfDll) == BaseAddress)
> +      if ((SIZE_T) (mi.lpBaseOfDll) == BaseAddress)

  +      if (mi.lpBaseOfDll == BaseAddress)


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat
