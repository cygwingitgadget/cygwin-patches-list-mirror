Return-Path: <cygwin-patches-return-3341-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19090 invoked by alias); 17 Dec 2002 07:29:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19081 invoked from network); 17 Dec 2002 07:29:56 -0000
Date: Mon, 16 Dec 2002 23:29:00 -0000
From: Steve O <bub@io.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] to_slave pipe is full fix
Message-ID: <20021217013105.A22529@hagbard.io.com>
References: <20021215144314.A28430@eris.io.com> <20021216170122.G19104@cygbert.vinschen.de> <20021216131554.D30600@hagbard.io.com> <20021216193629.GB19567@redhat.com> <20021216164704.A13198@fnord.io.com> <20021217035114.GA12993@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021217035114.GA12993@redhat.com>; from cgf@redhat.com on Mon, Dec 16, 2002 at 10:51:14PM -0500
X-SW-Source: 2002-q4/txt/msg00292.txt.bz2


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-length: 925

On Mon, Dec 16, 2002 at 10:51:14PM -0500, Christopher Faylor wrote:
> One more question, though.  In accept_input, shouldn't ret be set to
> something besides 1 when there is an "error writing to pipe"?

True.  I hadn't been considering the error case. 
I've attached a patch for this.  It's not terribly pretty. 

> I wonder if there is some other way to do this other than pulling
> everything out of the read ahead buffer and then putting it back on
> failure.  I guess it doesn't matter since this is an edge condition.

There's some things that could be done such as moving the get_readahead
later, but I agree, no point in adding complexity for this case. 

> Hmm.  I wonder if the WaitForSingleObject (input_mutex,...) is enough to
> make this code thread safe. 

I think so, but it may be more protection than you need.  OTOH, the
readahead buffer could probably use some more protection on the filling
side.

-steve

--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="tty5.patch"
Content-length: 2258

Index: cygwin/fhandler.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler.h,v
retrieving revision 1.149
diff -u -p -r1.149 fhandler.h
--- cygwin/fhandler.h	14 Dec 2002 04:01:32 -0000	1.149
+++ cygwin/fhandler.h	17 Dec 2002 06:28:09 -0000
@@ -123,7 +123,8 @@ enum line_edit_status
   line_edit_signalled = -1,
   line_edit_ok = 0,
   line_edit_input_done = 1,
-  line_edit_error = 2
+  line_edit_error = 2,
+  line_edit_pipe_full = 3
 };
 
 enum bg_check_types
Index: cygwin/fhandler_termios.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_termios.cc,v
retrieving revision 1.36
diff -u -p -r1.36 fhandler_termios.cc
--- cygwin/fhandler_termios.cc	17 Dec 2002 03:49:34 -0000	1.36
+++ cygwin/fhandler_termios.cc	17 Dec 2002 06:28:10 -0000
@@ -326,9 +326,10 @@ fhandler_termios::line_edit (const char 
       put_readahead (c);
       if (!iscanon || always_accept || input_done)
 	{
-	  if (!accept_input ()) 
+	  int status = accept_input ();
+	  if (status != 1) 
 	    {
-	      ret = line_edit_error;
+	      ret = status ? line_edit_error : line_edit_pipe_full;
 	      eat_readahead (1);
 	      break;
 	    }
Index: cygwin/fhandler_tty.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_tty.cc,v
retrieving revision 1.83
diff -u -p -r1.83 fhandler_tty.cc
--- cygwin/fhandler_tty.cc	17 Dec 2002 03:49:34 -0000	1.83
+++ cygwin/fhandler_tty.cc	17 Dec 2002 06:28:12 -0000
@@ -169,6 +169,7 @@ fhandler_pty_master::accept_input ()
 	{
 	  debug_printf ("error writing to pipe %E");
 	  get_ttyp ()->read_retval = -1;
+	  ret = -1;
 	}
       else
 	{
@@ -1077,11 +1078,17 @@ fhandler_pty_master::close ()
 int
 fhandler_pty_master::write (const void *ptr, size_t len)
 {
-  size_t i;
+  int i;
   char *p = (char *) ptr;
-  for (i=0; i<len; i++)
-    if (line_edit (p++, 1) == line_edit_error)
+  for (i=0; i < (int) len; i++)
+    {
+      line_edit_status status = line_edit (p++, 1);
+      if (status == line_edit_ok || status == line_edit_input_done)
+	continue;
+      if (status != line_edit_pipe_full)
+	i = -1;
       break;
+    }
   return i;
 }
 

--J2SCkAp4GZ/dPZZf--
