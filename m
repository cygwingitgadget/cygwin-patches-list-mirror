Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 31FC84BA2E06; Thu, 18 Dec 2025 11:23:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 31FC84BA2E06
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1766056990;
	bh=n1+M8mPyg8zi1ImD/NJQMPHX8GTvy9pHk71bYA0oHAA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=et1jJCta8H4e/T04ykiPInPV8e0P1wi8U+5iYOpckj8ha+iK0tJiUsUGhOTEfjddw
	 1IcgJo9j1oJEnWaTHc4nPg9z8AGH3fbvJ2kSovvQva/ny3bPTup/6WYe6gyY2NydkC
	 886XhNlBc8ZQ4T/2L+1pnmWutWi4Jea2kv3MAvAo=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 44C98A80350; Thu, 18 Dec 2025 12:23:08 +0100 (CET)
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2 1/4] Cygwin: uinfo: correctly check and override primary group
Date: Thu, 18 Dec 2025 12:23:05 +0100
Message-ID: <20251218112308.1004395-2-corinna-cygwin@cygwin.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251218112308.1004395-1-corinna-cygwin@cygwin.com>
References: <20251218112308.1004395-1-corinna-cygwin@cygwin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cygwin-patches.cygwin.com>

From: Corinna Vinschen <corinna@vinschen.de>

Commit dc7b67316d01 ("Cygwin: uinfo: prefer token primary group")
broke the code overriding the primary group in two different ways:

- It changed the way myself->gid was set before checking its value.

  Prior to dc7b67316d01, myself->gid was always set to the primary group
  from the passwd entry (pw_gid).  With the patch, it was set to the
  primary group from the Windows user token (token_gid) in the first
  place.

  The following condition checking if pw_gid is different
  from token_gid did so, by checking token_gid against myself->gid,
  rather than against pw_gid.  After dc7b67316d01 this was always
  false and the code block overriding the primary group in Cygwin and
  the Windows user token with pw_gid was never called anymore.

  The solution is obvious: Do not check token_gid against myself->gid,
  but against the desires primary GID value in pw_gid instead.

- The code block overriding the primary group simply assumed that
  myself->gid was already set to pw_gid, but, as outlined above,
  this was not true anymore after dc7b67316d01.

  This is a subtil error, because it leads to having the wrong primary
  GID in `id' output, while the primary group SID in the user token was
  correctly set.  But as soon as you run this under strace or GDB, the
  problem disappears, because the second process tree under GDB or
  strace takes over from the already changed user token.

  The solution is to override myself->gid with pw_gid once more, after
  successfully changing the primary GID to pw_gid.

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
2.52.0

