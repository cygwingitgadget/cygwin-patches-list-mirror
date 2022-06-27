Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
 by sourceware.org (Postfix) with ESMTPS id 261353858002
 for <cygwin-patches@cygwin.com>; Mon, 27 Jun 2022 12:45:04 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 261353858002
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak044095.dynamic.ppp.asahi-net.or.jp
 [119.150.44.95]) (authenticated)
 by conuserg-10.nifty.com with ESMTP id 25RCiblq003794;
 Mon, 27 Jun 2022 21:44:41 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 25RCiblq003794
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1656333881;
 bh=ds2aKhPyiURm+yMLqrX1+p7gU8WTAJF2iFZRsj+Iuk4=;
 h=From:To:Cc:Subject:Date:From;
 b=ULMICrMHMUiWHxZLKRfl56HyCMf9qM1RMrXrmZ7r3f613t1Emx6JbIAQb2Fvo88dJ
 8NLWMxAxBwmK+Bz8ULe+D8nMfdjuCEmjao+K+8/REkrukZ+M5m6CL7NLPeX3i+IEf6
 c/FDeahmwkdAONBjWyZC5sxaVDpLWawk5d4jB5cQzgLAOVf3vqHJroclxbDz/oaA0R
 g7YSMe3gq+l8ljQQ/S9CrEwzgV3AMyN4yZlzPNRV5cdeW0fHh6acV5mD6hYcKrk+AP
 9udQ6mO/R3/YQBDG1IGbPsU20A4TTlEYbe/UP6hIJ+FROu8aMNsJsYf1QTP3e2OK4l
 exh+RDi/4schA==
X-Nifty-SrcIP: [119.150.44.95]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: spawn: Treat empty path as the current directory.
Date: Mon, 27 Jun 2022 21:44:27 +0900
Message-Id: <20220627124427.184-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Mon, 27 Jun 2022 12:45:08 -0000

- With this patch, the empty path (empty element in PATH or PATH is
  absent) is treated as the current directory as Linux does.
Addresses: https://cygwin.com/pipermail/cygwin/2022-June/251730.html
---
 winsup/cygwin/release/3.3.6 |  4 ++++
 winsup/cygwin/spawn.cc      | 13 +++++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/release/3.3.6 b/winsup/cygwin/release/3.3.6
index f1a4b7812..ad4069568 100644
--- a/winsup/cygwin/release/3.3.6
+++ b/winsup/cygwin/release/3.3.6
@@ -22,3 +22,7 @@ Bug Fixes
   if events are inquired in multiple pollfd entries on the same fd
   at the same time.
   Addresses: https://cygwin.com/pipermail/cygwin/2022-June/251732.html
+
+- Treat an empty path (empty element in PATH or PATH is absent) as
+  the current directory as Linux does.
+  Addresses: https://cygwin.com/pipermail/cygwin/2022-June/251730.html
diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index e0f1247e1..292cd5a42 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -95,6 +95,7 @@ find_exec (const char *name, path_conv& buf, const char *search,
   char *tmp = tp.c_get ();
   bool has_slash = !!strpbrk (name, "/\\");
   int err = 0;
+  bool eopath = false;
 
   debug_printf ("find_exec (%s)", name);
 
@@ -118,8 +119,10 @@ find_exec (const char *name, path_conv& buf, const char *search,
      the name of an environment variable. */
   if (strchr (search, '/'))
     *stpncpy (tmp, search, NT_MAX_PATH - 1) = '\0';
-  else if (has_slash || isdrive (name) || !(path = getenv (search)) || !*path)
+  else if (has_slash || isdrive (name))
     goto errout;
+  else if (!(path = getenv (search)) || !*path)
+    strcpy (tmp, "."); /* Search the current directory when PATH is absent */
   else
     *stpncpy (tmp, path, NT_MAX_PATH - 1) = '\0';
 
@@ -130,11 +133,17 @@ find_exec (const char *name, path_conv& buf, const char *search,
   do
     {
       char *eotmp = strccpy (tmp_path, &path, ':');
+      if (*path)
+	path++;
+      else
+	eopath = true;
       /* An empty path or '.' means the current directory, but we've
 	 already tried that.  */
       if ((opt & FE_CWD) && (tmp_path[0] == '\0'
 			     || (tmp_path[0] == '.' && tmp_path[1] == '\0')))
 	continue;
+      else if (tmp_path[0] == '\0') /* An empty path means the current dir. */
+	eotmp = stpcpy (tmp_path, ".");
 
       *eotmp++ = '/';
       stpcpy (eotmp, name);
@@ -155,7 +164,7 @@ find_exec (const char *name, path_conv& buf, const char *search,
 	}
 
     }
-  while (*path && *++path);
+  while (!eopath);
 
  errout:
   /* Couldn't find anything in the given path.
-- 
2.36.1

