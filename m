Return-Path: <cygwin-patches-return-3976-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9175 invoked by alias); 29 Jun 2003 15:42:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9166 invoked from network); 29 Jun 2003 15:42:05 -0000
X-Originating-IP: [68.80.118.176]
X-Originating-Email: [rkitover@hotmail.com]
From: "Rafael Kitover" <caelum@debian.org>
To: <cygwin-patches@cygwin.com>
Subject: EIO error on background tty reads
Date: Sun, 29 Jun 2003 15:42:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Message-ID: <Law9-OE43Uu7CmzZazu00052307@hotmail.com>
X-OriginalArrivalTime: 29 Jun 2003 15:42:05.0215 (UTC) FILETIME=[FDC3D2F0:01C33E54]
X-SW-Source: 2003-q2/txt/msg00203.txt.bz2

While working on my port of screen for cygwin, I have tracked down the issue
that did not allow me to reattach detached screens.

A detached screen process owns a certain tty to which the new, attaching
screen process connects to and reads/writes to.

Recent builds of cygwin return an EIO on a read from the tty, the following
small change fixes this, but I have to admit that
this is my first time swimming in the bowels of cygwin itself and I don't
know if this makes sense or not.

2003-06-29  Rafael Kitover  <caelum@debian.org>

    * Fix EIO errors on background reads from a tty.

Index: cygwin/fhandler_termios.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_termios.cc,v
retrieving revision 1.46
diff -u -p -r1.46 fhandler_termios.cc
--- cygwin/fhandler_termios.cc  16 Jun 2003 03:24:10 -0000      1.46
+++ cygwin/fhandler_termios.cc  29 Jun 2003 14:59:13 -0000
@@ -160,7 +160,7 @@ fhandler_termios::bg_check (int sig)
     goto setEIO;
   else if (!sigs_ignored)
     /* nothing */;
-  else if (sig == SIGTTOU)
+  else if (sig == SIGTTOU || sig == SIGTTIN)
     return bg_ok;              /* Just allow the output */
   else
     goto setEIO;       /* This is an output error */
