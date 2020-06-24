Return-Path: <arthur2e5@aosc.io>
Received: from relay2.mymailcheap.com (relay2.mymailcheap.com [151.80.165.199])
 by sourceware.org (Postfix) with ESMTPS id CEE623851C19
 for <cygwin-patches@cygwin.com>; Wed, 24 Jun 2020 22:36:34 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org CEE623851C19
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: sourceware.org;
 spf=pass smtp.mailfrom=arthur2e5@aosc.io
Received: from filter1.mymailcheap.com (filter1.mymailcheap.com
 [149.56.130.247])
 by relay2.mymailcheap.com (Postfix) with ESMTPS id 500AF3F163
 for <cygwin-patches@cygwin.com>; Thu, 25 Jun 2020 00:36:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by filter1.mymailcheap.com (Postfix) with ESMTP id 75B042A3AA
 for <cygwin-patches@cygwin.com>; Wed, 24 Jun 2020 18:36:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
 s=default; t=1593038192;
 bh=hohoj5GGhKzKyiZWcIbU2qV9AhjKWP1R9QoOb2pqXDA=;
 h=From:To:Cc:Subject:Date:From;
 b=Hq8r1yJ0DAl4VS2C0VXDdaBy6m2Zx3odjE02dFnTGWMsQMkoW6AGNYf6+F5/6OU/i
 v55Iv8RoCZ9JG2tU0sLGzPVL+nPoSd/bVP1+JXlmycPV8HtRmjasqlee4ryvL6MlfR
 tjC+IHo+K7DJYo0/QUwAi3iLeZd2wGxhTnBL03gU=
