Return-Path: <cygwin-patches-return-3191-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18265 invoked by alias); 15 Nov 2002 18:50:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18256 invoked from network); 15 Nov 2002 18:50:22 -0000
Message-ID: <041a01c28cd7$7ffbf070$0201a8c0@sos>
From: "Sergey Okhapkin" <sos@prospect.com.ru>
To: "Cygwin-Patches" <cygwin-patches@cygwin.com>
Subject: select on serial fix
Date: Fri, 15 Nov 2002 10:50:00 -0000
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-Virus-Scanned: by amavisd-milter (http://amavis.org/)
X-SW-Source: 2002-q4/txt/msg00142.txt.bz2

The patch fixes a problem with a characters loss on select on a serial port.
I wonder what PurgeComm() calls in the original code supposed to do...


2002-11-15  Sergey Okhapkin  <sos@prospect.com.ru>

        * select.cc (peek_serial): Don't call PurgeComm() to avoid
characters loss.




Index: select.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/select.cc,v
retrieving revision 1.81
diff -u -p -r1.81 select.cc
--- select.cc   30 Sep 2002 15:17:44 -0000      1.81
+++ select.cc   15 Nov 2002 18:41:10 -0000
@@ -912,19 +912,15 @@ peek_serial (select_record *s, bool)
          return s->read_ready = true;
          select_printf ("got something");
        }
-      PurgeComm (h, PURGE_TXABORT | PURGE_RXABORT);
       break;
     case WAIT_OBJECT_0 + 1:
-      PurgeComm (h, PURGE_TXABORT | PURGE_RXABORT);
       select_printf ("interrupt");
       set_sig_errno (EINTR);
       ready = -1;
       break;
     case WAIT_TIMEOUT:
-      PurgeComm (h, PURGE_TXABORT | PURGE_RXABORT);
       break;
     default:
-      PurgeComm (h, PURGE_TXABORT | PURGE_RXABORT);
       debug_printf ("WaitForMultipleObjects");
       goto err;
     }

Sergey Okhapkin
Somerset, NJ

