Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
 by sourceware.org (Postfix) with ESMTPS id 3F31C3857025
 for <cygwin-patches@cygwin.com>; Tue, 30 Jun 2020 11:13:27 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 3F31C3857025
Received: from localhost.localdomain (v038192.dynamic.ppp.asahi-net.or.jp
 [124.155.38.192]) (authenticated)
 by conuserg-12.nifty.com with ESMTP id 05UBCvVp015554;
 Tue, 30 Jun 2020 20:13:01 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 05UBCvVp015554
X-Nifty-SrcIP: [124.155.38.192]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty,
 termios: Unify thoughts of read ahead beffer handling.
Date: Tue, 30 Jun 2020 20:12:50 +0900
Message-Id: <20200630111250.2724-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Tue, 30 Jun 2020 11:13:29 -0000

- Return value of eat_readahead() is redefined. The return values
  of fhandler_termios::eat_readahead() and fhandler_pty_slave::
  eat_readahead() were little bit different. This patch unifies
  them to number of bytes eaten by eat_readahead().
- Considerration for raixget() is added to fhandler_pty_master::
  accept_input() code.
- Transfering contents of read ahead buffer in
  fhandler_pty_master::transfer_input_to_pcon() is removed since
  it is not necessary.
- fhandler_pty_slave::eat_readahead() ckecks EOL only when ICANON
  is set.
- Guard for _POSIX_VDISABLE is added in checking EOL.
---
 winsup/cygwin/fhandler_termios.cc | 20 ++++++++---------
 winsup/cygwin/fhandler_tty.cc     | 37 +++++++++++++------------------
 2 files changed, 26 insertions(+), 31 deletions(-)

diff --git a/winsup/cygwin/fhandler_termios.cc b/winsup/cygwin/fhandler_termios.cc
index b03478b87..ac1d5bd5c 100644
--- a/winsup/cygwin/fhandler_termios.cc
+++ b/winsup/cygwin/fhandler_termios.cc
@@ -268,25 +268,25 @@ fhandler_termios::eat_readahead (int n)
 {
   int oralen = ralen ();
   if (n < 0)
-    n = ralen ();
-  if (n > 0 && ralen () > 0)
+    n = ralen () - raixget ();
+  if (n > 0 && ralen () > raixget ())
     {
-      if ((int) (ralen () -= n) < 0)
-	ralen () = 0;
+      if ((int) (ralen () -= n) < (int) raixget ())
+	ralen () = raixget ();
       /* If IUTF8 is set, the terminal is in UTF-8 mode.  If so, we erase
 	 a complete UTF-8 multibyte sequence on VERASE/VWERASE.  Otherwise,
 	 if we only erase a single byte, invalid unicode chars are left in
 	 the input. */
       if (tc ()->ti.c_iflag & IUTF8)
-	while (ralen () > 0 &&
+	while (ralen () > raixget () &&
 	       ((unsigned char) rabuf ()[ralen ()] & 0xc0) == 0x80)
 	  --ralen ();
-
-      if (raixget () >= ralen ())
-	raixget () = raixput () = ralen () = 0;
-      else if (raixput () > ralen ())
-	raixput () = ralen ();
     }
+  oralen = oralen - ralen ();
+  if (raixget () >= ralen ())
+    raixget () = raixput () = ralen () = 0;
+  else if (raixput () > ralen ())
+    raixput () = ralen ();
 
   return oralen;
 }
diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 0f95cec2e..a61167116 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -548,6 +548,7 @@ fhandler_pty_master::accept_input ()
 
   WaitForSingleObject (input_mutex, INFINITE);
 
+  char *p = rabuf () + raixget ();
   bytes_left = eat_readahead (-1);
 
   if (to_be_read_from_pcon ())
@@ -559,7 +560,6 @@ fhandler_pty_master::accept_input ()
     }
   else
     {
-      char *p = rabuf ();
       DWORD rc;
       DWORD written = 0;
 
@@ -1171,10 +1171,10 @@ fhandler_pty_slave::update_pcon_input_state (bool need_lock)
 	  '\n',
 	  '\r'
 	};
