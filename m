Return-Path: <cygwin-patches-return-3844-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1466 invoked by alias); 3 May 2003 13:02:22 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1456 invoked from network); 3 May 2003 13:02:21 -0000
Message-ID: <3EB3BDD3.6020608@yahoo.com>
Date: Sat, 03 May 2003 13:02:00 -0000
From: Earnie Boyd <earnie_boyd@yahoo.com>
Reply-To:  cygwin-patches@cygwin.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: Re: errno.cc (_sys_nerr) patch
References: <3EB16574.6040403@yahoo.com>
In-Reply-To: <3EB16574.6040403@yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q2/txt/msg00071.txt.bz2

Ping.

Earnie Boyd wrote:
> This patch leaves newlib/libc/include/sys/errno.h file as is.  The 
> importance of this patch is that currently _sys_nerr is marked as 
> imported because ``extern __declspec(dllexport)'' is converted to 
> __declspec(dllimport).
> 
> Earnie.
> 
> 
> ------------------------------------------------------------------------
> 
> 2003.05.01  Earnie Boyd  <earnie@users.sf.net>
> 
> 	* errno.cc: Remove macro definition kludges for _sys_nerr and sys_nerr.
> 	(_sys_nerr): Remove extern, const and NO_COPY modifiers to remove a
> 	section type conflict and to allow the variable to really be marked as
> 	exported instead of marked as imported.
> 
> Index: errno.cc
> ===================================================================
> RCS file: /cvs/src/src/winsup/cygwin/errno.cc,v
> retrieving revision 1.33
> diff -u -3 -p -r1.33 errno.cc
> --- errno.cc	27 Apr 2003 03:14:02 -0000	1.33
> +++ errno.cc	1 May 2003 18:05:48 -0000
> @@ -8,16 +8,12 @@ This software is a copyrighted work lice
>  Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
>  details. */
>  
> -#define _sys_nerr FOO_sys_nerr
> -#define sys_nerr FOOsys_nerr
>  #include "winsup.h"
>  #define _REENT_ONLY
>  #include <stdio.h>
>  #include <errno.h>
>  #include "cygerrno.h"
>  #include "thread.h"
> -#undef _sys_nerr
> -#undef sys_nerr
>  
>  /* Table to map Windows error codes to Errno values.  */
>  /* FIXME: Doing things this way is a little slow.  It's trivial to change
> @@ -295,7 +291,7 @@ const NO_COPY char __declspec(dllexport)
>  /* EOVERFLOW 139 */ "Value too large for defined data type"
>  };
>  
> -extern const int NO_COPY __declspec(dllexport) _sys_nerr = sizeof (_sys_errlist) / sizeof (_sys_errlist[0]);
> +int __declspec(dllexport) _sys_nerr = sizeof (_sys_errlist) / sizeof (_sys_errlist[0]);
>  };
>  
>  /* FIXME: Why is strerror() a long switch and not just:
