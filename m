Return-Path: <SRS0=POcl=NH=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 436CF383A48F
	for <cygwin-patches@cygwin.com>; Wed,  5 Jun 2024 02:04:26 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 436CF383A48F
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 436CF383A48F
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1717553068; cv=none;
	b=Pdkc3MeCCQpbS7Rg3NKOXhJgwpEqqwE4d+dwmDe4NBEg728Tf7OVyv0Lc6jIE7t/STdn4o1o16w55MywHaRMpRP3Uq9J3hyvHkQMQEOKC1KbTjbMolzVoNBiqE8eJ2GZ+YmaZ0JFYIdVO1tCe3wy9EtLSco8/whTPF2GXulYnSM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1717553068; c=relaxed/simple;
	bh=jqZNoUGHVXrn4+5R4oIuZLjYubePFioh+ar9sqFxV8k=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=sHnWQfp+z16dix5SaBYu/WFOs6DNVjg4ekE9NycuXl/4DzAdu/BPBCfuBDVb3Qd95X52jZnDaJyefD5/PyEj6904yuaAz6rQiUWz/PdXj0zdAQwzBptG5OsU64R+g6qjFiXNDWBZ5xvVgxut6XFDZrRcvKeXcqfxs3k1Rcc/OoQ=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 9614645B4A
	for <cygwin-patches@cygwin.com>; Tue,  4 Jun 2024 22:04:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:message-id:mime-version:content-type; s=csoft; bh=1bH75
	WGlqiBY4r+0/MOmHKuuidQ=; b=FP080p+OUTjzk28IFtHfBGuhHqVeP+g6rxC/9
	yzO/XT6+JpglWRcti2wFQAtIideypWeBwwTGr0pthgQ/mHFb4NGhiqanTDNgKTIi
	dr+7yizbh8PMyH4bClcrQ7e0RqLc/lCNz/UWisg/2QqZHnfDllYxJqJqq6IYb4M9
	SDduvc=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA512)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 8F23E45B41
	for <cygwin-patches@cygwin.com>; Tue,  4 Jun 2024 22:04:22 -0400 (EDT)
Date: Tue, 4 Jun 2024 19:04:22 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [PATCH v2] Cygwin: /proc/<PID>/mount*: escape strings.
Message-ID: <d7c79b40-237b-2f76-fc4d-3b7c3376199d@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

In order for these formats to be machine-parseable, characters used as
delimiters must be escaped.  Linux escapes space, tab, newline,
backslash, and hash (because code that parses mounts/mtab and fstab
would handle comments) using octal escapes.  Replicate that behavior
here.

Addresses: https://cygwin.com/pipermail/cygwin/2024-June/256082.html
Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
---

Changes from original:
* forgot to include tab '\t' in characters that need escaping
* I mis-iterpreted how octal escapes work: they don't require a leading 0,
but Linux uses a fixed 3 digit format, which makes calculating the length
cleaner.

 winsup/cygwin/fhandler/process.cc | 76 +++++++++++++++++++++++++++----
 1 file changed, 66 insertions(+), 10 deletions(-)

diff --git a/winsup/cygwin/fhandler/process.cc b/winsup/cygwin/fhandler/process.cc
index 37bdff84e3..db1763d702 100644
--- a/winsup/cygwin/fhandler/process.cc
+++ b/winsup/cygwin/fhandler/process.cc
@@ -1317,9 +1317,39 @@ extern "C" {
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
+    len += 3;
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
+      p += __small_sprintf (p, "\\%03o", (int)(unsigned char) str[i]);
+    }
+  p = stpcpy (p, str + s);
+  return (p - destbuf);
+}
+
 static off_t
 format_process_mountstuff (void *data, char *&destbuf, bool mountinfo)
 {
+  static const char MOUNTSTUFF_ESCAPEES[] = " \t\n\\#";
   _pinfo *p = (_pinfo *) data;
   user_info *u_shared = NULL;
   HANDLE u_hdl = NULL;
@@ -1369,9 +1399,9 @@ format_process_mountstuff (void *data, char *&destbuf, bool mountinfo)
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
@@ -1380,18 +1410,44 @@ format_process_mountstuff (void *data, char *&destbuf, bool mountinfo)
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

