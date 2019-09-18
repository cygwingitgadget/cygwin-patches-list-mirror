Return-Path: <cygwin-patches-return-9696-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 37855 invoked by alias); 18 Sep 2019 14:33:29 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 37844 invoked by uid 89); 18 Sep 2019 14:33:29 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-20.1 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.1 spammy=3707, HContent-Transfer-Encoding:8bit
X-HELO: condef-10.nifty.com
Received: from condef-10.nifty.com (HELO condef-10.nifty.com) (202.248.20.75) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 18 Sep 2019 14:33:27 +0000
Received: from conuserg-06.nifty.com ([10.126.8.69])by condef-10.nifty.com with ESMTP id x8IETaBv028164	for <cygwin-patches@cygwin.com>; Wed, 18 Sep 2019 23:29:36 +0900
Received: from localhost.localdomain (ntsitm283243.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.151.243]) (authenticated)	by conuserg-06.nifty.com with ESMTP id x8IETKDx031962;	Wed, 18 Sep 2019 23:29:30 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-06.nifty.com x8IETKDx031962
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1568816970;	bh=0e3lx7VeMCOLByZZZpL3orq3bcWlixlQ4UJBtAB/0T4=;	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;	b=gK/HiUNUpU2+fqZRaN9d++DH10BnZO3LxkWxG9SXDK4HMcVLJUnnpdbRqEoXJ9O8w	 x45pYhkS4h43iQ58Un1Iy6oRzFBV9A0Hki1CbEdiDrbh5wyebazSLlw9ay7ypIJb22	 V6YOtf0WBMDoLVEvZkcTLFjBgv4XKwnfR309ICbjD1QR4v2XTvp6wq5bncpG0u05PR	 AsHL+xSLLnZT3yQMwuRJ4EbpsYgPEVnGLjBqX+Nt4Dt2CylR7q9O8tOOkD59gfaSLM	 llT2Vxa1wn5b+/rL18/hDXggRB5HuS9oUV7QMhUBje8Rqndqe2ePCu/9lSbYxUkRxO	 0f7CluCcOOd3g==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 3/5] Cygwin: pty: Unify the charset conversion codes into a function.
Date: Wed, 18 Sep 2019 14:33:00 -0000
Message-Id: <20190918142921.835-4-takashi.yano@nifty.ne.jp>
In-Reply-To: <20190918142921.835-1-takashi.yano@nifty.ne.jp>
References: <20190918142921.835-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00216.txt.bz2

---
 winsup/cygwin/fhandler_tty.cc | 130 +++++++++++++---------------------
 1 file changed, 49 insertions(+), 81 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 843807aab..f723ec7cf 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -370,7 +370,43 @@ CreateProcessW_Hooked
 void set_ishybrid_and_switch_to_pcon (HANDLE) {}
 #endif /* USE_API_HOOK */
 
-bool
+static char *
+convert_mb_str (UINT cp_to, size_t *len_to,
+		UINT cp_from, const char *ptr_from, size_t len_from)
+{
+  char *buf;
+  size_t nlen;
+  if (cp_to != cp_from)
+    {
+      size_t wlen =
+	MultiByteToWideChar (cp_from, 0, ptr_from, len_from, NULL, 0);
+      wchar_t *wbuf = (wchar_t *)
+	HeapAlloc (GetProcessHeap (), 0, wlen * sizeof (wchar_t));
+      wlen =
+	MultiByteToWideChar (cp_from, 0, ptr_from, len_from, wbuf, wlen);
+      nlen = WideCharToMultiByte (cp_to, 0, wbuf, wlen, NULL, 0, NULL, NULL);
+      buf = (char *) HeapAlloc (GetProcessHeap (), 0, nlen);
+      nlen = WideCharToMultiByte (cp_to, 0, wbuf, wlen, buf, nlen, NULL, NULL);
+      HeapFree (GetProcessHeap (), 0, wbuf);
+    }
+  else
+    {
+      /* Just copy */
+      buf = (char *) HeapAlloc (GetProcessHeap (), 0, len_from);
+      memcpy (buf, ptr_from, len_from);
+      nlen = len_from;
+    }
+  *len_to = nlen;
+  return buf;
+}
+
+static void
+mb_str_free (char *ptr)
+{
+  HeapFree (GetProcessHeap (), 0, ptr);
+}
+
+static bool
 bytes_available (DWORD& n, HANDLE h)
 {
   DWORD navail, nleft;
@@ -1270,34 +1306,11 @@ fhandler_pty_slave::write (const void *ptr, size_t len)
 
   reset_switch_to_pcon ();
 
-  char *buf;
-  ssize_t nlen;
-  UINT targetCodePage = get_ttyp ()->switch_to_pcon_out ?
+  UINT target_code_page = get_ttyp ()->switch_to_pcon_out ?
     GetConsoleOutputCP () : get_ttyp ()->term_code_page;
-  if (targetCodePage != get_ttyp ()->term_code_page)
-    {
-      size_t wlen =
-	MultiByteToWideChar (get_ttyp ()->term_code_page, 0,
-			     (char *)ptr, len, NULL, 0);
-      wchar_t *wbuf = (wchar_t *)
-	HeapAlloc (GetProcessHeap (), 0, wlen * sizeof (wchar_t));
-      wlen =
-	MultiByteToWideChar (get_ttyp ()->term_code_page, 0,
-			     (char *)ptr, len, wbuf, wlen);
-      nlen = WideCharToMultiByte (targetCodePage, 0,
-				  wbuf, wlen, NULL, 0, NULL, NULL);
-      buf = (char *) HeapAlloc (GetProcessHeap (), 0, nlen);
-      nlen = WideCharToMultiByte (targetCodePage, 0,
-				  wbuf, wlen, buf, nlen, NULL, NULL);
-      HeapFree (GetProcessHeap (), 0, wbuf);
-    }
-  else
-    {
-      /* Just copy */
-      buf = (char *) HeapAlloc (GetProcessHeap (), 0, len);
-      memcpy (buf, (char *)ptr, len);
-      nlen = len;
-    }
+  ssize_t nlen;
+  char *buf = convert_mb_str (target_code_page, (size_t *) &nlen,
+		 get_ttyp ()->term_code_page, (const char *) ptr, len);
 
   /* If not attached to this pseudo console, try to attach temporarily. */
   pid_restore = 0;
@@ -1334,7 +1347,7 @@ fhandler_pty_slave::write (const void *ptr, size_t len)
       towrite = -1;
     }
   release_output_mutex ();
