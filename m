Return-Path: <cygwin-patches-return-2652-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 25788 invoked by alias); 15 Jul 2002 06:04:03 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25772 invoked from network); 15 Jul 2002 06:04:02 -0000
Message-ID: <3D2EE6B2.8B9AFE7D@certum.pl>
Date: Sun, 14 Jul 2002 23:04:00 -0000
From: Jacek Trzcinski <jacek@certum.pl>
Reply-To: jacek@certum.pl
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Serial patch - second attempt
Content-Type: multipart/mixed;
 boundary="------------050B889197A68679690CAE68"
X-SW-Source: 2002-q3/txt/msg00100.txt.bz2

This is a multi-part message in MIME format.
--------------050B889197A68679690CAE68
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-length: 197

Hi,
I spent a little time in weekend to fix my patch. Now it should be in
accordance with cvs sources ( I rebuilt cygwin from latest cvs sources
and tested how my patch worked).

Best regards
Jacek
--------------050B889197A68679690CAE68
Content-Type: text/plain; charset=us-ascii;
 name="serial_patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="serial_patch"
Content-length: 6444

--- fhandler.h	2002-07-14 12:45:23.000000000 +0200
+++ /home/Administrator/prace/serial_patch/latest/fhandler.h	2002-07-13 01:03:17.000000000 +0200
@@ -619,6 +619,8 @@
   unsigned int vmin_;			/* from termios */
   unsigned int vtime_;			/* from termios */
   pid_t pgrp_;
+  int rts;				/* for Windows 9x purposes only */
+  int dtr;				/* for Windows 9x purposes only */
 
  public:
   int overlapped_armed;
@@ -638,6 +640,7 @@
   int tcsendbreak (int);
   int tcdrain ();
   int tcflow (int);
+  int ioctl (unsigned int cmd, void *);
   int tcsetattr (int a, const struct termios *t);
   int tcgetattr (struct termios *t);
   __off64_t lseek (__off64_t, int) { return 0; }
--- fhandler_serial.cc	2002-07-14 12:45:24.000000000 +0200
+++ /home/Administrator/prace/serial_patch/latest/fhandler_serial.cc	2002-07-14 12:16:55.000000000 +0200
@@ -268,6 +268,23 @@
 	system_printf ("couldn't set initial state for %s, %E", get_name ());
     }
 
+  /* setting rts and dtr to known state so that ioctl() function with
+  request TIOCMGET could return correct value of RTS and DTR lines. 
+  Important only for Win 9x systems */
+  
+  if (wincap.is_winnt() == false)
+  {
+    if (EscapeCommFunction (get_handle (), SETDTR) == 0)
+      system_printf ("couldn't set initial state of DTR for %s, %E", get_name ());
+    if (EscapeCommFunction (get_handle (), SETRTS) == 0)
+      system_printf ("couldn't set initial state of RTS for %s, %E", get_name ());
+      
+    /* even though one of above functions fail I have to set rts and dtr
+    variables to initial value. */
+    rts = TIOCM_RTS;
+    dtr = TIOCM_DTR;
+  }
+  
   SetCommMask (get_handle (), EV_RXCHAR);
   set_open_status ();
   syscall_printf ("%p = fhandler_serial::open (%s, %p, %p)",
@@ -324,7 +341,7 @@
   DWORD win32action = 0;
   DCB dcb;
   char xchar;
-
+      
   termios_printf ("action %d", action);
 
   switch (action)
@@ -358,6 +375,107 @@
   return 0;
 }
 
+
+/* ioctl: */
+int
+fhandler_serial::ioctl (unsigned int cmd, void *buffer)
+{
+
+  DWORD ev;
+  COMSTAT st;
+  DWORD action;
+  DWORD modemLines;
+  DWORD mcr;
+  DWORD cbReturned;
+  bool result;
+  int modemStatus;
+  int request;
+  
+  request = *(int *) buffer;
+  action = 0;
+  modemStatus = 0;
+  if (!ClearCommError (get_handle (), &ev, &st))
+    return -1;
+  switch (cmd)
+    {
+    case TIOCMGET:
+      if (GetCommModemStatus (get_handle (), &modemLines) == 0)
+        return -1;
+      if (modemLines & MS_CTS_ON)
+        modemStatus |= TIOCM_CTS;
+      if (modemLines & MS_DSR_ON)
+        modemStatus |= TIOCM_DSR;
+      if (modemLines & MS_RING_ON)
+        modemStatus |= TIOCM_RI;
+      if (modemLines & MS_RLSD_ON)
+        modemStatus |= TIOCM_CD;
+      if (wincap.is_winnt() == true)
+        {
+	
+	  /* here is Windows NT or Windows 2000 part */
+	  result = DeviceIoControl (get_handle (),
+                                    0x001B0078,
+				    NULL, 0, &mcr, 4, &cbReturned, 0);
+          if (!result)
+	    return -1;
+          if (cbReturned != 4)
+	    return -1;
+          if (mcr & 2)
+	    modemStatus |= TIOCM_RTS;
+          if (mcr & 1)
+	    modemStatus |= TIOCM_DTR;
+	    
+	}
+      else
+        {
+	
+	  /* here is Windows 9x part */
+	  modemStatus |= rts | dtr;
+	  
+	}
+      *(int *) buffer = modemStatus;
+      return 0;
+    case TIOCMSET:
+      if (request & TIOCM_RTS)
+        {
+	  if (EscapeCommFunction (get_handle (), SETRTS) == 0)
+	    return -1;
+          else
+	    rts = TIOCM_RTS;
+	}
+      else
+        {
+	  if (EscapeCommFunction (get_handle (), CLRRTS) == 0)
+	    return -1;
+          else
+	    rts = 0;
+	}
+      if (request & TIOCM_DTR)
+        {
+	  if (EscapeCommFunction (get_handle (), SETDTR) == 0)
+	    return -1;
+          else
+	    dtr = TIOCM_DTR;
+	}
+      else
+        {
+	  if (EscapeCommFunction (get_handle (), CLRDTR) == 0)
+	    return -1;
+          else
+	    dtr = 0;
+	}
+      return 0;
+   case TIOCINQ:
+     if (ev & CE_FRAME | ev & CE_IOE | ev & CE_OVERRUN |
+         ev & CE_RXOVER | ev & CE_RXPARITY)
+       return -1;
+     *(int *) buffer = st.cbInQue;
+     return 0;
+   default:
+     return -1;
+   }
+}    
+
 /* tcflush: POSIX 7.2.2.1 */
 int
 fhandler_serial::tcflush (int queue)
