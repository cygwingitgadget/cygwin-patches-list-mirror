Return-Path: <cygwin-patches-return-2064-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 27303 invoked by alias); 15 Apr 2002 20:46:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27257 invoked from network); 15 Apr 2002 20:46:37 -0000
X-WM-Posted-At: avacado.atomice.net; Mon, 15 Apr 02 21:49:18 +0100
Message-ID: <001e01c1e4bf$03130870$0100a8c0@advent02>
From: "Chris January" <chris@atomice.net>
To: <cygwin-patches@cygwin.com>
References: <1653605153.20020415220043@gmx.net>
Subject: Re: [PATCH] cygutils:conv.c: Prevent truncation of file if 0xFF is encountered
Date: Mon, 15 Apr 2002 13:46:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q2/txt/msg00048.txt.bz2

> Hello ;)
> 
> Today a colleague of mine was struck by a bug of dos2unix/unix2dos
> utilities i.e. if the code encounters 0xFF in the file being processed
> it erronously thinks that this is the EOF and stops processing. The
> result is that the original file is truncated to the position of the
> 0xFF character.
> 
> As to why we have such characters in source file - our mother language
> is bulgarian and we sometimes still type comments in it :)
> 
> A patch is attached to fix this behaviour.
Hmm... Try this patch instead:
--- conv.c.bak  Mon Apr 15 21:47:34 2002
+++ conv.c      Mon Apr 15 21:48:03 2002
@@ -324,3 +324,3 @@
 static int convert(const char *fn, int ConvType, char * progname) {
-  char c;
+  int c;
   char *tempFn;

Regards
Chris

