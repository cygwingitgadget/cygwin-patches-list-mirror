Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 0077D4BA2E1C; Mon, 15 Dec 2025 21:29:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0077D4BA2E1C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1765834158;
	bh=f4yXzDwVgZ600zIOKwtTlF7gW6sfJf900DlCE6lzywQ=;
	h=From:To:Subject:Date:From;
	b=ExHnotbX8qfLMHvQ2BVy/JWZjh2+zOyI3IZBFOLHnn+ZfA1mdooCcXOZqUFaA/PM4
	 PKwnfLCXZlsRhpMbuF3UXAqC41QKMHhAWWW4BAKjb7PgcMjUxEcptTlhSL+/DVNhag
	 NCBt/613UvLyzR+nT8b3HKojCOgcAelfIfhkCzz0=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 27452A80CB0; Mon, 15 Dec 2025 22:29:16 +0100 (CET)
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: uinfo: fix overriding group from SAM comment on domain machines
Date: Mon, 15 Dec 2025 22:29:16 +0100
Message-ID: <20251215212916.741883-1-corinna-cygwin@cygwin.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cygwin-patches.cygwin.com>

From: Corinna Vinschen <corinna@vinschen.de>

When overriding the primary group of a local SAM account via comment
entry (e.g. '<cygwin group="some_group"/>') on a domain member machine,
we're prepending the local account domain to the group name before
fetching the group entry for that group.  While this is necessary to
fetch real local groups, it disallows to fetch aliases or builtin accounts.

If the group prepended with the local account domain doesn't fetch a
valid group, try again with the naked group name, to allow aliases or
builtin accounts as primary group.

Fixes: cc332c9e271b ("* uinfo.cc [...] (pwdgrp::fetch_account_from_windows): Drop outdated comment.  Fix code fetching primary group gid of group setting in SAM description field.")
Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
---
 winsup/cygwin/uinfo.cc | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/uinfo.cc b/winsup/cygwin/uinfo.cc
index fb4618b8a19e..1eb52f14578c 100644
--- a/winsup/cygwin/uinfo.cc
+++ b/winsup/cygwin/uinfo.cc
@@ -2563,7 +2563,11 @@ pwdgrp::fetch_account_from_windows (fetch_user_arg_t &arg, cyg_ldap *pldap)
 	      if (pgrp)
 		{
 		  /* Set primary group from the "Description" field.  Prepend
-		     account domain if this is a domain member machine. */
+		     account domain if this is a domain member machine.  Do
+		     this first, to find a local group even if a domain
+		     group with this name exists.  Only if that doesn't
+		     result in a valid group, try the group name without prefix
+		     to catch builtin and alias groups. */
 		  char gname[2 * DNLEN + strlen (pgrp) + 1], *gp = gname;
 		  struct group *gr;
 
@@ -2575,7 +2579,9 @@ pwdgrp::fetch_account_from_windows (fetch_user_arg_t &arg, cyg_ldap *pldap)
 		      *gp++ = NSS_SEPARATOR_CHAR;
 		    }
 		  stpcpy (gp, pgrp);
-		  if ((gr = internal_getgrnam (gname, cldap)))
+		  if ((gr = internal_getgrnam (gname, cldap)) ||
+		      (cygheap->dom.member_machine ()
+		       && (gr = internal_getgrnam (pgrp, cldap))))
 		    gid = gr->gr_gid;
 		}
 	      char *e;
-- 
2.52.0

