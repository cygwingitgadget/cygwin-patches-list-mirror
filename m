Return-Path: <cygwin-patches-return-10001-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 83756 invoked by alias); 25 Jan 2020 09:46:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 83747 invoked by uid 89); 25 Jan 2020 09:46:08 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-14.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=crlf, H*Ad:D*jp, Share
X-HELO: conuserg-01.nifty.com
Received: from conuserg-01.nifty.com (HELO conuserg-01.nifty.com) (210.131.2.68) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 25 Jan 2020 09:46:05 +0000
Received: from localhost.localdomain (ntsitm196171.sitm.nt.ngn.ppp.infoweb.ne.jp [125.0.207.171]) (authenticated)	by conuserg-01.nifty.com with ESMTP id 00P9jqVe007543;	Sat, 25 Jan 2020 18:45:57 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-01.nifty.com 00P9jqVe007543
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1579945557;	bh=mp6qW8CEyBWX12/QCN57zfpJmFf4lnCV+WIXCvbs8Qs=;	h=From:To:Cc:Subject:Date:From;	b=PVG68t/+P3Oqfhc0ojAj1IwRg55rlAcTOISePnjNutuv6AFuFdITF+JrCUU37CIqR	 UvifN0hYJ2JFca4v56xXPXjgp1wsE0XLC817drgfDMnff9p85sBALskyR0LmqO1Q5a	 /CrN35I/hQjXQTmpuZiEaJynnkix0qVG6XgXSY+mWaBTINrQF40AS9h3BTo/TVkYiA	 4YYMe65s1Vb+gMxpLehuAmc7n1AV2YD7gRHSqB14reqDSePKI4aR3ts/yADDtVPX+h	 NG6337HgGljIFmRPupmeVI6bef7zm5/ZxgF1JH1uJepw8hacSz/SVLRjoy3zX9n3Wt	 CJXZ7W3IkPfdg==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: console: Share readahead buffer within the same process.
Date: Sat, 25 Jan 2020 09:46:00 -0000
Message-Id: <20200125094548.958-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00107.txt

- The cause of the problem reported in
  https://www.cygwin.com/ml/cygwin/2020-01/msg00220.html is that the
  chars input before dup() cannot be read from the new file descriptor.
  This is because the readahead buffer (rabuf) in the console is newly
  created by dup(), and does not inherit from the parent. This patch
  fixes the issue.
---
 winsup/cygwin/fhandler.cc         | 58 ++++++++++++++++---------------
 winsup/cygwin/fhandler.h          | 24 ++++++++-----
 winsup/cygwin/fhandler_console.cc | 16 ++++++++-
 winsup/cygwin/fhandler_termios.cc | 35 ++++++++++---------
 winsup/cygwin/fhandler_tty.cc     |  2 +-
 5 files changed, 80 insertions(+), 55 deletions(-)

diff --git a/winsup/cygwin/fhandler.cc b/winsup/cygwin/fhandler.cc
index aeee8fe4d..ad4a7e61c 100644
--- a/winsup/cygwin/fhandler.cc
+++ b/winsup/cygwin/fhandler.cc
@@ -44,11 +44,12 @@ void
 fhandler_base::reset (const fhandler_base *from)
 {
   pc << from->pc;
-  rabuf = NULL;
-  ralen = 0;
-  raixget = 0;
-  raixput = 0;
-  rabuflen = 0;
+  ra.rabuf = NULL;
+  ra.ralen = 0;
+  ra.raixget = 0;
+  ra.raixput = 0;
+  ra.rabuflen = 0;
+  set_rabuf ();
   _refcnt = 0;
 }
 
@@ -66,15 +67,15 @@ int
 fhandler_base::put_readahead (char value)
 {
   char *newrabuf;
-  if (raixput < rabuflen)
+  if (raptr->raixput < raptr->rabuflen)
     /* Nothing to do */;
-  else if ((newrabuf = (char *) realloc (rabuf, rabuflen += 32)))
-    rabuf = newrabuf;
+  else if ((newrabuf = (char *) realloc (raptr->rabuf, raptr->rabuflen += 32)))
+    raptr->rabuf = newrabuf;
   else
     return 0;
 
-  rabuf[raixput++] = value;
-  ralen++;
+  raptr->rabuf[raptr->raixput++] = value;
+  raptr->ralen++;
   return 1;
 }
 
@@ -82,11 +83,11 @@ int
 fhandler_base::get_readahead ()
 {
   int chret = -1;
-  if (raixget < ralen)
-    chret = ((unsigned char) rabuf[raixget++]) & 0xff;
+  if (raptr->raixget < raptr->ralen)
+    chret = ((unsigned char) raptr->rabuf[raptr->raixget++]) & 0xff;
   /* FIXME - not thread safe */
-  if (raixget >= ralen)
-    raixget = raixput = ralen = 0;
+  if (raptr->raixget >= raptr->ralen)
+    raptr->raixget = raptr->raixput = raptr->ralen = 0;
   return chret;
 }
 
