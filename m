Return-Path: <cygwin-patches-return-2636-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 17946 invoked by alias); 12 Jul 2002 07:36:26 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17921 invoked from network); 12 Jul 2002 07:36:25 -0000
Message-ID: <3D2E872F.476FBDEC@certum.pl>
Date: Fri, 12 Jul 2002 00:36:00 -0000
From: Jacek Trzcinski <jacek@certum.pl>
Reply-To: jacek@certum.pl
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Assignment received from Jacek Trzcinski
References: <20020711170416.GA29920@redhat.com>
Content-Type: multipart/mixed;
 boundary="------------C2552F7731614DDAB4EB0B4C"
X-SW-Source: 2002-q3/txt/msg00084.txt.bz2

This is a multi-part message in MIME format.
--------------C2552F7731614DDAB4EB0B4C
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-length: 850

Hello Chris,
as I understood You , for now I do not have to check and correct my
patch sources whether they are in accordance to latest cvs source
because You will do it. So I send my patch as it was created last year.
I guess You let me know if something is wrong .

Best regards
Jacek

Christopher Faylor wrote:
> 
> We've received a Cygwin assignment from Jacek Trzcinski.
> 
> So, patch away Jacek!
> 
> Please resubmit, to cygwin-patches, any patches you may have previously
> submitted.  If your patch is against the current cvs source we will
> review it ASAP.  If it isn't, it will take a little longer...
> 
> cgf
> 
> --
> Unsubscribe info:      http://cygwin.com/ml/#unsubscribe-simple
> Bug reporting:         http://cygwin.com/bugs.html
> Documentation:         http://cygwin.com/docs.html
> FAQ:                   http://cygwin.com/faq/
--------------C2552F7731614DDAB4EB0B4C
Content-Type: text/plain; charset=us-ascii;
 name="serial.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="serial.patch"
Content-length: 5616

--- fhandler_serial.old.cc	Tue Apr 24 03:19:15 2001
+++ fhandler_serial.cc	Wed May 23 11:03:56 2001
@@ -32,6 +32,8 @@ fhandler_serial::fhandler_serial (const 
   vtime_ = 0;
   pgrp_ = myself->pgid;
   set_need_fork_fixup ();
+  dtr = 0;
+  rts = 0;
 }
 
 void
@@ -275,7 +277,8 @@ fhandler_serial::open (const char *name,
       if (!SetCommState (get_handle (), &state))
 	system_printf ("couldn't set initial state for %s, %E", get_name ());
     }
-
+  rts = TIOCM_RTS;
+  dtr = TIOCM_DTR;
   SetCommMask (get_handle (), EV_RXCHAR);
   set_open_status ();
   syscall_printf ("%p = fhandler_serial::open (%s, %p, %p)",
@@ -366,6 +369,106 @@ fhandler_serial::tcflow (int action)
   return 0;
 }
 
+
+/* ioctl: */
+int
+fhandler_serial::ioctl (unsigned int cmd,void * buffer)
+{
+ 
+  DWORD ev;
+  COMSTAT st;
+  DWORD action;
+  DWORD modemLines;
+  DWORD mcr;
+  DWORD cbReturned;
+  bool  result;
+  int   modemStatus;
+  int request;
+
+  request = *(int*)buffer;
+  action = 0;
+  modemStatus = 0;
+  if (!ClearCommError (get_handle (), &ev, &st))
+    return -1;
+  switch (cmd)
+    {
+    case TIOCMGET:
+      if (GetCommModemStatus (get_handle (), &modemLines) == 0)
+	return -1;
+      if (modemLines & MS_CTS_ON)
+	modemStatus |= TIOCM_CTS;
+      if (modemLines & MS_DSR_ON)
+	modemStatus |= TIOCM_DSR;
+      if (modemLines & MS_RING_ON)
+	modemStatus |= TIOCM_RNG | TIOCM_RI;
+      if (modemLines & MS_RLSD_ON)
+	modemStatus |= TIOCM_CAR | TIOCM_CD;
+      if (os_being_run == winNT)
+	{
+	  /* here is Windows NT or Windows 2000 part */
+	  result = DeviceIoControl (get_handle (),
+				    0x001B0078,
+				    NULL, 0, &mcr, 4, &cbReturned, 0);
+	  if (!result)
+	    return -1;
+	  if (cbReturned != 4)
+	    return -1;
+	  if (mcr & 2)
+	    modemStatus |= TIOCM_RTS;
+	  if (mcr & 1)
+	    modemStatus |= TIOCM_DTR;
+
+	}
+      else
+	{
+
+	  /* here is Windows 9x part */
+	  modemStatus |= rts | dtr;
+
+	}
+      *(int *) buffer = modemStatus;
+      return 0;
+    case TIOCMSET:
+      if (request & TIOCM_RTS)
+	{
+	  if (EscapeCommFunction (get_handle (), SETRTS) == 0)
+	    return -1;
+	  else
+	    rts = TIOCM_RTS;
+	}
+      else
+	{
+	  if (EscapeCommFunction (get_handle (), CLRRTS) == 0)
+	    return -1;
+	  else
+	    rts = 0;
+	}
+      if (request & TIOCM_DTR)
+	{
+	  if (EscapeCommFunction (get_handle (), SETDTR) == 0)
+	    return -1;
+	  else
+	    dtr = TIOCM_DTR;
+	}
+      else
+	{
+	  if (EscapeCommFunction (get_handle (), CLRDTR) == 0)
+	    return -1;
+	  else
+	    dtr = 0;
+	}
+      return 0;
+    case TIOCINQ:
+      if (ev & CE_FRAME | ev & CE_IOE | ev & CE_OVERRUN |
+	  ev & CE_RXOVER | ev & CE_RXPARITY)
+	return -1;
+      *(int *) buffer = st.cbInQue;
+      return 0;
+    default:
+      return -1;
+    }
+}
+
 /* tcflush: POSIX 7.2.2.1 */
 int
 fhandler_serial::tcflush (int queue)
