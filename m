Return-Path: <cygwin-patches-return-5457-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17052 invoked by alias); 18 May 2005 08:01:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16938 invoked from network); 18 May 2005 08:01:28 -0000
Received: from unknown (HELO calimero.vinschen.de) (84.148.23.119)
  by sourceware.org with SMTP; 18 May 2005 08:01:28 -0000
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id C7D396D4202; Wed, 18 May 2005 10:01:33 +0200 (CEST)
Date: Wed, 18 May 2005 08:01:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch] gcc4 fixes
Message-ID: <20050518080133.GA25438@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <428A7520.7FD9925C@dessent.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <428A7520.7FD9925C@dessent.net>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2005-q2/txt/msg00053.txt.bz2

On May 17 15:50, Brian Dessent wrote:
> diff -u -r1.109 mmap.cc
> --- mmap.cc	2 May 2005 03:50:07 -0000	1.109
> +++ mmap.cc	17 May 2005 22:40:14 -0000
> @@ -500,14 +500,14 @@
>      }
>  }
>  
> +static DWORD granularity = getshmlba ();
> +
>  extern "C" void *
>  mmap64 (void *addr, size_t len, int prot, int flags, int fd, _off64_t off)
>  {
>    syscall_printf ("addr %x, len %u, prot %x, flags %x, fd %d, off %D",
>  		  addr, len, prot, flags, fd, off);
>  
> -  static DWORD granularity = getshmlba ();
> -
>    /* Error conditions according to SUSv2 */
>    if (off % getpagesize ()
>        || (!(flags & MAP_SHARED) && !(flags & MAP_PRIVATE))
> 

While this might help to avoid... something, I'm seriously wondering
what's wrong with this expression.  Why does each new version of gcc
add new incompatibilities?


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
