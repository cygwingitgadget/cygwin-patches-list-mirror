Return-Path: <cygwin-patches-return-6193-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3203 invoked by alias); 13 Dec 2007 10:57:26 -0000
Received: (qmail 3189 invoked by uid 22791); 13 Dec 2007 10:57:22 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Thu, 13 Dec 2007 10:57:16 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 4377B6D4811; Thu, 13 Dec 2007 11:57:13 +0100 (CET)
Date: Thu, 13 Dec 2007 10:57:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch] poll() return value is actually that of select()
Message-ID: <20071213105713.GB32462@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <55c2fd8a0712120959q7d8cec61vb37a24c569cfb0c2@mail.gmail.com> <20071212185714.GD6618@calimero.vinschen.de> <55c2fd8a0712122012q3ee2afccm3b0e42244dba7987@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55c2fd8a0712122012q3ee2afccm3b0e42244dba7987@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q4/txt/msg00045.txt.bz2

On Dec 12 23:12, Craig MacGregor wrote:
> On Dec 12, 2007 1:57 PM, Corinna Vinschen wrote:
> >
> > Works for me.  How does it break the build for you?  Patch?
> 
> I get the following error making cygserver... i set up my dev env in a
> rush and just wanted a clean build, so i rolled back string.h to 1.8
> for a quick fix:

Oh, right.  I didn't check outside of the cygwin subdir.  Hmpf.
Thanks, I'll applied a fix.

> > it.  I'll rather have the `ir = 1' expressions standalone on a single
> > line and curly brackets.  I'll apply it tomorrow.
> 
> I changed as few lines as possible to avoid the next point :)

I applied a (IMHO) simpler solution which doesn't require any new
variable, along these lines:

Index: poll.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/poll.cc,v
retrieving revision 1.48
diff -u -p -b -r1.48 poll.cc
--- poll.cc	31 Jul 2006 14:27:56 -0000	1.48
+++ poll.cc	13 Dec 2007 10:37:54 -0000
@@ -1,6 +1,6 @@
 /* poll.cc. Implements poll(2) via usage of select(2) call.
 
-   Copyright 2000, 2001, 2002, 2003, 2004, 2005, 2006 Red Hat, Inc.
+   Copyright 2000, 2001, 2002, 2003, 2004, 2005, 2006, 2007 Red Hat, Inc.
 
    This file is part of Cygwin.
 
@@ -76,9 +76,14 @@ poll (struct pollfd *fds, nfds_t nfds, i
   if (invalid_fds)
     return invalid_fds;
 
-  int ret = cygwin_select (max_fd + 1, read_fds, write_fds, except_fds, timeout < 0 ? NULL : &tv);
+  int ret = cygwin_select (max_fd + 1, read_fds, write_fds, except_fds,
+			   timeout < 0 ? NULL : &tv);
+  if (ret <= 0)
+    return ret;
 
-  if (ret > 0)
+  /* Set revents fields and count fds with non-zero revents fields for
+     return value. */
+  ret = 0;
     for (unsigned int i = 0; i < nfds; ++i)
       {
 	if (fds[i].fd >= 0)
@@ -112,6 +117,8 @@ poll (struct pollfd *fds, nfds_t nfds, i
 		      fds[i].revents |= POLLPRI;
 		  }
 	      }
+	  if (fds[i].revents)
+	    ++ret;
 	  }
       }
 
 
The actual patch is just bigger due to the changed indentation.  Please
have a look if I didn't miss anything.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
