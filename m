Return-Path: <cygwin-patches-return-4585-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4648 invoked by alias); 3 Mar 2004 10:57:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4636 invoked from network); 3 Mar 2004 10:57:21 -0000
X-Authentication-Warning: gyre.weather.fi: jaakko owned process doing -bs
Date: Wed, 03 Mar 2004 10:57:00 -0000
From: =?ISO-8859-1?Q?Jaakko_Hyv=E4tti?= <jaakko@hyvatti.iki.fi>
X-X-Sender: jaakko@gyre.weather.fi
To: cygwin-patches@cygwin.com
Subject: Implement TIOCSBRK / TIOCCBRK serial ioctl
Message-ID: <Pine.LNX.4.58.0403031239150.12078@gyre.weather.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2004-q1/txt/msg00075.txt.bz2


Hi!

This implementation is compatible with Linux, BSD and most unixes I know
of.

This ioctl is necessary for devices connected to serial ports that need
the break condition on TxD line to be set permanently on.  This includes
popular electronics hobbyist devices like PIC microcontroller programmer
http://www.iki.fi/hyvatti/pic/picprog.html .

Index: winsup/cygwin/ChangeLog
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/ChangeLog,v
retrieving revision 1.2338
diff -u -r1.2338 ChangeLog
--- winsup/cygwin/ChangeLog	2 Mar 2004 13:07:47 -0000	1.2338
+++ winsup/cygwin/ChangeLog	3 Mar 2004 10:52:02 -0000
@@ -1,3 +1,8 @@
+2004-03-03  Jaakko Hyvatti  <jaakko.hyvatti@iki.fi>
+
+	* fhandler_serial.cc (fhandler_serial::ioctl): Implement TIOCSBRK
+	and TIOCCBRK which set and clear break condition on serial TxD.
+
 2004-03-02  Corinna Vinschen  <corinna@vinschen.de>

 	* fhandler_raw.cc (fhandler_dev_raw::raw_read): When reading with
Index: winsup/cygwin/fhandler_serial.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_serial.cc,v
retrieving revision 1.50
diff -u -r1.50 fhandler_serial.cc
--- winsup/cygwin/fhandler_serial.cc	9 Feb 2004 04:04:23 -0000	1.50
+++ winsup/cygwin/fhandler_serial.cc	3 Mar 2004 10:52:02 -0000
@@ -476,6 +476,20 @@
 	    res = -1;
 	  }
 	break;
+      case TIOCCBRK:
+	if (ClearCommBreak (get_handle ()) == 0)
+	  {
+	    __seterrno ();
+	    res = -1;
+	  }
+	break;
+      case TIOCSBRK:
+	if (SetCommBreak (get_handle ()) == 0)
+	  {
+	    __seterrno ();
+	    res = -1;
+	  }
+	break;
      case TIOCINQ:
        if (ev & CE_FRAME || ev & CE_IOE || ev & CE_OVERRUN || ev & CE_RXOVER
 	   || ev & CE_RXPARITY)
Index: winsup/cygwin/include/sys/termios.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/sys/termios.h,v
retrieving revision 1.8
diff -u -r1.8 termios.h
--- winsup/cygwin/include/sys/termios.h	27 Sep 2003 02:36:50 -0000	1.8
+++ winsup/cygwin/include/sys/termios.h	3 Mar 2004 10:52:02 -0000
@@ -23,6 +23,8 @@
 effects of their work one can achive by standard
 POSIX commands */

+#define TIOCSBRK	0x5427
+#define TIOCCBRK	0x5428

 #define	TIOCM_DTR	0x002
 #define	TIOCM_RTS	0x004


-- 
Jaakko.Hyvatti@iki.fi         http://www.iki.fi/hyvatti/        +358 40 5011222
echo 'movl $36,%eax;int $128;movl $0,%ebx;movl $1,%eax;int $128'|as -o/bin/sync
-- 
Foreca Ltd                                           Jaakko.Hyvatti@foreca.com
Pursimiehenkatu 29-31 B, FIN-00150 Helsinki, Finland     http://www.foreca.com
