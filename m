Return-Path: <SRS0=c54n=VC=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id C69513858C48
	for <cygwin-patches@cygwin.com>; Tue, 11 Feb 2025 01:14:00 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C69513858C48
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C69513858C48
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1739236442; cv=none;
	b=VOIAe98o/3qf55ChbfucasIq3ZIevgjoHpmFZleno4smkAPzP17vy/HUewWUYzAvgzs9FVl9bfq9unqyzIDLcHHMOUbA+hMXXylyFtX357Z6igkNGHb3kGT/7JhzfsvI6X10iS9rq23zizdq96qz/onZ7eN4Zj/P/iLuxaSV/AA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1739236442; c=relaxed/simple;
	bh=4uDurQHAVljbAGsf88K5xhmN6bxqTjc/lvLfExPGDFg=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=g6FejLs/4wdSdL0r0YIt/+mcLh2ZaA7+S+mT17XqcQqTBhNZJuyqisNwWbytYtiGMT898Ppeu5B6Q6PQBK7uiT1MSw7M+WTYjXWq1IG+DK7pajbER3alQ/7ZrF4Lzc5X4pvWEkQSDCL4hwiaHYj7BcXEpGKNG+NYSjoyG/vNQ9Q=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C69513858C48
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=GOtWl0ec
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 72AFF45C5A
	for <cygwin-patches@cygwin.com>; Mon, 10 Feb 2025 20:14:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:message-id:mime-version:content-type; s=csoft; bh=JVAV8
	fa/MMkiQrMOcH76BRdicM0=; b=GOtWl0ecySP6XkOIWah/CVsB7ShDDp8f+MMtV
	TSiqUT3GFZvASwNIGPJpmepg1+TU8jmCPlqvDUGBYFB3uft/trRmqxmaLA5Q+xKk
	Inv9i+wNeF09dSax8f3+NIOFjGR+ThlphM0nh1DoW6GJdKy1pqOv51JNiwAbrD8Y
	0+z5O4=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 366C445C59
	for <cygwin-patches@cygwin.com>; Mon, 10 Feb 2025 20:14:00 -0500 (EST)
Date: Mon, 10 Feb 2025 17:13:57 -0800 (PST)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [PATCH v2 1/2] Cygwin: make list of mounts for a volume in
 dos_drive_mappings
Message-ID: <827294fb-0391-197f-6b53-52ea0f5e11e7@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

make mappings linked list in order rather than reverse order.

Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
---
 winsup/cygwin/local_includes/mount.h | 11 +++++---
 winsup/cygwin/mount.cc               | 39 ++++++++++++++++++++--------
 2 files changed, 35 insertions(+), 15 deletions(-)

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
index bf26c4af3e..82ed4259f7 100644
--- a/winsup/cygwin/mount.cc
+++ b/winsup/cygwin/mount.cc
@@ -2009,6 +2009,7 @@ dos_drive_mappings::dos_drive_mappings ()
   if (sh == INVALID_HANDLE_VALUE)
     debug_printf ("FindFirstVolumeW, %E");
   else {
+    mapping **nextm = &mappings;
     do
       {
 	/* Skip drives which are not mounted. */
@@ -2047,20 +2048,30 @@ dos_drive_mappings::dos_drive_mappings ()
 	    mapping *m = new mapping ();
 	    if (m)
 	      {
-		m->dospath = wcsdup (mounts);
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
@@ -2088,11 +2099,11 @@ dos_drive_mappings::fixup_if_match (wchar_t *path)
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
@@ -2106,8 +2117,14 @@ dos_drive_mappings::~dos_drive_mappings ()
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

