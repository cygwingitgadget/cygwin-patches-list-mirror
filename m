Return-Path: <SRS0=U53b=TD=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e01.mail.nifty.com (mta-snd-e01.mail.nifty.com [106.153.226.33])
	by sourceware.org (Postfix) with ESMTPS id 1C6293858423
	for <cygwin-patches@cygwin.com>; Tue, 10 Dec 2024 13:46:15 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 1C6293858423
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 1C6293858423
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.33
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1733838376; cv=none;
	b=dF7SIYe/w7B+YuRC/vyJOGOdZcKoDlf9HlRIsheRNeyajBrshh6CB3eJJLs/h1h8DHK5mU+yhwpjbjdIcrgvYWIvE4+ncf9Q5DeJol+puQ9aic4MEwAxJmjC36kM7j6hSvKzJLPQGhKGiY9hBpupjYlNR/je5wiC8M4OFrM0Ntk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1733838376; c=relaxed/simple;
	bh=wiNTqr3DKOLxtiNl3czkqE0k8CNBQMo+idK+QFRj7oI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=dgsojmO5Kpd2f6fBFF16TAiqkGVDkcw5pkdONPP6T+evLovcsrLlAJ8dTNIlkzkm1e+xIEdD86Y+OlktRXGVxd9XCVl3AcC2mV27H4WPWe97BKO2GZLhI/6J//jyIKwp8aaHk5pw9Q09uoB+sI8DqeppDxu94gT5fzOhXpVelP4=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 1C6293858423
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=G2ud2k1i
Received: from localhost.localdomain by mta-snd-e01.mail.nifty.com
          with ESMTP
          id <20241210134614392.TKWU.9629.localhost.localdomain@nifty.com>;
          Tue, 10 Dec 2024 22:46:14 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Corinna Vinschen <corinna@vinschen.de>
Subject: [PATCH v3] Cygwin: access: Correction for samba/SMB share
Date: Tue, 10 Dec 2024 22:45:49 +0900
Message-ID: <20241210134559.640-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1733838374;
 bh=gDsNITi5yhKlDC69R68sf4w5Fgso9kKyyyQ4yydJeio=;
 h=From:To:Cc:Subject:Date;
 b=G2ud2k1iEL8h4aAY1QcSOKY1AeAbKA+Xibsg1rEoo86tv6b6QAWZAqL2WCTVlN0F6ga4Rtmq
 3+vD7jnkW2WO7GWXuvwHJS8L6nMLrCez8lUW1qqvGJiB0n82RUHWXhhTQTg0Px+llA4jDGGIb9
 W0Ax0kYguSkVxKDWWA3/4W0gX0KM5fM8DNBZpKDnJyNrcNI4B/RUZ/+lT80y3v/y5A+Qv8FaTL
 iZIWFANm/AD/ZI03R4EalPxXUU1pmrbMR5XFlJX7u45O22+RFXlMpapeoL+ro5zDOxPEwlMRII
 iADeL9VdLetuNe6uQz/i1zf0HY16GdO5yNc4NJsUEVIgd6NA==
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Previously, access() and eaccess() does not determine the permissions
for files on samba/SMB share correctly. Even if the user logs-in as
the owner of the file, access() and eaccess() referes to others'
permissions. With this patch, to determine the permissions correctly,
NtOpenFile() with desired access mask is used.

Fixes: cf762b08cfb0 ("* security.cc (check_file_access): Create.")
Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/sec/base.cc | 119 +++++++-------------------------------
 1 file changed, 20 insertions(+), 99 deletions(-)

diff --git a/winsup/cygwin/sec/base.cc b/winsup/cygwin/sec/base.cc
index d5e39d281..bc3f6ae3a 100644
--- a/winsup/cygwin/sec/base.cc
+++ b/winsup/cygwin/sec/base.cc
@@ -28,10 +28,6 @@ details. */
 				  | GROUP_SECURITY_INFORMATION \
 				  | OWNER_SECURITY_INFORMATION)
 
-static GENERIC_MAPPING NO_COPY_RO file_mapping = { FILE_GENERIC_READ,
-						   FILE_GENERIC_WRITE,
-						   FILE_GENERIC_EXECUTE,
-						   FILE_ALL_ACCESS };
 LONG
 get_file_sd (HANDLE fh, path_conv &pc, security_descriptor &sd,
 	     bool justcreated)
@@ -608,99 +604,9 @@ check_access (security_descriptor &sd, GENERIC_MAPPING &mapping,
   return ret;
 }
 