@@ -94,10 +95,10 @@ int
 fhandler_base::peek_readahead (int queryput)
 {
   int chret = -1;
-  if (!queryput && raixget < ralen)
-    chret = ((unsigned char) rabuf[raixget]) & 0xff;
-  else if (queryput && raixput > 0)
-    chret = ((unsigned char) rabuf[raixput - 1]) & 0xff;
+  if (!queryput && raptr->raixget < raptr->ralen)
+    chret = ((unsigned char) raptr->rabuf[raptr->raixget]) & 0xff;
+  else if (queryput && raptr->raixput > 0)
+    chret = ((unsigned char) raptr->rabuf[raptr->raixput - 1]) & 0xff;
   return chret;
 }
 
@@ -105,7 +106,7 @@ void
 fhandler_base::set_readahead_valid (int val, int ch)
 {
   if (!val)
-    ralen = raixget = raixput = 0;
+    raptr->ralen = raptr->raixget = raptr->raixput = 0;
   if (ch != -1)
     put_readahead (ch);
 }
@@ -1092,7 +1093,7 @@ fhandler_base::lseek (off_t offset, int whence)
   if (whence != SEEK_CUR || offset != 0)
     {
       if (whence == SEEK_CUR)
-	offset -= ralen - raixget;
+	offset -= raptr->ralen - raptr->raixget;
       set_readahead_valid (0);
     }
 
@@ -1142,7 +1143,7 @@ fhandler_base::lseek (off_t offset, int whence)
      readahead that we have to take into account when calculating
      the actual position for the application.  */
   if (whence == SEEK_CUR)
-    res -= ralen - raixget;
+    res -= raptr->ralen - raptr->raixget;
 
   return res;
 }
@@ -1565,23 +1566,24 @@ fhandler_base::fhandler_base () :
   ino (0),
   _refcnt (0),
   openflags (0),
-  rabuf (NULL),
-  ralen (0),
-  raixget (0),
-  raixput (0),
-  rabuflen (0),
   unique_id (0),
   archetype (NULL),
   usecount (0)
 {
+  ra.rabuf = NULL;
+  ra.ralen = 0;
+  ra.raixget = 0;
+  ra.raixput = 0;
+  ra.rabuflen = 0;
+  set_rabuf ();
   isclosed (false);
 }
 
 /* Normal I/O destructor */
 fhandler_base::~fhandler_base ()
 {
-  if (rabuf)
-    free (rabuf);
+  if (ra.rabuf)
+    free (ra.rabuf);
 }
 
 /**********************************************************************/
diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index c0d56b4da..35190c0fe 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -202,16 +202,22 @@ class fhandler_base
 
   ino_t ino;	/* file ID or hashed filename, depends on FS. */
   LONG _refcnt;
+ public:
+  struct rabuf_t
+  {
+    char *rabuf;		/* used for crlf conversion in text files */
+    size_t ralen;
+    size_t raixget;
+    size_t raixput;
+    size_t rabuflen;
+  };
 
  protected:
   /* File open flags from open () and fcntl () calls */
   int openflags;
 
-  char *rabuf;		/* used for crlf conversion in text files */
-  size_t ralen;
-  size_t raixget;
-  size_t raixput;
-  size_t rabuflen;
+  struct rabuf_t ra;
+  struct rabuf_t *raptr;
 
   /* Used for advisory file locking.  See flock.cc.  */
   int64_t unique_id;
@@ -315,7 +321,8 @@ class fhandler_base
     ReleaseSemaphore (read_state, n, NULL);
   }
 
-  bool get_readahead_valid () { return raixget < ralen; }
+  virtual void set_rabuf (void) { raptr = &ra;};
+  bool get_readahead_valid () { return raptr->raixget < raptr->ralen; }
   int puts_readahead (const char *s, size_t len = (size_t) -1);
   int put_readahead (char value);
 
@@ -464,8 +471,8 @@ public:
   virtual bg_check_types bg_check (int, bool = false) {return bg_ok;}
   virtual void clear_readahead ()
   {
-    raixput = raixget = ralen = rabuflen = 0;
-    rabuf = NULL;
+    raptr->raixput = raptr->raixget = raptr->ralen = raptr->rabuflen = 0;
+    raptr->rabuf = NULL;
   }
   void operator delete (void *p) {cfree (p);}
   virtual void set_eof () {}
@@ -1968,6 +1975,7 @@ private:
   static bool create_invisible_console (HWINSTA);
   static bool create_invisible_console_workaround ();
   static console_state *open_shared_console (HWND, HANDLE&, bool&);
+  void set_rabuf (void);
 
  public:
   static pid_t tc_getpgid ()
diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index b3f2cb65a..9bb85e3b1 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -56,6 +56,11 @@ bool NO_COPY fhandler_console::invisible_console;
 static DWORD orig_conin_mode = (DWORD) -1;
 static DWORD orig_conout_mode = (DWORD) -1;
 
