Return-Path: <SRS0=Z4hW=VJ=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 98F9B3858D20
	for <cygwin-patches@cygwin.com>; Tue, 18 Feb 2025 21:25:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 98F9B3858D20
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 98F9B3858D20
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1739913928; cv=none;
	b=mYaKNbqEVsKpfooTRkAqukwiS6gDijcP3Jjx8T0Q9QxrA6MwiOzGCxuGcYmffUBvqJlWdOAw7GWMpQK9YBHJDc+waC8d+w64vP6Wld8k/6CRcdI4TU11pB6iwX6uep3R37N/ykgMCJMXUj2/+tDsET3UEV7u1vjCRGbOcs1ycnM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1739913928; c=relaxed/simple;
	bh=VEwXdYtik2hjI0+OTGE69gJ84u2dbNE6vkyEvXKu2EI=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=lGhZ9N4tmJcwGY7aYobINPW/wNjd566JQyMS8kmtTwfQvxvWtcmxhcg2MIWWKyCdr8fmI7YMmE4FIM8Uzh0/YAFxlIAPXpyrfheWSEM+BBH5n4zfV4eqIXoh6HetUhenwErRc+Xyo61he2pRSsjVqhnHZgnFor739RvZ0BIBzR0=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 98F9B3858D20
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=XXYyMgpk
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 636FD45C30
	for <cygwin-patches@cygwin.com>; Tue, 18 Feb 2025 16:25:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:message-id:mime-version:content-type; s=csoft; bh=LwGKx
	o0BiedE1A5KV3gRw75T6a0=; b=XXYyMgpkrEqsQka6OdS07Yi1hyheAQTJV33/v
	6D5FPcxH2fJ4hHLf2lP7jbboRoZDmjn3rqjGQ+hip4dpuknmxqd8n5fG58SCbnuE
	sOErgG0SA65tyR2N5IPt0LO9Yj5MYYpUvWumaNzyg77nXTQQGgwTRpknZs2/4/6j
	IYji6I=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 35EC045BF6
	for <cygwin-patches@cygwin.com>; Tue, 18 Feb 2025 16:25:28 -0500 (EST)
Date: Tue, 18 Feb 2025 13:25:28 -0800 (PST)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: include network mounts in cygdrive_getmntent.
Message-ID: <8dd3b5f5-004c-53ee-53ea-6428de5dd597@jdrake.com>
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

This was generated on top of the patch
https://cygwin.com/pipermail/cygwin-patches/2025q1/013390.html but should
be able to be applied without it.

 winsup/cygwin/mount.cc | 145 ++++++++++++++++++++++++++++++++---------
 1 file changed, 113 insertions(+), 32 deletions(-)

diff --git a/winsup/cygwin/mount.cc b/winsup/cygwin/mount.cc
index a3d9e5bd0f..68414f13af 100644
--- a/winsup/cygwin/mount.cc
+++ b/winsup/cygwin/mount.cc
@@ -1995,6 +1995,40 @@ endmntent (FILE *)
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
@@ -2004,6 +2038,44 @@ dos_drive_mappings::dos_drive_mappings ()
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
@@ -2011,43 +2083,22 @@ dos_drive_mappings::dos_drive_mappings ()
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
@@ -2072,15 +2123,45 @@ dos_drive_mappings::dos_drive_mappings ()
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

