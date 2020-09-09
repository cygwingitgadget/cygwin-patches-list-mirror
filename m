Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-07.nifty.com (conuserg-07.nifty.com [210.131.2.74])
 by sourceware.org (Postfix) with ESMTPS id 40F553857C6C
 for <cygwin-patches@cygwin.com>; Wed,  9 Sep 2020 13:41:31 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 40F553857C6C
Received: from localhost.localdomain (v038192.dynamic.ppp.asahi-net.or.jp
 [124.155.38.192]) (authenticated)
 by conuserg-07.nifty.com with ESMTP id 089DeqLf022890;
 Wed, 9 Sep 2020 22:41:01 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 089DeqLf022890
X-Nifty-SrcIP: [124.155.38.192]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2 1/2] Cygwin: pty: Revise convert_mb_str() function.
Date: Wed,  9 Sep 2020 22:40:42 +0900
Message-Id: <20200909134043.1864-2-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200909134043.1864-1-takashi.yano@nifty.ne.jp>
References: <20200909134043.1864-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Wed, 09 Sep 2020 13:41:33 -0000

- Use tmp_pathbuf instead of HeapAlloc()/HeapFree().
- Remove mb_str_free() function.
- Consider the case where the multibyte string stops in the middle
  of a multibyte char.
---
 winsup/cygwin/fhandler_tty.cc | 118 ++++++++++++++++++++++------------
 1 file changed, 77 insertions(+), 41 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 6de591d9b..c4b7fc61d 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -26,6 +26,7 @@ details. */
 #include <asm/socket.h>
 #include "cygwait.h"
 #include "registry.h"
+#include "tls_pbuf.h"
 
 #ifndef PROC_THREAD_ATTRIBUTE_PSEUDOCONSOLE
 #define PROC_THREAD_ATTRIBUTE_PSEUDOCONSOLE 0x00020016
@@ -116,40 +117,72 @@ CreateProcessW_Hooked
   return CreateProcessW_Orig (n, c, pa, ta, inh, f, e, d, si, pi);
 }
 
-static char *
-convert_mb_str (UINT cp_to, size_t *len_to,
-		UINT cp_from, const char *ptr_from, size_t len_from)
+static void
+convert_mb_str (UINT cp_to, char *ptr_to, size_t *len_to,
+		UINT cp_from, const char *ptr_from, size_t len_from,
+		mbstate_t *stat)
 {
-  char *buf;
   size_t nlen;
+  tmp_pathbuf tp;
   if (cp_to != cp_from)
     {
-      size_t wlen =
-	MultiByteToWideChar (cp_from, 0, ptr_from, len_from, NULL, 0);
-      wchar_t *wbuf = (wchar_t *)
-	HeapAlloc (GetProcessHeap (), 0, wlen * sizeof (wchar_t));
-      wlen =
-	MultiByteToWideChar (cp_from, 0, ptr_from, len_from, wbuf, wlen);
-      nlen = WideCharToMultiByte (cp_to, 0, wbuf, wlen, NULL, 0, NULL, NULL);
-      buf = (char *) HeapAlloc (GetProcessHeap (), 0, nlen);
-      nlen = WideCharToMultiByte (cp_to, 0, wbuf, wlen, buf, nlen, NULL, NULL);
-      HeapFree (GetProcessHeap (), 0, wbuf);
+      wchar_t *wbuf = tp.w_get ();
+      int wlen = 0;
+      if (cp_from == 65000) /* UTF-7 */
+	/* MB_ERR_INVALID_CHARS does not work properly for UTF-7.
+	   Therefore, just convert string without checking */
+	wlen = MultiByteToWideChar (cp_from, 0, ptr_from, len_from,
+				    wbuf, NT_MAX_PATH);
+      else
+	{
+	  char *tmpbuf = tp.c_get ();
+	  memcpy (tmpbuf, stat->__value.__wchb, stat->__count);
+	  if (stat->__count + len_from > NT_MAX_PATH)
+	    len_from = NT_MAX_PATH - stat->__count;
+	  memcpy (tmpbuf + stat->__count, ptr_from, len_from);
+	  int total_len = stat->__count + len_from;
+	  stat->__count = 0;
+	  int mblen = 0;
+	  for (const char *p = tmpbuf; p < tmpbuf + total_len; p += mblen)
+	    /* Max bytes in multibyte char is 4. */
+	    for (mblen = 1; mblen <= 4; mblen ++)
+	      {
+		/* Try conversion */
+		int l = MultiByteToWideChar (cp_from, MB_ERR_INVALID_CHARS,
+					     p, mblen,
+					     wbuf + wlen, NT_MAX_PATH - wlen);
+		if (l)
+		  { /* Conversion Success */
+		    wlen += l;
+		    break;
+		  }
+		else if (mblen == 4)
+		  { /* Conversion Fail */
+		    l = MultiByteToWideChar (cp_from, 0, p, 1,
+					     wbuf + wlen, NT_MAX_PATH - wlen);
+		    wlen += l;
+		    mblen = 1;
+		    break;
+		  }
+		else if (p + mblen == tmpbuf + total_len)
+		  { /* Multibyte char incomplete */
+		    memcpy (stat->__value.__wchb, p, mblen);
+		    stat->__count = mblen;
+		    break;
+		  }
+		/* Retry conversion with extended length */
+	      }
+	}
+      nlen = WideCharToMultiByte (cp_to, 0, wbuf, wlen,
+				  ptr_to, *len_to, NULL, NULL);
     }
   else
     {
       /* Just copy */
-      buf = (char *) HeapAlloc (GetProcessHeap (), 0, len_from);
-      memcpy (buf, ptr_from, len_from);
-      nlen = len_from;
+      nlen = min (*len_to, len_from);
+      memcpy (ptr_to, ptr_from, nlen);
     }
   *len_to = nlen;
-  return buf;
-}
-
-static void
-mb_str_free (char *ptr)
-{
-  HeapFree (GetProcessHeap (), 0, ptr);
 }
 
 static bool