+/* con_ra is shared in the same process. */
+/* The console can be exist only one in a process,
+   therefore, static is suitable. */
+static struct fhandler_base::rabuf_t con_ra;
+
 static void
 beep ()
 {
@@ -214,6 +219,12 @@ fhandler_console::setup ()
     }
 }
 
+void
+fhandler_console::set_rabuf (void)
+{
+  raptr = &con_ra;
+}
+
 /* Return the tty structure associated with a given tty number.  If the
    tty number is < 0, just return a dummy record. */
 tty_min *
@@ -454,7 +465,7 @@ fhandler_console::read (void *pv, size_t& buflen)
   copied_chars +=
     get_readahead_into_buffer (buf + copied_chars, buflen);
 
-  if (!ralen)
+  if (!con_ra.ralen)
     input_ready = false;
   release_input_mutex ();
 
@@ -1103,6 +1114,9 @@ fhandler_console::close ()
   CloseHandle (get_handle ());
   CloseHandle (get_output_handle ());
 
+  if (con_ra.rabuf)
+    free (con_ra.rabuf);
+
   /* If already attached to pseudo console, don't call free_console () */
   cygheap_fdenum cfd (false);
   while (cfd.next () >= 0)
diff --git a/winsup/cygwin/fhandler_termios.cc b/winsup/cygwin/fhandler_termios.cc
index 5b0ba5603..00d2b0482 100644
--- a/winsup/cygwin/fhandler_termios.cc
+++ b/winsup/cygwin/fhandler_termios.cc
@@ -265,25 +265,26 @@ fhandler_termios::bg_check (int sig, bool dontsignal)
 int
 fhandler_termios::eat_readahead (int n)
 {
-  int oralen = ralen;
+  int oralen = raptr->ralen;
   if (n < 0)
-    n = ralen;
-  if (n > 0 && ralen > 0)
+    n = raptr->ralen;
+  if (n > 0 && raptr->ralen > 0)
     {
-      if ((int) (ralen -= n) < 0)
-	ralen = 0;
+      if ((int) (raptr->ralen -= n) < 0)
+	raptr->ralen = 0;
       /* If IUTF8 is set, the terminal is in UTF-8 mode.  If so, we erase
 	 a complete UTF-8 multibyte sequence on VERASE/VWERASE.  Otherwise,
 	 if we only erase a single byte, invalid unicode chars are left in
 	 the input. */
       if (tc ()->ti.c_iflag & IUTF8)
-	while (ralen > 0 && ((unsigned char) rabuf[ralen] & 0xc0) == 0x80)
-	  --ralen;
-
-      if (raixget >= ralen)
-	raixget = raixput = ralen = 0;
-      else if (raixput > ralen)
-	raixput = ralen;
+	while (raptr->ralen > 0 &&
+	       ((unsigned char) raptr->rabuf[raptr->ralen] & 0xc0) == 0x80)
+	  --raptr->ralen;
+
+      if (raptr->raixget >= raptr->ralen)
+	raptr->raixget = raptr->raixput = raptr->ralen = 0;
+      else if (raptr->raixput > raptr->ralen)
+	raptr->raixput = raptr->ralen;
     }
 
   return oralen;
@@ -411,7 +412,7 @@ fhandler_termios::line_edit (const char *rptr, size_t nread, termios& ti,
 	  if (ti.c_lflag & ECHO)
 	    {
 	      doecho ("\n\r", 2);
-	      doecho (rabuf, ralen);
+	      doecho (raptr->rabuf, raptr->ralen);
 	    }
 	  continue;
 	}
@@ -438,13 +439,13 @@ fhandler_termios::line_edit (const char *rptr, size_t nread, termios& ti,
 	doecho (&c, 1);
       /* Write in chunks of 32 bytes to reduce the number of WriteFile calls
       	in non-canonical mode. */
-      if ((!iscanon && ralen >= 32) || input_done)
+      if ((!iscanon && raptr->ralen >= 32) || input_done)
 	{
 	  int status = accept_input ();
 	  if (status != 1)
 	    {
 	      ret = status ? line_edit_error : line_edit_pipe_full;
-	      nread += ralen;
+	      nread += raptr->ralen;
 	      break;
 	    }
 	  ret = line_edit_input_done;
@@ -453,14 +454,14 @@ fhandler_termios::line_edit (const char *rptr, size_t nread, termios& ti,
     }
 
   /* If we didn't write all bytes in non-canonical mode, write them now. */
-  if (!iscanon && ralen > 0
+  if (!iscanon && raptr->ralen > 0
       && (ret == line_edit_ok || ret == line_edit_input_done))
     {
       int status = accept_input ();
       if (status != 1)
 	{
 	  ret = status ? line_edit_error : line_edit_pipe_full;
-	  nread += ralen;
+	  nread += raptr->ralen;
 	}
       else
 	ret = line_edit_input_done;
diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 4977a8bd5..71a1f42ba 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -525,7 +525,7 @@ fhandler_pty_master::accept_input ()
     }
   else
     {
-      char *p = rabuf;
+      char *p = raptr->rabuf;
       DWORD rc;
       DWORD written = 0;
 
-- 
2.21.0
