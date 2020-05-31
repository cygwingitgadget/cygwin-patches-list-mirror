Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-07.nifty.com (conuserg-07.nifty.com [210.131.2.74])
 by sourceware.org (Postfix) with ESMTPS id 7B7EB386EC42
 for <cygwin-patches@cygwin.com>; Sun, 31 May 2020 05:53:57 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 7B7EB386EC42
Received: from localhost.localdomain (v038192.dynamic.ppp.asahi-net.or.jp
 [124.155.38.192]) (authenticated)
 by conuserg-07.nifty.com with ESMTP id 04V5rSi1024218;
 Sun, 31 May 2020 14:53:42 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 04V5rSi1024218
X-Nifty-SrcIP: [124.155.38.192]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH 1/4] Cygwin: pty: Prevent garbage remained in read ahead
 buffer.
Date: Sun, 31 May 2020 14:53:17 +0900
Message-Id: <20200531055320.1419-2-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200531055320.1419-1-takashi.yano@nifty.ne.jp>
References: <20200531055320.1419-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0,
 RCVD_IN_BARRACUDACENTRAL, RCVD_IN_DNSWL_NONE, SPF_HELO_NONE, SPF_PASS,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Sun, 31 May 2020 05:53:59 -0000

- After commit 29431fcb5b14d4c5ac3b3161a076eb1a208349d9, the issue
  reported in https://cygwin.com/pipermail/cygwin/2020-May/245057.html
  occurs. This is caused by the following mechanism. Cygwin less
  called from non-cygwin git is executed under /dev/cons* rather
  than /dev/pty* because parent git process only inherits pseudo
  console handle. Therefore, less sets ICANON flag for /dev/cons*
  rather than original /dev/pty*. When pty is switched to non-cygwin
  git process, line_edit() is used in fhandler_pty_master::write()
  only to set input_available_event and read ahead buffer is supposed
  to be flushed in accept_input(). However, ICANON flag is not set
  for /dev/pty*, so accept_input() is not called unless newline
  is entered. As a result, the input data remains in the read ahead
  buffer. This patch fixes the issue.
---
 winsup/cygwin/fhandler.h      |  3 ++-
 winsup/cygwin/fhandler_tty.cc | 14 ++++++++++++--
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index b2957e4ee..4035c7e56 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -328,7 +328,7 @@ class fhandler_base
 
   virtual bool get_readahead_valid () { return raixget () < ralen (); }
   int puts_readahead (const char *s, size_t len = (size_t) -1);
-  int put_readahead (char value);
+  virtual int put_readahead (char value);
 
   int get_readahead ();
   int peek_readahead (int queryput = 0);
@@ -2381,6 +2381,7 @@ public:
   int process_slave_output (char *buf, size_t len, int pktmode_on);
   void doecho (const void *str, DWORD len);
   int accept_input ();
+  int put_readahead (char value);
   int open (int flags, mode_t mode = 0);
   void open_setup (int flags);
   ssize_t __stdcall write (const void *ptr, size_t len);
diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index b091765b3..d017cde38 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -532,6 +532,14 @@ fhandler_pty_master::doecho (const void *str, DWORD len)
   release_output_mutex ();
 }
 
+int
+fhandler_pty_master::put_readahead (char value)
+{
+  if (to_be_read_from_pcon ())
+    return 1;
+  return fhandler_base::put_readahead (value);
+}
+
 int
 fhandler_pty_master::accept_input ()
 {
@@ -542,12 +550,14 @@ fhandler_pty_master::accept_input ()
 
   bytes_left = eat_readahead (-1);
 
-  if (!bytes_left)
+  if (to_be_read_from_pcon ())
+    ; /* Do nothing */
+  else if (!bytes_left)
     {
       termios_printf ("sending EOF to slave");
       get_ttyp ()->read_retval = 0;
     }
-  else if (!to_be_read_from_pcon ())
+  else
     {
       char *p = rabuf ();
       DWORD rc;
-- 
2.26.2