@@ -365,7 +483,7 @@
   if (queue == TCOFLUSH || queue == TCIOFLUSH)
     PurgeComm (get_handle (), PURGE_TXABORT | PURGE_TXCLEAR);
 
-  if (queue == TCIFLUSH | queue == TCIOFLUSH)
+  if (queue == TCIFLUSH || queue == TCIOFLUSH)
     /* Input flushing by polling until nothing turns up
        (we stop after 1000 chars anyway) */
     for (int max = 1000; max > 0; max--)
@@ -395,6 +513,8 @@
   COMMTIMEOUTS to;
   DCB ostate, state;
   unsigned int ovtime = vtime_, ovmin = vmin_;
+  int tmpDtr, tmpRts;
+  tmpDtr = tmpRts = 0;
 
   termios_printf ("action %d", action);
   if ((action == TCSADRAIN) || (action == TCSAFLUSH))
@@ -560,6 +680,7 @@
     {							/* disable */
       state.fRtsControl = RTS_CONTROL_ENABLE;
       state.fOutxCtsFlow = FALSE;
+      tmpRts = TIOCM_RTS;
     }
 
   if (t->c_cflag & CRTSXOFF)
@@ -592,7 +713,10 @@
   set_w_binary ((t->c_oflag & ONLCR) ? 0 : 1);
 
   if (dropDTR == TRUE)
-    EscapeCommFunction (get_handle (), CLRDTR);
+    {
+      EscapeCommFunction (get_handle (), CLRDTR);
+      tmpDtr = 0;
+    }
   else
     {
       /* FIXME: Sometimes when CLRDTR is set, setting
@@ -601,7 +725,11 @@
       parameters while DTR is still down. */
 
       EscapeCommFunction (get_handle (), SETDTR);
+      tmpDtr = TIOCM_DTR;
     }
+    
+  rts = tmpRts;
+  dtr = tmpDtr;
 
   /*
   The following documentation on was taken from "Linux Serial Programming
--- include/sys/termios.h	2002-07-14 12:45:24.000000000 +0200
+++ /home/Administrator/prace/serial_patch/latest/termios.h	2002-07-13 16:24:53.000000000 +0200
@@ -13,6 +13,26 @@
 #ifndef	_SYS_TERMIOS_H
 #define _SYS_TERMIOS_H
 
+#define	TIOCMGET	0x5415
+#define	TIOCMSET	0x5418
+#define	TIOCINQ		0x541B	
+
+/* TIOCINQ is utilized instead of FIONREAD which has been
+accupied for other purposes under CYGWIN.
+Other UNIX ioctl requests has been omited because
+effects of their work one can achive by standard
+POSIX commands */
+
+
+#define	TIOCM_DTR	0x002
+#define	TIOCM_RTS	0x004
+#define	TIOCM_CTS	0x020
+#define	TIOCM_CAR	0x040
+#define	TIOCM_RNG	0x080
+#define	TIOCM_DSR	0x100
+#define	TIOCM_CD	TIOCM_CAR
+#define	TIOCM_RI	TIOCM_RNG
+
 #define TCOOFF		0
 #define TCOON		1
 #define TCIOFF		2

--------------050B889197A68679690CAE68
Content-Type: text/plain; charset=us-ascii;
 name="serial.patch.ChangeLog"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="serial.patch.ChangeLog"
Content-length: 663

13 July 2002 Jacek Trzcinski <jacek@certum.pl>

    * fhandler.h (class fhandler_serial): Add new members of 
    the class - rts,dtr and method ioctl(). Variables rts and dtr
    important for Win 9x only.
    * fhandler_serial.cc (fhandler_serial::open): Add initial setting
    of dtr and rts. Important for Win 9x only.
    (fhandler_serial::ioctl): New function. Implements commands TIOCMGET,
    TIOCMSET and TIOCINQ.
    (fhandler_serial::tcflush): Fixed found error.
    (fhandler_serial::tcsetattr): Add settings of rts and dtr. Important
    for Win 9x only. 
    * termios.h: Add new defines as a support for ioctl() function
    on serial device.
    
--------------050B889197A68679690CAE68--
