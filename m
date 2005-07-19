Return-Path: <cygwin-patches-return-5576-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9665 invoked by alias); 19 Jul 2005 20:02:55 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9036 invoked by uid 22791); 19 Jul 2005 20:02:16 -0000
Received: from c-24-61-23-223.hsd1.ma.comcast.net (HELO cgf.cx) (24.61.23.223)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Tue, 19 Jul 2005 20:02:15 +0000
Received: by cgf.cx (Postfix, from userid 201)
	id BFC8413C261; Tue, 19 Jul 2005 16:02:13 -0400 (EDT)
Date: Tue, 19 Jul 2005 20:02:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: cygcheck .exe magic
Message-ID: <20050719200213.GA26440@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <loom.20050719T212315-901@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <loom.20050719T212315-901@post.gmane.org>
User-Agent: Mutt/1.5.8i
X-SW-Source: 2005-q3/txt/msg00031.txt.bz2

On Tue, Jul 19, 2005 at 07:27:12PM +0000, Eric Blake wrote:
>I was annoyed that "cygcheck bash" worked but "cygcheck /bin/bash" did not.
>
>2005-07-19  Eric Blake  <ebb9@byu.net>
>
>	* cygcheck.cc (find_on_path): Perform .exe magic on non-PATH search.

Are you sure this is right?  cygcheck.exe isn't a cygwin program so I'd wonder
about the use of the inodes returned from windows stat() call.

cgf

>Index: winsup/utils/cygcheck.cc
>===================================================================
>RCS file: /cvs/src/src/winsup/utils/cygcheck.cc,v
>retrieving revision 1.75
>diff -p -r1.75 cygcheck.cc
>*** winsup/utils/cygcheck.cc    5 Jul 2005 21:41:37 -0000       1.75
>--- winsup/utils/cygcheck.cc    19 Jul 2005 19:24:27 -0000
>***************
>*** 12,17 ****
>--- 12,18 ----
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <string.h>
>+ #include <sys/stat.h>
>  #include <sys/time.h>
>  #include <ctype.h>
>  #include <io.h>
>*************** find_on_path (char *file, char *default_
>*** 218,224 ****
>      }
>  
>    if (strchr (file, ':') || strchr (file, '\\') || strchr (file, '/'))
>!     return cygpath (file, NULL);
>  
>    if (strchr (file, '.'))
>      default_extension = (char *) "";
>--- 219,237 ----
>      }
>  
>    if (strchr (file, ':') || strchr (file, '\\') || strchr (file, '/'))
>!     {
>!       struct stat stshort, stlong;
>!       char *shortname = cygpath (file, NULL);
>!       strcat (strcpy (tmp, shortname), default_extension);
>!       /* if short name doesn't exist, or if short name and extension name are
>!          same file, append the extension */
>!       if (stat (shortname, &stshort)
>!           || (! stat (tmp, &stlong) && stshort.st_ino == stlong.st_ino))
>!         strcpy (rv, tmp);
>!       else
>!         strcpy (rv, shortname);
>!       return rv;
>!     }
>  
>    if (strchr (file, '.'))
>      default_extension = (char *) "";
