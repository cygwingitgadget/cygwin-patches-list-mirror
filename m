Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 2EFA94A9E047; Fri,  5 Dec 2025 16:38:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2EFA94A9E047
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1764952738;
	bh=EHMozwJxF0SL3wDh8GH3RVQ4ZN0kH9dP4MaYEesQ/1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=myHptVjvT0NMZDsYiCxKqR+hkXIGuT14UmQEygqMgknJP81aPuO6TH324wmClL/HT
	 Pteb5oLqNKJJRNfN9WKma178AZeVsGeUjm3BB2hS6N47MGRz0tQjiluCP9w+7bvmPc
	 oRE9+539RLpSNg/NTod8uDGhMgIlLVFhbaChiQ2s=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 439F9A8048C; Fri, 05 Dec 2025 17:38:56 +0100 (CET)
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Cc: Marco Atzeri <marco.atzeri@gmail.com>
Subject: [PATCH 1/3] Cygwin: uinfo: correctly check and override primary group
Date: Fri,  5 Dec 2025 17:38:54 +0100
Message-ID: <20251205163856.3993550-2-corinna-cygwin@cygwin.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251205163856.3993550-1-corinna-cygwin@cygwin.com>
References: <20251205163856.3993550-1-corinna-cygwin@cygwin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cygwin-patches.cygwin.com>

From: Corinna Vinschen <corinna@vinschen.de>

Commit dc7b67316d01 ("Cygwin: uinfo: prefer token primary group")
broke the code overriding the primary group twofold.

First, it invalidated one of the conditions used to check if the
override is supposed to happen.  Do not check against myself->gid,
but against the desires primary GID value instead.

Second, the followup code expected myself->gid to be set correctly
to the desired primary GID already, but it wasn't anymore.  This is
a subtil error, because it leads to having the wrong primary GID in
`id' output, while the primary group SID in the user token was
correctly set.  But as soon as you run this under strace or GDB,
the problem disappears, because the second process tree under GDB
or strace takes over from the already changed user token.  Override
myself->gid once again after successfully changing the primary GID.

Fixes: dc7b67316d01 ("Cygwin: uinfo: prefer token primary group")
Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
---
 winsup/cygwin/uinfo.cc | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/uinfo.cc b/winsup/cygwin/uinfo.cc
index ffe71ee0726c..8e9b9e07de9d 100644
--- a/winsup/cygwin/uinfo.cc
+++ b/winsup/cygwin/uinfo.cc
@@ -174,7 +174,7 @@ internal_getlogin (cygheap_user &user)
       gsid = cygheap->dom.account_sid ();
       gsid.append (DOMAIN_GROUP_RID_USERS);
       if (!pgrp
-	  || (myself->gid != pgrp->gr_gid
+	  || (pwd->pw_gid != pgrp->gr_gid
 	      && cygheap->dom.account_sid () != cygheap->dom.primary_sid ()
 	      && RtlEqualSid (gsid, user.groups.pgsid)))
 	{
@@ -209,7 +209,10 @@ internal_getlogin (cygheap_user &user)
 			myself->gid = pwd->pw_gid = pgrp->gr_gid;
 		    }
 		  else
-		    user.groups.pgsid = gsid;
+		    {
+		      user.groups.pgsid = gsid;
+		      myself->gid = pwd->pw_gid;
+		    }
 		  clear_procimptoken ();
 		}
 	    }
-- 
2.51.1

