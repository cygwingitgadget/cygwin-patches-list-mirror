Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 4AE534CCCA0F; Fri,  5 Dec 2025 16:38:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4AE534CCCA0F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1764952738;
	bh=gEMBTTWM5jzZjNvH6Q0VJ9nlP/OtysgH3Z12F71UpCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VNeWuIDlRysnGL0kYT5xbNy2EqrbIDqKKBwsZjtQDtLZNaVI3YyD4woogXr2lMeX7
	 jScAbVJ9nzwRmARbuDT1q8wl7N1uatOEyIgBJlM219Z+QfuS/y7sCXVhxs4Be0pgE1
	 1I5RBR0tXnkYak1cfSE9c+s6YXDigt095iugeDaQ=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 45DD7A80F16; Fri, 05 Dec 2025 17:38:56 +0100 (CET)
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Cc: Marco Atzeri <marco.atzeri@gmail.com>
Subject: [PATCH 2/3] Cygwin: uinfo: allow to override user account as primary group
Date: Fri,  5 Dec 2025 17:38:55 +0100
Message-ID: <20251205163856.3993550-3-corinna-cygwin@cygwin.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251205163856.3993550-1-corinna-cygwin@cygwin.com>
References: <20251205163856.3993550-1-corinna-cygwin@cygwin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cygwin-patches.cygwin.com>

From: Corinna Vinschen <corinna@vinschen.de>

Do not only allow to override the (localized) group "None" as
primary group, but also the user account.  This occurs if the
user account is a Microsoft Account or a AzureAD account.

Fixes: dc7b67316d01 ("Cygwin: uinfo: prefer token primary group")
Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
---
 winsup/cygwin/uinfo.cc | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/uinfo.cc b/winsup/cygwin/uinfo.cc
index 8e9b9e07de9d..fb4618b8a19e 100644
--- a/winsup/cygwin/uinfo.cc
+++ b/winsup/cygwin/uinfo.cc
@@ -170,13 +170,17 @@ internal_getlogin (cygheap_user &user)
 	 group of a local user ("None", localized), we have to find the SID
 	 of that group and try to override the token primary group.  Also
 	 makes sure we're not on a domain controller, where account_sid ()
-	 == primary_sid (). */
+	 == primary_sid ().
+	 CV 2025-12-05: Microsoft Accounts as well as AzureAD accounts have
+	 the primary group SID in their user token set to their own user SID.
+	 Allow to override them as well. */
       gsid = cygheap->dom.account_sid ();
       gsid.append (DOMAIN_GROUP_RID_USERS);
       if (!pgrp
 	  || (pwd->pw_gid != pgrp->gr_gid
 	      && cygheap->dom.account_sid () != cygheap->dom.primary_sid ()
-	      && RtlEqualSid (gsid, user.groups.pgsid)))
+	      && (gsid == user.groups.pgsid
+		  || user.sid () == user.groups.pgsid)))
 	{
 	  if (gsid.getfromgr (grp = internal_getgrgid (pwd->pw_gid, &cldap)))
 	    {
-- 
2.51.1