-/* Samba override.  Check security descriptor for Samba UNIX user and group
-   accounts and check if we have an RFC 2307 mapping to a Windows account.
-   Create a new security descriptor with all of the UNIX accounts with
-   valid mapping replaced with their Windows counterpart. */
-static void
-convert_samba_sd (security_descriptor &sd_ret)
-{
-  NTSTATUS status;
-  BOOLEAN dummy;
-  PSID sid;
-  cygsid owner;
-  cygsid group;
-  SECURITY_DESCRIPTOR sd;
-  cyg_ldap cldap;
-  tmp_pathbuf tp;
-  PACL acl, oacl;
-  size_t acl_len;
-  PACCESS_ALLOWED_ACE ace;
-
-  if (!NT_SUCCESS (RtlGetOwnerSecurityDescriptor (sd_ret, &sid, &dummy)))
-    return;
-  owner = sid;
-  if (!NT_SUCCESS (RtlGetGroupSecurityDescriptor (sd_ret, &sid, &dummy)))
-    return;
-  group = sid;
-
-  if (sid_id_auth (owner) == 22)
-    {
-      struct passwd *pwd;
-      uid_t uid = owner.get_uid (&cldap);
-      if (uid < UNIX_POSIX_OFFSET && (pwd = internal_getpwuid (uid)))
-	owner.getfrompw (pwd);
-    }
-  if (sid_id_auth (group) == 22)
-    {
-      struct group *grp;
-      gid_t gid = group.get_gid (&cldap);
-      if (gid < UNIX_POSIX_OFFSET && (grp = internal_getgrgid (gid)))
-	group.getfromgr (grp);
-    }
-
-  if (!NT_SUCCESS (RtlGetDaclSecurityDescriptor (sd_ret, &dummy,
-						 &oacl, &dummy)))
-    return;
-  acl = (PACL) tp.w_get ();
-  RtlCreateAcl (acl, ACL_MAXIMUM_SIZE, ACL_REVISION);
-  acl_len = sizeof (ACL);
-
-  for (DWORD i = 0; i < oacl->AceCount; ++i)
-    if (NT_SUCCESS (RtlGetAce (oacl, i, (PVOID *) &ace)))
-      {
-	cygsid ace_sid ((PSID) &ace->SidStart);
-	if (sid_id_auth (ace_sid) == 22)
-	  {
-	    if (sid_sub_auth (ace_sid, 0) == 1) /* user */
-	      {
-		struct passwd *pwd;
-		uid_t uid = ace_sid.get_uid (&cldap);
-		if (uid < UNIX_POSIX_OFFSET && (pwd = internal_getpwuid (uid)))
-		  ace_sid.getfrompw (pwd);
-	      }
-	    else if (sid_sub_auth (ace_sid, 0) == 2) /* group */
-	      {
-		struct group *grp;
-		gid_t gid = ace_sid.get_gid (&cldap);
-		if (gid < UNIX_POSIX_OFFSET && (grp = internal_getgrgid (gid)))
-		  ace_sid.getfromgr (grp);
-	      }
-	  }
-	if (!add_access_allowed_ace (acl, ace->Mask, ace_sid, acl_len,
-				     ace->Header.AceFlags))
-	  return;
-      }
-  acl->AclSize = acl_len;
-
-  RtlCreateSecurityDescriptor (&sd, SECURITY_DESCRIPTOR_REVISION);
-  RtlSetControlSecurityDescriptor (&sd, SE_DACL_PROTECTED, SE_DACL_PROTECTED);
-  RtlSetOwnerSecurityDescriptor (&sd, owner, FALSE);
-  RtlSetGroupSecurityDescriptor (&sd, group, FALSE);
-
-  status = RtlSetDaclSecurityDescriptor (&sd, TRUE, acl, FALSE);
-  if (!NT_SUCCESS (status))
-    return;
-  DWORD sd_size = 0;
-  status = RtlAbsoluteToSelfRelativeSD (&sd, sd_ret, &sd_size);
-  if (sd_size > 0 && sd_ret.malloc (sd_size))
-    RtlAbsoluteToSelfRelativeSD (&sd, sd_ret, &sd_size);
-}
-
 int
 check_file_access (path_conv &pc, int flags, bool effective)
 {
-  security_descriptor sd;
   int ret = -1;
   ACCESS_MASK desired = 0;
   if (flags & R_OK)
@@ -709,13 +615,28 @@ check_file_access (path_conv &pc, int flags, bool effective)
     desired |= FILE_WRITE_DATA;
   if (flags & X_OK)
     desired |= FILE_EXECUTE;
-  if (!get_file_sd (pc.handle (), pc, sd, false))
+
+  if (!effective)
+    cygheap->user.deimpersonate ();
+
+  OBJECT_ATTRIBUTES attr;
+  pc.init_reopen_attr (attr, pc.handle ());
+  NTSTATUS status;
+  IO_STATUS_BLOCK io;
+  HANDLE h;
+  status = NtOpenFile (&h, desired, &attr, &io, FILE_SHARE_VALID_FLAGS,
+		       FILE_OPEN_FOR_BACKUP_INTENT);
+  if (NT_SUCCESS (status))
     {
-      /* Tweak Samba security descriptor as necessary. */
-      if (pc.fs_is_samba ())
-	convert_samba_sd (sd);
-      ret = check_access (sd, file_mapping, desired, flags, effective);
+      NtClose (h);
+      ret = 0;
     }
+  else
+    __seterrno_from_nt_status (status);
+
+  if (!effective)
+    cygheap->user.reimpersonate ();
+
   debug_printf ("flags %y, ret %d", flags, ret);
   return ret;
 }
-- 
2.45.1

