Return-Path: <cygwin-patches-return-3067-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 24116 invoked by alias); 20 Oct 2002 12:02:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24107 invoked from network); 20 Oct 2002 12:01:59 -0000
Message-ID: <3DB29B4C.4000302@yahoo.com>
Date: Sun, 20 Oct 2002 05:02:00 -0000
From: Earnie Boyd <earnie_boyd@yahoo.com>
Reply-To:  cygwin-patches@cygwin.com
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Igor Pechtchanski <pechtcha@cs.nyu.edu>
CC:  cygwin-patches@cygwin.com
Subject: Re: [PATCH] winsup cvs HEAD build broken
References: <Pine.GSO.4.44.0210192212110.6818-200000@slinky.cs.nyu.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q4/txt/msg00018.txt.bz2

FYI, Danny fixed this but with a different patch.

Earnie.

Igor Pechtchanski wrote:
> Hi,
> The winsup cvs HEAD doesn't build.  The error is in winsup/mingw/crt1.c --
> gcc chokes on _onexit_t.  Further investigation identified the culprit:
> http://www.cygwin.com/ml/cygwin-cvs/2002-q4/msg00056.html , in particular,
> the following change:
> 	crt1.c: Don't include fcntrl.h, stdlib.h.
> _onexit_t is defined in stdlib.h.
> I've attached the patch to include stdlib.h back, which fixes the build.
> 	Igor
> 
> ChangeLog:
> 2002-10-19  Igor Pechtchanski <pechtcha@cs.nyu.edu>
> 
> 	* crt1.c: Include stdlib.h.
> 
> 
> 
> ------------------------------------------------------------------------
> 
> Index: winsup/mingw/crt1.c
> ===================================================================
> RCS file: /cvs/src/src/winsup/mingw/crt1.c,v
> retrieving revision 1.4
> diff -u -p -r1.4 crt1.c
> --- winsup/mingw/crt1.c	19 Oct 2002 20:26:26 -0000	1.4
> +++ winsup/mingw/crt1.c	20 Oct 2002 02:22:52 -0000
> @@ -26,6 +26,7 @@
>   *
>   */
>  
> +#include <stdlib.h>
>  #include <stdio.h>
>  #include <io.h>
>  #include <process.h>