X-Virus-Scanned: Debian amavisd-new at filter1.mymailcheap.com
Received: from filter1.mymailcheap.com ([127.0.0.1])
 by localhost (filter1.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FSo_LskkkMSi for <cygwin-patches@cygwin.com>;
 Wed, 24 Jun 2020 18:36:31 -0400 (EDT)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by filter1.mymailcheap.com (Postfix) with ESMTPS
 for <cygwin-patches@cygwin.com>; Wed, 24 Jun 2020 18:36:31 -0400 (EDT)
Received: from [213.133.102.83] (ml.mymailcheap.com [213.133.102.83])
 by mail20.mymailcheap.com (Postfix) with ESMTP id 2AAD940849;
 Wed, 24 Jun 2020 22:36:29 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com; dkim=pass (1024-bit key;
 unprotected) header.d=aosc.io header.i=@aosc.io header.b="bPVR0zSx"; 
 dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from localhost.localdomain (unknown [101.224.24.230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail20.mymailcheap.com (Postfix) with ESMTPSA id 052E6403ED;
 Wed, 24 Jun 2020 22:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
 t=1593038169; bh=hohoj5GGhKzKyiZWcIbU2qV9AhjKWP1R9QoOb2pqXDA=;
 h=From:To:Cc:Subject:Date:From;
 b=bPVR0zSx+lU1qKZrsOm20jNfVJ3acH7Pz8hWvqqN6uPiRyrdcQq7ixZQuEe0T1GUZ
 ab5G2oL9iBMrP1UQg9vPjelHj/vivoNTFctL/yCv1eDO1/CJBmOdFj20gvcI8j1ny9
 ZO8C+NHvvY2WvK87nLWW6casVpM8AfvY3KhyW3Z0=
From: Mingye Wang <arthur2e5@aosc.io>
To: cygwin-patches@cygwin.com
Cc: Mingye Wang <arthur2e5@aosc.io>
Subject: [PATCH] Cygwin: rewrite cmdline parser
Date: Thu, 25 Jun 2020 06:35:53 +0800
Message-Id: <20200624223553.8892-1-arthur2e5@aosc.io>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2AAD940849
X-Spamd-Result: default: False [4.90 / 20.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; R_DKIM_ALLOW(0.00)[aosc.io:s=default];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; DMARC_NA(0.00)[aosc.io];
 BROKEN_CONTENT_TYPE(1.50)[]; R_SPF_SOFTFAIL(0.00)[~all];
 ML_SERVERS(-3.10)[213.133.102.83]; DKIM_TRACE(0.00)[aosc.io:+];
 RCPT_COUNT_TWO(0.00)[2]; MID_CONTAINS_FROM(1.00)[];
 RCVD_IN_DNSWL_NONE(0.00)[213.133.102.83:from];
 RCVD_NO_TLS_LAST(0.10)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+];
 ASN(0.00)[asn:24940, ipnet:213.133.96.0/19, country:DE];
 RCVD_COUNT_TWO(0.00)[2];
 HFILTER_HELO_BAREIP(3.00)[213.133.102.83,1]
X-Rspamd-Server: mail20.mymailcheap.com
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, SPF_HELO_NONE, SPF_PASS,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Wed, 24 Jun 2020 22:36:37 -0000

This commit rewrites the cmdline parser to achieve the following:
* MSVCRT compatibility. Except for the single-quote handling (an
  extension for compatibility with old Cygwin), the parser now
  interprets option boundaries exactly like MSVCR since 2008. This fixes
  the issue where our escaping does not work with our own parsing.
* Clarity. Since globify() is no longer responsible for handling the
  opening and closing of quotes, the code is much simpler.
* Sanity. The GLOB_NOCHECK flag is removed, so a failed glob correctly
  returns the literal value. Without the change, anything path-like
  would be garbled by globify's escaping.

The change fixes two complaints of mine:
* That cygwin is incompatible with its own escape.[1]
* That there is no way to echo `C:\"` from win32.[2]
  [1]: https://cygwin.com/pipermail/cygwin/2020-June/245162.html
  [2]: https://cygwin.com/pipermail/cygwin/2019-October/242790.html

(It's never the point to spawn cygwin32 from cygwin64. Consistency
matters: with yourself always, and with the outside world when you are
supposed to.)
---
 winsup/cygwin/dcrt0.cc | 192 +++++++++++++++++++----------------------
 1 file changed, 88 insertions(+), 104 deletions(-)

diff --git a/winsup/cygwin/dcrt0.cc b/winsup/cygwin/dcrt0.cc
index 5d8b4b74e..71fdda294 100644
--- a/winsup/cygwin/dcrt0.cc
+++ b/winsup/cygwin/dcrt0.cc
@@ -151,43 +151,52 @@ isquote (char c)
   return ch == '"' || ch == '\'';
 }
 
-/* Step over a run of characters delimited by quotes */
+
+/* MSVCRT-like argument parsing.
+ * Parse a word, consuming characters and marking where quoting state is changed. */
 static /*__inline*/ char *
-quoted (char *cmd, int winshell)
+next_arg (char *cmd, char *arg, size_t* quotepos)
 {
-  char *p;
-  char quote = *cmd;
+  int inquote = 0;
+  int nbs = 0;
+  char *start = cmd;
+  char quote = '\0';
 
-  if (!winshell)
+  while (*cmd && (inquote || !issep(*cmd)))
     {
-      char *p;
-      strcpy (cmd, cmd + 1);
-      if (*(p = strchrnul (cmd, quote)))
-	strcpy (p, p + 1);
-      return p;
-    }
+      if (*cmd == '\\')
+	{
+	  nbs += 1;
+	  continue;
+	}
 
-  const char *s = quote == '\'' ? "'" : "\\\"";
-  /* This must have been run from a Windows shell, so preserve
-     quotes for globify to play with later. */
-  while (*cmd && *++cmd)
-    if ((p = strpbrk (cmd, s)) == NULL)
-      {
-	cmd = strchr (cmd, '\0');	// no closing quote
-	break;
-      }
-    else if (*p == '\\')
-      cmd = ++p;
-    else if (quote == '"' && p[1] == '"')
-      {
-	*p = '\\';
-	cmd = ++p;			// a quoted quote
-      }
-    else
-      {
-	cmd = p + 1;		// point to after end
-	break;
-      }
+      // For anything else, sort out backslashes first.
+      memset(arg, '\\', nbs / 2);
+      arg += nbs / 2;
+
+      // Single-quote is our addition.
+      if (nbs % 2 == 0 && (inquote ? *cmd == quote : isquote(*cmd)))
+	{
+	  // The infamous "" special case: emit literal '"', no change.
+	  if (inquote && *cmd == '"' && cmd[1] == '"')
+	    *arg++ = *cmd++;
+	  else
+	    {
+	      if (!inquote)
+		quote = *cmd;
+	      inquote = !inquote;
+	      *quotepos++ = cmd - start;
+	    }
+	}
+      else
+	{
+	  *arg++ = *cmd;
+	}
+
+      nbs = 0;
+      cmd++;
+    }
+  *arg = '\0';
   return cmd;
 }
 
@@ -202,67 +211,60 @@ quoted (char *cmd, int winshell)
 			    && isalpha ((s)[2]) \
 			    && strchr ((s) + 3, '\\')))
 
+/* Call glob(3) on the word, and fill argv accordingly.
+ * If the input looks like a DOS path, double up backslashes.
+ */
 static int __stdcall
