Return-Path: <cygwin-patches-return-3345-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32212 invoked by alias); 20 Dec 2002 01:17:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 32177 invoked from network); 20 Dec 2002 01:17:30 -0000
Date: Thu, 19 Dec 2002 17:17:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: grep on Win9x directories
Message-ID: <20021220011728.GC6359@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20021219182916.00824490@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20021219182916.00824490@mail.attbi.com>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2002-q4/txt/msg00296.txt.bz2

Wow, you're quick.  I was just checking into this.  I had a breakpoint set
and everything.

Please check this in, Pierre.  It's a nice addition to 1.3.18.

cgf

On Thu, Dec 19, 2002 at 06:29:16PM -0500, Pierre A. Humblet wrote:
>
>
>2002-12-19  Pierre Humblet <pierre.humblet@ieee.org>
>
>	* fhandler.cc (fhandler_base::open): Use "flags" rather than "mode" in 
>	Win9X directory code.
>
>Index: fhandler.cc
>===================================================================
>RCS file: /cvs/src/src/winsup/cygwin/fhandler.cc,v
>retrieving revision 1.142
>diff -u -p -r1.142 fhandler.cc
>--- fhandler.cc 14 Dec 2002 19:11:42 -0000      1.142
>+++ fhandler.cc 19 Dec 2002 23:20:53 -0000
>@@ -463,9 +463,9 @@ fhandler_base::open (path_conv *pc, int 
>     {
>       if (!wincap.can_open_directories () && pc && pc->isdir ())
>        {
>-         if (mode & (O_CREAT | O_EXCL) == (O_CREAT | O_EXCL))
>+         if (flags & (O_CREAT | O_EXCL) == (O_CREAT | O_EXCL))
>            set_errno (EEXIST);
>-         else if (mode & (O_WRONLY | O_RDWR))
>+         else if (flags & (O_WRONLY | O_RDWR))
>            set_errno (EISDIR);
>          else
>            set_nohandle (true);
