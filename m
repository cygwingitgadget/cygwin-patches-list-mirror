Return-Path: <cygwin-patches-return-1941-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 12816 invoked by alias); 4 Mar 2002 05:18:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 12782 invoked from network); 4 Mar 2002 05:18:02 -0000
Message-ID: <007401c1c33c$3bc49e80$cf823bd5@dmitry>
From: "Dmitry Timoshkov" <dmitry@baikal.ru>
To: <cygwin-patches@cygwin.com>
Subject: [PATCH] Use ftruncate64 directly to not lose upper 32 bits
Date: Mon, 04 Mar 2002 08:48:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0063_01C1C37D.F52B2BA0"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
X-SW-Source: 2002-q1/txt/msg00298.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_0063_01C1C37D.F52B2BA0
Content-Type: text/plain;
	charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-length: 151

Hello.

2002-03-04  Dmitry Timoshkov  <dmitry@baikal.ru>

* syscalls.cc (truncate64): Use ftruncate64 directly to not lose upper 32 bits.

-- 
Dmitry.

------=_NextPart_000_0063_01C1C37D.F52B2BA0
Content-Type: application/octet-stream;
	name="syscalls.cc.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="syscalls.cc.diff"
Content-length: 391

--- src/winsup/cygwin/syscalls.cc	Fri Mar 01 08:13:42 2002
+++ src/winsup/cygwin/syscalls.cc	Mon Mar 04 04:59:26 2002
@@ -1720,7 +1720,7 @@ truncate64 (const char *pathname, __off6
     set_errno (EBADF);
   else
     {
-      res = ftruncate (fd, length);
+      res = ftruncate64 (fd, length);
       close (fd);
     }
   syscall_printf ("%d = truncate (%s, %d)", res, pathname, length);

------=_NextPart_000_0063_01C1C37D.F52B2BA0--
