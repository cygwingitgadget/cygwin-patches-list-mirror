Return-Path: <cygwin-patches-return-8245-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7816 invoked by alias); 23 Sep 2015 15:20:28 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 7796 invoked by uid 89); 23 Sep 2015 15:20:28 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=0.8 required=5.0 tests=BAYES_50,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.2
X-HELO: forward20p.cmail.yandex.net
Received: from forward20p.cmail.yandex.net (HELO forward20p.cmail.yandex.net) (77.88.31.15) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Wed, 23 Sep 2015 15:20:26 +0000
Received: from web4g.yandex.ru (web4g.yandex.ru [IPv6:2a02:6b8:0:1402::14])	by forward20p.cmail.yandex.net (Yandex) with ESMTP id 51AAA20C41	for <cygwin-patches@cygwin.com>; Wed, 23 Sep 2015 18:20:21 +0300 (MSK)
Received: from 127.0.0.1 (localhost [127.0.0.1])	by web4g.yandex.ru (Yandex) with ESMTP id EFD5F3800D02;	Wed, 23 Sep 2015 18:20:20 +0300 (MSK)
Received: by web4g.yandex.ru with HTTP;	Wed, 23 Sep 2015 18:20:20 +0300
From: Evgeny Grin <k2k@yandex.ru>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Fix compiler errors/warnings when compiling with -O3
MIME-Version: 1.0
Message-Id: <754151443021620@web4g.yandex.ru>
Date: Wed, 23 Sep 2015 15:20:00 -0000
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-IsSubscribed: yes
X-SW-Source: 2015-q3/txt/msg00027.txt.bz2

GCC find more suspicious places with -O3. Cygwin use -Werror so uninitialized variables prevent compilations.
This patch allow compilation with CFLAGS='-O3' CXXFLAGS='-O3'.


---
 winsup/cygwin/fhandler_socket.cc | 4 ++--
 winsup/cygwin/regex/regcomp.c    | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/fhandler_socket.cc b/winsup/cygwin/fhandler_socket.cc
index ecb6198..658dca7 100644
--- a/winsup/cygwin/fhandler_socket.cc
+++ b/winsup/cygwin/fhandler_socket.cc
@@ -746,7 +746,7 @@ fhandler_socket::wait_for_events (const long event_mask, const DWORD flags)
     return 0;
 
   int ret;
-  long events;
+  long events = 0;
 
   while (!(ret = evaluate_events (event_mask, events, !(flags & MSG_PEEK)))
 	 && !events)
@@ -1160,7 +1160,7 @@ int
 fhandler_socket::connect (const struct sockaddr *name, int namelen)
 {
   struct sockaddr_storage sst;
-  int type;
+  int type = 0;
 
   if (get_inet_addr (name, namelen, &sst, &namelen, &type, connect_secret)
       == SOCKET_ERROR)
diff --git a/winsup/cygwin/regex/regcomp.c b/winsup/cygwin/regex/regcomp.c
index d68dcc3..554b43a 100644
--- a/winsup/cygwin/regex/regcomp.c
+++ b/winsup/cygwin/regex/regcomp.c
@@ -1246,7 +1246,7 @@ freeset(struct parse *p, cset *cs)
 static wint_t
 singleton(cset *cs)
 {
-	wint_t i, s, n;
+	wint_t i, s = OUT, n;
 
 	for (i = n = 0; i < NC; i++)
 		if (CHIN(cs, i)) {
-- 
2.5.1.windows.1
