Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 4E3BA4BA2E1D; Thu, 18 Dec 2025 11:23:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4E3BA4BA2E1D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1766056990;
	bh=lyi+WPj9jGfEYecSninZ+xYmuKrZKbYlTFVNqxw0AKI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=KVIWZXXU0RQjwM6eMt6BlgBfbJZxM6GkK0jtfUxtvxQkvN6RkHyotRWG7ea01X20w
	 A34ifFQXFlfFkq4FdmnM2pj9JsTMn9kMyWaa5PCnarhnagqL7vivzOotJXngXd/x/x
	 tKJyca2/ILS0UdkTP7wUaTojeWSqgxmtlfujzlzU=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 47BE5A80CB0; Thu, 18 Dec 2025 12:23:08 +0100 (CET)
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2 2/4] Cygwin: uinfo: allow to override user account as primary group
Date: Thu, 18 Dec 2025 12:23:06 +0100
Message-ID: <20251218112308.1004395-3-corinna-cygwin@cygwin.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251218112308.1004395-1-corinna-cygwin@cygwin.com>
References: <20251218112308.1004395-1-corinna-cygwin@cygwin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cygwin-patches.cygwin.com>

From: Corinna Vinschen <corinna@vinschen.de>

Do not only allow to override the (localized) group "None" as primary
group, but also the user account.  The user account is used as primary
group in the user token, if the user account is a Microsoft Account or
an AzureAD account.

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
2.52.0

