Return-Path: <SRS0=3P/8=VK=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 5F8B53858C66
	for <cygwin-patches@cygwin.com>; Wed, 19 Feb 2025 01:50:52 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5F8B53858C66
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5F8B53858C66
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1739929852; cv=none;
	b=hdBSISEYP7InKbu3jG9AZ7zMtpBvgB8NKC6dwjLojw7ugMeZ3phe4KwPEUMkGpb56fzeKi9iH9+8P9ZKpFxEMJFP95DsaUeq0/IiZIqvoPhKlijlmZ/QrxtEs2FfSVnpD9Gx/TtbB09tEPaTzCiQZyu4ImiuYMHjsKjX5QdigcI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1739929852; c=relaxed/simple;
	bh=mQ9VyPNangegmiQJeygs7p2lRPUB/dj4kNyqxGxczMQ=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=v3EiNi/6JQmU8EdVKivkA92/3WluoMJW/vvL/GrfH25w4GMoF+CM1ZWHMqk2POU3t5Zgw3Q9qTJCpOhCYxB00iQguzk8dSn48zh6d1VFGVilSlOHY/mbd8mpQRQnkyo/MVae/9QgT/76bMg0bM9T0YWW3ZhpsALPzNCOgiTv0Bk=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5F8B53858C66
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=iB5FQSqE
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 2F46445C30
	for <cygwin-patches@cygwin.com>; Tue, 18 Feb 2025 20:50:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:message-id:mime-version:content-type; s=csoft; bh=2GsyU
	zjsc07K6JR4vj7LWjJNl18=; b=iB5FQSqEaxE27QoLCrfvjbB44sHoZ67b1eUIV
	cyLQ+wcjUNxwgj0U2BJ8WsK4V3OhLb2c5XHCkNJ8wY/WAuxe24KdgiyE5Lv8b+y7
	70S0vZ5cPXK88eTqU4FkBbt253puE7aKKQN630Fa8Y+Zr4EnlXvAOQ/qysFJpPrs
	5W+ZjQ=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 0531045BF6
	for <cygwin-patches@cygwin.com>; Tue, 18 Feb 2025 20:50:52 -0500 (EST)
Date: Tue, 18 Feb 2025 17:50:51 -0800 (PST)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [PATCH v2 1/2] Cygwin: include network mounts in
 cygdrive_getmntent.
Message-ID: <2e179a89-ddcf-5f36-dbfb-dba077571a3f@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

After migrating from GetLogicalDrives to Find(First|Next)VolumeW, mapped
network drives no longer showed up in getmntent output.  To fix that,
also iterate GetLogicalDriveStringsW when builing dos_drive_mappings,
and merge with volume mounts (skipping any volume mounts that are just
mounted on the root of a drive, and replacing the dos mounts in the
mapping for a volume which is mounted on both a drive root and a
directory).

Fixes: 04a5b072940cc ("Cygwin: expose all windows volume mount points.")
Addresses: https://cygwin.com/pipermail/cygwin/2025-February/257384.html
Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
---
 winsup/cygwin/mount.cc | 145 ++++++++++++++++++++++++++++++++---------
 1 file changed, 113 insertions(+), 32 deletions(-)

diff --git a/winsup/cygwin/mount.cc b/winsup/cygwin/mount.cc
index b8d8d4a974..ab07c5abef 100644
--- a/winsup/cygwin/mount.cc
+++ b/winsup/cygwin/mount.cc
@@ -1986,6 +1986,40 @@ endmntent (FILE *)
   return 1;
 }

+static bool
+resolve_dos_device (const wchar_t *dosname, wchar_t *devpath)
+{
+  if (QueryDosDeviceW (dosname, devpath, NT_MAX_PATH))
+    {
+      /* The DOS drive mapping can be another symbolic link.  If so,
+	 the mapping won't work since the section name is the name
+	 after resolving all symlinks.  Resolve symlinks here, too. */
+      for (int syml_cnt = 0; syml_cnt < SYMLOOP_MAX; ++syml_cnt)
+	{
+	  UNICODE_STRING upath;
+	  OBJECT_ATTRIBUTES attr;
+	  NTSTATUS status;
+	  HANDLE h;
+
+	  RtlInitUnicodeString (&upath, devpath);
+	  InitializeObjectAttributes (&attr, &upath, OBJ_CASE_INSENSITIVE,
+				      NULL, NULL);
+	  status = NtOpenSymbolicLinkObject (&h, SYMBOLIC_LINK_QUERY, &attr);
+	  if (!NT_SUCCESS (status))
+	    break;
+	  RtlInitEmptyUnicodeString (&upath, devpath, (NT_MAX_PATH - 1)
+						      * sizeof (WCHAR));
+	  status = NtQuerySymbolicLinkObject (h, &upath, NULL);
+	  NtClose (h);
+	  if (!NT_SUCCESS (status))
+	    break;
+	  devpath[upath.Length / sizeof (WCHAR)] = L'\0';
+	}
+      return true;
+    }
+  return false;
+}
+
 dos_drive_mappings::dos_drive_mappings ()
 : mappings(0)
 , cur_mapping(0)
@@ -1995,6 +2029,44 @@ dos_drive_mappings::dos_drive_mappings ()
   wchar_t vol[64]; /* Long enough for Volume GUID string */
   wchar_t *devpath = tp.w_get ();
   wchar_t *mounts = tp.w_get ();