-globify (char *word, char **&argv, int &argc, int &argvlen)
+globify (char *word, size_t *quotepos, char **&argv, int &argc, int &argvlen)
 {
   if (*word != '~' && strpbrk (word, "?*[\"\'(){}") == NULL)
     return 0;
 
-  int n = 0;
-  char *p, *s;
-  int dos_spec = is_dos_path (word);
-  if (!dos_spec && isquote (*word) && word[1] && word[2])
-    dos_spec = is_dos_path (word + 1);
-
   /* We'll need more space if there are quoting characters in
      word.  If that is the case, doubling the size of the
      string should provide more than enough space. */
-  if (strpbrk (word, "'\""))
-    n = strlen (word);
+  int n = quotepos[0] == SIZE_MAX ? 0 : strlen(word);
+  char *p, *s;
+  int dos_spec = is_dos_path (word);
   char pattern[strlen (word) + ((dos_spec + 1) * n) + 1];
+  int inquote = 0;
 
   /* Fill pattern with characters from word, quoting any
      characters found within quotes. */
   for (p = pattern, s = word; *s != '\000'; s++, p++)
-    if (!isquote (*s))
-      {
-	if (dos_spec && *s == '\\')
-	  *p++ = '\\';
-	*p = *s;
-      }
-    else
-      {
-	char quote = *s;
-	while (*++s && *s != quote)
-	  {
-	    if (dos_spec || *s != '\\')
-	      /* nothing */;
-	    else if (s[1] == quote || s[1] == '\\')
-	      s++;
+    {
+      if (*quotepos == s - word)
+	{
+	  inquote = !inquote;
+	  quotepos++;
+	}
+      if (!inquote)
+	{
+	  if (dos_spec && *s == '\\')
 	    *p++ = '\\';
-	    size_t cnt = isascii (*s) ? 1 : mbtowc (NULL, s, MB_CUR_MAX);
-	    if (cnt <= 1 || cnt == (size_t)-1)
-	      *p++ = *s;
-	    else
-	      {
-		--s;
-		while (cnt-- > 0)
-		  *p++ = *++s;
-	      }
-	  }
-	if (*s == quote)
-	  p--;
-	if (*s == '\0')
-	    break;
-      }
-
+	  *p = *s;
+	}
+      else
+	{
+	  *p++ = '\\';
+	  int cnt = isascii (*s) ? 1 : mbtowc (NULL, s, MB_CUR_MAX);
+	  if (cnt <= 1)
+	    *p = *s;
+	  else
+	    {
+	      memcpy(p, s, cnt);
+	      p += cnt - 1;
+	      s += cnt - 1;
+	    }
+	}
+    }
   *p = '\0';
 
   glob_t gl;
   gl.gl_offs = 0;
 
   /* Attempt to match the argument.  Return just word (minus quoting) if no match. */
-  if (glob (pattern, GLOB_TILDE | GLOB_NOCHECK | GLOB_BRACE | GLOB_QUOTE, NULL, &gl) || !gl.gl_pathc)
+  if (glob (pattern, GLOB_TILDE | GLOB_BRACE | GLOB_QUOTE, NULL, &gl) || !gl.gl_pathc)
     return 0;
 
   /* Allocate enough space in argv for the matched filenames. */
@@ -288,12 +290,14 @@ globify (char *word, char **&argv, int &argc, int &argvlen)
 }
 
 /* Build argv, argc from string passed from Windows.  */
-
 static void __stdcall
-build_argv (char *cmd, char **&argv, int &argc, int winshell)
+build_argv (char *cmd, char **&argv, int &argc, int doglob)
 {
   int argvlen = 0;
   int nesting = 0;		// monitor "nesting" from insert_file
+  char *word = (char *) malloc(strlen(cmd) + 1);
+  // Locations for quote transition. We can trim this down to 32767 later.
+  size_t *quotepos = (size_t *) malloc(strlen(cmd) * sizeof(size_t));
 
   argc = 0;
   argvlen = 0;
@@ -302,39 +306,17 @@ build_argv (char *cmd, char **&argv, int &argc, int winshell)
   /* Scan command line until there is nothing left. */
   while (*cmd)
     {
-      /* Ignore spaces */
-      if (issep (*cmd))
+      while (issep(*cmd))
 	{
 	  cmd++;
 	  continue;
 	}
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
+      quotepos[0] = SIZE_MAX;
+      cmd = next_arg (cmd, word, quotepos);
 
       /* Possibly look for @file construction assuming that this isn't
 	 the very first argument and the @ wasn't quoted */
-      if (argc && sawquote != word && *word == '@')
+      if (argc && quotepos[0] > 1 && *word == '@')
 	{
 	  if (++nesting > MAX_AT_FILE_LEVEL)
 	    api_fatal ("Too many levels of nesting for %s", word);
@@ -350,16 +332,18 @@ build_argv (char *cmd, char **&argv, int &argc, int winshell)
 	}
 
       /* Add word to argv file after (optional) wildcard expansion. */
-      if (!winshell || !argc || !globify (word, argv, argc, argvlen))
+      if (!doglob || !argc || !globify (word, quotepos, argv, argc, argvlen))
 	{
 	  debug_printf ("argv[%d] = '%s'", argc, word);
-	  argv[argc++] = word;
+	  argv[argc++] = strdup(word);
 	}
     }
 
   if (argv)
     argv[argc] = NULL;
 
+  free(word);
+  free(quotepos);
   debug_printf ("argc %d", argc);
 }
 
@@ -1064,7 +1048,7 @@ _dll_crt0 ()
 	  if (stackaddr)
 	    {
 	      /* Set stack pointer to new address.  Set frame pointer to
-	         stack pointer and subtract 32 bytes for shadow space. */
+		 stack pointer and subtract 32 bytes for shadow space. */
 	      __asm__ ("\n\
 		       movq %[ADDR], %%rsp \n\
 		       movq  %%rsp, %%rbp  \n\
-- 
2.20.1.windows.1
