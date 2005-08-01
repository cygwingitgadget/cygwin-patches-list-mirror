Return-Path: <cygwin-patches-return-5600-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2436 invoked by alias); 1 Aug 2005 19:25:16 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2371 invoked by uid 22791); 1 Aug 2005 19:25:11 -0000
Received: from zipcon.net (HELO zipcon.net) (209.221.136.5)
    by sourceware.org (qpsmtpd/0.30-dev) with SMTP; Mon, 01 Aug 2005 19:25:11 +0000
Received: (qmail 14860 invoked from network); 1 Aug 2005 12:25:07 -0700
Received: from unknown (HELO efn.org) (209.221.136.31)
  by mail.zipcon.net with SMTP; 1 Aug 2005 12:25:07 -0700
Received: by efn.org (sSMTP sendmail emulation); Mon, 1 Aug 2005 12:25:11 -0700
Date: Mon, 01 Aug 2005 19:25:00 -0000
From: Yitzchak Scott-Thoennes <sthoenna@efn.org>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] TIOCMBI[SC]
Message-ID: <20050801192510.GA3656@efn.org>
References: <20050801111552.GA2844@efn.org> <20050801165639.GK14783@calimero.vinschen.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
In-Reply-To: <20050801165639.GK14783@calimero.vinschen.de>
User-Agent: Mutt/1.4.2.1i
X-SW-Source: 2005-q3/txt/msg00055.txt.bz2


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-length: 1055

On Mon, Aug 01, 2005 at 06:56:39PM +0200, Corinna Vinschen wrote:
> On Aug  1 04:15, Yitzchak Scott-Thoennes wrote:
> > I don't have a serial device to test this with, but it's just selected
> > parts of the TIOCMSET handling slightly adapted.
> 
> I'm not serial I/O savvy, but the change looks pretty much ok.  I'm just
> not exactly glad that the functionality itself is duplicated.  Would you
> mind a rewrite so that the functionality is not copied, for instance by
> creating a private method which does it, or by recursively calling
> fhandler_serial::ioctl() with tweaked arguments (TIOCMSET)?

No problem.  How does this look?

2005-08-01  Yitzchak Scott-Thoennes  <sthoenna@efn.org>

	* include/sys/termios.h: Define TIOCMBIS and TIOCMBIC.
        * fhandler.h (class fhandler_serial): Declare switch_modem_lines.
	* fhandler_serial.cc (fhandler_serial::switch_modem_lines): New
        static function to set or clear DTR and/or RTS.
        (fhandler_serial::ioctl): Use switch_modem_lines for TIOCMSET
        and new TIOCMBIS and TIOCMBIC.


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="tiocmbi.patch"
Content-length: 3352

--- winsup/cygwin/include/sys/termios.h.orig	2005-05-01 20:50:10.000000000 -0700
+++ winsup/cygwin/include/sys/termios.h	2005-08-01 02:22:34.361969600 -0700
@@ -1,6 +1,6 @@
 /* sys/termios.h
 
-   Copyright 1997, 1998, 1999, 2000, 2001, 2002, 2003 Red Hat, Inc.
+   Copyright 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2005 Red Hat, Inc.
 
 This file is part of Cygwin.
 
@@ -14,6 +14,8 @@ details. */
 #define _SYS_TERMIOS_H
 
 #define	TIOCMGET	0x5415
+#define	TIOCMBIS	0x5416
+#define	TIOCMBIC	0x5417
 #define	TIOCMSET	0x5418
 #define	TIOCINQ		0x541B
 
--- winsup/cygwin/fhandler.h.orig	2005-07-29 10:04:46.000000000 -0700
+++ winsup/cygwin/fhandler.h	2005-08-01 11:46:07.884528000 -0700
@@ -722,6 +722,7 @@ class fhandler_serial: public fhandler_b
   int tcdrain ();
   int tcflow (int);
   int ioctl (unsigned int cmd, void *);
+  int switch_modem_lines (int set, int clr);
   int tcsetattr (int a, const struct termios *t);
   int tcgetattr (struct termios *t);
   _off64_t lseek (_off64_t, int) { return 0; }
--- winsup/cygwin/fhandler_serial.cc.orig	2005-07-06 13:05:00.000000000 -0700
+++ winsup/cygwin/fhandler_serial.cc	2005-08-01 11:50:49.269139200 -0700
@@ -376,6 +376,56 @@ fhandler_serial::tcflow (int action)
 }
 
 
+/* switch_modem_lines: set or clear RTS and/or DTR */
+int
+fhandler_serial::switch_modem_lines (int set, int clr)
+{
+  int res = 0;
+
+  if (set & TIOCM_RTS)
+    {
+      if (EscapeCommFunction (get_handle (), SETRTS))
+        rts = TIOCM_RTS;
+      else
+        {
+          __seterrno ();
+          res = -1;
+        }
+    }
+  else if (clr & TIOCM_RTS)
+    {
+      if (EscapeCommFunction (get_handle (), CLRRTS))
+        rts = 0;
+      else
+        {
+          __seterrno ();
+          res = -1;
+        }
+    }
+  if (set & TIOCM_DTR)
+    {
+      if (EscapeCommFunction (get_handle (), SETDTR))
+        rts = TIOCM_DTR;
+      else
+        {
+          __seterrno ();
+          res = -1;
+        }
+    }
+  else if (clr & TIOCM_DTR)
+    {
+      if (EscapeCommFunction (get_handle (), CLRDTR))
+        rts = 0;
+      else
+        {
+          __seterrno ();
+          res = -1;
+        }
+    }
+
+  return res;
+}
+
 /* ioctl: */
 int
 fhandler_serial::ioctl (unsigned int cmd, void *buffer)
@@ -432,44 +482,17 @@ fhandler_serial::ioctl (unsigned int cmd
 	  }
 	break;
       case TIOCMSET:
-	if (ipbuffer & TIOCM_RTS)
-	  {
-	    if (EscapeCommFunction (get_handle (), SETRTS))
-	      rts = TIOCM_RTS;
-	    else
-	      {
-		__seterrno ();
-		res = -1;
-	      }
-	  }
-	else
-	  {
-	    if (EscapeCommFunction (get_handle (), CLRRTS))
-	      rts = 0;
-	    else
-	      {
-		__seterrno ();
-		res = -1;
-	      }
-	  }
-	if (ipbuffer & TIOCM_DTR)
-	  {
-	    if (EscapeCommFunction (get_handle (), SETDTR))
-	      dtr = TIOCM_DTR;
-	    else
-	      {
-		__seterrno ();
-		res = -1;
-	      }
-	  }
-	else if (EscapeCommFunction (get_handle (), CLRDTR))
-	  dtr = 0;
-	else
-	  {
-	    __seterrno ();
-	    res = -1;
-	  }
+        if (switch_modem_lines (ipbuffer, ~ ipbuffer))
+          res = -1;
 	break;
+      case TIOCMBIS:
+	if (switch_modem_lines (ipbuffer, 0))
+          res = -1;
+        break;
+      case TIOCMBIC:
+	if (switch_modem_lines (0, ipbuffer))
+          res = -1;
+        break;
       case TIOCCBRK:
 	if (ClearCommBreak (get_handle ()) == 0)
 	  {

--UlVJffcvxoiEqYs2--