+  mapping **nextm = &mappings;
+  mapping *endfirstloop = NULL;
+  DWORD len;
+
+  /* Iterate over all drive letters, fetch the DOS device path */
+  if (!(len = GetLogicalDriveStringsW (NT_MAX_PATH - 1, mounts)) ||
+      len >= NT_MAX_PATH)
+    debug_printf ("GetLogicalDriveStringsW, %E");
+  else {
+    for (wchar_t *mount = mounts; *mount; mount += len + 2)
+      {
+	len = wcslen (mount);
+	mount[--len] = L'\0'; /* Drop trailing backslash */
+	if (resolve_dos_device (mount, devpath))
+	  {
+	    mapping *m = new mapping ();
+	    if (m)
+	      {
+		m->dos.path = wcsdup (mount);
+		m->ntdevpath = wcsdup (devpath);
+		if (!m->dos.path || !m->ntdevpath)
+		  {
+		    free (m->dos.path);
+		    free (m->ntdevpath);
+		    delete m;
+		    continue;
+		  }
+		m->dos.len = len;
+		m->ntlen = wcslen (m->ntdevpath);
+		*nextm = endfirstloop = m;
+		nextm = &m->next;
+	      }
+	  }
+	else
+	  debug_printf ("Unable to determine the native mapping for %ls "
+			"(error %E)", mount);
+      }
+  }

   /* Iterate over all volumes, fetch the list of DOS paths the volume is
      mounted to. */
@@ -2002,43 +2074,22 @@ dos_drive_mappings::dos_drive_mappings ()
   if (sh == INVALID_HANDLE_VALUE)
     debug_printf ("FindFirstVolumeW, %E");
   else {
-    mapping **nextm = &mappings;
     do
       {
-	/* Skip drives which are not mounted. */
-	DWORD len;
+	/* Skip volumes which are not mounted. */
 	if (!GetVolumePathNamesForVolumeNameW (vol, mounts, NT_MAX_PATH, &len)
 	    || mounts[0] == L'\0')
 	  continue;
+	/* Skip volumes which are only mounted to the root of a drive letter:
+	   they were handled in the loop above */
+	if (len == 5 && mounts[1] == L':' && mounts[2] == L'\\' && !mounts[3])
+	  continue;
+
 	*wcsrchr (vol, L'\\') = L'\0';
-	if (QueryDosDeviceW (vol + 4, devpath, NT_MAX_PATH))
+	if (resolve_dos_device (vol + 4, devpath))
 	  {
-	    /* The DOS drive mapping can be another symbolic link.  If so,
-	       the mapping won't work since the section name is the name
-	       after resolving all symlinks.  Resolve symlinks here, too. */
-	    for (int syml_cnt = 0; syml_cnt < SYMLOOP_MAX; ++syml_cnt)
-	      {
-		UNICODE_STRING upath;
-		OBJECT_ATTRIBUTES attr;
-		NTSTATUS status;
-		HANDLE h;
-
-		RtlInitUnicodeString (&upath, devpath);
-		InitializeObjectAttributes (&attr, &upath,
-					    OBJ_CASE_INSENSITIVE, NULL, NULL);
-		status = NtOpenSymbolicLinkObject (&h, SYMBOLIC_LINK_QUERY,
-						   &attr);
-		if (!NT_SUCCESS (status))
-		  break;
-		RtlInitEmptyUnicodeString (&upath, devpath, (NT_MAX_PATH - 1)
-							    * sizeof (WCHAR));
-		status = NtQuerySymbolicLinkObject (h, &upath, NULL);
-		NtClose (h);
-		if (!NT_SUCCESS (status))
-		  break;
-		devpath[upath.Length / sizeof (WCHAR)] = L'\0';
-	      }
 	    mapping *m = new mapping ();
+	    bool hadrootmount = false;
 	    if (m)
 	      {
 		/* store mount point list */
@@ -2063,15 +2114,45 @@ dos_drive_mappings::dos_drive_mappings ()
 		    dos->path = mount;
 		    dos->len = wcslen (dos->path);
 		    dos->path[--dos->len] = L'\0'; /* Drop trailing backslash */
+		    if (dos->len == 2 && dos->path[1] == L':')
+		      hadrootmount = true;
 		  }
 		m->ntlen = wcslen (m->ntdevpath);
-		*nextm = m;
-		nextm = &m->next;
+		if (hadrootmount)
+		{
+		  /* This device has already been added to the mappings list
+		     in the first loop above, but with only the drive root
+		     mount.  Find that entry and replace it with the complete
+		     list of mounts. */
+		  hadrootmount = false;
+		  for (mapping *m2 = mappings;
+		       endfirstloop && m2 != endfirstloop->next;
+		       m2 = m2->next)
+		    {
+		      if (m->ntlen == m2->ntlen &&
+			  !wcscmp (m->ntdevpath, m2->ntdevpath))
+			{
+			  free (m2->dos.path);
+			  m2->dos.next = m->dos.next;
+			  m2->dos.path = m->dos.path;
+			  m2->dos.len = m->dos.len;
+			  free (m->ntdevpath);
+			  delete m;
+			  hadrootmount = true;
+			  break;
+			}
+		    }
+		}
+		if (!hadrootmount)
+		  {
+		    *nextm = m;
+		    nextm = &m->next;
+		  }
 	      }
 	  }
 	else
 	  debug_printf ("Unable to determine the native mapping for %ls "
-			"(error %u)", vol, GetLastError ());
+			"(error %E)", vol);
       }
     while (FindNextVolumeW (sh, vol, 64));
     FindVolumeClose (sh);
-- 
2.48.1.windows.1

