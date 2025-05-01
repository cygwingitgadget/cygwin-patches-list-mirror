Return-Path: <SRS0=nMGZ=XR=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 12CF23858D34
	for <cygwin-patches@cygwin.com>; Thu,  1 May 2025 19:28:43 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 12CF23858D34
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 12CF23858D34
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1746127723; cv=none;
	b=UGH0TQXPpr3T2Z6wAXf4eYSHiD4QNRNDSr9EslsxwUgchcHu4U3ijN/zNkPl/SYMhLsXU3pk67lpAJ+pPytTVEFO1jVyWaC2epTytOjq5KAgmKvJlxeqNqFOLZILerIHBqB1M2OldD1/s1Ae/CSwqmMH/NJmJpKRD+YsPAy+1qs=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1746127723; c=relaxed/simple;
	bh=H7QqJutvtjpwWXHXP2LisurnjbYtBUzu5aG3fUAdnP8=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=XTV5qCQu2D8wvIWXm2zHeofOBoTssH2+vXjv8Ccx+fP26kEQNb/vWdRF5WqczdWU72U9rW0qpnXCNYeUG94wDWlLXOnHFDUuY/CQbh4abLdVwIt/+QfroUn1Mq/GA4EHYjulji345J+uUz+PyT4I94ZF0AfspmIfyasEsLxh9Dc=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 12CF23858D34
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=SSblYUo2
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id C48C845C56
	for <cygwin-patches@cygwin.com>; Thu, 01 May 2025 15:28:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:message-id:mime-version:content-type; s=csoft; bh=g/Tua
	uRDCy4xy8n+vJy21IDJZ/4=; b=SSblYUo2mh49cFyEQ653VbwHSTqIcutlLtEcK
	0lDiSwzUamFRTM9taYrHWGTnxmnHQTpnp/nQ88GWuPfVxoUn1UntAv1QsjmL8yYI
	axic6P9y9AimOgldx+pq0/yOcSNMlYsMsm8QFQicvjZivVMNUCWCp80AVEfRP1rr
	du9YH0=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id AD6A145B8A
	for <cygwin-patches@cygwin.com>; Thu, 01 May 2025 15:28:42 -0400 (EDT)
Date: Thu, 1 May 2025 12:28:42 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: docs: flesh out docs for cygwin_conv_path.
Message-ID: <cb20f137-46cb-eab9-27e9-ca098d1364e5@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Explicitly specify that `from` and `to` are NUL-terminated strings, that
NULL is permitted in `to` when `size` is 0, and that `to` is not
written to in the event of an error (unless it was a fault while writing
to `to`).

Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
---
 winsup/doc/path.xml | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/winsup/doc/path.xml b/winsup/doc/path.xml
index f56614bb68..de1b95a37b 100644
--- a/winsup/doc/path.xml
+++ b/winsup/doc/path.xml
@@ -33,12 +33,12 @@

   <refsect1 id="func-cygwin-conv-path-desc">
     <title>Description</title>
-<para>Use this function to convert POSIX paths in
-<parameter>from</parameter> to Win32 paths in <parameter>to</parameter>
-or, vice versa, Win32 paths in <parameter>from</parameter> to POSIX paths
-in <parameter>to</parameter>.  <parameter>what</parameter>
-defines the direction of this conversion and can be any of the below
-values.</para>
+<para>Use this function to convert NUL-terminated POSIX paths in
+<parameter>from</parameter> to NUL-terminated Win32 paths in
+<parameter>to</parameter> or, vice versa, NUL-terminated Win32 paths in
+<parameter>from</parameter> to NUL-terminated POSIX paths in
+<parameter>to</parameter>.  <parameter>what</parameter> defines the
+direction of this conversion and can be any of the below values.</para>

 <programlisting>
   CCP_POSIX_TO_WIN_A      /* from is char *posix, to is char *win32       */
@@ -62,7 +62,8 @@ default.</para>

 <para><parameter>size</parameter> is the size of the buffer pointed to
 by <parameter>to</parameter> in bytes.  If <parameter>size</parameter>
-is 0, <function>cygwin_conv_path</function> just returns the required
+is 0, <parameter>to</parameter> may be NULL and
+<function>cygwin_conv_path</function> just returns the required
 buffer size in bytes.  Otherwise, it returns 0 on success, or -1 on
 error and errno is set to one of the below values.</para>

@@ -73,6 +74,12 @@ error and errno is set to one of the below values.</para>
                   of what == CCP_POSIX_TO_WIN_A, longer than MAX_PATH.
     ENOSPC        size is less than required for the conversion.
 </programlisting>
+
+<para>In the event of an error, the memory at <parameter>to</parameter> is
+not modified unless the error is <constant>EFAULT</constant> writing to
+the memory at <parameter>to</parameter>, which may happen if
+<parameter>size</parameter> is incorrectly specified.
+
   </refsect1>

   <refsect1 id="func-cygwin-conv-path-example">
-- 
2.49.0.windows.1

