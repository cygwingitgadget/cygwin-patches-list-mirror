Return-Path: <cygwin-patches-return-4891-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25448 invoked by alias); 10 Aug 2004 15:04:43 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25436 invoked from network); 10 Aug 2004 15:04:42 -0000
Date: Tue, 10 Aug 2004 15:04:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: array size problem in select.cc
Message-ID: <20040810150454.GB21680@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20040810103704.2A6C11B57A@cgf.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040810103704.2A6C11B57A@cgf.cx>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q3/txt/msg00043.txt.bz2

On Tue, Aug 10, 2004 at 11:36:41AM +0100, Charles Reindorf wrote:
>Cygwin developers,
>
>I was browsing in "winsup/cygwin/select.cc" from snapshot 20040808-1 and I
>think I see an array size problem there, resutling in possible core dumps when
>selecting about 63 file descriptors. I wonder if the following patch is
>applicable?

Thanks, but, the correct change is this:

Index: select.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/select.cc,v
retrieving revision 1.93
diff -u -p -r1.93 select.cc
--- select.cc   10 Apr 2004 13:45:10 -0000      1.93
+++ select.cc   10 Aug 2004 14:24:02 -0000
@@ -233,7 +233,7 @@ select_stuff::wait (fd_set *readfds, fd_
      counting the number of active fds. */
   while ((s = s->next))
     {
-      if (m > MAXIMUM_WAIT_OBJECTS)
+      if (m >= MAXIMUM_WAIT_OBJECTS)
        {
          set_sig_errno (EINVAL);
          return -1;

I'll make that change.  Thanks for the heads up.

cgf
