Return-Path: <cygwin-patches-return-3082-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 21531 invoked by alias); 23 Oct 2002 05:31:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21520 invoked from network); 23 Oct 2002 05:31:01 -0000
Date: Tue, 22 Oct 2002 22:31:00 -0000
From: Steve O <bub@io.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] fhandler_tty deadlock patch + console + eof
Message-ID: <20021023002947.A537@hagbard.io.com>
References: <20021022003249.A32108@eris.io.com> <Pine.GSO.4.44.0210221404560.8025-100000@slinky.cs.nyu.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.4.44.0210221404560.8025-100000@slinky.cs.nyu.edu>; from pechtcha@cs.nyu.edu on Tue, Oct 22, 2002 at 02:06:17PM -0400
X-SW-Source: 2002-q4/txt/msg00033.txt.bz2


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-length: 1213

Hi,
I noticed that my last patch caused EOF to be ignored in non-console
situations, like rxvt -e sh.  I've attached an updated patch that
should solve this.

On Tue, Oct 22, 2002 at 02:06:17PM -0400, Igor Pechtchanski wrote:
> One more thing I noticed when using this patch is that pasting now seems
> really slow, as if it's sending one character at a time...  Did you turn
> off the buffering somewhere by any chance?

Not that I know of.  In large pastes, say larger than 2k, the buffers
fill up and the app stops being able to write the paste buffer in large
chunks.  This could contribute to a character-at-a-time feel.

While trying to reproduce this I noticed that pasting a selection with
tab characters into bash causes delays due to bash trying to do command
completion.  Also note that bash bypasses termios processing and so 
a paste into bash will result in a series of 1 character writes to the
pipe.  The pipe seems to have a 4k buffer, but depending on the timing 
bash may get to read each character out individually.

Though, I could of broke something.  If you want to persue this, you're
welcome to send me a test case off-list, and I'll see if anything unusual
is happening.

Thanks,
-steve

--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=ChangeLog
Content-length: 2176

2002-10-22  Steve Osborn  <bub@io.com>

	* fhandler.cc (fhandler_base::put_readahead): Limited size of buffer
	to reduce amount of garbage from cat'ing a binary file. 
	* fhandler.h (fhandler_termios::doecho): Returns int, added force.
	(fhandler_termios::accept_input): Changed sense of return.
	(fhandler_termios::line_edit_cnt): Added.
	(fhandler_console::doecho): Returns int, added force.
	(fhandler_pty_master::doecho): Returns int, added force.
	(fhandler_pty_master::get_echobuf_valid): Added.
	(fhandler_pty_master::get_echobuf_into_buffer): Added.	
	(fhandler_pty_master::clear_echobuf): Added.	
	(fhandler_pty_master::ebbuf): Added pointer to echobuf.
	(fhandler_pty_master::ebixget): Added echobuf get index.
	(fhandler_pty_master::ebixput): Added echobuf put index.
	(fhandler_pty_master::ebbuflen): Added echobuf length.
	(fhandler_pty_master::ebguard): Added handle for guard mutex.
	* fhandler_termios.cc (fhandler_termios::line_edit): Wraps 
	line_edit_cnt to provide previous signature.
	(fhandler_termios::line_edit_cnt): Added line_edit function with the
	ability to report number of bytes written.  Handles cases where the
 	echo or readahead buffer is full. 
	(fhandler_termios::line_edit_cnt): Returns true if the last 
        character resulted in an input_done - necessary for console.
	(fhandler_termios::line_edit_cnt): Added accept_input in EOF case.
	* fhandler_tty.cc (fhandler_pty_master::get_echobuf_valid): Added.
	(fhandler_pty_master::doecho): Rewritten to return bytes written to 
	echobuf.  Added force option to expand the buffer as necessary.
	(fhandler_pty_master::get_echobuf_into_buffer): Added.	
	(fhandler_pty_master::clear_echobuf): Added.
	(fhandler_pty_master::accept_input): Sense of return changed to 
	number of bytes not written.  Added support for partial write.
	(fhandler_pty_master::process_slave_output): Prime read with echobuf.
	(fhandler_pty_master::fhandler_pty_master): Initializers for echobuf.
	(fhandler_pty_master::open): Calls clear_echobuf.
	(fhandler_pty_master::close): Calls clear_echobuf.
	(fhandler_pty_master::write): Returns number of bytes written.
	* select.cc (peek_pipe): Check for echobuf valid.

--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="tty3.patch"
Content-length: 11833

Index: cygwin/fhandler.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler.cc,v
retrieving revision 1.138
diff -u -p -r1.138 fhandler.cc
--- cygwin/fhandler.cc	23 Sep 2002 00:31:30 -0000	1.138
+++ cygwin/fhandler.cc	22 Oct 2002 06:15:46 -0000
@@ -58,13 +58,15 @@ fhandler_base::puts_readahead (const cha
   return success;
 }
 
