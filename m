Return-Path: <cygwin-patches-return-3115-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 9990 invoked by alias); 5 Nov 2002 00:20:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9981 invoked from network); 5 Nov 2002 00:20:02 -0000
Message-ID: <001c01c28460$ca1e5eb0$0201a8c0@sos>
From: "Sergey Okhapkin" <sos@prospect.com.ru>
To: "Cygwin-Patches" <cygwin-patches@cygwin.com>
Subject: ioctl.cc fix
Date: Mon, 04 Nov 2002 16:20:00 -0000
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-Virus-Scanned: by amavisd-milter (http://amavis.org/)
X-SW-Source: 2002-q4/txt/msg00066.txt.bz2

I see no output from "debug_printf ("returning %d", res);" in trace file
without this fix... gcc bug?

2002-11-04  Sergey Okhapkin  <sos@prospect.com.ru>

        * ioctl.cc (ioctl): Add default case.


Index: ioctl.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/ioctl.cc,v
retrieving revision 1.18
diff -u -p -r1.18 ioctl.cc
--- ioctl.cc    4 Nov 2002 04:09:14 -0000       1.18
+++ ioctl.cc    5 Nov 2002 00:14:48 -0000
@@ -50,6 +50,8 @@ ioctl (int fd, int cmd, ...)
          return tcsetattr (fd, TCSADRAIN, (struct termios *) argp);
        case TCSETAF:
          return tcsetattr (fd, TCSAFLUSH, (struct termios *) argp);
+       default:
+         break;
       }

   int res = cfd->ioctl (cmd, argp);

Sergey Okhapkin
Somerset, NJ

