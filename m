Return-Path: <cygwin-patches-return-6032-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7408 invoked by alias); 9 Feb 2007 02:19:31 -0000
Received: (qmail 7398 invoked by uid 22791); 9 Feb 2007 02:19:29 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-68-163-198-143.bos.east.verizon.net (HELO pool-68-163-198-143.bos.east.verizon.net) (68.163.198.143)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 09 Feb 2007 02:19:25 +0000
Received: from [192.168.1.10] (helo=Compaq) 	by phumblet.no-ip.org with smtp (Exim 4.65) 	(envelope-from <pierre@phumblet.no-ip.org>) 	id JD6BSA-0002I0-OA 	for cygwin-patches@cygwin.com; Thu, 08 Feb 2007 21:19:23 -0500
Message-Id: <3.0.1.32.20070208211922.00b9b408@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
X-Mailer: Windows Eudora Pro Version 3.0.1 (32)
Date: Fri, 09 Feb 2007 02:19:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: [Patch] libc/minires-os-if.c
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q1/txt/msg00013.txt.bz2

This brings libc/minires up to minires 1.02, 
but using the recently updated w32api/include/windns.h.

Pierre


2007-02-08  Pierre A. Humblet  <Pierre.Humblet@ieee.org>

        * libc/minires-os-if.c (write_record): Handle DNS_TYPE_SRV and
	some obsolete types.


Index: minires-os-if.c
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/libc/minires-os-if.c,v
retrieving revision 1.2
diff -u -p -r1.2 minires-os-if.c
--- minires-os-if.c     15 Dec 2006 09:50:32 -0000      1.2
+++ minires-os-if.c     9 Feb 2007 02:01:20 -0000
@@ -120,10 +120,13 @@ static u_char * write_record(unsigned ch
     }
     break;
   case DNS_TYPE_MINFO:
+  case DNS_TYPE_RP:
     PUTDOMAIN(rr->Data.MINFO.pNameMailbox, ptr);
     PUTDOMAIN(rr->Data.MINFO.pNameErrorsMailbox, ptr);
     break;
   case DNS_TYPE_MX:
+  case DNS_TYPE_AFSDB:
+  case DNS_TYPE_RT:
     if (ptr + 2 > EndPtr)
       ptr += 2;
     else
@@ -131,7 +134,9 @@ static u_char * write_record(unsigned ch
     PUTDOMAIN(rr->Data.MX.pNameExchange, ptr);
     break;
   case DNS_TYPE_HINFO:
-  case DNS_TYPE_TEXT: 
+  case DNS_TYPE_ISDN:
+  case DNS_TYPE_TEXT:
+  case DNS_TYPE_X25: 
   {
     unsigned int i, len;
     for (i = 0; i < rr->Data.TXT.dwStringCount; i++) {
@@ -146,6 +151,16 @@ static u_char * write_record(unsigned ch
     }
     break;
   }
+  case DNS_TYPE_SRV:
+    if (ptr + 6 > EndPtr)
+      ptr += 6;
+    else {
+      PUTSHORT(rr->Data.SRV.wPriority, ptr);
+      PUTSHORT(rr->Data.SRV.wWeight, ptr);
+      PUTSHORT(rr->Data.SRV.wPort, ptr);
+    }
+    PUTDOMAIN(rr->Data.SRV.pNameTarget, ptr);
+    break;
   default:
   {
     unsigned int len = rr->wDataLength;
