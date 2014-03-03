Return-Path: <cygwin-patches-return-7973-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6346 invoked by alias); 3 Mar 2014 19:32:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 6271 invoked by uid 89); 3 Mar 2014 19:32:06 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.0 required=5.0 tests=AWL,BAYES_00,KAM_STOCKGEN,RCVD_IN_DNSWL_NONE autolearn=no version=3.3.2
X-HELO: mho-02-ewr.mailhop.org
Received: from mho-02-ewr.mailhop.org (HELO mho-02-ewr.mailhop.org) (204.13.248.72) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-SHA encrypted) ESMTPS; Mon, 03 Mar 2014 19:32:05 +0000
Received: from pool-173-76-43-57.bstnma.fios.verizon.net ([173.76.43.57] helo=cgf.cx)	by mho-02-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf-use-the-mailinglist-please@cygwin.com>)	id 1WKYap-000O10-KO	for cygwin-patches@cygwin.com; Mon, 03 Mar 2014 19:32:03 +0000
Received: from ednor (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with SMTP id 08DFB60121	for <cygwin-patches@cygwin.com>; Mon,  3 Mar 2014 14:32:02 -0500 (EST)
Received: by ednor (sSMTP sendmail emulation); Mon, 03 Mar 2014 14:32:01 -0500
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/sendlabs/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX18fNImgjHxHNG7V1bSthkzL
Date: Mon, 03 Mar 2014 19:32:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix errno codes set by opendir() in case of problems with the path argument
Message-ID: <20140303193201.GA914@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <5314CB53.4070300@oktetlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5314CB53.4070300@oktetlabs.ru>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SW-Source: 2014-q1/txt/msg00046.txt.bz2

On Mon, Mar 03, 2014 at 10:34:59PM +0400, Oleg Kravtsov wrote:
>Currently cygwin has a problem with errno code set by opendir() 
>function. It always sets errno to ENOENT.
>After applying the path opendir() sets errno to 'ENAMETOOLONG' when path 
>or a path component is too long,
>'ELOOP' when a loop of symbolic links exits in the path.
>
>Best regards,
>Oleg
>
>2014-02-18  Oleg Kravtsov <Oleg.Kravtsov@oktetlabs.ru>
>
>        * dir.cc (opendir): Set errno code depending on the type of an error
>        instead of always setting it to ENOENT.

Thanks for the patch but I don't see any reason for a goto here.  Also
you seem to be skipping over a free which could result in a memory leak.

I think the below should do the same thing without those limitations.

Does it work for you?

cgf

Index: dir.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/dir.cc,v
retrieving revision 1.136
diff -d -u -p -r1.136 dir.cc
--- dir.cc	31 Jan 2014 19:27:26 -0000	1.136
+++ dir.cc	3 Mar 2014 19:31:30 -0000
@@ -58,6 +58,11 @@ opendir (const char *name)
   fh = build_fh_name (name, PC_SYM_FOLLOW);
   if (!fh)
     res = NULL;
+  else if (fh->error ())
+    {
+      set_errno (fh->error ());
+      res = NULL;
+    }
   else if (fh->exists ())
     res = fh->opendir (-1);
   else
