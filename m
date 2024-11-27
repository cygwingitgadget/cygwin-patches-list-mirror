Return-Path: <SRS0=5dpU=SW=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 185713858CDB
	for <cygwin-patches@cygwin.com>; Wed, 27 Nov 2024 19:26:52 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 185713858CDB
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 185713858CDB
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1732735612; cv=none;
	b=E8oUuq+o930BwCB9OP+A4SxAa1Ai9gfNsmgtxBcz1KepzdDFyL91QmOJVPMrGpHv7Od1CNlwTHoUC0U/Z8Zg+2hbBvbx04HbTYh8+CsMdie5TWDhp0PcdfHf9WO9G4tHDrlJGkPFLvtS8xdKgxqWzCxPihPksiZ1lioHygGu/Xc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1732735612; c=relaxed/simple;
	bh=9BawSCQMF/XNiD6QIcJyYu97ipDnXK7vmJKaJyOQPdo=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=jSY3uRCX+ea/eL1YE2FUNhe4d8JlcbYiYSJsIwxOasrEVVoGndqi0H6JlzwymPM3E7qNDcpiExOBAg6h23nnLqzHGXitW10VSHZ1Nbn2/pjD59VTdq+AOwGUOTD5jWpsPRVL5hO+u69OOUHqrN/EnM0PnFzV8HmvAeUzB9yK5JU=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 185713858CDB
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=E0A0mEdv
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id E8CD345C87
	for <cygwin-patches@cygwin.com>; Wed, 27 Nov 2024 14:26:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:message-id:mime-version:content-type; s=csoft; bh=TuJAe
	YW+qUyF5/MplPrz6/qqN/Q=; b=E0A0mEdvSamlhMV1UoyhFKkxO6xJsftS71cvo
	AYCDveqRxLaSgsvFamOcsT5KXaWbEHuKoPfT+8TJgTEQeEzeS6BNX1dVa10RO3Bj
	n1RykXFIHGZUUepIUY3wYXBVKJm28IUFgCTKxIWtUiizqJwexDGtn48naYnRaB8C
	3apNWU=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA512)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id E40A145C83
	for <cygwin-patches@cygwin.com>; Wed, 27 Nov 2024 14:26:51 -0500 (EST)
Date: Wed, 27 Nov 2024 11:26:50 -0800 (PST)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [PATCH v3 2/2] Cygwin: uname: add host machine tag to sysname.
Message-ID: <018bf8a4-0aa3-8885-8532-d2db9e73e390@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
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

v3: inline append_host_suffix, remove unnecessary switch cases, fix typo
strcpy -> stpcpy in ARM64 case

 winsup/cygwin/uname.cc | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/uname.cc b/winsup/cygwin/uname.cc
index dd4160189c..52c807ae54 100644
--- a/winsup/cygwin/uname.cc
+++ b/winsup/cygwin/uname.cc
@@ -33,11 +33,25 @@ uname_x (struct utsname *name)
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
+      if (wincap.host_machine () != wincap.cygwin_machine ())
+	{
+	  switch (wincap.host_machine ())
+	    {
+	      case IMAGE_FILE_MACHINE_ARM64:
+		n = stpcpy (name->sysname + n, "-ARM64") - name->sysname;
+		break;
+	      default:
+		n += __small_sprintf (name->sysname + n, "-%04y",
+				      (int) wincap.host_machine ());
+		break;
+	    }
+	}
       /* nodename */
       memset (buf, 0, sizeof buf);
       cygwin_gethostname (buf, sizeof buf - 1);
-- 
2.47.0.windows.2