-	if (is_line_input () && memchr (eols, c, sizeof (eols)))
+	if (is_line_input () && c && memchr (eols, c, sizeof (eols)))
 	  saw_accept = true;
-	if ((get_ttyp ()->ti.c_lflag & ISIG) &&
-	    memchr (sigs, c, sizeof (sigs)))
+	if ((get_ttyp ()->ti.c_lflag & ISIG)
+	    && c && memchr (sigs, c, sizeof (sigs)))
 	  saw_accept = true;
       }
   get_ttyp ()->pcon_in_empty = pipe_empty && !(ralen () > raixget ());
@@ -1189,7 +1189,7 @@ fhandler_pty_slave::update_pcon_input_state (bool need_lock)
 int
 fhandler_pty_slave::eat_readahead (int n)
 {
-  int oralen = ralen () - raixget ();
+  int oralen = ralen ();
   if (n < 0)
     n = ralen () - raixget ();
   if (n > 0 && ralen () > raixget ())
@@ -1202,7 +1202,8 @@ fhandler_pty_slave::eat_readahead (int n)
       };
       while (n > 0 && ralen () > raixget ())
 	{
-	  if (memchr (eols, rabuf ()[ralen ()-1], sizeof (eols)))
+	  if (is_line_input () && rabuf ()[ralen ()-1]
+	      && memchr (eols, rabuf ()[ralen ()-1], sizeof (eols)))
 	    break;
 	  -- n;
 	  -- ralen ();
@@ -1213,15 +1214,15 @@ fhandler_pty_slave::eat_readahead (int n)
 	 if we only erase a single byte, invalid unicode chars are left in
 	 the input. */
       if (get_ttyp ()->ti.c_iflag & IUTF8)
-	while (ralen () > 0 &&
+	while (ralen () > raixget () &&
 	       ((unsigned char) rabuf ()[ralen ()] & 0xc0) == 0x80)
 	  --ralen ();
-
-      if (raixget () >= ralen ())
-	raixget () = raixput () = ralen () = 0;
-      else if (raixput () > ralen ())
-	raixput () = ralen ();
     }
+  oralen = oralen - ralen ();
+  if (raixget () >= ralen ())
+    raixget () = raixput () = ralen () = 0;
+  else if (raixput () > ralen ())
+    raixput () = ralen ();
 
   return oralen;
 }
@@ -1245,7 +1246,7 @@ fhandler_pty_slave::get_readahead_into_buffer (char *buf, size_t buflen)
 	};
 	buf[copied_chars++] = (unsigned char)(ch & 0xff);
 	buflen--;
-	if (is_line_input () && memchr (eols, ch & 0xff, sizeof (eols)))
+	if (is_line_input () && ch && memchr (eols, ch & 0xff, sizeof (eols)))
 	  break;
       }
 
@@ -1264,7 +1265,7 @@ fhandler_pty_slave::get_readahead_valid (void)
 	'\n'
       };
       for (size_t i=raixget (); i<ralen (); i++)
-	if (memchr (eols, rabuf ()[i], sizeof (eols)))
+	if (rabuf ()[i] && memchr (eols, rabuf ()[i], sizeof (eols)))
 	  return true;
       return false;
     }
@@ -2554,7 +2555,7 @@ fhandler_pty_master::write (const void *ptr, size_t len)
       };
       if (tc ()->ti.c_lflag & ISIG)
 	for (size_t i=0; i<sizeof (sigs); i++)
-	  if (memchr (buf, sigs[i], nlen))
+	  if (sigs[i] && memchr (buf, sigs[i], nlen))
 	    {
 	      eat_readahead (-1);
 	      SetEvent (input_available_event);
@@ -3224,12 +3225,6 @@ fhandler_pty_master::transfer_input_to_pcon (void)
       if (WriteFile (to_slave, buf, n, &n, 0))
 	transfered += n;
     }
-  DWORD bytes_left = eat_readahead (-1);
-  if (bytes_left)
-    {
-      if (WriteFile (to_slave, rabuf (), bytes_left, &n, NULL))
-	transfered += n;
-    }
   if (transfered)
     get_ttyp ()->pcon_in_empty = false;
   ReleaseMutex (input_mutex);
-- 
2.27.0

