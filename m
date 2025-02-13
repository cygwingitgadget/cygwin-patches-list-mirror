Return-Path: <SRS0=kr8w=VE=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 82C6D3858404
	for <cygwin-patches@cygwin.com>; Thu, 13 Feb 2025 01:38:55 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 82C6D3858404
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 82C6D3858404
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1739410735; cv=none;
	b=qUe5NP/3yzCptoGc9DkPsMTAzgbtpfHukDyFQCBBA5t3AqQ+1PbsHsYQQlnQRayj8DPFyMQysq4S9RfqL2k/JZJgqdhScfdlw+fUJLl3ewVo4hpS+WaOA3rrpPH7Mi613OM7T1nyQdAUj54XJsagnixo4v36DVP6mnnLYqL+368=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1739410735; c=relaxed/simple;
	bh=oHG8KTIf2bmN7vqDbS0vd/2EabzOyUTk9yXSzZRY0tc=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=VceEfMFgCKwvdCwXNLf39WgKuiVb5cnBiW0FN19QuG+MKSs2IMK3+U9EP6lT0UI2a7XzS/Zu8Hndcl8tCzQKzZU6QsA6ULAtpUoAIMtpwNMO/C+FFA5ytOWm9ZHRmIq+quTObSaja4RfMRCl2qj3qVN6zPZXNeDWjcpv+90ER3g=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 82C6D3858404
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=Hegvze2K
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 5E8A145C1D
	for <cygwin-patches@cygwin.com>; Wed, 12 Feb 2025 20:38:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:message-id:mime-version:content-type; s=csoft; bh=AvD0O
	fmFdNxPDZiM7A1ktc/vU5A=; b=Hegvze2KJFWTMEIUZOB9rzSZAWCmPe8aS1wEs
	hHy+zwzVH4hjQxjJJ4kLUIFrb9yKTzCkalKgOpvl5Fvz0gutqS+K/G+Mije/ZCQ1
	gHgzORu+LO99ppkyv4TxWpzr3qIiBxRXdFRmEBxTzx69ataRz+3moA/l1Dc3wTHL
	2aMRlY=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 592ED45BF6
	for <cygwin-patches@cygwin.com>; Wed, 12 Feb 2025 20:38:55 -0500 (EST)
Date: Wed, 12 Feb 2025 17:38:55 -0800 (PST)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [PATCH v4 1/3] Cygwin: store list of mounts for volumes in
 dos_drive_mappings.
Message-ID: <b350ec1f-af57-479c-bc6f-260d3710c04c@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

The existing code only stored the first mount for each volume, but now
we store the complete list, and split it into a linked list.  This will
be used in a subsequent commit to populate cygdrive mount entries.

Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
---
 winsup/cygwin/local_includes/mount.h | 11 ++++---
 winsup/cygwin/mount.cc               | 46 +++++++++++++++++++---------
 2 files changed, 39 insertions(+), 18 deletions(-)

diff --git a/winsup/cygwin/local_includes/mount.h b/winsup/cygwin/local_includes/mount.h
index b2acdf08b4..c96b34781e 100644
--- a/winsup/cygwin/local_includes/mount.h
+++ b/winsup/cygwin/local_includes/mount.h
@@ -223,12 +223,15 @@ class dos_drive_mappings
   struct mapping
   {
     mapping *next;
-    size_t doslen;
     size_t ntlen;
-    wchar_t *dospath;
     wchar_t *ntdevpath;
-  };
-  mapping *mappings;
+    struct dosmount
+    {
+      dosmount *next;
+      wchar_t *path;
+      size_t len;
+    } dos;
+  } *mappings;

 public:
   dos_drive_mappings ();
diff --git a/winsup/cygwin/mount.cc b/winsup/cygwin/mount.cc
index bf26c4af3e..4be24fbe84 100644
--- a/winsup/cygwin/mount.cc
+++ b/winsup/cygwin/mount.cc
@@ -2002,13 +2002,13 @@ dos_drive_mappings::dos_drive_mappings ()
   wchar_t *devpath = tp.w_get ();
   wchar_t *mounts = tp.w_get ();

-  /* Iterate over all volumes, fetch the first path from the list of
-     DOS paths the volume is mounted to, or use the GUID volume path
-     otherwise. */
+  /* Iterate over all volumes, fetch the list of DOS paths the volume is
+     mounted to. */
   HANDLE sh = FindFirstVolumeW (vol, 64);
   if (sh == INVALID_HANDLE_VALUE)
     debug_printf ("FindFirstVolumeW, %E");
   else {
+    mapping **nextm = &mappings;
     do
       {
 	/* Skip drives which are not mounted. */
@@ -2047,20 +2047,32 @@ dos_drive_mappings::dos_drive_mappings ()
 	    mapping *m = new mapping ();
 	    if (m)
 	      {
-		m->dospath = wcsdup (mounts);
+		/* store mount point list */
+		if ((m->dos.path = (wchar_t *) malloc (len * sizeof (WCHAR))))
+		  memcpy (m->dos.path, mounts, len * sizeof (WCHAR));
 		m->ntdevpath = wcsdup (devpath);
-		if (!m->dospath || !m->ntdevpath)
+		if (!m->dos.path || !m->ntdevpath)
 		  {
-		    free (m->dospath);
+		    free (m->dos.path);
 		    free (m->ntdevpath);
 		    delete m;
 		    continue;
 		  }
-		m->doslen = wcslen (m->dospath);
-		m->dospath[--m->doslen] = L'\0'; /* Drop trailing backslash */
+		/* split mount point list into dosmount entries */
+		mapping::dosmount *dos = &m->dos;
+		for (wchar_t *mount = m->dos.path;
+		    dos;
+		    mount += dos->len + 2,
+		      dos->next = mount[0] ? new mapping::dosmount () : NULL,
+		      dos = dos->next)
+		  {
+		    dos->path = mount;
+		    dos->len = wcslen (dos->path);
+		    dos->path[--dos->len] = L'\0'; /* Drop trailing backslash */
+		  }
 		m->ntlen = wcslen (m->ntdevpath);
-		m->next = mappings;
-		mappings = m;
+		*nextm = m;
+		nextm = &m->next;
 	      }
 	  }
 	else
@@ -2088,11 +2100,11 @@ dos_drive_mappings::fixup_if_match (wchar_t *path)
       {
 	wchar_t *tmppath;

-	if (m->ntlen > m->doslen)
-	  wcsncpy (path += m->ntlen - m->doslen, m->dospath, m->doslen);
+	if (m->ntlen > m->dos.len)
+	  wcsncpy (path += m->ntlen - m->dos.len, m->dos.path, m->dos.len);
 	else if ((tmppath = wcsdup (path + m->ntlen)) != NULL)
 	  {
-	    wcpcpy (wcpcpy (path, m->dospath), tmppath);
+	    wcpcpy (wcpcpy (path, m->dos.path), tmppath);
 	    free (tmppath);
 	  }
 	break;
@@ -2106,8 +2118,14 @@ dos_drive_mappings::~dos_drive_mappings ()
   for (mapping *m = mappings; m; m = n)
     {
       n = m->next;
-      free (m->dospath);
+      free (m->dos.path);
       free (m->ntdevpath);
+      mapping::dosmount *dn;
+      for (mapping::dosmount *dm = m->dos.next; dm; dm = dn)
+	{
+	  dn = dm->next;
+	  delete dm;
+	}
       delete m;
     }
 }
-- 
2.47.1.windows.2

