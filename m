Return-Path: <cygwin-patches-return-5597-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13760 invoked by alias); 1 Aug 2005 11:15:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13746 invoked by uid 22791); 1 Aug 2005 11:15:52 -0000
Received: from zipcon.net (HELO zipcon.net) (209.221.136.5)
    by sourceware.org (qpsmtpd/0.30-dev) with SMTP; Mon, 01 Aug 2005 11:15:52 +0000
Received: (qmail 31086 invoked from network); 1 Aug 2005 04:21:33 -0700
Received: from unknown (HELO efn.org) (209.221.136.27)
  by mail.zipcon.net with SMTP; 1 Aug 2005 04:21:33 -0700
Received: by efn.org (sSMTP sendmail emulation); Mon, 1 Aug 2005 04:15:53 -0700
Date: Mon, 01 Aug 2005 11:15:00 -0000
From: Yitzchak Scott-Thoennes <sthoenna@efn.org>
To: cygwin-patches@cygwin.com
Subject: [PATCH] TIOCMBI[SC]
Message-ID: <20050801111552.GA2844@efn.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-SW-Source: 2005-q3/txt/msg00052.txt.bz2


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-length: 318

I don't have a serial device to test this with, but it's just selected
parts of the TIOCMSET handling slightly adapted.

2005-08-01  Yitzchak Scott-Thoennes  <sthoenna@efn.org>

	* fhandler_serial.cc (fhandler_serial::ioctl): Implement TIOCMBIS and
	TIOCMBIC.
	* include/sys/termios.h: Define TIOCMBIS and TIOCMBIC

.

--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="tiocmbi.patch"
Content-length: 1627

--- winsup/cygwin/include/sys/termios.h.orig	2005-05-01 20:50:10.000000000 -0700
+++ winsup/cygwin/include/sys/termios.h	2005-08-01 02:22:34.361969600 -0700
@@ -1,6 +1,6 @@
 /* sys/termios.h
 
-   Copyright 1997, 1998, 1999, 2000, 2001, 2002, 2003 Red Hat, Inc.
+   Copyright 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2005 Red Hat, Inc.
 
 This file is part of Cygwin.
 
@@ -14,6 +14,8 @@
 #define _SYS_TERMIOS_H
 
 #define	TIOCMGET	0x5415
+#define	TIOCMBIS	0x5416
+#define	TIOCMBIC	0x5417
 #define	TIOCMSET	0x5418
 #define	TIOCINQ		0x541B
 
--- winsup/cygwin/fhandler_serial.cc.orig	2005-07-06 13:05:00.000000000 -0700
+++ winsup/cygwin/fhandler_serial.cc	2005-08-01 02:31:30.993608000 -0700
@@ -470,6 +470,50 @@ fhandler_serial::ioctl (unsigned int cmd
 	    res = -1;
 	  }
 	break;
+      case TIOCMBIS:
+	if (ipbuffer & TIOCM_RTS)
+	  {
+	    if (EscapeCommFunction (get_handle (), SETRTS))
+	      rts = TIOCM_RTS;
+	    else
+	      {
+		__seterrno ();
+		res = -1;
+	      }
+	  }
+	if (ipbuffer & TIOCM_DTR)
+	  {
+	    if (EscapeCommFunction (get_handle (), SETDTR))
+	      dtr = TIOCM_DTR;
+	    else
+	      {
+		__seterrno ();
+		res = -1;
+	      }
+	  }
+	break;
+      case TIOCMBIC:
+	if (ipbuffer & TIOCM_RTS)
+	  {
+	    if (EscapeCommFunction (get_handle (), CLRRTS))
+	      rts = 0;
+	    else
+	      {
+		__seterrno ();
+		res = -1;
+	      }
+	  }
+	if (ipbuffer & TIOCM_DTR)
+	  {
+	    if (EscapeCommFunction (get_handle (), CLRDTR))
+	      dtr = 0;
+	    else
+	      {
+		__seterrno ();
+		res = -1;
+	      }
+	  }
+	break;
       case TIOCCBRK:
 	if (ClearCommBreak (get_handle ()) == 0)
 	  {

--fUYQa+Pmc3FrFX/N--