@@ -373,7 +476,7 @@ fhandler_serial::tcflush (int queue)
   if (queue == TCOFLUSH || queue == TCIOFLUSH)
     PurgeComm (get_handle (), PURGE_TXABORT | PURGE_TXCLEAR);
 
-  if (queue == TCIFLUSH | queue == TCIOFLUSH)
+  if (queue == TCIFLUSH || queue == TCIOFLUSH)
     /* Input flushing by polling until nothing turns up
        (we stop after 1000 chars anyway) */
     for (int max = 1000; max > 0; max--)
@@ -404,6 +507,8 @@ fhandler_serial::tcsetattr (int action, 
   COMMTIMEOUTS to;
   DCB ostate, state;
   unsigned int ovtime = vtime_, ovmin = vmin_;
+  int tmpDtr,tmpRts;
+  tmpDtr = tmpRts = 0;
 
   termios_printf ("action %d", action);
   if ((action == TCSADRAIN) || (action == TCSAFLUSH))
@@ -569,6 +674,7 @@ fhandler_serial::tcsetattr (int action, 
     {							/* disable */
       state.fRtsControl = RTS_CONTROL_ENABLE;
       state.fOutxCtsFlow = FALSE;
+      tmpRts = TIOCM_RTS;
     }
 
   if (t->c_cflag & CRTSXOFF)
@@ -601,7 +707,10 @@ fhandler_serial::tcsetattr (int action, 
   set_w_binary ((t->c_oflag & ONLCR) ? 0 : 1);
 
   if (dropDTR == TRUE)
+  {
     EscapeCommFunction (get_handle (), CLRDTR);
+    tmpDtr = 0;
+  }
   else
     {
       /* FIXME: Sometimes when CLRDTR is set, setting
@@ -610,7 +719,11 @@ fhandler_serial::tcsetattr (int action, 
       parameters while DTR is still down. */
 
       EscapeCommFunction (get_handle (), SETDTR);
+      tmpDtr = TIOCM_DTR;
     }
+    
+  rts = tmpRts;
+  dtr = tmpDtr;
 
   /*
   The following documentation on was taken from "Linux Serial Programming
--- fhandler.old.h	Tue Apr 24 03:19:14 2001
+++ fhandler.h	Wed May 23 10:38:00 2001
@@ -529,6 +529,8 @@ private:
   unsigned int vmin_;			/* from termios */
   unsigned int vtime_;			/* from termios */
   pid_t pgrp_;
+  int	rts;				/* for Windows 9x purposes only */
+  int	dtr;				/* for Windows 9x purposes only */
 
 public:
   int overlapped_armed;
@@ -547,6 +549,7 @@ public:
   int tcsendbreak (int);
   int tcdrain ();
   int tcflow (int);
+  int ioctl (unsigned int cmd, void *);
   int tcsetattr (int a, const struct termios *t);
   int tcgetattr (struct termios *t);
   off_t lseek (off_t, int) { return 0; }
--- ./include/sys/termios.old.h	Sun Mar 25 21:09:52 2001
+++ ./include/sys/termios.h	Wed May 23 11:15:38 2001
@@ -13,6 +13,19 @@ details. */
 #ifndef	_SYS_TERMIOS_H
 #define _SYS_TERMIOS_H
 
+#define TIOCMGET        0x5415
+#define TIOCMSET        0x5418
+#define TIOCINQ         0x541B
+
+#define TIOCM_DTR       0x002
+#define TIOCM_RTS       0x004
+#define TIOCM_CTS       0x020
+#define TIOCM_CAR       0x040
+#define TIOCM_RNG       0x080
+#define TIOCM_DSR       0x100
+#define TIOCM_CD        TIOCM_CAR
+#define TIOCM_RI        TIOCM_RNG
+
 #define TCOOFF		0
 #define TCOON		1
 #define TCIOFF		2

--------------C2552F7731614DDAB4EB0B4C
Content-Type: text/plain; charset=us-ascii;
 name="serial.patch.ChangeLog"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="serial.patch.ChangeLog"
Content-length: 612

23 May 2001 Jacek Trzcinski <jacek@certum.pl>

    * cygwin/fhandler.h: new members of fhandler_serial class - rts,
    dtr and method ioctl()
    * cygwin/fhandler_serial.cc: implementation of ioctl method from
    fhandler_serial class. It supports three commands - TIOCMGET,TIOCMSET
    and TIOCINQ. Changes made in other methods of the class caused either
    by found error (in method tcflush) or by necessity implementation of
    TIOCMGET(for RTS and DTR signal) in Windows 9x environment.
    * cygwin/include/sys/termios.h: new constants added to support
    ioctl method from class fhandler_serial
    
--------------C2552F7731614DDAB4EB0B4C--
