Return-Path: <SRS0=8Yr5=JQ=aosc.io=arthur2e5@sourceware.org>
Received: from relay3.mymailcheap.com (relay3.mymailcheap.com [217.182.119.157])
	by sourceware.org (Postfix) with ESMTPS id 664D442FA07D
	for <cygwin-patches@cygwin.com>; Fri, 27 Nov 2026 12:56:54 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 664D442FA07D
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=aosc.io
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=aosc.io
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 664D442FA07D
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=217.182.119.157
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1795784214; cv=none;
	b=eikxpYD0nCaNnpRZ2ZzbbGB6vLkpPcSWdakauizIJO0brt4mgw/vzV6tVGNBTwIKL5gYnruZDBYte06UwrA+he6ubVzrmzPnKpAWs8OZYehKqS3iqo8GMa/amnlKCgo2GOL/dwWEpbHhZZ2aSpGNKKPUgmnytk1fTYYg9qYrCuk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1795784214; c=relaxed/simple;
	bh=nAOrPdcqMJN1IG9VW5M9fRdmhTL7ITewSeHYQH49rus=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=eLeLdWQBa7Dz/RlwicIKOpRnAje1XMtiioDSCA5TgGyRUnMkOMQdn0shC6kIFr+NxCOWkk9lTDquhb/ZfkHdzmzTNmvaqP1Y7R85626irvsm5jnww0rOTJseK0lR6V4bcgdiiXgrGhPZer+ne75RQ9m1pXT3e6Gj8vs8z/RmDG0=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (1024-bit key, unprotected) header.d=aosc.io header.i=@aosc.io header.a=rsa-sha256 header.s=default header.b=RrFb4vLu
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 664D442FA07D
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=aosc.io header.i=@aosc.io header.a=rsa-sha256 header.s=default header.b=RrFb4vLu
Received: from nf1.mymailcheap.com (nf1.mymailcheap.com [51.75.14.91])
	by relay3.mymailcheap.com (Postfix) with ESMTPS id D61A03EB6B
	for <cygwin-patches@cygwin.com>; Fri, 27 Nov 2026 12:56:52 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.38.223.107])
	by nf1.mymailcheap.com (Postfix) with ESMTPSA id 6062140083
	for <cygwin-patches@cygwin.com>; Fri, 27 Nov 2026 12:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aosc.io; s=default;
	t=1795784208; bh=B+ETrYB2d5hm4iPVS/9RdS7kgME25z/rrYj/G5gSmv4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=RrFb4vLu71SS8chbVA0Bsv4WzgFVEOeSO+CL9tbV/Co33Ffm3gZovcnsHMpzDGiLN
	 02zU2OZlOlmeoIzWpbKIKh0BClHvWrl6MM0nwgnvx2KYbF9Q7ASQM3TpbAgwZ5ZRzO
	 6kRVtYdVoi1Kr9Ke7ZQcYDTE1lFFmXSeqvADgD4M=
