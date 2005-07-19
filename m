Return-Path: <cygwin-patches-return-5577-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5568 invoked by alias); 19 Jul 2005 20:36:26 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5456 invoked by uid 22791); 19 Jul 2005 20:36:20 -0000
Received: from main.gmane.org (HELO ciao.gmane.org) (80.91.229.2)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Tue, 19 Jul 2005 20:36:20 +0000
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Duyof-0004Jl-F6
	for cygwin-patches@cygwin.com; Tue, 19 Jul 2005 22:35:49 +0200
Received: from eblake.csw.L-3com.com ([128.170.36.44])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <cygwin-patches@cygwin.com>; Tue, 19 Jul 2005 22:35:49 +0200
Received: from ebb9 by eblake.csw.L-3com.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <cygwin-patches@cygwin.com>; Tue, 19 Jul 2005 22:35:49 +0200
To: cygwin-patches@cygwin.com
From:  Eric Blake <ebb9@byu.net>
Subject:  Re: cygcheck .exe magic
Date: Tue, 19 Jul 2005 20:36:00 -0000
Message-ID:  <loom.20050719T222825-989@post.gmane.org>
References:  <loom.20050719T212315-901@post.gmane.org> <20050719200213.GA26440@trixie.casa.cgf.cx>
Mime-Version:  1.0
Content-Type:  text/plain; charset=us-ascii
Content-Transfer-Encoding:  7bit
User-Agent: Loom/3.14 (http://gmane.org/)
X-SW-Source: 2005-q3/txt/msg00032.txt.bz2

Christopher Faylor <cgf-no-personal-reply-please <at> cygwin.com> writes:

> 
> Are you sure this is right?  cygcheck.exe isn't a cygwin program so I'd wonder
> about the use of the inodes returned from windows stat() call.
> 

You have a point; revised patch attached.  The original worked for me in 
testing, but only because I was short-circuiting when the first stat failed, 
and appending the .exe happened to be the right thing to do.  Since this is not 
a cygwin app, there is no .exe magic in stat() to counteract, and all we really 
need to do is see if appending the suffix makes stat succeed.


2005-07-19  Eric Blake  <ebb9 <at> byu.net>

	* cygcheck.cc (find_on_path): Perform .exe magic on non-PATH search.

Index: winsup/utils/cygcheck.cc
===================================================================
RCS file: /cvs/src/src/winsup/utils/cygcheck.cc,v
retrieving revision 1.75
diff -p -r1.75 cygcheck.cc
*** winsup/utils/cygcheck.cc    5 Jul 2005 21:41:37 -0000       1.75
--- winsup/utils/cygcheck.cc    19 Jul 2005 19:24:27 -0000
***************
*** 12,17 ****
--- 12,18 ----
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
+ #include <sys/stat.h>
  #include <sys/time.h>
  #include <ctype.h>
  #include <io.h>
*************** find_on_path (char *file, char *default_
*** 218,224 ****
      }
  
    if (strchr (file, ':') || strchr (file, '\\') || strchr (file, '/'))
!     return cygpath (file, NULL);
  
    if (strchr (file, '.'))
      default_extension = (char *) "";
--- 219,235 ----
      }
  
    if (strchr (file, ':') || strchr (file, '\\') || strchr (file, '/'))
!     {
!       struct stat stshort, stlong;
!       char *shortname = cygpath (file, NULL);
!       strcat (strcpy (tmp, shortname), default_extension);
!       /* Check if extension makes a difference.  */
!       if (stat (shortname, &stshort) && ! stat (tmp, &stlong))
! 	strcpy (rv, tmp);
!       else
! 	strcpy (rv, shortname);
!       return rv;
!     }
  
    if (strchr (file, '.'))
      default_extension = (char *) "";


