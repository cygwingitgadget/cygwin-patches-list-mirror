Return-Path: <SRS0=PnHA=SQ=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id D66B13857B96
	for <cygwin-patches@cygwin.com>; Thu, 21 Nov 2024 19:44:51 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D66B13857B96
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D66B13857B96
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1732218291; cv=none;
	b=EZxuYUHbmSpNEwKYP1VATH2QI2Sb03stBExQDN+M7CSU5FtJfPCMkKQNE1/6PshJghkfS/+Uhn25OA96Pop5avyQ70CDEwUml0ln8QUvuF6NuLQ2Ce5wsFOhxDbSfAx3yXSVXfquKkCKuGugJ7LM7/s5iMa7y28LiqOnQjsBdk4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1732218291; c=relaxed/simple;
	bh=Uhkqry5YLyXPUBiReAzzqNkLmf2g6OzHjOMgRV2vGYc=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=anTxijyQmZpRvodYBWDOjqjIECDy7fkxMbkDUOwZILw3Tf14VE794MtM7JYHMqFUhLWbEWlXX6kgu8xTxH7mRuC0dZjA+uEaGx8FDWYrX9Uq9xSRYVqf+qTlBLvdc/uIA9kMhxRir9T/RDdj4O/8i2f7Hqht/ghw/ZjuZIuK/Wo=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D66B13857B96
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=ULV4ZQ/b
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id AE5A145C0A
	for <cygwin-patches@cygwin.com>; Thu, 21 Nov 2024 14:44:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:message-id:mime-version:content-type; s=csoft; bh=SDRN0
	Z0WUZ4E4j0Fdt8+KjELw50=; b=ULV4ZQ/bLY/2Q2CgmIDpSdMI2Sxvgiu/jU/Jc
	8HJBAwxaseYVe6Nnu0uRcJMO7fLi+Fgq9hmkDDiMehXF3u9tdyNwzDF0l+/8TD88
	J05f8QGWV0EuhaqmOW3GMBare3m21lm3mGTeAvDsg2sRsrLAVI/qjd7+s9536u0W
	nDftks=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA512)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 79FE245C00
	for <cygwin-patches@cygwin.com>; Thu, 21 Nov 2024 14:44:51 -0500 (EST)
Date: Thu, 21 Nov 2024 11:44:51 -0800 (PST)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [PATCH 2/2] Cygwin: uname: add host machine tag to sysname.
Message-ID: <be79571e-9fab-cee4-54e4-a63348aed429@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

If the Cygwin dll's architecture is different from the host system's
architecture, append an additional tag that indicates the host system
architecture (the Cygwin dll's architecture is already indicated in
machine).
---
You may well want me to remove some cases from the switch ;)

 winsup/cygwin/uname.cc | 44 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/winsup/cygwin/uname.cc b/winsup/cygwin/uname.cc
index dd4160189c..40030fba16 100644
--- a/winsup/cygwin/uname.cc
+++ b/winsup/cygwin/uname.cc
@@ -24,6 +24,49 @@ extern "C" int getdomainname (char *__name, size_t __len);
 #define ATTRIBUTE_NONSTRING
 #endif

+static int
+append_host_suffix (char * buf)
+{
+  USHORT host = wincap.host_machine ();
+  USHORT cygwin = wincap.current_module_machine ();
+  int n = 0;
+  if (host != cygwin)
+    {
+      switch (host)
+	{
+	  case IMAGE_FILE_MACHINE_AMD64:
+	    /* special case for backwards compatibility */
+	    if (cygwin == IMAGE_FILE_MACHINE_I386)
+	      {
+		strcpy (buf, "-WOW64");
+		n = 6;
+	      }
+	    else
+	      {
+		strcpy (buf, "-x64");
+		n = 4;
+	      }
+	    break;
+	  case IMAGE_FILE_MACHINE_I386:
+	    strcpy (buf, "-x86");
+	    n = 4;
+	    break;
+	  case IMAGE_FILE_MACHINE_ARMNT:
+	    strcpy (buf, "-ARM");
+	    n = 4;
+	    break;
+	  case IMAGE_FILE_MACHINE_ARM64:
+	    strcpy (buf, "-ARM64");
+	    n = 6;
+	    break;
+	  default:
+	    n = __small_sprintf (buf, "-%04y", host);
+	    break;
+	}
+    }
+  return n;
+}
+
 /* uname: POSIX 4.4.1.1 */

 /* New entrypoint for applications since API 335 */
@@ -38,6 +81,7 @@ uname_x (struct utsname *name)
       /* sysname */
       __small_sprintf (name->sysname, "CYGWIN_%s-%u",
 		       wincap.osname (), wincap.build_number ());
+      append_host_suffix (name->sysname + n);
       /* nodename */
       memset (buf, 0, sizeof buf);
       cygwin_gethostname (buf, sizeof buf - 1);
-- 
2.47.0.windows.2

