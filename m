Return-Path: <cygwin-patches-return-3110-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 7853 invoked by alias); 4 Nov 2002 03:26:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7776 invoked from network); 4 Nov 2002 03:26:41 -0000
Message-ID: <006b01c283b1$b33bb580$0201a8c0@sos>
From: "Sergey Okhapkin" <sos@prospect.com.ru>
To: "Cygwin-Patches" <cygwin-patches@cygwin.com>
Subject: fhandler_serial fix
Date: Sun, 03 Nov 2002 19:26:00 -0000
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-Virus-Scanned: by amavisd-milter (http://amavis.org/)
X-SW-Source: 2002-q4/txt/msg00061.txt.bz2

The patch fixes a crash when ioctl(fd, TCFLSH, how) is called for a serial
port.

2002-11-03  Sergey Okhapkin  <sos@prospect.com.ru>

        * fhandler_serial.cc (fhandler_serial::ioctl): the 3rd argument of
        ioctl(fd, TCFLSH, ...) is integer but not a pointer.


Index: fhandler_serial.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_serial.cc,v
retrieving revision 1.31
diff -u -p -r1.31 fhandler_serial.cc
--- fhandler_serial.cc  30 Sep 2002 04:35:17 -0000      1.31
+++ fhandler_serial.cc  4 Nov 2002 03:19:55 -0000
@@ -391,6 +391,9 @@ fhandler_serial::ioctl (unsigned int cmd
   int modemStatus;
   int request;

+  if (cmd == TCFLSH)
+    return tcflush ((int) buffer);
+
   request = *(int *) buffer;
   action = 0;
   modemStatus = 0;

Sergey Okhapkin
Somerset, NJ

