Return-Path: <cygwin-patches-return-3102-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 15333 invoked by alias); 4 Nov 2002 00:36:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15276 invoked from network); 4 Nov 2002 00:36:07 -0000
Date: Sun, 03 Nov 2002 16:36:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: fhandler_tty patch
Message-ID: <20021104003759.GA22976@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <002701c28394$ce2fc1f0$0201a8c0@sos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <002701c28394$ce2fc1f0$0201a8c0@sos>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2002-q4/txt/msg00053.txt.bz2

On Sun, Nov 03, 2002 at 06:57:42PM -0500, Sergey Okhapkin wrote:
>The patch resolves -1 return value from ioctl(slave_tty, TIOCSWINSZ, ...)
>problem and avoids extra SIGWINCH if the window size did not change.
>
>2002-11-03  Sergey Okhapkin  <sos@prospect.com.ru>
>
>	* fhandler_tty.cc (fhandler_tty_slave::ioctl): Do nothing if the new
>	window size is equal to the old one.  Send SIGWINCH if slave connected
>	to a pseudo tty.
>	(fhandler_pty_master::ioctl): Do nothing if the new window size is
>	equal to the old one.

Is this according to some standard?  It seems like we're sending too many
SIGWINCHes with your patch.

cgf

Index: fhandler_tty.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_tty.cc,v
retrieving revision 1.76
diff -u -p -r1.76 fhandler_tty.cc
--- fhandler_tty.cc	20 Oct 2002 04:15:50 -0000	1.76
+++ fhandler_tty.cc	3 Nov 2002 23:35:43 -0000
@@ -955,12 +955,23 @@ fhandler_tty_slave::ioctl (unsigned int 
       get_ttyp ()->winsize = get_ttyp ()->arg.winsize;
       break;
     case TIOCSWINSZ:
-      get_ttyp ()->ioctl_retval = -1;
-      get_ttyp ()->arg.winsize = * (struct winsize *) arg;
-      if (ioctl_request_event)
-	SetEvent (ioctl_request_event);
-      if (ioctl_done_event)
-	WaitForSingleObject (ioctl_done_event, INFINITE);
+      if (get_ttyp ()->winsize.ws_row != ((struct winsize *) arg)->ws_row
+	  || get_ttyp ()->winsize.ws_col != ((struct winsize *) arg)->ws_col)
+        {
+          get_ttyp ()->arg.winsize = * (struct winsize *) arg;
+          if (ioctl_request_event)
+	    {
+              get_ttyp ()->ioctl_retval = -1;
+	      SetEvent (ioctl_request_event);
+	    }
+	  else
+	    {
+	      get_ttyp ()->winsize = * (struct winsize *) arg;
+	      kill (-get_ttyp ()->getpgid (), SIGWINCH);
+	    }
+          if (ioctl_done_event)
+	    WaitForSingleObject (ioctl_done_event, INFINITE);
+	}
       break;
     }
 
@@ -1103,8 +1114,12 @@ fhandler_pty_master::ioctl (unsigned int
 	* (struct winsize *) arg = get_ttyp ()->winsize;
 	break;
       case TIOCSWINSZ:
-	get_ttyp ()->winsize = * (struct winsize *) arg;
-	kill (-get_ttyp ()->getpgid (), SIGWINCH);
+        if (get_ttyp ()->winsize.ws_row != ((struct winsize *) arg)->ws_row
+	    || get_ttyp ()->winsize.ws_col != ((struct winsize *) arg)->ws_col)
+          {
+	    get_ttyp ()->winsize = * (struct winsize *) arg;
+	    kill (-get_ttyp ()->getpgid (), SIGWINCH);
+	  }
 	break;
       case FIONBIO:
 	set_nonblocking (*(int *) arg);
