Return-Path: <cygwin-patches-return-3335-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7495 invoked by alias); 16 Dec 2002 19:14:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7486 invoked from network); 16 Dec 2002 19:14:43 -0000
Date: Mon, 16 Dec 2002 11:14:00 -0000
From: Steve O <bub@io.com>
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] to_slave pipe is full fix
Message-ID: <20021216131554.D30600@hagbard.io.com>
References: <20021215144314.A28430@eris.io.com> <20021216170122.G19104@cygbert.vinschen.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021216170122.G19104@cygbert.vinschen.de>; from cygwin-patches@cygwin.com on Mon, Dec 16, 2002 at 05:01:22PM +0100
X-SW-Source: 2002-q4/txt/msg00286.txt.bz2


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-length: 506

On Mon, Dec 16, 2002 at 05:01:22PM +0100, Corinna Vinschen wrote:
> did you perhaps forgot to attach the patch?

My apologies, the patch is enclosed this time.
-steve

ChangeLog:
2002-12-15  Steve Osborn  <bub@io.com>

    * fhandler_termios.cc (fhandler_termios::line_edit): Return
    line_edit_error and remove last char from readahead buffer
    if accept_input() fails.
    * fhandler_tty.cc (fhandler_pty_master::accept_input): Return 0
    and restore readahead buffer when tty slave pipe is full.


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="tty4.patch"
Content-length: 1751

Index: cygwin/fhandler_termios.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_termios.cc,v
retrieving revision 1.35
diff -u -p -r1.35 fhandler_termios.cc
--- cygwin/fhandler_termios.cc	14 Dec 2002 19:40:41 -0000	1.35
+++ cygwin/fhandler_termios.cc	15 Dec 2002 20:23:10 -0000
@@ -326,7 +326,12 @@ fhandler_termios::line_edit (const char 
       put_readahead (c);
       if (!iscanon || always_accept || input_done)
 	{
-	  (void) accept_input();
+	  if (!accept_input ()) 
+	    {
+	      ret = line_edit_error;
+	      eat_readahead (1);
+	      break;
+	    }
 	  ret = line_edit_input_done;
 	  input_done = 0;
 	}
Index: cygwin/fhandler_tty.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_tty.cc,v
retrieving revision 1.82
diff -u -p -r1.82 fhandler_tty.cc
--- cygwin/fhandler_tty.cc	14 Dec 2002 04:01:32 -0000	1.82
+++ cygwin/fhandler_tty.cc	15 Dec 2002 20:23:13 -0000
@@ -149,6 +149,7 @@ fhandler_pty_master::accept_input ()
   DWORD n;
   DWORD rc;
   char* p;
+  int ret = 1;
 
   rc = WaitForSingleObject (input_mutex, INFINITE);
 
@@ -175,10 +176,9 @@ fhandler_pty_master::accept_input ()
 	  if (bytes_left > 0)
 	    {
 	      debug_printf ("to_slave pipe is full");
-	      SetEvent (input_available_event);
-	      ReleaseMutex (input_mutex);
-	      Sleep (10);
-	      rc = WaitForSingleObject (input_mutex, INFINITE);
+	      puts_readahead (p, bytes_left);
+	      ret = 0;
+	      break;
 	    }
 	}
     }
@@ -189,7 +189,7 @@ fhandler_pty_master::accept_input ()
     }
   SetEvent (input_available_event);
   ReleaseMutex (input_mutex);
-  return 1;
+  return ret;
 }
 
 static DWORD WINAPI

--sdtB3X0nJg68CQEu--
