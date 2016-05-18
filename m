Return-Path: <cygwin-patches-return-8563-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 110067 invoked by alias); 18 May 2016 23:14:50 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 109916 invoked by uid 89); 18 May 2016 23:14:49 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,SPF_PASS,TVD_RCVD_IP autolearn=ham version=3.3.2 spammy=miscellaneous, Miscellaneous, 1827, HTo:U*cygwin-patches
X-HELO: glup.org
Received: from 216-15-121-172.c3-0.smr-ubr2.sbo-smr.ma.static.cable.rcn.com (HELO glup.org) (216.15.121.172) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-SHA encrypted) ESMTPS; Wed, 18 May 2016 23:14:29 +0000
Received: from minipixel.i.glup.org (unknown [198.206.215.41])	by glup.org (Postfix) with ESMTP id 721CB854D7;	Wed, 18 May 2016 19:14:26 -0400 (EDT)
Authentication-Results: glup.org; dmarc=none header.from=glup.org
Authentication-Results: glup.org; dkim=none (no signature)	header.i=unknown; x-dkim-adsp=fail
From: cgull@glup.org
To: cygwin-patches@cygwin.com
Cc: John Hood <cgull@glup.org>
Subject: [PATCH 4/4] Miscellaneous style cleanup, whitespace only.
Date: Wed, 18 May 2016 23:14:00 -0000
Message-Id: <1463613259-2899-4-git-send-email-cgull@glup.org>
In-Reply-To: <1463613259-2899-1-git-send-email-cgull@glup.org>
References: <1463613259-2899-1-git-send-email-cgull@glup.org>
X-SW-Source: 2016-q2/txt/msg00038.txt.bz2

From: John Hood <cgull@glup.org>

---
 winsup/cygwin/select.cc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
index 9aa2833..b75393e 100644
--- a/winsup/cygwin/select.cc
+++ b/winsup/cygwin/select.cc
@@ -182,7 +182,7 @@ select (int maxfds, fd_set *readfds, fd_set *writefds, fd_set *exceptfds,
       select_printf ("sel.always_ready %d", sel.always_ready);
 
       if (sel.always_ready || us == 0)
-	/* Catch any active fds via sel.poll() below */
+	/* Catch any active fds via sel.poll () below */
 	wait_state = select_stuff::select_ok;
       else
 	/* wait for an fd to become active or time out */
@@ -942,7 +942,7 @@ fhandler_console::select_read (select_stuff *ss)
   s->peek = peek_console;
   s->h = get_handle ();
   s->read_selected = true;
-  s->read_ready = get_readahead_valid();
+  s->read_ready = get_readahead_valid ();
   return s;
 }
 
-- 
2.8.2
