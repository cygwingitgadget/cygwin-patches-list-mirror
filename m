Return-Path: <cygwin-patches-return-5205-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12101 invoked by alias); 14 Dec 2004 20:21:20 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11961 invoked from network); 14 Dec 2004 20:21:12 -0000
Received: from unknown (HELO moutng.kundenserver.de) (212.227.126.171)
  by sourceware.org with SMTP; 14 Dec 2004 20:21:12 -0000
Received: from [212.227.126.207] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1CeJAV-0008Rc-00
	for cygwin-patches@cygwin.com; Tue, 14 Dec 2004 21:21:11 +0100
Received: from [217.245.13.27] (helo=towo.net)
	by mrelayng.kundenserver.de with asmtp (Exim 3.35 #1)
	id 1CeJAV-0007GT-00
	for cygwin-patches@cygwin.com; Tue, 14 Dec 2004 21:21:11 +0100
Received: by towo.net (sSMTP sendmail emulation); Tue, 14 Dec 2004 06:02:31 +0100
Date: Tue, 14 Dec 2004 20:21:00 -0000
From: Thomas Wolff <towo@computer.org>
To: cygwin-patches@cygwin.com
CC-To: Corinna Vinschen <vinschen@redhat.com>
Subject: [Patch] bug # 514 (cygwin console handling) - update
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=%%message-boundary%%
Message-Id: <E1CeJAV-0007GT-00@mrelayng.kundenserver.de>
X-SW-Source: 2004-q4/txt/msg00206.txt.bz2


--%%message-boundary%%
Content-Type: text/plain
Content-length: 920

This is an update of my "trivial patch" that fixes
 http://sourceware.org/bugzilla/show_bug.cgi?id=514

> I guess the patch is pretty much ok and I'm inclined to let it pass
> under the trivial patch rule... iff you change it so that the #ifdef
> goes away.  Which alternative seems more appropriate resp. which one
> results in the more readable output?  It's the one we should choose
> (since any choice will result in complains anyway).
OK, I kept the alternative that was selected by #ifdef before. 
It's the more consistent one anyway.

> And please shorten the ChangeLog entry to about one sentence.
OK.

Thanks a lot.
Thomas


2004-12-14  Thomas Wolff  <towo@computer.org>

* fhandler_console.cc (get_win32_attr): Avoid inappropriate intensity 
     interchanging that used to render reverse output unreadable 
     when (non-reversed) text is bright.
     See http://sourceware.org/bugzilla/show_bug.cgi?id=514


--%%message-boundary%%
Content-Type: text/plain
Content-length: 937

--- cygwin-1.5.12-1/winsup/cygwin/fhandler_console.cc	2004-11-30 12:47:46.000000000 +0100
+++ cygwin-1.5.12-1/winsup/cygwin/fhandler_console.cc.fix514.1	2004-12-14 14:13:43.725870000 +0100
@@ -924,11 +924,11 @@ fhandler_console::get_win32_attr ()
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
     }
   if (dev_state->underline)
     win_fg = dev_state->underline_color;

--%%message-boundary%%--
