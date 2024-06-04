Return-Path: <SRS0=wmYr=NG=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 4835B385DDF5
	for <cygwin-patches@cygwin.com>; Tue,  4 Jun 2024 22:37:40 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4835B385DDF5
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 4835B385DDF5
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1717540662; cv=none;
	b=GtkPm0z6PpzTwJAiCXNS9ODBHuvsvUWGFgcfB65gxszG2zNfTpumWSddGh0iTqA0nYE0Zs5Rkww+Epd0Mz3Ki9fiAy0bG+VPeOFhODBGCcppDMmP3dzMVbPzHTiErN0gwtieCot636MGIVwPpWLlZzzwdnKISJeu3f1pNRAU1Uk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1717540662; c=relaxed/simple;
	bh=EJsQhYKhdtd5cF9QX/gqW/hPmiuehW1DiJRA74Kq4/0=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=CZibpBAdO39WrpLk/j5JsxB+inUykIC2iKpYMxNla/YSI+FlcX4ad0DXwOVf8yuR+WL3J9e+2AEP1n0KP35CXddw+pxtc7/vCgrCv98c+de35B16j6+jDwu/J3lcJK4O74SafE2ivwmF8CBkNyd71omA3fceUfKyDfAoi/2gZOs=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 8335E45B3F
	for <cygwin-patches@cygwin.com>; Tue,  4 Jun 2024 18:37:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:message-id:mime-version:content-type; s=csoft; bh=XsHep
	xfWX9s81bCcqOZd1h3U+9U=; b=zDrehxthh69vPKDSc7P28xxCnEqki55xyL+AF
	LRmC9RH4Tn5UUEBJHZHhDgWCJkYf/6DHSSRQ+qXC+owqdQ7Vo53qADUj8lI9UvfI
	Q7N0Ipb77L5laHv1fzjS2Nbg5TpJtF7fIuyUVfZXDNghPvD8U3ng623n1uaeNGeZ
	T3v+To=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA512)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 4F81A45B39
	for <cygwin-patches@cygwin.com>; Tue,  4 Jun 2024 18:37:37 -0400 (EDT)
Date: Tue, 4 Jun 2024 15:37:37 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: /proc/<PID>/mount*: escape strings.
Message-ID: <25845177-e982-8b0e-b4f8-ebd514a209ce@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

In order for these formats to be machine-parseable, characters used as
delimiters must be escaped.  Linux escapes space, newline, backslash,
and hash (because code that parses mounts/mtab and fstab would handle
comments) using octal escapes.  Replicate that behavior here.

Addresses: https://cygwin.com/pipermail/cygwin/2024-June/256082.html
Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
---

I took a crack at adding escaping to "mountstuff".  It seems like there
might be other such /proc entries that are expected to be machine-readable
that might need escaping.  As such, perhaps the escape_string* functions
should be in some other file (and not static) so other source files can
call them too.

I made some effort to match formatting, but I may well have missed
something (I just noticed I missed space between function name and open
paren on the new functions, I went ahead and fixed that in the patch
manually in the email client).

 winsup/cygwin/fhandler/process.cc | 81 +++++++++++++++++++++++++++----
 1 file changed, 71 insertions(+), 10 deletions(-)

diff --git a/winsup/cygwin/fhandler/process.cc b/winsup/cygwin/fhandler/process.cc
index 37bdff84e3..0ab07bd119 100644
--- a/winsup/cygwin/fhandler/process.cc
+++ b/winsup/cygwin/fhandler/process.cc
@@ -1317,9 +1317,44 @@ extern "C" {
   struct mntent *getmntent (FILE *);
 };

