Return-Path: <cygwin-patches-return-4569-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18890 invoked by alias); 11 Feb 2004 14:24:18 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18827 invoked from network); 11 Feb 2004 14:24:16 -0000
X-Authentication-Warning: slinky.cs.nyu.edu: pechtcha owned process doing -bs
Date: Wed, 11 Feb 2004 14:24:00 -0000
From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: Thomas Pfaff <tpfaff@gmx.net>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Thread safe stdio
In-Reply-To: <4029FF39.9080806@gmx.net>
Message-ID: <Pine.GSO.4.56.0402110921490.9477@slinky.cs.nyu.edu>
References: <4029FF39.9080806@gmx.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; FORMAT=flowed
Content-ID: <Pine.GSO.4.56.0402110921492.9477@slinky.cs.nyu.edu>
X-Scanned-By: MIMEDefang 2.39
X-SW-Source: 2004-q1/txt/msg00059.txt.bz2

Thomas,

IMHO, include/cygwin/_types.h should be created before the below patch is
applied, to provide continuity (otherwise the builds will be broken
between the two patches).  Creating it earlier does no harm, AFAICS.  The
rest of the Cygwin patch should obviously wait.
	Igor

On Wed, 11 Feb 2004, Thomas Pfaff wrote:

> _flock_t is now defined in cygwin/_types.h. I will sent following patch
> for newlib when this one is applied:
>
> --- _types.h.org	2004-01-26 23:33:11.000000000 +0100
> +++ _types.h	2004-02-10 12:28:44.359443200 +0100
> @@ -9,6 +9,10 @@
>   #ifndef	_SYS__TYPES_H
>   #define _SYS__TYPES_H
>
> +#ifdef __CYGWIN__
> +#include <cygwin/_types.h>
> +#endif
> +
>   typedef long _off_t;
>   __extension__ typedef long long _off64_t;
>
> @@ -32,7 +36,9 @@ typedef struct
>     } __value;		/* Value so far.  */
>   } _mbstate_t;
>
> +#ifndef __CYGWIN__
>   typedef int _flock_t;
> +#endif
>
>   /* Iconv descriptor type */
>   typedef void *_iconv_t;
>
>
> The __sinit call must be done after malloc is initialized, otherwise the
> mutex creation will fail.
>
> Thomas
>
> 2004-02-11 Thomas Pfaff <tpfaff@gmx.net>
>
> 	* include/cygwin/_types.h: New file.
> 	* include/sys/lock.h: Ditto.
> 	* include/sys/stdio.h: Ditto.
> 	* dcrt0.cc (dll_crt0_1): Add __sinit call after malloc
> 	initialization.
> 	(_dll_crt0): Remove __sinit call.
> 	* thread.cc: Include sys/lock.h
> 	(__cygwin_lock_init): New function.
> 	(__cygwin_lock_init_recursive): Ditto.
> 	(__cygwin_lock_fini): Ditto.
> 	(__cygwin_lock_lock): Ditto.
> 	(__cygwin_lock_unlock): Ditto.

-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_		pechtcha@cs.nyu.edu
ZZZzz /,`.-'`'    -.  ;-;;,_		igor@watson.ibm.com
     |,4-  ) )-,_. ,\ (  `'-'		Igor Pechtchanski, Ph.D.
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

"I have since come to realize that being between your mentor and his route
to the bathroom is a major career booster."  -- Patrick Naughton