-  HeapFree (GetProcessHeap (), 0, buf);
+  mb_str_free (buf);
   flags = ENABLE_VIRTUAL_TERMINAL_PROCESSING;
   if (get_ttyp ()->switch_to_pcon_out && !fallback)
     SetConsoleMode (get_output_handle (), dwMode | flags);
@@ -2260,33 +2273,10 @@ fhandler_pty_master::write (const void *ptr, size_t len)
      if current application is native console application. */
   if (to_be_read_from_pcon ())
     {
-      char *buf;
       size_t nlen;
+      char *buf = convert_mb_str
+	(CP_UTF8, &nlen, get_ttyp ()->term_code_page, (const char *) ptr, len);
 
-      if (get_ttyp ()->term_code_page != CP_UTF8)
-	{
-	  size_t wlen =
-	    MultiByteToWideChar (get_ttyp ()->term_code_page, 0,
-				 (char *)ptr, len, NULL, 0);
-	  wchar_t *wbuf = (wchar_t *)
-	    HeapAlloc (GetProcessHeap (), 0, wlen * sizeof (wchar_t));
-	  wlen =
-	    MultiByteToWideChar (get_ttyp ()->term_code_page, 0,
-				 (char *)ptr, len, wbuf, wlen);
-	  nlen = WideCharToMultiByte (CP_UTF8, 0,
-				      wbuf, wlen, NULL, 0, NULL, NULL);
-	  buf = (char *) HeapAlloc (GetProcessHeap (), 0, nlen);
-	  nlen = WideCharToMultiByte (CP_UTF8, 0,
-				      wbuf, wlen, buf, nlen, NULL, NULL);
-	  HeapFree (GetProcessHeap (), 0, wbuf);
-	}
-      else
-	{
-	  /* Just copy */
-	  buf = (char *) HeapAlloc (GetProcessHeap (), 0, len);
-	  memcpy (buf, (char *)ptr, len);
-	  nlen = len;
-	}
       DWORD wLen;
       WriteFile (to_slave, buf, nlen, &wLen, NULL);
 
@@ -2302,7 +2292,7 @@ fhandler_pty_master::write (const void *ptr, size_t len)
       else
 	SetEvent (input_available_event);
 
-      HeapFree (GetProcessHeap (), 0, buf);
+      mb_str_free (buf);
       return len;
     }
 
@@ -3039,32 +3029,10 @@ fhandler_pty_master::pty_master_fwd_thread ()
 	    }
 	  wlen = rlen;
 
-	  char *buf;
 	  size_t nlen;
-	  if (get_ttyp ()->term_code_page != CP_UTF8)
-	    {
-	      size_t wlen2 =
-		MultiByteToWideChar (CP_UTF8, 0,
-				     (char *)ptr, wlen, NULL, 0);
-	      wchar_t *wbuf = (wchar_t *)
-		HeapAlloc (GetProcessHeap (), 0, wlen2 * sizeof (wchar_t));
-	      wlen2 =
-		MultiByteToWideChar (CP_UTF8, 0,
-				     (char *)ptr, wlen, wbuf, wlen2);
-	      nlen = WideCharToMultiByte (get_ttyp ()->term_code_page, 0,
-					  wbuf, wlen2, NULL, 0, NULL, NULL);
-	      buf = (char *) HeapAlloc (GetProcessHeap (), 0, nlen);
-	      nlen = WideCharToMultiByte (get_ttyp ()->term_code_page, 0,
-					  wbuf, wlen2, buf, nlen, NULL, NULL);
-	      HeapFree (GetProcessHeap (), 0, wbuf);
-	    }
-	  else
-	    {
-	      /* Just copy */
-	      buf = (char *) HeapAlloc (GetProcessHeap (), 0, wlen);
-	      memcpy (buf, (char *)ptr, wlen);
-	      nlen = wlen;
-	    }
+	  char *buf = convert_mb_str
+	    (get_ttyp ()->term_code_page, &nlen, CP_UTF8, ptr, wlen);
+
 	  ptr = buf;
 	  wlen = rlen = nlen;
 
@@ -3083,7 +3051,7 @@ fhandler_pty_master::pty_master_fwd_thread ()
 	      wlen = (rlen -= written);
 	    }
 	  release_output_mutex ();
-	  HeapFree (GetProcessHeap (), 0, buf);
+	  mb_str_free (buf);
 	  continue;
 	}
       acquire_output_mutex (INFINITE);
-- 
2.21.0