+static size_t
+escape_string_length (const char *str, const char *escapees)
+{
+  size_t i, len = 0;
+
+  for (i = strcspn (str, escapees);
+       str[i];
+       i += strcspn (str + i + 1, escapees) + 1)
+    if ((unsigned char) str[i] < 8)
+      len += 2;
+    else if ((unsigned char) str[i] < 64)
+      len += 3;
+    else
+      len += 4;
+  return len + i;
+}
+
+static size_t
+escape_string (char *destbuf, const char *str, const char *escapees)
+{
+  size_t s, i;
+  char *p = destbuf;
+
+  for (s = 0, i = strcspn (str, escapees);
+       str[i];
+       s = i + 1, i += strcspn (str + s, escapees) + 1)
+    {
+      p = stpncpy (p, str + s, i - s);
+      p += __small_sprintf (p, "\\0%o", (int)(unsigned char) str[i]);
+    }
+  p = stpcpy (p, str + s);
+  return (p - destbuf);
+}
+
 static off_t
 format_process_mountstuff (void *data, char *&destbuf, bool mountinfo)
 {
+  static const char MOUNTSTUFF_ESCAPEES[] = " \n\\#";
   _pinfo *p = (_pinfo *) data;
   user_info *u_shared = NULL;
   HANDLE u_hdl = NULL;
@@ -1369,9 +1404,9 @@ format_process_mountstuff (void *data, char *&destbuf, bool mountinfo)
 	    continue;
 	}
       destbuf = (char *) crealloc_abort (destbuf, len
-						  + strlen (mnt->mnt_fsname)
-						  + strlen (mnt->mnt_dir)
-						  + strlen (mnt->mnt_type)
+						  + escape_string_length (mnt->mnt_fsname, MOUNTSTUFF_ESCAPEES)
+						  + escape_string_length (mnt->mnt_dir, MOUNTSTUFF_ESCAPEES)
+						  + escape_string_length (mnt->mnt_type, MOUNTSTUFF_ESCAPEES)
 						  + strlen (mnt->mnt_opts)
 						  + 30);
       if (mountinfo)
@@ -1380,18 +1415,44 @@ format_process_mountstuff (void *data, char *&destbuf, bool mountinfo)
 	  dev_t dev = pc.exists () ? pc.fs_serial_number () : -1;

 	  len += __small_sprintf (destbuf + len,
-				  "%d %d %d:%d / %s %s - %s %s %s\n",
+				  "%d %d %d:%d / ",
 				  iteration, iteration,
-				  major (dev), minor (dev),
-				  mnt->mnt_dir, mnt->mnt_opts,
-				  mnt->mnt_type, mnt->mnt_fsname,
+				  major (dev), minor (dev));
+	  len += escape_string (destbuf + len,
+				mnt->mnt_dir,
+				MOUNTSTUFF_ESCAPEES);
+	  len += __small_sprintf (destbuf + len,
+				  " %s - ",
+				  mnt->mnt_opts);
+	  len += escape_string (destbuf + len,
+				mnt->mnt_type,
+				MOUNTSTUFF_ESCAPEES);
+	  destbuf[len++] = ' ';
+	  len += escape_string (destbuf + len,
+				mnt->mnt_fsname,
+				MOUNTSTUFF_ESCAPEES);
+	  len += __small_sprintf (destbuf + len,
+				  " %s\n",
 				  (pc.fs_flags () & FILE_READ_ONLY_VOLUME)
 				  ? "ro" : "rw");
 	}
       else
-	len += __small_sprintf (destbuf + len, "%s %s %s %s %d %d\n",
-				mnt->mnt_fsname, mnt->mnt_dir, mnt->mnt_type,
-				mnt->mnt_opts, mnt->mnt_freq, mnt->mnt_passno);
+        {
+	  len += escape_string (destbuf + len,
+				mnt->mnt_fsname,
+				MOUNTSTUFF_ESCAPEES);
+	  destbuf[len++] = ' ';
+	  len += escape_string (destbuf + len,
+				mnt->mnt_dir,
+				MOUNTSTUFF_ESCAPEES);
+	  destbuf[len++] = ' ';
+	  len += escape_string (destbuf + len,
+				mnt->mnt_type,
+				MOUNTSTUFF_ESCAPEES);
+	  len += __small_sprintf (destbuf + len, " %s %d %d\n",
+				  mnt->mnt_opts, mnt->mnt_freq,
+				  mnt->mnt_passno);
+	}
     }

   /* Restore available_drives */
-- 
2.45.2.windows.1

