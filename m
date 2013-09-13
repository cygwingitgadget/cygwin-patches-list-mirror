Return-Path: <cygwin-patches-return-7897-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31796 invoked by alias); 13 Sep 2013 18:06:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 31779 invoked by uid 89); 13 Sep 2013 18:06:24 -0000
Received: from mho-03-ewr.mailhop.org (HELO mho-01-ewr.mailhop.org) (204.13.248.66) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-SHA encrypted) ESMTPS; Fri, 13 Sep 2013 18:06:24 +0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=3.6 required=5.0 tests=AWL,BAYES_00,FSL_HELO_NON_FQDN_1,HELO_LOCALHOST,RCVD_IN_PBL,RCVD_IN_RP_RNBL,RCVD_IN_SORBS_DUL,RP_MATCHES_RCVD autolearn=no version=3.3.2
X-HELO: mho-01-ewr.mailhop.org
Received: from pool-173-76-44-83.bstnma.fios.verizon.net ([173.76.44.83] helo=cgf.cx)	by mho-01-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf@cgf.cx>)	id 1VKXl6-000Dj1-6i	for cygwin-patches@cygwin.com; Fri, 13 Sep 2013 18:06:20 +0000
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 8C1456011D	for <cygwin-patches@cygwin.com>; Fri, 13 Sep 2013 14:06:19 -0400 (EDT)
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/sendlabs/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX1/vUaWrp01u8YK+SL/Fh/jA
Date: Fri, 13 Sep 2013 18:06:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygcheck: xz packages
Message-ID: <20130913180619.GB7571@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <52334717.6070803@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52334717.6070803@users.sourceforge.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SW-Source: 2013-q3/txt/msg00004.txt.bz2

On Fri, Sep 13, 2013 at 12:10:47PM -0500, Yaakov (Cygwin/X) wrote:
>cygcheck needs fixing wrt .tar.xz packages; patch attached.

Thanks for noticing this but I think I'd like to see a more general
fix.  In upset, I just completely relaxed the checking of .gz/.bz2/.xz
in favor of just checking for .tar.  So, instead, something like the
below.

I can't confirm right now if this works or not so I won't check it in
until I can.

cgf


Index: dump_setup.cc
===================================================================
RCS file: /cvs/src/src/winsup/utils/dump_setup.cc,v
retrieving revision 1.27
diff -d -u -p -r1.27 dump_setup.cc
--- dump_setup.cc	21 Jan 2013 16:28:27 -0000	1.27
+++ dump_setup.cc	13 Sep 2013 17:51:10 -0000
@@ -41,18 +41,13 @@ typedef struct
 static int
 find_tar_ext (const char *path)
 {
-  char *p = strchr (path, '\0') - 7;
+  char *p = strstr (path, '\0') - 9;
   if (p <= path)
     return 0;
-  if (*p == '.')
-    {
-      if (strcmp (p, ".tar.gz") != 0)
-	return 0;
-    }
-  else if (--p <= path || strcmp (p, ".tar.bz2") != 0)
+  if ((p = strstr (path, ".tar")) != NULL)
+    return p - path;
+  else
     return 0;
-
-  return p - path;
 }
 
 static char *
