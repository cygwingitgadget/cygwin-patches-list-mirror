Return-Path: <cygwin-patches-return-8621-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 76348 invoked by alias); 31 Aug 2016 18:08:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 76333 invoked by uid 89); 31 Aug 2016 18:08:04 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.8 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.2 spammy=Interchange, Hx-languages-length:1103, HTo:U*cygwin-patches
X-HELO: smtp.salomon.at
Received: from smtp.salomon.at (HELO smtp.salomon.at) (193.186.16.13) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 31 Aug 2016 18:07:54 +0000
Received: from samail03.wamas.com ([172.28.33.235] helo=mailhost.salomon.at)	by smtp.salomon.at with esmtps (UNKNOWN:DHE-RSA-AES256-SHA:256)	(Exim 4.80.1)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1bf9vT-0004ea-OE; Wed, 31 Aug 2016 20:07:52 +0200
Received: from [172.28.41.34] (helo=s01en24)	by mailhost.salomon.at with smtp (Exim 4.77)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1bf9vS-0006vz-GJ; Wed, 31 Aug 2016 20:07:51 +0200
Received: by s01en24 (sSMTP sendmail emulation); Wed, 31 Aug 2016 20:07:50 +0200
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
To: cygwin-patches@cygwin.com
Cc: michael.haubenwallner@ssi-schaefer.com
Subject: [PATCH 2/4] dlopen (pathfinder): try each basename per dir
Date: Wed, 31 Aug 2016 18:08:00 -0000
Message-Id: <1472666829-32223-3-git-send-email-michael.haubenwallner@ssi-schaefer.com>
In-Reply-To: <1472666829-32223-1-git-send-email-michael.haubenwallner@ssi-schaefer.com>
References: <1472666829-32223-1-git-send-email-michael.haubenwallner@ssi-schaefer.com>
X-SW-Source: 2016-q3/txt/msg00029.txt.bz2

Rather than searching all search dirs per one basename,
search for all basenames within per one search dir.

pathfinder.h (check_path_access): Interchange dir- and basename-loops.
---
 winsup/cygwin/pathfinder.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/winsup/cygwin/pathfinder.h b/winsup/cygwin/pathfinder.h
index bbba168..c306604 100644
--- a/winsup/cygwin/pathfinder.h
+++ b/winsup/cygwin/pathfinder.h
@@ -182,12 +182,12 @@ public:
 	     basenamelist::member const ** found_basename = NULL)
   {
     char const * critname = criterion.name ();
-    for (basenamelist::iterator name = basenames_.begin ();
-	 name != basenames_.end ();
-	 ++name)
-      for (searchdirlist::iterator dir(searchdirs_.begin ());
-	   dir != searchdirs_.end ();
-	   ++dir)
+    for (searchdirlist::iterator dir(searchdirs_.begin ());
+	 dir != searchdirs_.end ();
+	 ++dir)
+      for (basenamelist::iterator name = basenames_.begin ();
+	   name != basenames_.end ();
+	   ++name)
 	if (criterion.test (dir, name))
 	  {
 	    debug_printf ("(%s), take %s%s", critname,
-- 
2.7.3
