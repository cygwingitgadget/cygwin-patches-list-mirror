Return-Path: <cygwin-patches-return-5175-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12695 invoked by alias); 1 Dec 2004 21:13:27 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 12553 invoked from network); 1 Dec 2004 21:13:21 -0000
Received: from unknown (HELO moutng.kundenserver.de) (212.227.126.191)
  by sourceware.org with SMTP; 1 Dec 2004 21:13:21 -0000
Received: from [212.227.126.208] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1CZbmq-0007rW-00
	for cygwin-patches@cygwin.com; Wed, 01 Dec 2004 22:13:20 +0100
Received: from [217.245.9.107] (helo=towo.net)
	by mrelayng.kundenserver.de with asmtp (Exim 3.35 #1)
	id 1CZbmo-0000PC-00
	for cygwin-patches@cygwin.com; Wed, 01 Dec 2004 22:13:19 +0100
Received: by towo.net (sSMTP sendmail emulation); Wed, 1 Dec 2004 08:16:28 +0100
Date: Wed, 01 Dec 2004 21:13:00 -0000
To: cygwin-patches@cygwin.com
From: Thomas Wolff <towo@computer.org>
Subject: change log fix: [Patch] bug # 514 (cygwin console handling)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=%%message-boundary%%
Message-Id: <E1CZbmo-0000PC-00@mrelayng.kundenserver.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:1bd85ed25de6039e01e18a198cf341a2
X-SW-Source: 2004-q4/txt/msg00176.txt.bz2


--%%message-boundary%%
Content-Type: text/plain
Content-length: 947

Sorry, I missed to insert the function name in the change log 
entry, so here it is again as an update; the patch is the same.

This is a small patch that fixes
 http://sourceware.org/bugzilla/show_bug.cgi?id=514

Please integrate it into the cygwin DLL.

2004-11-26  Thomas Wolff  <towo@computer.org>

* fhandler_console.cc (get_win32_attr): Avoid inappropriate intensity 
     interchanging that used to render reverse output unreadable 
     when (non-reversed) text is bright.
     See http://sourceware.org/bugzilla/show_bug.cgi?id=514
     There are two useful alternatives to handle this; both are in 
     the patch (#ifdef reverse_bright) and one is selected by #define:
     a) (selected) bright foreground will reverse to a bright background,
     b) bright foreground will reverse to a dim background but 
        the background will no longer reverse to a bright foreground 
        (which used to render reverse output unreadable).


--%%message-boundary%%
Content-Type: text/plain
Content-length: 1844

--- cygwin-1.5.12-1/winsup/cygwin/fhandler_console.cc	2004-10-28 17:33:04.000000000 +0200
+++ cygwin-1.5.12-1/winsup/cygwin/fhandler_console.cc.fix514	2004-11-30 12:44:03.499523500 +0100
@@ -921,14 +921,32 @@ fhandler_console::get_win32_attr ()
   if (dev_state->reverse)
     {
       WORD save_fg = win_fg;
+#define reverse_bright
+#ifdef reverse_bright
+      /* This way, a bright foreground will reverse to a bright background.
+       */
       win_fg = (win_bg & BACKGROUND_RED   ? FOREGROUND_RED   : 0) |
 	       (win_bg & BACKGROUND_GREEN ? FOREGROUND_GREEN : 0) |
 	       (win_bg & BACKGROUND_BLUE  ? FOREGROUND_BLUE  : 0) |
-	       (win_fg & FOREGROUND_INTENSITY);
+	       (win_bg & BACKGROUND_INTENSITY ? FOREGROUND_INTENSITY : 0);
       win_bg = (save_fg & FOREGROUND_RED   ? BACKGROUND_RED   : 0) |
 	       (save_fg & FOREGROUND_GREEN ? BACKGROUND_GREEN : 0) |
 	       (save_fg & FOREGROUND_BLUE  ? BACKGROUND_BLUE  : 0) |
-	       (win_bg & BACKGROUND_INTENSITY);
+	       (save_fg & FOREGROUND_INTENSITY ? BACKGROUND_INTENSITY : 0);
+#else
+      /* This way, a bright foreground will reverse to a dim background.
+         But the background will no longer reverse to a bright foreground 
+         (which used to render reverse output unreadable).
+       */
+      win_fg = (win_bg & BACKGROUND_RED   ? FOREGROUND_RED   : 0) |
+	       (win_bg & BACKGROUND_GREEN ? FOREGROUND_GREEN : 0) |
+	       (win_bg & BACKGROUND_BLUE  ? FOREGROUND_BLUE  : 0) |
+	       (win_bg & FOREGROUND_INTENSITY);
+      win_bg = (save_fg & FOREGROUND_RED   ? BACKGROUND_RED   : 0) |
+	       (save_fg & FOREGROUND_GREEN ? BACKGROUND_GREEN : 0) |
+	       (save_fg & FOREGROUND_BLUE  ? BACKGROUND_BLUE  : 0) |
+	       (save_fg & BACKGROUND_INTENSITY);
+#endif
     }
   if (dev_state->underline)
     win_fg = dev_state->underline_color;

--%%message-boundary%%--
