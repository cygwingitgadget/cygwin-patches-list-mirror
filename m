From: Chris Faylor <cgf@cygnus.com>
To: cygpatch <cygwin-patches@sourceware.cygnus.com>
Subject: Re: [Patch]: fhandler_base::puts_readahead crashes sometimes.
Date: Tue, 09 May 2000 14:05:00 -0000
Message-id: <20000509170512.A7622@cygnus.com>
References: <39187C1A.EAB5BFD2@vinschen.de>
X-SW-Source: 2000-q2/msg00047.html

On Tue, May 09, 2000 at 10:59:06PM +0200, Corinna Vinschen wrote:
>I have found a problem in puts_readahead. When starting a ssh
>connection to another host and then trying to start vi on that
>host, ssh crashes with SIGSEGV. I could find the assassin in
>fhandler_base::puts_readahead().

Looks right.  I wonder what I was thinking when I wrote that code.  I'm
surprised it doesn't screw up more often.

Please check it in.

cgf

>ChangeLog:
>==========
>
>	* fhandler.cc (fhandler_base::puts_readahead): Change
>	while condition to disallow wild runs.
>Index: fhandler.cc
>===================================================================
>RCS file: /cvs/src/src/winsup/cygwin/fhandler.cc,v
>retrieving revision 1.16
>diff -u -p -r1.16 fhandler.cc
>--- fhandler.cc	2000/05/08 16:13:54	1.16
>+++ fhandler.cc	2000/05/09 20:41:23
>@@ -22,8 +22,8 @@ int
> fhandler_base::puts_readahead (const char *s, size_t len = (size_t) -1)
> {
>   int success = 1;
>-  while ((((len == (size_t) -1) && *s) || len--) &&
>-	 (success = put_readahead (*s++) > 0))
>+  while ((*s || (len != (size_t) -1 && len--))
>+         && (success = put_readahead (*s++) > 0))
>     continue;
>   return success;
> }


-- 
cgf@cygnus.com                        Cygnus Solutions, a Red Hat company
http://sourceware.cygnus.com/         http://www.redhat.com/