Received: from Arisu (unknown [179.253.246.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id 9722EE1FD2
	for <cygwin-patches@cygwin.com>; Fri, 27 Nov 2026 12:56:47 +0000 (UTC)
From: Mingye Wang <arthur2e5@aosc.io>
To: cygwin-patches@cygwin.com
Subject: [PATCH v7 2/3] Cygwin: extract command line tokenizer into next_arg
Date: Fri, 27 Nov 2026 20:56:38 +0800
Message-ID: <20261127125639.2099-3-arthur2e5@aosc.io>
X-Mailer: git-send-email 2.56.0.windows.4.niugit
In-Reply-To: <20261127125639.2099-1-arthur2e5@aosc.io>
References: <20261127125639.2099-1-arthur2e5@aosc.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6062140083
X-Spamd-Result: default: False [1.20 / 10.00];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	R_SPF_ALLOW(-0.10)[+mx];
	R_DKIM_ALLOW(-0.10)[aosc.io:s=default];
	LOCAL_OUTBOUND(0.00)[];
	ASN(0.00)[asn:16276,ipnet:51.38.0.0/16,country:FR];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[aosc.io,quarantine];
	FROM_HAS_DN(0.00)[];
	R_DKIM_ALIGNED(0.00)[strict];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[aosc.io:+];
	PREVIOUSLY_DELIVERED(0.00)[cygwin-patches@cygwin.com];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: nf1.mymailcheap.com
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Pull the per-argument scanning loop out of build_argv into a next_arg
helper in the same file.  Quoting, whitespace handling and the in-place
termination of words are unchanged, so the rewrite can change the
tokenizer instead of the loop around it.

No functional change.  This is an artificial commit, only here to make
the following rewrite's diff readable.

AI was used to perform the refactoring mechanically.

Co-Authored-By: Skadi "Skadeep" Deepseek <noreply@deepseek.com>
---
 winsup/cygwin/winf.cc | 72 ++++++++++++++++++++++++-------------------
 1 file changed, 41 insertions(+), 31 deletions(-)

diff --git a/winsup/cygwin/winf.cc b/winsup/cygwin/winf.cc
index 881438fa42e..a4b2d87d312 100644
--- a/winsup/cygwin/winf.cc
+++ b/winsup/cygwin/winf.cc
@@ -257,6 +257,42 @@ quoted (char *cmd, int winshell)
   return cmd;
 }
 
+/* Grab the next argument from the command line, terminating it in place.
+   Return false when the command line is exhausted.  */
+static bool
+next_arg (char *&cmd, char *&word, char *&sawquote, bool winshell, bool first)
+{
+  while (issep (*cmd))
+    cmd++;
+
+  if (!*cmd)
+    return false;
+
+  word = cmd;
+  sawquote = NULL;
+  while (*cmd)
+    {
+      if (*cmd != '"' && (!winshell || *cmd != '\''))
+	cmd++;			// Skip over this character
+      else
+	/* Skip over characters until the closing quote */
+	{
+	  sawquote = cmd;
+	  /* Handle quoting.  Only strip off quotes if the parent is
+	     a Cygwin process, or if the word starts with a '@'.
+	     In this case, the insert_file function needs an unquoted
+	     DOS filename and globbing isn't performed anyway. */
+	  cmd = quoted (cmd, winshell && !first && *word != '@');
+	}
+      if (issep (*cmd))		// End of argument if space
+	break;
+    }
+  if (*cmd)
+    *cmd++ = '\0';		// Terminate `word'
+
+  return true;
+}
+
 /* Perform a glob on word if it contains wildcard characters.
    Also quote every character between quotes to force glob to
    treat the characters literally. */
@@ -354,6 +390,7 @@ globify (char *word, char **&argv, int &argc, int &argvlen)
   return 1;
 }
 
+
 /* Build argv, argc from string passed from Windows.  */
 
 static void
@@ -366,39 +403,12 @@ build_argv (char *cmd, char **&argv, int &argc, int winshell)
   argvlen = 0;
   argv = NULL;
 
+  char *word;
+  char *sawquote;
+
   /* Scan command line until there is nothing left. */
-  while (*cmd)
+  while (next_arg (cmd, word, sawquote, winshell, argc == 0))
     {
-      /* Ignore spaces */
-      if (issep (*cmd))
-	{
-	  cmd++;
-	  continue;
-	}
-
-      /* Found the beginning of an argument. */
-      char *word = cmd;
-      char *sawquote = NULL;
-      while (*cmd)
-	{
-	  if (*cmd != '"' && (!winshell || *cmd != '\''))
-	    cmd++;		// Skip over this character
-	  else
-	    /* Skip over characters until the closing quote */
-	    {
-	      sawquote = cmd;
-	      /* Handle quoting.  Only strip off quotes if the parent is
-		 a Cygwin process, or if the word starts with a '@'.
-		 In this case, the insert_file function needs an unquoted
-		 DOS filename and globbing isn't performed anyway. */
-	      cmd = quoted (cmd, winshell && argc > 0 && *word != '@');
-	    }
-	  if (issep (*cmd))	// End of argument if space
-	    break;
-	}
-      if (*cmd)
-	*cmd++ = '\0';		// Terminate `word'
-
       /* Possibly look for @file construction assuming that this isn't
 	 the very first argument and the @ wasn't quoted */
       if (argc && sawquote != word && *word == '@')
-- 
2.56.0.windows.4.niugit

