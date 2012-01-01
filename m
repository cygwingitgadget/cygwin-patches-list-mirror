Return-Path: <cygwin-patches-return-7578-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2169 invoked by alias); 1 Jan 2012 06:46:48 -0000
Received: (qmail 2157 invoked by uid 22791); 1 Jan 2012 06:46:46 -0000
X-SWARE-Spam-Status: No, hits=-1.8 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,TW_TW
X-Spam-Check-By: sourceware.org
Received: from mho-02-ewr.mailhop.org (HELO mho-02-ewr.mailhop.org) (204.13.248.72)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 01 Jan 2012 06:46:32 +0000
Received: from pool-173-76-50-112.bstnma.fios.verizon.net ([173.76.50.112] helo=cgf.cx)	by mho-02-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf@cgf.cx>)	id 1RhFBf-000Fe5-Fo	for cygwin-patches@cygwin.com; Sun, 01 Jan 2012 06:46:31 +0000
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id D4B1D13C0CD	for <cygwin-patches@cygwin.com>; Sun,  1 Jan 2012 01:46:30 -0500 (EST)
X-Mail-Handler: MailHop Outbound by DynDNS
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/mailhop/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX1/S7gYHbgiW5OKiTaIC4NQB
Date: Sun, 01 Jan 2012 06:46:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add get_current_dir_name(3)
Message-ID: <20120101064630.GB3446@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1325385907.4064.7.camel@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1325385907.4064.7.camel@YAAKOV04>
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
X-SW-Source: 2012-q1/txt/msg00001.txt.bz2

On Sat, Dec 31, 2011 at 08:45:07PM -0600, Yaakov (Cygwin/X) wrote:
>This patchset adds get_current_dir_name(3), a GNU extension:
>[snip]
>diff -u -p -r1.644 path.cc
>--- path.cc	24 Dec 2011 13:11:34 -0000	1.644
>+++ path.cc	27 Dec 2011 11:28:06 -0000
>@@ -2855,6 +2855,27 @@ getwd (char *buf)
>   return getcwd (buf, PATH_MAX + 1);  /*Per SuSv3!*/
> }
> 
>+extern "C" char *
>+get_current_dir_name (void)
>+{
>+  char *pwd = getenv ("PWD");
>+  char *cwd = getcwd (NULL, 0);
>+
>+  if (pwd)
>+    {
>+      struct __stat64 pwdbuf, cwdbuf;
>+      stat64 (pwd, &pwdbuf);
>+      stat64 (cwd, &cwdbuf);
>+      if (pwdbuf.st_ino == cwdbuf.st_ino)

You have to check st_dev here too don't you?

cgf
