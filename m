Return-Path: <cygwin-patches-return-4903-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30406 invoked by alias); 21 Aug 2004 13:52:43 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30397 invoked from network); 21 Aug 2004 13:52:42 -0000
Date: Sat, 21 Aug 2004 13:52:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] fhandler_disk_file::fchmod
Message-ID: <20040821135321.GB9451@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20040821094631.007dee80@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20040821094631.007dee80@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q3/txt/msg00055.txt.bz2

On Sat, Aug 21, 2004 at 09:46:31AM -0400, Pierre A. Humblet wrote:
>This bug was found while investigating testsuite failures.  It occurs
>only on 9x, when ntsec is on.  An alternate (more general) solution
>would be to only set allow_ntsec (in environ.cc) on NT.  Why allow it
>on 9x?

That was my first reaction on looking at your patch before reading the
above comment.

Why don't we do that?  It seems like it would simplify things slightly
throughout cygwin.

cgf

>Pierre 
>
>2004-08-14  Pierre Humblet <pierre.humblet@ieee.org>
>
>	* fhandler_disk_file.cc (fhandler_disk_file::fchmod): Check if Windows
>	has security when determining res.
>
>Index: fhandler_disk_file.cc
>===================================================================
>RCS file: /cvs/src/src/winsup/cygwin/fhandler_disk_file.cc,v
>retrieving revision 1.92
>diff -u -p -r1.92 fhandler_disk_file.cc
>--- fhandler_disk_file.cc       29 May 2004 00:51:16 -0000      1.92
>+++ fhandler_disk_file.cc       21 Aug 2004 02:26:21 -0000
>@@ -409,7 +409,7 @@ fhandler_disk_file::fchmod (mode_t mode)
> 
>   if (!SetFileAttributes (pc, pc))
>     __seterrno ();
>-  else if (!allow_ntsec)
>+  else if (!(allow_ntsec && wincap.has_security ()))
>     /* Correct NTFS security attributes have higher priority */
>     res = 0;
> 
>
