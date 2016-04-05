Return-Path: <cygwin-patches-return-8552-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 119422 invoked by alias); 5 Apr 2016 08:52:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 119391 invoked by uid 89); 5 Apr 2016 08:52:18 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2 spammy=apparent, pressing, freeze, HTo:U*cygwin-patches
X-HELO: mout.gmx.net
Received: from mout.gmx.net (HELO mout.gmx.net) (212.227.17.21) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Tue, 05 Apr 2016 08:52:08 +0000
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx101) with ESMTPSA (Nemesis) id 0MfRnb-1bAeE42CTr-00P6Pg; Tue, 05 Apr 2016 10:52:03 +0200
Date: Tue, 05 Apr 2016 08:52:00 -0000
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: cygwin-patches@cygwin.com
cc: Thomas Wolff <towo@towo.net>
Subject: [PATCH] Be truthful about reporting whether readahead is available
Message-ID: <4b19a1f32862208db6121371bd7ef395f6699535.1459846294.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-UI-Out-Filterresults: notjunk:1;V01:K0:NPiZmABdh/s=:yYZjg/irXeUXr4pMfRfkQp lt38iYPrZh3t+uSZtRLZgsSpNBh8HkMAlYkOWiNbHksW6uEc769AUa8OpMqv609Lg250hwUoV wHPyseUFFyKNRO8EmzNjo1ZW9JVIhhNmR3phx7eyqZldvd8ukXGjqSsas2F7wXMZkPfYV6sTo t7rIUmUIfaybt261CzAJXNKR7tpP5hlZOxIJjs+XxfGlDwWr7IzOUyuU5D/na3NhbZLCMVcfm mElgY7sWCJwhVdhGjX3I/dABpS6dTf3SQb1gL8R4d93OK3pN25m3Vv7qdM0H2sar68Uta6Qxs JOcXPYQ800bMTgZ1LMxQdX5jJpG6hz6A3z0x/QHXVffzSgwKy4pOQg0xXh5bPQG4OEy+J+zxW 333tjPg+J051rhVqCxgUtSiDyGdiYjylziQpvnUwWpjYigA004fHUkIeKk2rJZM70uJLI/dL0 lY3BH1BwHdsQ2od2/Sn95hKE3hnPRu0XJ+wsIAuE4lk+2EiH1XZEmOnyF4DMmEKAWXFv1WLWv Jbz+ckGMvvyDW+0T23HQd65T8xpJxBCbxps1UhJCOwRmv3XawwinaD5hVSMLe+cx4XZIldK9G +kG1gAtIEmBdO8zJjGTN2BDlhlfyoi5r3lXzm4O1S/Ux+QBnwCHaM0q8npjpoorCTrBxysKSj +jzQc94QeMfDR/lc2CVHm2aOP4ldZ3odmGwzbczPNbVpllJ51qozWjYbVKYLzX+mycnZuWY4K 47lgVCQW4vwEKWIJWVdV3INU1CfsXv3RqM2OfHbXL4rVtAE/6O0LWsds4CV9Xds/Pm2y6gcrf D/A2vIq
X-IsSubscribed: yes
X-SW-Source: 2016-q2/txt/msg00027.txt.bz2

In 7346568 (Make requested console reports work, 2016-03-16), code was
introduced to report the current cursor position. It works by using a
pointer that either points to the next byte in the readahead buffer, or
to a NUL byte if the buffer is depleted, or the pointer is NULL.

These conditions are heeded in the fhandler_console::read() method, but
the condition that the pointer can point at the end of the readahead
buffer was not handled properly in the get_cons_readahead_valid()
method.

This poses a problem e.g. in Git for Windows (which uses a slightly
modified MSYS2 runtime which is in turn a slightly modified Cygwin
runtime) when vim queries the cursor position and immediately goes on to
read console input, erroneously thinking that the readahead buffer is
valid when it is already depleted instead. This condition results in an
apparent freeze that can be helped only by pressing keys repeatedly.

The full Git for Windows bug report is here:

	https://github.com/git-for-windows/git/issues/711

Let's just teach the get_cons_readahead_valid() method to handle a
depleted readahead buffer correctly.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 winsup/cygwin/fhandler.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index 4610557..bd1a923 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -1453,7 +1453,8 @@ private:
   bool focus_aware () {return shared_console_info->con.use_focus;}
   bool get_cons_readahead_valid ()
   {
-    return shared_console_info->con.cons_rapoi != NULL;
+    return shared_console_info->con.cons_rapoi != NULL &&
+      *shared_console_info->con.cons_rapoi;
   }
 
   select_record *select_read (select_stuff *);
-- 
2.8.0.windows.1
