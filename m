Return-Path: <cygwin-patches-return-2150-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 19144 invoked by alias); 4 May 2002 13:10:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19128 invoked from network); 4 May 2002 13:10:22 -0000
X-WM-Posted-At: avacado.atomice.net; Sat, 4 May 02 14:13:16 +0100
Message-ID: <00c801c1f36d$73d55470$0100a8c0@advent02>
From: "Chris January" <chris@atomice.net>
To: <cygwin-patches@cygwin.com>
References: <011901c1f2fb$1fbf5330$0100a8c0@advent02> <20020504042742.GI32261@redhat.com>
Subject: Re: Bug in ln / cygwin1.dll
Date: Sat, 04 May 2002 06:10:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q2/txt/msg00134.txt.bz2

> >When I run 'make -f Makefile.cvs' with QT3, I find that ln segfaults
trying
> >to create a symlink. I've included the output of strace showing the
problem,
> >output of cygcheck and also the stackdump ln produces. I can reproduce
this,
> >so if you need any more information, please ask. The problem occurs with
the
> >latest Cygwin CVS.
> >ln is 'ln (fileutils) 4.1'.
> >cygwin is 'CYGWIN_NT-5.0 ADVENT02 1.3.11(0.52/3/2) 2002-05-03 15:18 i686
> >unknown'
>
> You're using a locally built version of cygwin.  Please run it under gdb
> and pinpoint where the problem is occurring.  You may find the techniques
> in how-to-debug-cygwin.txt useful.

This patch fixes the problem.

--- ChangeLog follows ---
2002-05-24  Christopher January <chris@atomice.net>

 * path.h (path_conv::path_conv): Initialise normalized_path to NULL.
--- path.h.patch follows ---
Index: path.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/path.h,v
retrieving revision 1.39
diff -u -3 -p -u -p -w -r1.39 path.h
--- path.h 3 May 2002 02:43:45 -0000 1.39
+++ path.h 4 May 2002 13:07:33 -0000
@@ -126,7 +126,7 @@ class path_conv
     check (src, opt | PC_NULLEMPTY, suffixes);
   }

-  path_conv (): path_flags (0), known_suffix (NULL), error (0), devn (0),
unit (0), fileattr (INVALID_FILE_ATTRIBUTES) {path[0] = '\0';}
+  path_conv (): path_flags (0), known_suffix (NULL), error (0), devn (0),
unit (0), fileattr (INVALID_FILE_ATTRIBUTES), normalized_path (NULL)
{path[0] = '\0';}

   ~path_conv ();
   inline char *get_win32 () { return path; }