@@ -1613,9 +1646,13 @@ fhandler_pty_master::write (const void *ptr, size_t len)
      if current application is native console application. */
   if (to_be_read_from_pcon () && get_ttyp ()->h_pseudo_console)
     {
-      size_t nlen;
-      char *buf = convert_mb_str (CP_UTF8, &nlen, get_ttyp ()->term_code_page,
-				  (const char *) ptr, len);
+      tmp_pathbuf tp;
+      char *buf = tp.c_get ();
+      static mbstate_t mbstat;
+      size_t nlen = NT_MAX_PATH;
+      convert_mb_str (CP_UTF8, buf, &nlen,
+		      get_ttyp ()->term_code_page, (const char *) ptr, len,
+		      &mbstat);
 
       WaitForSingleObject (input_mutex, INFINITE);
 
@@ -1650,7 +1687,6 @@ fhandler_pty_master::write (const void *ptr, size_t len)
 	      get_ttyp ()->pcon_start = false;
 	    }
 	  ReleaseMutex (input_mutex);
-	  mb_str_free (buf);
 	  return len;
 	}
 
@@ -1658,7 +1694,6 @@ fhandler_pty_master::write (const void *ptr, size_t len)
 
       ReleaseMutex (input_mutex);
 
-      mb_str_free (buf);
       return len;
     }
 
@@ -1975,13 +2010,16 @@ DWORD
 fhandler_pty_master::pty_master_fwd_thread ()
 {
   DWORD rlen;
-  char outbuf[65536];
+  tmp_pathbuf tp;
+  char *outbuf = tp.c_get ();
+  char *mbbuf = tp.c_get ();
+  static mbstate_t mbstat;
 
   termios_printf ("Started.");
   for (;;)
     {
       get_ttyp ()->pcon_last_time = GetTickCount ();
-      if (!ReadFile (from_slave, outbuf, sizeof outbuf, &rlen, NULL))
+      if (!ReadFile (from_slave, outbuf, NT_MAX_PATH, &rlen, NULL))
 	{
 	  termios_printf ("ReadFile for forwarding failed, %E");
 	  break;
@@ -2031,11 +2069,11 @@ fhandler_pty_master::pty_master_fwd_thread ()
 	    else
 	      state = 0;
 
-	  size_t nlen;
-	  char *buf = convert_mb_str (get_ttyp ()->term_code_page,
-				      &nlen, CP_UTF8, ptr, wlen);
+	  size_t nlen = NT_MAX_PATH;
+	  convert_mb_str (get_ttyp ()->term_code_page, mbbuf, &nlen,
+			  CP_UTF8, ptr, wlen, &mbstat);
 
-	  ptr = buf;
+	  ptr = mbbuf;
 	  wlen = rlen = nlen;
 
 	  /* OPOST processing was already done in pseudo console,
@@ -2051,14 +2089,13 @@ fhandler_pty_master::pty_master_fwd_thread ()
 	      ptr += written;
 	      wlen = (rlen -= written);
 	    }
-	  mb_str_free (buf);
 	  continue;
 	}
-      size_t nlen;
-      char *buf = convert_mb_str (get_ttyp ()->term_code_page, &nlen,
-				  GetConsoleOutputCP (), ptr, wlen);
+      size_t nlen = NT_MAX_PATH;
+      convert_mb_str (get_ttyp ()->term_code_page, mbbuf, &nlen,
+		      GetConsoleOutputCP (), ptr, wlen, &mbstat);
 
-      ptr = buf;
+      ptr = mbbuf;
       wlen = rlen = nlen;
       acquire_output_mutex (INFINITE);
       while (rlen>0)
@@ -2072,7 +2109,6 @@ fhandler_pty_master::pty_master_fwd_thread ()
 	  wlen = (rlen -= wlen);
 	}
       release_output_mutex ();
-      mb_str_free (buf);
     }
   return 0;
 }
-- 
2.28.0

