Return-Path: <cygwin-patches-return-3647-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16050 invoked by alias); 28 Feb 2003 05:56:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16041 invoked from network); 28 Feb 2003 05:56:35 -0000
Date: Fri, 28 Feb 2003 05:56:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: access () and path.cc
Message-ID: <20030228055635.GB24690@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030227235437.0080a480@incoming.verizon.net> <3.0.5.32.20030227230453.007d3a60@mail.attbi.com> <3.0.5.32.20030227230453.007d3a60@mail.attbi.com> <3.0.5.32.20030227235437.0080a480@incoming.verizon.net> <3.0.5.32.20030228004959.007ff8b0@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20030228004959.007ff8b0@incoming.verizon.net>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2003-q1/txt/msg00296.txt.bz2

On Fri, Feb 28, 2003 at 12:49:59AM -0500, Pierre A. Humblet wrote:
>OK, following Chris' remarks here is a much smaller set
>of changes.

Do you think it would make sense to do something along the lines
of:

>+      path_conv pc (cfd->is_device ? cfd->get_name () : cfd->get_win32_name (), PC_SYM_NOFOLLOW);

just to minimize the (minimal) performance hit?  Ordinarily, I
wouldn't advocate such a kludge but these are special circumstances.

I suppose you could do something similar in access(), too.

cgf

>Pierre
>
>
>2003-02-28  Pierre Humblet  <pierre.humblet@ieee.org>
>
>	* syscalls.cc (fstat64): Pass get_name () to pc.
>	(access): Pass fn to stat_worker. 
>
>Index: syscalls.cc
>===================================================================
>RCS file: /cvs/src/src/winsup/cygwin/syscalls.cc,v
>retrieving revision 1.246
>diff -u -p -r1.246 syscalls.cc
>--- syscalls.cc 21 Feb 2003 14:29:18 -0000      1.246
>+++ syscalls.cc 28 Feb 2003 05:46:09 -0000
>@@ -1013,7 +1013,7 @@ fstat64 (int fd, struct __stat64 *buf)
>     res = -1;
>   else
>     {
>-      path_conv pc (cfd->get_win32_name (), PC_SYM_NOFOLLOW);
>+      path_conv pc (cfd->get_name (), PC_SYM_NOFOLLOW);
>       memset (buf, 0, sizeof (struct __stat64));
>       res = cfd->fstat (buf, &pc);
>       if (!res && cfd->get_device () != FH_SOCKET)
>@@ -1200,7 +1200,7 @@ access (const char *fn, int flags)
>     return check_file_access (real_path, flags);
> 
>   struct __stat64 st;
>-  int r = stat_worker (real_path, &st, 0);
>+  int r = stat_worker (fn, &st, 0);
>   if (r)
>     return -1;
>   r = -1;
>
>
