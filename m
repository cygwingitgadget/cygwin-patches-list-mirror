Return-Path: <cygwin-patches-return-6872-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24625 invoked by alias); 16 Dec 2009 15:56:40 -0000
Received: (qmail 24615 invoked by uid 22791); 16 Dec 2009 15:56:39 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-76-42-77.bstnma.fios.verizon.net (HELO cgf.cx) (173.76.42.77)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 16 Dec 2009 15:56:35 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id 8874B3B0002 	for <cygwin-patches@cygwin.com>; Wed, 16 Dec 2009 10:56:25 -0500 (EST)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 3914A2B352; Wed, 16 Dec 2009 10:56:25 -0500 (EST)
Date: Wed, 16 Dec 2009 15:56:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] ps command returns 1 if PID not found
Message-ID: <20091216155624.GA31219@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <b4864b490912082352s369fc0e4me50de3883d782100@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4864b490912082352s369fc0e4me50de3883d782100@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q4/txt/msg00203.txt.bz2

On Wed, Dec 09, 2009 at 06:52:14PM +1100, Ryan Dortmans wrote:
>Attached is a small patch for ps to return 1 if the option --process
>is passed and the PID is not found. This is the behaviour in other
>versions of ps.

Sorry but returning 1 doesn't make sense and it isn't the way that linux
works.  It actually returns 0.

I haven't tested this but it seems to do what you want.

cgf

Index: ps.cc
===================================================================
RCS file: /cvs/uberbaum/winsup/utils/ps.cc,v
retrieving revision 1.26
diff -d -u -r1.26 ps.cc
--- ps.cc	11 May 2009 14:01:17 -0000	1.26
+++ ps.cc	16 Dec 2009 15:56:20 -0000
@@ -258,6 +258,7 @@
 {
   external_pinfo *p;
   int aflag, lflag, fflag, sflag, uid, proc_id;
+  bool found_proc_id = true;
   cygwin_getinfo_types query = CW_GETPINFO;
   const char *dtitle = "    PID TTY     STIME COMMAND\n";
   const char *dfmt   = "%7d%4s%10s %s\n";
@@ -299,6 +300,7 @@
       case 'p':
 	proc_id = atoi (optarg);
 	aflag = 1;
+	found_proc_id = false;
 	break;
       case 's':
 	sflag = 1;
@@ -369,6 +371,8 @@
     {
       if ((proc_id > 0) && (p->pid != proc_id))
 	continue;
+      else
+	found_proc_id = true;
 
       if (aflag)
 	/* nothing to do */;
@@ -499,6 +503,5 @@
     }
   (void) cygwin_internal (CW_UNLOCK_PINFO);
 
-  return 0;
+  return found_proc_id ? 0 : 1;
 }
-
