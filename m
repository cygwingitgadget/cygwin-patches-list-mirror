Return-Path: <cygwin-patches-return-7972-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20834 invoked by alias); 3 Mar 2014 18:35:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 20821 invoked by uid 89); 3 Mar 2014 18:35:04 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: Yes, score=5.1 required=5.0 tests=AWL,BAYES_00,KAM_STOCKGEN,RP_MATCHES_RCVD,SPF_PASS autolearn=no version=3.3.2
X-HELO: shelob.oktetlabs.ru
Received: from shelob.oktetlabs.ru (HELO shelob.oktetlabs.ru) (195.131.132.186) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-SHA encrypted) ESMTPS; Mon, 03 Mar 2014 18:35:03 +0000
Received: from [192.168.37.15] (olwe.oktetlabs.ru [192.168.37.15])	(using TLSv1 with cipher AES256-SHA (256/256 bits))	(No client certificate requested)	by shelob.oktetlabs.ru (Postfix) with ESMTPS id 69DA67F4DF	for <cygwin-patches@cygwin.com>; Mon,  3 Mar 2014 22:34:58 +0400 (MSK)
X-DKIM: Sendmail DKIM Filter v2.8.2 shelob.oktetlabs.ru 69DA67F4DF
Authentication-Results: shelob.oktetlabs.ru/69DA67F4DF; dkim=none	(no signature) header.i=unknown; dkim-adsp=none
Message-ID: <5314CB53.4070300@oktetlabs.ru>
Date: Mon, 03 Mar 2014 18:35:00 -0000
From: Oleg Kravtsov <Oleg.Kravtsov@oktetlabs.ru>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20131104 Icedove/17.0.10
MIME-Version: 1.0
To: cygwin-patches <cygwin-patches@cygwin.com>
Subject: [PATCH] Fix errno codes set by opendir() in case of problems with the path argument
Content-Type: multipart/mixed; boundary="------------020208020802000803010407"
X-SW-Source: 2014-q1/txt/msg00045.txt.bz2

This is a multi-part message in MIME format.
--------------020208020802000803010407
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 475

Currently cygwin has a problem with errno code set by opendir() 
function. It always sets errno to ENOENT.
After applying the path opendir() sets errno to 'ENAMETOOLONG' when path 
or a path component is too long,
'ELOOP' when a loop of symbolic links exits in the path.

Best regards,
Oleg

2014-02-18  Oleg Kravtsov <Oleg.Kravtsov@oktetlabs.ru>

        * dir.cc (opendir): Set errno code depending on the type of an error
        instead of always setting it to ENOENT.



--------------020208020802000803010407
Content-Type: text/x-diff;
 name="opendir_errno_fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="opendir_errno_fix.patch"
Content-length: 858

Index: cygwin/dir.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/dir.cc,v
retrieving revision 1.136
diff -u -p -r1.136 dir.cc
--- cygwin/dir.cc	31 Jan 2014 19:27:26 -0000	1.136
+++ cygwin/dir.cc	3 Mar 2014 18:33:55 -0000
@@ -57,7 +57,16 @@ opendir (const char *name)
 
   fh = build_fh_name (name, PC_SYM_FOLLOW);
   if (!fh)
-    res = NULL;
+    {
+      res = NULL;
+      goto done;
+    }
+
+  if (fh->error ())
+    {
+      debug_printf ("got %d error from build_fh_name", fh->error ());
+      set_errno (fh->error ());
+    }
   else if (fh->exists ())
     res = fh->opendir (-1);
   else
@@ -71,6 +80,8 @@ opendir (const char *name)
   /* Applications calling flock(2) on dirfd(fd) need this... */
   if (res && !fh->nohandle ())
     fh->set_unique_id ();
+
+done:
   return res;
 }
 

--------------020208020802000803010407--