+#define READAHEAD_BUFFER_MAXSIZE 4096
 int
 fhandler_base::put_readahead (char value)
 {
   char *newrabuf;
   if (raixput < rabuflen)
     /* Nothing to do */;
-  else if ((newrabuf = (char *) realloc (rabuf, rabuflen += 32)))
+  else if (rabuflen < READAHEAD_BUFFER_MAXSIZE &&
+	   (newrabuf = (char *) realloc (rabuf, rabuflen += 32)))
     rabuf = newrabuf;
   else
     return 0;
Index: cygwin/fhandler.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler.h,v
retrieving revision 1.143
diff -u -p -r1.143 fhandler.h
--- cygwin/fhandler.h	9 Oct 2002 05:55:40 -0000	1.143
+++ cygwin/fhandler.h	22 Oct 2002 06:15:49 -0000
@@ -682,8 +682,8 @@ class fhandler_termios: public fhandler_
 {
  protected:
   HANDLE output_handle;
-  virtual void doecho (const void *, DWORD) {};
-  virtual int accept_input () {return 1;};
+  virtual int doecho (const void *, DWORD, int force = 1) {return 1;};
+  virtual int accept_input () {return 0;};
  public:
   tty_min *tc;
   fhandler_termios (DWORD dev, int unit = 0) :
@@ -693,6 +693,7 @@ class fhandler_termios: public fhandler_
   }
   HANDLE& get_output_handle () { return output_handle; }
   int line_edit (const char *rptr, int nread, int always_accept = 0);
+  int line_edit_cnt (const char *rptr, int *nread, int always_accept = 0);
   void set_output_handle (HANDLE h) { output_handle = h; }
   void tcinit (tty_min *this_tc, int force = FALSE);
   virtual int is_tty () { return 1; }
@@ -812,7 +813,7 @@ class fhandler_console: public fhandler_
   int open (path_conv *, int flags, mode_t mode = 0);
 
   int write (const void *ptr, size_t len);
-  void doecho (const void *str, DWORD len) { (void) write (str, len); }
+  int doecho (const void *str, DWORD len, int force=1) { return write (str, len); }
   int __stdcall read (void *ptr, size_t len) __attribute__ ((regparm (3)));
   int close ();
 
@@ -907,7 +908,7 @@ class fhandler_pty_master: public fhandl
   fhandler_pty_master (DWORD devtype = FH_PTYM, int unit = -1);
 
   int process_slave_output (char *buf, size_t len, int pktmode_on);
-  void doecho (const void *str, DWORD len);
+  int doecho (const void *str, DWORD len, int force = 1);
   int accept_input ();
   int open (path_conv *, int flags, mode_t mode = 0);
   int write (const void *ptr, size_t len);
@@ -924,6 +925,17 @@ class fhandler_pty_master: public fhandl
 
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
+  HANDLE ebguard;
+  int get_echobuf_into_buffer (char *buf, size_t buflen);
+  void clear_echobuf ();
 };
 
 class fhandler_tty_master: public fhandler_pty_master
