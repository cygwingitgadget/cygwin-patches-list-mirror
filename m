Return-Path: <cygwin-patches-return-3069-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 790 invoked by alias); 21 Oct 2002 05:59:54 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 781 invoked from network); 21 Oct 2002 05:59:54 -0000
Date: Sun, 20 Oct 2002 22:59:00 -0000
From: Steve O <bub@io.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] fhandler_tty deadlock patch
Message-ID: <20021021010303.A2647@eris.io.com>
References: <20021018011921.A20255@hagbard.io.com> <Pine.GSO.4.44.0210202249210.18735-101000@slinky.cs.nyu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.4.44.0210202249210.18735-101000@slinky.cs.nyu.edu>; from pechtcha@cs.nyu.edu on Sun, Oct 20, 2002 at 11:15:47PM -0400
X-SW-Source: 2002-q4/txt/msg00020.txt.bz2

On Sun, Oct 20, 2002 at 11:15:47PM -0400, Igor Pechtchanski wrote:
> However, there are a couple of problems with this patch.  For example,
> this makes bash run from a command prompt (or a shortcut) treat every
> character as a ^D.

So every character closes bash?  I'm not able to reproduce this on
WinXP, have an strace?

> /bin/sh ignores Enter (or ^J, or ^M).  

Good find.  I've attached a diff that should fix this.  Unsure
how to proceed since the original patch hasn't been applied.
Do I resubmit the original patch or treat this one as it's own
thing?

> Running 'bash -c "echo BLAH && exit"' from
> a command prompt works, however, running "bash -c 'echo BLAH && exit'
...

Curious behavior, but not related to the tty patch.  Happens
with previous cygwin dll's and in rxvt -e cmd.

Thanks,
-steve


2002-10-20  Steve Osborn  <bub@io.com>

	* fhandler_termios.cc (fhandler_termios::line_edit_cnt) Return
        1 if last character processed results in input_done.

--- fhandler_termios_orig.cc	2002-10-20 22:43:40.000000000 -0700
+++ fhandler_termios.cc	2002-10-20 22:00:44.000000000 -0700
@@ -206,6 +206,7 @@ fhandler_termios::line_edit_cnt (const c
 
   for (nprocessed = 0; nprocessed < *nread; nprocessed++)
     {
+      input_done=0;
       c = *rptr++;
       eat_on_failure = FALSE;
 
@@ -342,7 +343,6 @@ fhandler_termios::line_edit_cnt (const c
 
       if (input_done) 
 	{
-	  input_done=0;
 	  if (accept_input ()) 
 	    {
 	      termios_printf ("accept_input full, undoing last char");
@@ -364,20 +364,19 @@ fhandler_termios::line_edit_cnt (const c
 	}
     }
 
-  if (!iscanon || always_accept)
-    set_input_done (ralen > 0);
-
   if (sawsig)
     input_done = -1;
-  else if (input_done)
-    if (accept_input () && nprocessed == *nread) 
-      {
-	termios_printf ("accept_input full");
-	if (eat_on_failure)
-	  eat_readahead (1);
-	nprocessed--;
-      }
-
+  else if (!input_done && ralen > 0 && (!iscanon || always_accept))
+    {
+      set_input_done (1);
+      if (accept_input () && nprocessed == *nread)
+	{
+	  termios_printf ("accept_input full");
+	  if (eat_on_failure)
+	    eat_readahead (1);
+	  nprocessed--;
+	}
+    }
   *nread = nprocessed;
   return input_done;
 }
