Return-Path: <cygwin-patches-return-3350-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4599 invoked by alias); 22 Dec 2002 03:06:28 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4585 invoked from network); 22 Dec 2002 03:06:27 -0000
Date: Sat, 21 Dec 2002 19:06:00 -0000
From: Steve O <bub@io.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] pty_master echobuf
Message-ID: <20021221210844.A27687@hagbard.io.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-SW-Source: 2002-q4/txt/msg00301.txt.bz2


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-length: 1058

Hi,
Thank you Christopher for reviewing all these tty patches.
Here's the next one.  It introduces an echo buffer that doecho
will eventually use.  As nothing yet puts characters into the
echo buffer, this patch should not have any noticeable effect. 

Thanks,
-steve

ChangeLog
2002-12-21  Steve Osborn  <bub@io.com>

	* fhandler.h (fhandler_pty_master::get_echobuf_valid): New.
	(fhandler_pty_master::ebbuf): New buffer.
	(fhandler_pty_master::ebixget): New buffer get index.
	(fhandler_pty_master::ebixput): New buffer put index.
	(fhandler_pty_master::ebixlen): New buffer length.
	(fhandler_pty_master::get_echobuf_into_buffer): New.
	(fhandler_pty_master::clear_echobuf): New.
	* fhandler_tty.cc (fhandler_pty_master::get_echobuf_into_buffer): New.
	(fhandler_pty_master::process_slave_output) Read from echobuf 
	initially.
	(fhandler_pty_master::fhandler_pty_master): Initialize new variables.
	(fhandler_pty_master::clear_echobuf): New.
	(fhandler_pty_master::close): Clear echobuf on close.
	* select.cc (peek_pipe): Check for input from echobuf.


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="tty6.patch"
Content-length: 3202

Index: cygwin/fhandler.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler.h,v
retrieving revision 1.151
diff -u -p -r1.151 fhandler.h
--- cygwin/fhandler.h	21 Dec 2002 04:38:12 -0000	1.151
+++ cygwin/fhandler.h	22 Dec 2002 02:40:27 -0000
@@ -937,6 +937,16 @@ class fhandler_pty_master: public fhandl
 
   void set_close_on_exec (int val);
   bool hit_eof ();
+
+  bool get_echobuf_valid () { return ebixget < ebixput; }
+
+ protected:
+  char *ebbuf;		/* used for buffering echo chars */
+  size_t ebixget;
+  size_t ebixput;
+  size_t ebbuflen;
+  int get_echobuf_into_buffer (char *buf, size_t buflen);
+  void clear_echobuf ();
 };
 
 class fhandler_tty_master: public fhandler_pty_master
Index: cygwin/fhandler_tty.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_tty.cc,v
retrieving revision 1.85
diff -u -p -r1.85 fhandler_tty.cc
--- cygwin/fhandler_tty.cc	21 Dec 2002 04:38:12 -0000	1.85
+++ cygwin/fhandler_tty.cc	22 Dec 2002 02:40:30 -0000
@@ -220,6 +220,19 @@ fhandler_pty_master::hit_eof ()
 /* Process tty output requests */
 
 int
+fhandler_pty_master::get_echobuf_into_buffer (char *buf, size_t buflen)
+{
+  size_t copied_chars = 0;
+  while (copied_chars < buflen && ebixget < ebixput)
+      buf[copied_chars++] = ebbuf[ebixget++];
+
+  if (ebixget >= ebixput)
+    ebixget = ebixput = 0;
+
+  return (int)copied_chars;
+}
+
+int
 fhandler_pty_master::process_slave_output (char *buf, size_t len, int pktmode_on)
 {
   size_t rlen;
@@ -261,7 +274,7 @@ fhandler_pty_master::process_slave_outpu
 
       HANDLE handle = get_io_handle ();
 
-      n = 0; // get_readahead_into_buffer (outbuf, len);
+      n = get_echobuf_into_buffer (outbuf, rlen);
       if (!n)
 	{
 	  /* Doing a busy wait like this is quite inefficient, but nothing
@@ -992,7 +1005,11 @@ out:
  fhandler_pty_master
 */
 fhandler_pty_master::fhandler_pty_master (DWORD devtype, int unit)
-  : fhandler_tty_common (devtype, unit)
+  : fhandler_tty_common (devtype, unit),
+    ebbuf (NULL),
+    ebixget (0),
+    ebixput (0),
+    ebbuflen (0)
 {
 }
 
@@ -1047,6 +1064,15 @@ fhandler_tty_common::close ()
   return 0;
 }
 
+void 
+fhandler_pty_master::clear_echobuf ()
+{
+  ebixput = ebixget = ebbuflen = 0;
+  if (ebbuf) 
+    free(ebbuf);
+  ebbuf = NULL;
+}
+
 int
 fhandler_pty_master::close ()
 {
@@ -1071,7 +1097,7 @@ fhandler_pty_master::close ()
 	CloseHandle (get_ttyp ()->to_master);
       get_ttyp ()->init ();
     }
-
+  clear_echobuf ();
   return 0;
 }
 
Index: cygwin/select.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/select.cc,v
retrieving revision 1.83
diff -u -p -r1.83 select.cc
--- cygwin/select.cc	11 Dec 2002 04:00:04 -0000	1.83
+++ cygwin/select.cc	22 Dec 2002 02:40:33 -0000
@@ -431,7 +431,8 @@ peek_pipe (select_record *s, bool from_s
 	{
 	case FH_PTYM:
 	case FH_TTYM:
-	  if (((fhandler_pty_master *) fh)->need_nl)
+	  if (((fhandler_pty_master *) fh)->need_nl
+	      || ((fhandler_pty_master *)fh)->get_echobuf_valid ())
 	    {
 	      gotone = s->read_ready = true;
 	      goto out;

--ikeVEW9yuYc//A+q--
