Return-Path: <cygwin-patches-return-3247-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5916 invoked by alias); 30 Nov 2002 02:03:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5824 invoked from network); 30 Nov 2002 02:03:55 -0000
Date: Fri, 29 Nov 2002 18:03:00 -0000
From: Steve O <bub@io.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] fhandler_tty read_retval fix
Message-ID: <20021129200410.A20532@eris.io.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-SW-Source: 2002-q4/txt/msg00198.txt.bz2


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-length: 348

Hi,
This patch fixes a premature EOF if the tty_slave happens to 
read read_retval as the pty_master is executing accept_input. 
-steve

ChangeLog entry
2002-11-29 Steve O <bub@io.com>

	* fhandler_tty.cc (fhandler_pty_master::accept_input): Moved
	  read_retval assignment to prevent race condition.  Removed
	  read_retval from return statement.

--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="tty_patch.1"
Content-length: 1257

Index: cygwin/fhandler_tty.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_tty.cc,v
retrieving revision 1.79
diff -u -p -r1.79 fhandler_tty.cc
--- cygwin/fhandler_tty.cc	26 Nov 2002 20:32:39 -0000	1.79
+++ cygwin/fhandler_tty.cc	30 Nov 2002 01:49:03 -0000
@@ -153,7 +153,6 @@ fhandler_pty_master::accept_input ()
   rc = WaitForSingleObject (input_mutex, INFINITE);
 
   bytes_left = n = eat_readahead (-1);
-  get_ttyp ()->read_retval = 0;
   p = rabuf;
 
   if (n != 0)
@@ -165,9 +164,12 @@ fhandler_pty_master::accept_input ()
 	  if (!rc)
 	    {
 	      debug_printf ("error writing to pipe %E");
+	      get_ttyp ()->read_retval = -1;
 	      break;
 	    }
-	  get_ttyp ()->read_retval += written;
+	  else 
+	    get_ttyp ()->read_retval = 1;
+
 	  p += written;
 	  bytes_left -= written;
 	  if (bytes_left > 0)
@@ -181,10 +183,13 @@ fhandler_pty_master::accept_input ()
 	}
     }
   else
-    termios_printf ("sending EOF to slave");
+    {
+      termios_printf ("sending EOF to slave");
+      get_ttyp ()->read_retval = 0;
+    }
   SetEvent (input_available_event);
   ReleaseMutex (input_mutex);
-  return get_ttyp ()->read_retval;
+  return 1;
 }
 
 static DWORD WINAPI

--wRRV7LY7NUeQGEoC--