Index: cygwin/fhandler_termios.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_termios.cc,v
retrieving revision 1.33
diff -u -p -r1.33 fhandler_termios.cc
--- cygwin/fhandler_termios.cc	23 Sep 2002 00:31:30 -0000	1.33
+++ cygwin/fhandler_termios.cc	22 Oct 2002 06:15:49 -0000
@@ -189,14 +189,26 @@ fhandler_termios::echo_erase (int force)
 int
 fhandler_termios::line_edit (const char *rptr, int nread, int always_accept)
 {
+  int nprocessed=nread;
+  return line_edit_cnt (rptr, &nprocessed, always_accept);
+}
+
+int
+fhandler_termios::line_edit_cnt (const char *rptr, int *nread, 
+				 int always_accept)
+{
   char c;
+  int nprocessed = 0;
   int input_done = 0;
   bool sawsig = FALSE;
+  bool eat_on_failure = FALSE;
   int iscanon = tc->ti.c_lflag & ICANON;
 
-  while (nread-- > 0)
+  for (nprocessed = 0; nprocessed < *nread; nprocessed++)
     {
+      input_done=0;
       c = *rptr++;
+      eat_on_failure = FALSE;
 
       termios_printf ("char %c", c);
 
@@ -308,6 +320,7 @@ fhandler_termios::line_edit (const char 
 	{
 	  termios_printf ("EOF");
 	  input_done = 1;
+	  accept_input();
 	  continue;
 	}
       else if (CCEQ (tc->ti.c_cc[VEOL], c) ||
@@ -321,19 +334,51 @@ fhandler_termios::line_edit (const char 
       if (tc->ti.c_iflag & IUCLC && isupper (c))
 	c = cyg_tolower (c);
 
-      if (tc->ti.c_lflag & ECHO)
-	doecho (&c, 1);
-      put_readahead (c);
-    }
+      if (!put_readahead (c)) 
+	{
+	  input_done = 0;
+	  if (!iscanon || always_accept)
+	    break;
+	  continue; /* drop char if canonical mode */
+	}
 
-  if (!iscanon || always_accept)
-    set_input_done (ralen > 0);
+      if (input_done) 
+	{
+	  if (accept_input ()) 
+	    {
+	      termios_printf ("accept_input full, undoing last char");
+	      eat_readahead (1);
+	      break;
+	    }
+	  else
+	    if (tc->ti.c_lflag & ECHO)
+	      doecho(&c, 1); 
+	}
+      else
+	{
+	  if (tc->ti.c_lflag & ECHO && !doecho (&c, 1, 0)) 
+	    {
+	      eat_readahead (1);
+	      break;
+	    }
+	  eat_on_failure = TRUE;
+	}
+    }
 
   if (sawsig)
     input_done = -1;
-  else if (input_done)
-    (void) accept_input ();
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
+  *nread = nprocessed;
   return input_done;
 }
 
Index: cygwin/fhandler_tty.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_tty.cc,v
retrieving revision 1.76
diff -u -p -r1.76 fhandler_tty.cc
--- cygwin/fhandler_tty.cc	20 Oct 2002 04:15:50 -0000	1.76
+++ cygwin/fhandler_tty.cc	22 Oct 2002 06:15:52 -0000
@@ -131,60 +131,117 @@ fhandler_tty_common::__release_output_mu
 }
 
 /* Process tty input. */
+#define ECHOBUF_MAXSIZE 2048
+int
+fhandler_pty_master::doecho (const void *str, DWORD len, int force)
+{
+  int written;
+  const char *s = (const char *)str; 
+  if (ebguard == NULL)
+    ebguard = CreateMutex (&sec_all, FALSE, NULL);
+  debug_printf ("echo len %d",len);
+  
+  WaitForSingleObject(ebguard,INFINITE);
+  if (ebixput + len > ebbuflen && (ebbuflen < ECHOBUF_MAXSIZE || force)) 
+    {
+      int roundlen = (len + 31) & ~31;
+      char *newbuf = (char *) realloc (ebbuf, ebbuflen + roundlen);
+      if (newbuf) 
+	{
+	  ebbuf = newbuf;
+	  ebbuflen += roundlen;
+	}
+    }
+  for (written=0; written < (int)len  && ebixput < ebbuflen; written++) 
+    ebbuf[ebixput++] = *s++;
+  ReleaseMutex(ebguard);
+  return written;
+}
 
-void
-fhandler_pty_master::doecho (const void *str, DWORD len)
+int
+fhandler_pty_master::get_echobuf_into_buffer (char *buf, size_t buflen)
 {
-  acquire_output_mutex (INFINITE);
-  if (!WriteFile (get_ttyp ()->to_master, str, len, &len, NULL))
-    termios_printf ("Write to %p failed, %E", get_ttyp ()->to_master);
-//  WaitForSingleObject (output_done_event, INFINITE);
-  release_output_mutex ();
+  size_t copied_chars = 0;
+  debug_printf ("getbuf");
+  WaitForSingleObject(ebguard,INFINITE);
+  while (copied_chars < buflen && ebixget < ebixput)
+      buf[copied_chars++] = ebbuf[ebixget++];
+
+  if (ebixget >= ebixput)
+    ebixget = ebixput = 0;
+  termios_printf ("echoed %d chars %d",copied_chars,buflen);
+  ReleaseMutex(ebguard);
+  return (int)copied_chars;
+}
+
+void 
+fhandler_pty_master::clear_echobuf ()
+{
+  ebixput = ebixget = ebbuflen = 0;
+  if (ebbuf) 
+    free(ebbuf);
+  ebbuf = NULL;
+  if (ebguard) 
+    ForceCloseHandle(ebguard);
+  ebguard = NULL;
 }
 
 int
 fhandler_pty_master::accept_input ()
 {
-  DWORD bytes_left, written;
-  DWORD n;
-  DWORD rc;
-  char* p;
-
+  DWORD bytes_left, n, rc;
+  char* p = rabuf;
+  int read_retval = 0;
   rc = WaitForSingleObject (input_mutex, INFINITE);
 
   bytes_left = n = eat_readahead (-1);
-  get_ttyp ()->read_retval = 0;
-  p = rabuf;
+  termios_printf ("about to write %d chars to slave", n);
 
   if (n != 0)
     {
+      DWORD chunk_size=4096;
       while (bytes_left > 0)
 	{
-	  termios_printf ("about to write %d chars to slave", bytes_left);
-	  rc = WriteFile (get_output_handle (), p, bytes_left, &written, NULL);
+	  DWORD written, towrite = min (bytes_left,chunk_size);
+	  rc = WriteFile (get_output_handle (), p, towrite, &written, NULL);
 	  if (!rc)
 	    {
 	      debug_printf ("error writing to pipe %E");
 	      break;
 	    }
-	  get_ttyp ()->read_retval += written;
+	  read_retval += written;
 	  p += written;
 	  bytes_left -= written;
-	  if (bytes_left > 0)
+	  if ( written < towrite ) 
 	    {
-	      debug_printf ("to_slave pipe is full");
-	      SetEvent (input_available_event);
-	      ReleaseMutex (input_mutex);
-	      Sleep (10);
-	      rc = WaitForSingleObject (input_mutex, INFINITE);
+	      if (chunk_size < 2)
+		break;
+	      else /* WriteFile may succeed with smaller towrite */
+		while( (chunk_size >>=1) && chunk_size > bytes_left)
+		  ;
 	    }
 	}
+      if (bytes_left > 0)
+	{
+	  /* push the left overs back into the readahead buffer */
+	  char *s=rabuf;
+	  int copylen = bytes_left;
+	  if (n == bytes_left) 
+	    read_retval = 1; /* otherwise looks like EOF */
+	  else
+	    while(copylen-- > 0) 
+	      *s++=*p++;
+	  
+	  raixput = ralen = bytes_left;
+	  debug_printf ("to_slave pipe is full, %d bytes left",bytes_left);
+	}
     }
   else
     termios_printf ("sending EOF to slave");
   SetEvent (input_available_event);
   ReleaseMutex (input_mutex);
-  return get_ttyp ()->read_retval;
+  get_ttyp ()->read_retval = read_retval;
+  return bytes_left;
 }
 
 static DWORD WINAPI
@@ -258,7 +315,7 @@ fhandler_pty_master::process_slave_outpu
 
       HANDLE handle = get_io_handle ();
 
-      n = 0; // get_readahead_into_buffer (outbuf, len);
+      n = get_echobuf_into_buffer (outbuf, rlen);
       if (!n)
 	{
 	  /* Doing a busy wait like this is quite inefficient, but nothing
@@ -975,7 +1032,12 @@ out:
  fhandler_pty_master
 */
 fhandler_pty_master::fhandler_pty_master (DWORD devtype, int unit)
-  : fhandler_tty_common (devtype, unit)
+  : fhandler_tty_common (devtype, unit),
+    ebbuf (NULL),
+    ebixget (0),
+    ebixput (0),
+    ebbuflen (0),
+    ebguard (NULL)
 {
 }
 
@@ -990,6 +1052,7 @@ fhandler_pty_master::open (path_conv *, 
   inuse = get_ttyp ()->create_inuse (TTY_MASTER_ALIVE);
   set_flags ((flags & ~O_TEXT) | O_BINARY);
   set_open_status ();
+  clear_echobuf();
 
   termios_printf ("opened pty master tty%d<%p>", ttynum, this);
   return 1;
@@ -1054,15 +1117,16 @@ fhandler_pty_master::close ()
 	CloseHandle (get_ttyp ()->to_master);
       get_ttyp ()->init ();
     }
-
+  clear_echobuf();
   return 0;
 }
 
 int
 fhandler_pty_master::write (const void *ptr, size_t len)
 {
-  (void) line_edit ((char *) ptr, len);
-  return len;
+  int wrote = len;
+  (void) line_edit_cnt ((char *) ptr, &wrote);
+  return wrote;
 }
 
 int __stdcall
Index: cygwin/select.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/select.cc,v
retrieving revision 1.81
diff -u -p -r1.81 select.cc
--- cygwin/select.cc	30 Sep 2002 15:17:44 -0000	1.81
+++ cygwin/select.cc	22 Oct 2002 06:15:55 -0000
@@ -431,7 +431,8 @@ peek_pipe (select_record *s, bool from_s
 	{
 	case FH_PTYM:
 	case FH_TTYM:
-	  if (((fhandler_pty_master *)fh)->need_nl)
+	  if (((fhandler_pty_master *)fh)->need_nl 
+	      || ((fhandler_pty_master *)fh)->get_echobuf_valid ())
 	    {
 	      gotone = s->read_ready = true;
 	      goto out;

--G4iJoqBmSsgzjUCe--
