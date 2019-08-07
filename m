Return-Path: <cygwin-patches-return-9549-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19810 invoked by alias); 7 Aug 2019 08:51:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 19801 invoked by uid 89); 7 Aug 2019 08:51:39 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-18.1 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.1 spammy=H*r:smtp, HContent-Transfer-Encoding:8bit
X-HELO: atfriesa01.ssi-schaefer.com
Received: from atfriesa01.ssi-schaefer.com (HELO atfriesa01.ssi-schaefer.com) (193.186.16.100) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 07 Aug 2019 08:51:38 +0000
Received: from samail03.wamas.com (HELO mailhost.salomon.at) ([172.28.33.235])  by atfriesa01.ssi-schaefer.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Aug 2019 10:51:36 +0200
Received: from fril0049.wamas.com ([172.28.42.244] helo=wamas.com)	by mailhost.salomon.at with smtp (Exim 4.77)	(envelope-from <haubi@wamas.com>)	id 1hvHfT-0000TY-9H; Wed, 07 Aug 2019 10:51:35 +0200
Received: with nullmailer 2.2;	Wed, 07 Aug 2019 08:51:35 -0000
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
To: cygwin-patches@cygwin.com
Cc: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Subject: [PATCH] Cygwin: build_env: fix off-by-one bug when re-adding PATH
Date: Wed, 07 Aug 2019 08:51:00 -0000
Message-Id: <20190807085116.7985-1-michael.haubenwallner@ssi-schaefer.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SW-Source: 2019-q3/txt/msg00069.txt.bz2

Adding default winvar 'PATH=C:\cygwin64\binZ' to an environment that is
already allocated for 'SYSTEMROOT=ZWINDIR=Z', we need to count that
trailing (Z)ero as well.  Otherwise we trigger this assertion failure:

$ /bin/env -i SYSTEMROOT= WINDIR= /bin/env
assertion "(s - envblock) <= tl" failed: file "/home/corinna/src/cygwin/cygwin-3.0.7/cygwin-3.0.7-1.x86_64/src/newlib-cygwin/winsup/cygwin/environ.cc", line 1302, function: char** build_env(const char* const*, WCHAR*&, int&, bool, HANDLE)
Aborted (core dumped)
---
 winsup/cygwin/environ.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/cygwin/environ.cc b/winsup/cygwin/environ.cc
index 124842734..8fa01b2d5 100644
--- a/winsup/cygwin/environ.cc
+++ b/winsup/cygwin/environ.cc
@@ -1295,7 +1295,7 @@ build_env (const char * const *envp, PWCHAR &envblock, int &envc,
 	 during execve. */
       if (!saw_PATH)
 	{
-	  new_tl += cygheap->installation_dir.Length / sizeof (WCHAR) + 5;
+	  new_tl += cygheap->installation_dir.Length / sizeof (WCHAR) + 5 + 1;
 	  if (new_tl > tl)
 	    tl = raise_envblock (new_tl, envblock, s);
 	  s = wcpcpy (wcpcpy (s, L"PATH="),
-- 
2.21.0
