Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 40AEF4BA2E1C; Thu, 18 Dec 2025 11:23:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 40AEF4BA2E1C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1766056990;
	bh=AI04pbtLyjpoyEs4N6KdZuEXeclRJ2CuntFlmSLt8OU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=xnu3rWk/BxyKe8/JlvGSaFMvaNMgw3u4b7dZVQvZzSIAP2fSt1Q0PEw6OoRs9QzGc
	 HA+BA45ZYKuZQidFflWPz23epDfyccfqPuYzDr9ivNFCGkUk6mwtFE0usupsttmKQ+
	 YSoQ0EH8iqw/t9ecmr9UKMswCkLW9bRYHSjltuhc=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 4DE9AA80D54; Thu, 18 Dec 2025 12:23:08 +0100 (CET)
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2 3/4] Cygwin: uinfo: fix overriding group from SAM comment on AD member machines
Date: Thu, 18 Dec 2025 12:23:07 +0100
Message-ID: <20251218112308.1004395-4-corinna-cygwin@cygwin.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251218112308.1004395-1-corinna-cygwin@cygwin.com>
References: <20251218112308.1004395-1-corinna-cygwin@cygwin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cygwin-patches.cygwin.com>

From: Corinna Vinschen <corinna@vinschen.de>

When overriding the (localized) primary group "None" of a local SAM
account via SAM comment entry (e.g. '<cygwin group="some_group"/>') on a
Active Directory domain member machine, we have to take into account,
that the local account domain (actually the machine name) is always
prepended to local account names, i. e.

  MACHINE+account

because the names without prepended domain are reserved for the
primary AD domain accounts.

Therefore commit cc332c9e271b added code to prepend the local account
domain to the group name from the SAM comment, if the machine is a
domain member.

But here's the problem:

If the group in the SAM comment entry is a real local group, prepending
the local account domain is all nice and dandy.  But if the account used
in the SAM comment is a builtin like "Authenticated Users" (S-1-5-11) or
an alias like "Users" (S-1-5-32-545), this falls flat.

This patch keeps the check for "MACHINE+account" first.  This avoids
fetching the AD group rather than the local SAM group, if a local
group has the same name as an AD group.

But now, if the group prepended with the local account domain doesn't
result in a valid group entry, try again with the naked group name, to
allow aliases or builtin accounts to pass as primary group.

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

