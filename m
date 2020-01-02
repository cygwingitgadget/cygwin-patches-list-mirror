Return-Path: <cygwin-patches-return-9900-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 76979 invoked by alias); 2 Jan 2020 13:17:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 76969 invoked by uid 89); 2 Jan 2020 13:17:45 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-19.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*Ad:D*jp, H*F:D*ne.jp, keys, HContent-Transfer-Encoding:8bit
X-HELO: conuserg-03.nifty.com
Received: from conuserg-03.nifty.com (HELO conuserg-03.nifty.com) (210.131.2.70) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 02 Jan 2020 13:17:43 +0000
Received: from localhost.localdomain (ntsitm247158.sitm.nt.ngn.ppp.infoweb.ne.jp [124.27.253.158]) (authenticated)	by conuserg-03.nifty.com with ESMTP id 002DHJBP027269;	Thu, 2 Jan 2020 22:17:25 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-03.nifty.com 002DHJBP027269
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1577971045;	bh=PaGS8KhHqyC5kZLnbTGJSaCK58jkSetlN/oI8kj93Cc=;	h=From:To:Cc:Subject:Date:From;	b=P9TNsu2h59VxdUuFZuLw4QTo0QZebV09lqcyEv1EbJ+kegneAMwXmfTwDzckV1MFh	 +Ca3sH5SeqEHFjKJQa0glfADSVkNIj6vJlvulloBjgbk9wjehi+PjcpDIUje+sMjtL	 pTbx+fjdEPuyOh+zyowXYiM1SOwSH0lrBRNfNU/PREqU3Qkw0iTS3ePNN9+yYfU3uE	 3YZt9i9sOgUjNwXgWRZsUWVymIKP77vNtCF9w9tq3Vu/qQX7EgJwnL6cAS66NvkYF8	 WysFmOix4wYRFTytD8hPTfE5tK/47spcwkMqBr2+z6yly8L709wnPnAXOYoY00RM+5	 g8wuDGlyXacog==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: console: Add code to restore console mode on close.
Date: Thu, 02 Jan 2020 13:17:00 -0000
Message-Id: <20200102131716.1179-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00006.txt

- The console with 24bit color support has a problem that console
  mode is changed if cygwin process is executed in cmd.exe which
  started in cygwin shell. For example, cursor keys become not
  working if bash -> cmd -> true are executed in this order.
  This patch fixes the issue.
---
 winsup/cygwin/fhandler_console.cc | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index 30b9165ca..78f42999c 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -64,6 +64,9 @@ fhandler_console::console_state NO_COPY *fhandler_console::shared_console_info;
 
 bool NO_COPY fhandler_console::invisible_console;
 
+static DWORD orig_conin_mode = (DWORD) -1;
+static DWORD orig_conout_mode = (DWORD) -1;
+
 static void
 beep ()
 {
@@ -1019,6 +1022,11 @@ fhandler_console::open (int flags, mode_t)
   get_ttyp ()->rstcons (false);
   set_open_status ();
 
+  if (orig_conin_mode == (DWORD) -1)
+    GetConsoleMode (get_handle (), &orig_conin_mode);
+  if (orig_conout_mode == (DWORD) -1)
+    GetConsoleMode (get_output_handle (), &orig_conout_mode);
+
   if (getpid () == con.owner && wincap.has_con_24bit_colors ())
     {
       DWORD dwMode;
@@ -1088,6 +1096,19 @@ fhandler_console::close ()
       SetConsoleMode (get_output_handle (), dwMode);
     }
 
+  /* Restore console mode if this is the last closure. */
+  OBJECT_BASIC_INFORMATION obi;
+  NTSTATUS status;
+  status = NtQueryObject (get_handle (), ObjectBasicInformation,
+			  &obi, sizeof obi, NULL);
+  if (NT_SUCCESS (status) && obi.HandleCount == 1)
+    {
+      if (orig_conin_mode != (DWORD) -1)
+	SetConsoleMode (get_handle (), orig_conin_mode);
+      if (orig_conout_mode != (DWORD) -1)
+	SetConsoleMode (get_handle (), orig_conout_mode);
+    }
+
   CloseHandle (get_handle ());
   CloseHandle (get_output_handle ());
 
-- 
2.21.0
