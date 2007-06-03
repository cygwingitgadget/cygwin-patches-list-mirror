Return-Path: <cygwin-patches-return-6111-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27168 invoked by alias); 3 Jun 2007 16:09:16 -0000
Received: (qmail 27155 invoked by uid 22791); 3 Jun 2007 16:09:15 -0000
X-Spam-Check-By: sourceware.org
Received: from mailout04.sul.t-online.com (HELO mailout04.sul.t-online.com) (194.25.134.18)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sun, 03 Jun 2007 16:09:13 +0000
Received: from fwd35.aul.t-online.de  	by mailout04.sul.t-online.com with smtp  	id 1Husdi-0005CS-00; Sun, 03 Jun 2007 18:09:10 +0200
Received: from [10.3.2.2] (EfT00UZeYek55O9NKeCRXINJuklS0vXtdCjgD3zl5XCsOTSu1LI-Qi@[217.235.234.52]) by fwd35.sul.t-online.de 	with esmtp id 1HusdW-0N1yyW0; Sun, 3 Jun 2007 18:08:58 +0200
Message-ID: <4662E7A0.3060605@t-online.de>
Date: Sun, 03 Jun 2007 16:09:00 -0000
From: Christian Franke <Christian.Franke@t-online.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.2pre) Gecko/20070111 SeaMonkey/1.1
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: Re: [Patch] "strace ./app.exe" probably runs application from /bin
References: <466183F3.5020900@t-online.de> <20070602154156.GA19696@ednor.casa.cgf.cx> <466196BE.30700@t-online.de>
In-Reply-To: <466196BE.30700@t-online.de>
Content-Type: multipart/mixed;  boundary="------------080900090103060806030703"
X-ID: EfT00UZeYek55O9NKeCRXINJuklS0vXtdCjgD3zl5XCsOTSu1LI-Qi
X-TOI-MSGID: 2439b72f-4971-4f0e-b06e-e073733a56de
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q2/txt/msg00057.txt.bz2

This is a multi-part message in MIME format.
--------------080900090103060806030703
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 552

cygcheck is also affected by the same issue like strace:

$ cd /tmp

$ cygcheck ./ls
C:\cygwin\bin\ls.exe
...

$ cygcheck ././ls
ls - cannot open.


The attached patch fixes this for strace and cygcheck.
It does not fix the cygcheck issue reported by Brian.

All other calls to path.cc:cygpath() use absolute path names.
So it should not break anything to keep a leading "./".

2007-06-03  Christian Franke <franke@computer.org>

	* path.cc (cygpath): Don't remove leading "./" to avoid
	invalid application search in strace and cygcheck.


Christian


--------------080900090103060806030703
Content-Type: text/plain;
 name="cygwin-1.5.24-2-path.patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygwin-1.5.24-2-path.patch.txt"
Content-length: 470

--- cygwin-1.5.24-2.orig/winsup/utils/path.cc	2005-04-29 18:39:34.001000000 +0200
+++ cygwin-1.5.24-2/winsup/utils/path.cc	2007-06-03 15:40:56.093750000 +0200
@@ -278,8 +278,6 @@ cygpath (const char *s, ...)
     read_mounts ();
   va_start (v, s);
   char *path = vconcat (s, v);
-  if (strncmp (path, "./", 2) == 0)
-    memmove (path, path + 2, strlen (path + 2) + 1);
   if (strncmp (path, "/./", 3) == 0)
     memmove (path + 1, path + 3, strlen (path + 3) + 1);
 

--------------080900090103060806030703--
