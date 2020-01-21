Return-Path: <cygwin-patches-return-9970-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29927 invoked by alias); 21 Jan 2020 14:42:15 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 29906 invoked by uid 89); 21 Jan 2020 14:42:14 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-19.7 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*MI:1598, HX-Languages-Length:2251, HContent-Transfer-Encoding:8bit
X-HELO: conuserg-05.nifty.com
Received: from conuserg-05.nifty.com (HELO conuserg-05.nifty.com) (210.131.2.72) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 21 Jan 2020 14:42:04 +0000
Received: from localhost.localdomain (ntsitm247158.sitm.nt.ngn.ppp.infoweb.ne.jp [124.27.253.158]) (authenticated)	by conuserg-05.nifty.com with ESMTP id 00LEfp87022724;	Tue, 21 Jan 2020 23:41:57 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-05.nifty.com 00LEfp87022724
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1579617717;	bh=7fiXWXPJa/MQ8fojdn0pmfQtk93yC6T6czepwAt4Q4s=;	h=From:To:Cc:Subject:Date:From;	b=bqiB6mv5A7YuasyMl+EWz4opCJLmIEbhNb4UuphpFd2rNMNRkZjJENdQ+0+rBsCw9	 u0SosxGoyuw8WjFEkHDtN1HqRGAo9HaAr5BVyOd/y2z1hTfiapjYM7tapSiY4+RRSp	 VnoH/6dGK9WBXlg9TZuBrhXqlabDQlcXfLTDQc/V98Zywvp2kMd8RzFgOUJDEZzmVd	 F5vo6aRXy/UxdznLZYH7GmiPE+Czd8uVlWLVGf16MvX8lPLj7yRKFZDhTzOmFJ5N+U	 OKTmjg8wqKJjHWp6OJSFbdVdliaJsre/ZTqKCUMKkLxP/Pdcc52VB52VifkquoKvNl	 G9Bxa1L6p+8oA==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: pty: Fix reopening slave in push_to_pcon_screenbuffer().
Date: Tue, 21 Jan 2020 14:42:00 -0000
Message-Id: <20200121144144.1598-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00076.txt

- For programs compiled with -mwindows option, reopening slave is
  needed in push_to_pcon_screenbuffer(), however, it was not at
  appropriate place. This causes the problem reported in
  https://www.cygwin.com/ml/cygwin/2020-01/msg00161.html. This
  patch fixes the issue.
---
 winsup/cygwin/fhandler_tty.cc | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index fff5bebe3..b5e7368b0 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -1272,9 +1272,21 @@ fhandler_pty_slave::push_to_pcon_screenbuffer (const char *ptr, size_t len)
 	break;
     }
 
+  int retry_count;
+  retry_count = 0;
   DWORD dwMode, flags;
   flags = ENABLE_VIRTUAL_TERMINAL_PROCESSING;
-  GetConsoleMode (get_output_handle (), &dwMode);
+  while (!GetConsoleMode (get_output_handle (), &dwMode))
+    {
+      termios_printf ("GetConsoleMode failed, %E");
+      /* Re-open handles */
+      this->close ();
+      this->open (0, 0);
+      /* Fix pseudo console window size */
+      this->ioctl (TIOCSWINSZ, &get_ttyp ()->winsize);
+      if (++retry_count > 3)
+	goto cleanup;
+    }
   if (!(get_ttyp ()->ti.c_oflag & OPOST) ||
       !(get_ttyp ()->ti.c_oflag & ONLCR))
     flags |= DISABLE_NEWLINE_AUTO_RETURN;
@@ -1283,8 +1295,6 @@ fhandler_pty_slave::push_to_pcon_screenbuffer (const char *ptr, size_t len)
   p = buf;
   DWORD wLen, written;
   written = 0;
-  int retry_count;
-  retry_count = 0;
   BOOL (WINAPI *WriteFunc)
     (HANDLE, LPCVOID, DWORD, LPDWORD, LPOVERLAPPED);
   WriteFunc = WriteFile_Orig ? WriteFile_Orig : WriteFile;
@@ -1293,16 +1303,13 @@ fhandler_pty_slave::push_to_pcon_screenbuffer (const char *ptr, size_t len)
       if (!WriteFunc (get_output_handle (), p, nlen - written, &wLen, NULL))
 	{
 	  termios_printf ("WriteFile failed, %E");
-	  this->open (0, 0); /* Re-open handles */
-	  /* Fix pseudo console window size */
-	  struct winsize win;
-	  this->ioctl (TIOCGWINSZ, &win);
-	  this->ioctl (TIOCSWINSZ, &win);
-	  if (++retry_count > 3)
-	    break;
+	  break;
+	}
+      else
+	{
+	  written += wLen;
+	  p += wLen;
 	}
-      written += wLen;
-      p += wLen;
     }
   /* Detach from pseudo console and resume. */
   flags = ENABLE_VIRTUAL_TERMINAL_PROCESSING;
-- 
2.21.0
