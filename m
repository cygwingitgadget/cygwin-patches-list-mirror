Return-Path: <cygwin-patches-return-3966-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26671 invoked by alias); 16 Jun 2003 11:32:16 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25744 invoked from network); 16 Jun 2003 11:31:53 -0000
Message-ID: <3EEDAAAC.3090401@yahoo.com>
Date: Mon, 16 Jun 2003 11:32:00 -0000
From: Earnie Boyd <earnie_boyd@yahoo.com>
Reply-To:  cygwin-patches@cygwin.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: Re: exceptions.cc - stackdump file - patch to identify version and
 build date
References: <3EE9BA02.7080502@yahoo.com>
In-Reply-To: <3EE9BA02.7080502@yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q2/txt/msg00193.txt.bz2

What's up?  It seems to me that I'm being ignored.  I would have thought 
a little discussion or CVS update would have ensued.

Earnie.

Earnie Boyd wrote:
> 
> ------------------------------------------------------------------------
> 
> 2003-06-13  Earnie Boyd  <earnie@users.sf.net>
> 
> 	* exceptions.cc (exception): Output version and build date information
> 	to the stackdump.
> 
> Index: exceptions.cc
> ===================================================================
> RCS file: /cvs/src/src/winsup/cygwin/exceptions.cc,v
> retrieving revision 1.149
> diff -u -3 -p -r1.149 exceptions.cc
> --- exceptions.cc	12 Jun 2003 12:36:07 -0000	1.149
> +++ exceptions.cc	13 Jun 2003 11:43:05 -0000
> @@ -22,6 +22,7 @@ details. */
>  #include "shared_info.h"
>  #include "perprocess.h"
>  #include "security.h"
> +#include "cygwin_version.h"
>  
>  #define CALL_HANDLER_RETRY 20
>  
> @@ -206,6 +207,11 @@ exception (EXCEPTION_RECORD *e,  CONTEXT
>  
>  #ifdef __i386__
>  #define HAVE_STATUS
> +  small_printf ("CYGWIN-%d.%d.%d Build:%s\r\n",
> +      cygwin_version.dll_major / 1000,
> +      cygwin_version.dll_major % 1000,
> +      cygwin_version.dll_minor,
> +      cygwin_version.dll_build_date);
>    if (exception_name)
>      small_printf ("Exception: %s at eip=%08x\r\n", exception_name, in->Eip);
>    else
