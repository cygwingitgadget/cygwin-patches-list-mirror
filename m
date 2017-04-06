Return-Path: <cygwin-patches-return-8732-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4313 invoked by alias); 6 Apr 2017 06:01:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 122793 invoked by uid 89); 6 Apr 2017 06:00:52 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-23.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,KAM_LAZY_DOMAIN_SECURITY autolearn=ham version=3.3.2 spammy=H*a:doing, H*a:process, H*a:owned, H*r:8.12.11
X-HELO: m0.truegem.net
Received: from m0.truegem.net (HELO m0.truegem.net) (69.55.228.47) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 06 Apr 2017 06:00:48 +0000
Received: from localhost (mark@localhost)	by m0.truegem.net (8.12.11/8.12.11) with ESMTP id v3660mHX075783	for <cygwin-patches@cygwin.com>; Wed, 5 Apr 2017 23:00:48 -0700 (PDT)	(envelope-from mark@maxrnd.com)
Date: Thu, 06 Apr 2017 06:01:00 -0000
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Subject: Remove "function" from line to avoid dash objecting to this bash-ism
Message-ID: <Pine.BSF.4.63.1704052252100.72447@m0.truegem.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-IsSubscribed: yes
X-SW-Source: 2017-q2/txt/msg00003.txt.bz2

I've been home-building the last few versions of Cygwin DLL on Windows 
where I routinely have dash set as my non-interactive shell.  The only 
issue I run into is this one occurrence of the 'function' keyword in 
winsup/cygwin/mkvers.sh.  This patch gets rid of the keyword.

FWIW using dash instead of bash has the build running 5%-10% faster.
Cheers,

..mark

From fb9db7a75c7e391f451cb1df3c1e8463ef4c7bf3 Mon Sep 17 00:00:00 2001
From: Mark Geisert <mark@maxrnd.com>
Date: Wed, 5 Apr 2017 22:20:09 -0700
Subject: [PATCH] Remove "function" from line to avoid dash objecting to 
this bash-ism.

---
  winsup/cygwin/mkvers.sh | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/cygwin/mkvers.sh b/winsup/cygwin/mkvers.sh
index 7e763e0..5aecb14 100755
--- a/winsup/cygwin/mkvers.sh
+++ b/winsup/cygwin/mkvers.sh
@@ -34,7 +34,7 @@ done
    echo "**** Couldn't open file '$incfile'.  Aborting."
  }

-function parse_preproc_flags() {
+parse_preproc_flags() {
    # Since we're manually specifying the preprocessor, pass the default 
flags
    # normally defined.
    ccflags="--preprocessor=$1 --preprocessor-arg=-E \
--
2.8.3
