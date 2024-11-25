Return-Path: <SRS0=xIql=SU=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id C55F03858D38
	for <cygwin-patches@cygwin.com>; Mon, 25 Nov 2024 19:24:26 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C55F03858D38
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C55F03858D38
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1732562666; cv=none;
	b=okIosmt0FL4wgyCt5k3tZr7+yuR4GqQJdAw5rMJfkGTwz5DX+Q02jNBRdmG+jqLFlsQ+audnQUhUprrWFuQfWmyXw3KLwxGZZ7DvnFOPbgHwpTSHJBVBXsZEZuGlaHRu4ud+moMcclP9eq+rVcZ/MD6g6BQ85e448/j4FMlwcUY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1732562666; c=relaxed/simple;
	bh=IXq3oOvu8T5NocXuovparJtxzo2hB9REknWm+6IHuMc=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=lM2TWhHCYBvB2i9n6LnWOzFrdQxUX4n2DPPoQ7/UdodxmmSWRvntFMtynzg8pFmWq3p2ZC95i+B47kvV8oJq+Ta04vMMXYw+BWyG/qW7WeuK0toIJYM7cyBscZrmxGRvRiaEChd5w1AwNRdk0ovOtE0DDyvrcWm8LTZ/a5PEYxo=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C55F03858D38
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=VnNO9Naq
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 9DA1F45C80
	for <cygwin-patches@cygwin.com>; Mon, 25 Nov 2024 14:24:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:message-id:mime-version:content-type; s=csoft; bh=xg2oA
	eJyog71HWVZ+C7hpLpXuB4=; b=VnNO9Naq00FfgRxgtLTuyZjW/AJ1AwnHpA6lS
	uqV/UjDIh8yGMji8kvUUd4eBTa1oVEFOTSClTPvXRD4eFTAhdb70HGJ8BthwpXtY
	IEfxeqYHSwOjj+7bqdnxJgOV4C3kKEDkqiA/NF/T4j2zI6T5XCa5pIb2CzdPRcWj
	/EW7tg=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA512)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 7376845C7D
	for <cygwin-patches@cygwin.com>; Mon, 25 Nov 2024 14:24:26 -0500 (EST)
Date: Mon, 25 Nov 2024 11:24:26 -0800 (PST)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [PATCH v2 2/2] Cygwin: uname: add host machine tag to sysname.
Message-ID: <ecdfa413-1ad4-ea0e-4f01-33579f1616e9@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

From: Jeremy Drake <cygwin@jdrake.com>

If the Cygwin dll's architecture is different from the host system's
architecture, append an additional tag that indicates the host system
architecture (the Cygwin dll's architecture is already indicated in
machine).

Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
---
v2: get rid of hardcoded string lengths, use wincap accessors
directly instead of caching their returns, actually add "n" variable as
intended

 winsup/cygwin/uname.cc | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/uname.cc b/winsup/cygwin/uname.cc
index dd4160189c..2410dc502e 100644
--- a/winsup/cygwin/uname.cc
+++ b/winsup/cygwin/uname.cc
@@ -24,6 +24,38 @@ extern "C" int getdomainname (char *__name, size_t __len);
 #define ATTRIBUTE_NONSTRING
 #endif

+static int
+append_host_suffix (char * buf)
+{
+  int n = 0;
+  if (wincap.host_machine () != wincap.cygwin_machine ())
+    {
+      switch (wincap.host_machine ())
+	{
+	  case IMAGE_FILE_MACHINE_AMD64:
+	    /* special case for backwards compatibility */
+	    if (wincap.cygwin_machine () == IMAGE_FILE_MACHINE_I386)
+	      n = stpcpy (buf, "-WOW64") - buf;
+	    else
+	      n = stpcpy (buf, "-x64") - buf;
+	    break;
+	  case IMAGE_FILE_MACHINE_I386:
+	    n = stpcpy (buf, "-x86") - buf;
+	    break;
+	  case IMAGE_FILE_MACHINE_ARMNT:
+	    n = stpcpy (buf, "-ARM") - buf;
+	    break;
+	  case IMAGE_FILE_MACHINE_ARM64:
+	    n = strcpy (buf, "-ARM64") - buf;
+	    break;
+	  default:
+	    n = __small_sprintf (buf, "-%04y", (int) wincap.host_machine ());
+	    break;
+	}
+    }
+  return n;
+}
+
 /* uname: POSIX 4.4.1.1 */

 /* New entrypoint for applications since API 335 */
@@ -33,11 +65,13 @@ uname_x (struct utsname *name)
   __try
     {
       char buf[NI_MAXHOST + 1] ATTRIBUTE_NONSTRING;
+      int n;

       memset (name, 0, sizeof (*name));
       /* sysname */
-      __small_sprintf (name->sysname, "CYGWIN_%s-%u",
-		       wincap.osname (), wincap.build_number ());
+      n = __small_sprintf (name->sysname, "CYGWIN_%s-%u",
+			   wincap.osname (), wincap.build_number ());
+      n += append_host_suffix (name->sysname + n);
       /* nodename */
       memset (buf, 0, sizeof buf);
       cygwin_gethostname (buf, sizeof buf - 1);
-- 
2.47.0.windows.2

