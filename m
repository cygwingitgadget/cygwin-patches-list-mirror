Return-Path: <SRS0=MpmZ=CZ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from dmta0013.nifty.com (mta-snd00010.nifty.com [106.153.226.42])
	by sourceware.org (Postfix) with ESMTPS id B7417385697B
	for <cygwin-patches@cygwin.com>; Fri,  7 Jul 2023 03:35:38 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B7417385697B
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain by dmta0013.nifty.com with ESMTP
          id <20230707033537191.WELV.104052.localhost.localdomain@nifty.com>;
          Fri, 7 Jul 2023 12:35:37 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 2/2] Cygwin: fstat(): Fix st_rdev returned by fstat() for /dev/tty.
Date: Fri,  7 Jul 2023 12:34:58 +0900
Message-Id: <20230707033458.1034-3-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230707033458.1034-1-takashi.yano@nifty.ne.jp>
References: <20230707033458.1034-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

While st_rdev returned by fstat() for /dev/tty should be FH_TTY,
the current cygwin1.dll returns FH_PTYS+minor or FH_CONS+minor.
Similarly, fstat() does not return correct value for /dev/console,
/dev/conout, /dev/conin or /dev/ptmx.

This patch fixes the issue by:
1) Introduce dev_refered_via in fhandler_termios.
2) Add new argument, which has dev_t value refered by open(),
  for constructors of fhandler_pty_slave and fhandler_pty_master to
  set the value of dev_refered_via.
3) Set st_rdev using dev_refered_via in fhandler_termios::fstat()
  if it is available.

Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/dtable.cc                 |  5 +++--
 winsup/cygwin/fhandler/console.cc       |  8 ++++++--
 winsup/cygwin/fhandler/pty.cc           |  8 +++++---
 winsup/cygwin/fhandler/termios.cc       |  9 +++++++++
 winsup/cygwin/local_includes/fhandler.h | 12 ++++++++++--
 5 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/winsup/cygwin/dtable.cc b/winsup/cygwin/dtable.cc
index 2aae2fd65..156445119 100644
--- a/winsup/cygwin/dtable.cc
+++ b/winsup/cygwin/dtable.cc
@@ -509,7 +509,7 @@ fh_alloc (path_conv& pc)
 	  break;
 	case FH_PTMX:
 	  if (pc.isopen ())
-	    fh = cnew (fhandler_pty_master, -1);
+	    fh = cnew (fhandler_pty_master, -1, (dev_t) pc.dev);
 	  else
 	    fhraw = cnew_no_ctor (fhandler_pty_master, -1);
 	  break;
@@ -618,7 +618,8 @@ fh_alloc (path_conv& pc)
 	      if (iscons_dev (myself->ctty))
 		fh = cnew (fhandler_console, pc.dev);
 	      else
-		fh = cnew (fhandler_pty_slave, myself->ctty);
+		fh = cnew (fhandler_pty_slave,
+			   minor (myself->ctty), (dev_t) pc.dev);
 	      if (fh->dev () != FH_NADA)
 		fh->set_name ("/dev/tty");
 	    }
diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index 6aa3b50bf..f4e3fad92 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -2110,6 +2110,7 @@ fhandler_console::fhandler_console (fh_devices devunit) :
   fhandler_termios (), input_ready (false), thread_sync_event (NULL),
   input_mutex (NULL), output_mutex (NULL), unit (MAX_CONS_DEV)
 {
+  dev_refered_via = (dev_t) devunit;
   if (devunit > 0)
     dev ().parse (devunit);
   setup ();
@@ -4558,9 +4559,12 @@ fhandler_console::fstat (struct stat *st)
      the console instance. Due to this, get_ttyp() returns NULL here.
      So, calling set_unit() is necessary to access getsid(). */
   if (!get_ttyp ())
-    set_unit ();
+    {
+      dev_refered_via = get_device ();
+      set_unit ();
+    }
 
-  fhandler_base::fstat (st);
+  fhandler_termios::fstat (st);
   st->st_mode = S_IFCHR | S_IRUSR | S_IWUSR;
   pinfo p (get_ttyp ()->getsid ());
   if (p)
diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index 1f2b634a0..67289369d 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -765,10 +765,11 @@ out:
 
 /* pty slave stuff */
 
-fhandler_pty_slave::fhandler_pty_slave (int unit)
+fhandler_pty_slave::fhandler_pty_slave (int unit, dev_t via)
   : fhandler_pty_common (), inuse (NULL), output_handle_nat (NULL),
   io_handle_nat (NULL), slave_reading (NULL), num_reader (0)
 {
+  dev_refered_via = via;
   if (unit >= 0)
     dev ().parse (DEV_PTYS_MAJOR, unit);
 }
@@ -1769,7 +1770,7 @@ out:
 int
 fhandler_pty_slave::fstat (struct stat *st)
 {
-  fhandler_base::fstat (st);
+  fhandler_termios::fstat (st);
 
   bool to_close = false;
   if (!input_available_event)
@@ -1974,13 +1975,14 @@ errout:
 /*******************************************************
  fhandler_pty_master
 */
-fhandler_pty_master::fhandler_pty_master (int unit)
+fhandler_pty_master::fhandler_pty_master (int unit, dev_t via)
   : fhandler_pty_common (), pktmode (0), master_ctl (NULL),
     master_thread (NULL), from_master_nat (NULL), to_master_nat (NULL),
     from_slave_nat (NULL), to_slave_nat (NULL), echo_r (NULL), echo_w (NULL),
     dwProcessId (0), to_master (NULL), from_master (NULL),
     master_fwd_thread (NULL)
 {
+  dev_refered_via = via;
   if (unit >= 0)
     dev ().parse (DEV_PTYM_MAJOR, unit);
   set_name ("/dev/ptmx");
diff --git a/winsup/cygwin/fhandler/termios.cc b/winsup/cygwin/fhandler/termios.cc
index 1a5dfdd1b..72a2e0e1b 100644
--- a/winsup/cygwin/fhandler/termios.cc
+++ b/winsup/cygwin/fhandler/termios.cc
@@ -691,6 +691,15 @@ fhandler_termios::tcgetsid ()
   return -1;
 }
 
+int
+fhandler_termios::fstat (struct stat *buf)
+{
+  fhandler_base::fstat (buf);
+  if (dev_refered_via > 0)
+    buf->st_rdev = dev_refered_via;
+  return 0;
+}
+
 static bool
 is_console_app (const WCHAR *filename)
 {
diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/local_includes/fhandler.h
index f82f565cf..da7d40864 100644
--- a/winsup/cygwin/local_includes/fhandler.h
+++ b/winsup/cygwin/local_includes/fhandler.h
@@ -1936,6 +1936,7 @@ class fhandler_termios: public fhandler_base
   virtual void acquire_input_mutex_if_necessary (DWORD ms) {};
   virtual void release_input_mutex_if_necessary (void) {};
   virtual void discard_input () {};
+  dev_t dev_refered_via;
 
   /* Result status of processing keys in process_sigs(). */
   enum process_sig_state {
@@ -1975,6 +1976,7 @@ class fhandler_termios: public fhandler_base
   void echo_erase (int force = 0);
   virtual off_t lseek (off_t, int);
   pid_t tcgetsid ();
+  virtual int fstat (struct stat *buf);
 
   fhandler_termios (void *) {}
 
@@ -2297,7 +2299,9 @@ private:
   void copy_from (fhandler_base *x)
   {
     pc.free_strings ();
+    dev_t via = this->dev_refered_via; /* Do not copy dev_refered_via */
     *this = *reinterpret_cast<fhandler_console *> (x);
+    this->dev_refered_via = via;
     _copy_from_reset_helper ();
   }
 
@@ -2424,7 +2428,7 @@ class fhandler_pty_slave: public fhandler_pty_common
   typedef ptys_handle_set_t handle_set_t;
 
   /* Constructor */
-  fhandler_pty_slave (int);
+  fhandler_pty_slave (int, dev_t via = 0);
 
   void set_output_handle_nat (HANDLE h) { output_handle_nat = h; }
   HANDLE& get_output_handle_nat () { return output_handle_nat; }
@@ -2462,7 +2466,9 @@ class fhandler_pty_slave: public fhandler_pty_common
   void copy_from (fhandler_base *x)
   {
     pc.free_strings ();
+    dev_t via = this->dev_refered_via; /* Do not copy dev_refered_via */
     *this = *reinterpret_cast<fhandler_pty_slave *> (x);
+    this->dev_refered_via = via;
     _copy_from_reset_helper ();
   }
 
@@ -2537,7 +2543,7 @@ private:
 public:
   HANDLE get_echo_handle () const { return echo_r; }
   /* Constructor */
-  fhandler_pty_master (int);
+  fhandler_pty_master (int, dev_t via = 0);
 
   static DWORD pty_master_thread (const master_thread_param_t *p);
   static DWORD pty_master_fwd_thread (const master_fwd_thread_param_t *p);
@@ -2572,7 +2578,9 @@ public:
   void copy_from (fhandler_base *x)
   {
     pc.free_strings ();
+    dev_t via = this->dev_refered_via; /* Do not copy dev_refered_via */
     *this = *reinterpret_cast<fhandler_pty_master *> (x);
+    this->dev_refered_via = via;
     _copy_from_reset_helper ();
   }
 
-- 
2.39.0

