Return-Path: <cygwin-patches-return-5174-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15380 invoked by alias); 30 Nov 2004 21:31:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15083 invoked from network); 30 Nov 2004 21:31:13 -0000
Received: from unknown (HELO moutng.kundenserver.de) (212.227.126.190)
  by sourceware.org with SMTP; 30 Nov 2004 21:31:13 -0000
Received: from [212.227.126.155] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1CZFaa-0003c5-00
	for cygwin-patches@cygwin.com; Tue, 30 Nov 2004 22:31:12 +0100
Received: from [217.245.21.155] (helo=towo.net)
	by mrelayng.kundenserver.de with asmtp (Exim 3.35 #1)
	id 1CZFaa-00086S-00
	for cygwin-patches@cygwin.com; Tue, 30 Nov 2004 22:31:12 +0100
Received: by towo.net (sSMTP sendmail emulation); Tue, 30 Nov 2004 22:31:10 +0100
Date: Tue, 30 Nov 2004 21:31:00 -0000
To: cygwin-patches@cygwin.com
From: Thomas Wolff <towo@computer.org>
Subject: [Patch] bug # 512 (cygwin console handling)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=%%message-boundary%%
Message-Id: <E1CZFaa-00086S-00@mrelayng.kundenserver.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:1bd85ed25de6039e01e18a198cf341a2
X-SW-Source: 2004-q4/txt/msg00175.txt.bz2


--%%message-boundary%%
Content-Type: text/plain
Content-length: 365

This is a small patch that fixes
 http://sourceware.org/bugzilla/show_bug.cgi?id=512

Please integrate it into the cygwin DLL.

2004-11-26  Thomas Wolff  <towo@computer.org>

* fhandler_console.cc (read) <mouse position detection>: 
     Considering offset within scrolling region of the DOS box window.
     See http://sourceware.org/bugzilla/show_bug.cgi?id=512


--%%message-boundary%%
Content-Type: text/plain
Content-length: 1094

--- cygwin-1.5.12-1/winsup/cygwin/fhandler_console.cc	2004-10-28 17:33:04.000000000 +0200
+++ cygwin-1.5.12-1/winsup/cygwin/fhandler_console.cc.fix512	2004-11-30 12:42:40.172503500 +0100
@@ -422,10 +422,25 @@ fhandler_console::read (void *pv, size_t
 	      if (mouse_event.dwEventFlags)
 		continue;
 
-	      /* If the mouse event occurred out of the area we can handle,
-		 ignore it. */
+	      /* Retrieve reported mouse position */
 	      int x = mouse_event.dwMousePosition.X;
 	      int y = mouse_event.dwMousePosition.Y;
+
+	      /* Adjust mouse position by scroll buffer offset */
+	      CONSOLE_SCREEN_BUFFER_INFO now;
+	      if (GetConsoleScreenBufferInfo (get_output_handle (), &now))
+		{
+		  y -= now.srWindow.Top;
+		  x -= now.srWindow.Left;
+		}
+	      else
+		{
+		  syscall_printf ("mouse: cannot adjust position by scroll buffer offset");
+		  continue;
+		}
+
+	      /* If the mouse event occurred out of the area we can handle,
+		 ignore it. */
 	      if ((x + ' ' + 1 > 0xFF) || (y + ' ' + 1 > 0xFF))
 		{
 		  syscall_printf ("mouse: position out of range");

--%%message-boundary%%--
