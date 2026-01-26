Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 5EAB24BC8967; Mon, 26 Jan 2026 10:29:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5EAB24BC8967
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1769423383;
	bh=WFakMBTGo7DndpQH7roGUbHfea6rkMxH9kvHIAmovPE=;
	h=From:To:Subject:Date:From;
	b=L6SMQBnA7teab6GAvVw5p4O2TuQ3/oAyrzasUCa4B2pjmzR+Y/5aZJWUv4SePySUn
	 bDU18xEMGeCMjJCG6y2uvF2lEMzRn3C6faFoR90lDnva7BcNfqiebXXIQ+xP5HmhQz
	 1nPtjkf8kmaPzSJHgjW3eyfz3N+KB42o/FrLIhX8=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 765B9A81CEE; Mon, 26 Jan 2026 11:29:41 +0100 (CET)
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: setrlimit: fix comments in terms of input checking
Date: Mon, 26 Jan 2026 11:29:41 +0100
Message-ID: <20260126102941.383039-1-corinna-cygwin@cygwin.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cygwin-patches.cygwin.com>

From: Corinna Vinschen <corinna@vinschen.de>

Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
---
 winsup/cygwin/resource.cc | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/resource.cc b/winsup/cygwin/resource.cc
index 9dfe36b13e36..1e9e91810c8d 100644
--- a/winsup/cygwin/resource.cc
+++ b/winsup/cygwin/resource.cc
@@ -296,24 +296,25 @@ setrlimit (int resource, const struct rlimit *rlp)
 {
   struct rlimit oldlimits;
 
-  /* Check if the request is to actually change the resource settings.
-     If it does not result in a change, take no action and do not fail. */
   if (getrlimit (resource, &oldlimits) < 0)
     return -1;
 
   __try
     {
+      /* Check if the request is to actually change the resource settings.
+	 If it does not result in a change, take no action and do not fail. */
       if (oldlimits.rlim_cur == rlp->rlim_cur &&
 	  oldlimits.rlim_max == rlp->rlim_max)
-	/* No change in resource requirements, succeed immediately */
 	return 0;
 
+      /* soft limit > hard limit ? EINVAL */
       if (rlp->rlim_cur > rlp->rlim_max)
 	{
 	  set_errno (EINVAL);
 	  __leave;
 	}
 
+      /* hard limit > current hard limit ? EPERM if not admin */
       if (rlp->rlim_max > oldlimits.rlim_max
 	  && !check_token_membership (well_known_admins_sid))
 	{
-- 
2.52.0

