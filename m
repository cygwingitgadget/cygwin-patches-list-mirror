Return-Path: <cygwin-patches-return-3249-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13983 invoked by alias); 30 Nov 2002 22:55:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13972 invoked from network); 30 Nov 2002 22:54:59 -0000
Date: Sat, 30 Nov 2002 14:55:00 -0000
From: Steve O <bub@io.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] line_edit return value
Message-ID: <20021130170221.A6355@fnord.io.com>
References: <20021129200410.A20532@eris.io.com> <20021130222603.GB29907@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021130222603.GB29907@redhat.com>; from cgf@redhat.com on Sat, Nov 30, 2002 at 05:26:03PM -0500
X-SW-Source: 2002-q4/txt/msg00200.txt.bz2


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-length: 1156

On Sat, Nov 30, 2002 at 05:26:03PM -0500, Christopher Faylor wrote:
> P.S.  Btw, did you notice that the return value for accept_input
> is not being used, AFAICT?  I had always wanted to do something
> with that but it never seemed to be necessary.

Yep, about 5 or 6 patches from now, I am thinking of using 
the return value to signal that accept_input didn't work. 

Here's the next patch.  It shouldn't change the code behavior at all
but lays some ground work for having line_edit return an error condition.

Thanks,
-steve

ChangeLog entry
2002-11-30 Steve Osborn <bub@io.com>
	* fhandler.h (fhandler_termios::line_edit): Changed return
	  from an int to an enum to allow the function to return an
	  error.
	* fhandler_console.cc (fhandler_console::read): Updated the
	  line_edit call to use the new enum.
	* fhandler_termios.cc (fhandler_termios::line_edit): Changed 
	  return from an int to an enum to allow the function to return an
          error.  Put put_readahead call before doecho for future patch. 
	* fhandler_tty.cc (fhandler_pty_master::write): Changed to 
	  call line_edit one character at a time, and stop if an error
	  occurs.

--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="tty_patch.2"
Content-length: 3580

Index: cygwin/fhandler.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler.h,v
retrieving revision 1.146
diff -u -p -r1.146 fhandler.h
--- cygwin/fhandler.h	9 Nov 2002 03:17:40 -0000	1.146
+++ cygwin/fhandler.h	30 Nov 2002 22:32:19 -0000
@@ -118,6 +118,14 @@ typedef struct __DIR DIR;
 struct dirent;
 struct iovec;
 
+enum line_edit_status
+{
+  line_edit_signalled = -1,
+  line_edit_ok = 0,
+  line_edit_input_done = 1,
+  line_edit_error = 2
+};
+
 enum bg_check_types
 {
   bg_error = -1,
@@ -693,7 +701,7 @@ class fhandler_termios: public fhandler_
     set_need_fork_fixup ();
   }
   HANDLE& get_output_handle () { return output_handle; }
-  int line_edit (const char *rptr, int nread, int always_accept = 0);
+  line_edit_status line_edit (const char *rptr, int nread, int always_accept = 0);
   void set_output_handle (HANDLE h) { output_handle = h; }
   void tcinit (tty_min *this_tc, int force = FALSE);
   virtual int is_tty () { return 1; }
Index: cygwin/fhandler_console.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_console.cc,v
retrieving revision 1.96
diff -u -p -r1.96 fhandler_console.cc
--- cygwin/fhandler_console.cc	15 Nov 2002 04:35:13 -0000	1.96
+++ cygwin/fhandler_console.cc	30 Nov 2002 22:32:23 -0000
@@ -457,10 +457,10 @@ fhandler_console::read (void *pv, size_t
 
       if (toadd)
 	{
-	  int res = line_edit (toadd, nread);
-	  if (res < 0)
+	  line_edit_status res = line_edit (toadd, nread);
+	  if (res == line_edit_signalled)
 	    goto sig_exit;
-	  else if (res)
+	  else if (res == line_edit_input_done)
 	    break;
 	}
 #undef ich
Index: cygwin/fhandler_termios.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_termios.cc,v
retrieving revision 1.33
diff -u -p -r1.33 fhandler_termios.cc
--- cygwin/fhandler_termios.cc	23 Sep 2002 00:31:30 -0000	1.33
+++ cygwin/fhandler_termios.cc	30 Nov 2002 22:32:24 -0000
@@ -186,9 +186,10 @@ fhandler_termios::echo_erase (int force)
     doecho ("\b \b", 3);
 }
 
-int
+line_edit_status
 fhandler_termios::line_edit (const char *rptr, int nread, int always_accept)
 {
+  line_edit_status ret = line_edit_ok;
   char c;
   int input_done = 0;
   bool sawsig = FALSE;
@@ -321,20 +322,23 @@ fhandler_termios::line_edit (const char 
       if (tc->ti.c_iflag & IUCLC && isupper (c))
 	c = cyg_tolower (c);
 
+      put_readahead (c);
       if (tc->ti.c_lflag & ECHO)
 	doecho (&c, 1);
-      put_readahead (c);
     }
 
   if (!iscanon || always_accept)
     set_input_done (ralen > 0);
 
   if (sawsig)
-    input_done = -1;
+    ret = line_edit_signalled;
   else if (input_done)
-    (void) accept_input ();
+    {
+      ret = line_edit_input_done;
+      (void) accept_input ();
+    }
 
-  return input_done;
+  return ret;
 }
 
 void
Index: cygwin/fhandler_tty.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_tty.cc,v
retrieving revision 1.80
diff -u -p -r1.80 fhandler_tty.cc
--- cygwin/fhandler_tty.cc	30 Nov 2002 22:23:01 -0000	1.80
+++ cygwin/fhandler_tty.cc	30 Nov 2002 22:32:26 -0000
@@ -1077,8 +1077,12 @@ fhandler_pty_master::close ()
 int
 fhandler_pty_master::write (const void *ptr, size_t len)
 {
-  (void) line_edit ((char *) ptr, len);
-  return len;
+  size_t i;
+  char *p = (char *) ptr;
+  for (i=0; i<len; i++)
+    if (line_edit (p++, 1) == line_edit_error) 
+      break;
+  return i;
 }
 
 int __stdcall

--d6Gm4EdcadzBjdND--
