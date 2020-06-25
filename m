Return-Path: <arthur2e5@aosc.io>
Received: from relay1.mymailcheap.com (relay1.mymailcheap.com
 [144.217.248.102])
 by sourceware.org (Postfix) with ESMTPS id A5D703858D34
 for <cygwin-patches@cygwin.com>; Thu, 25 Jun 2020 14:45:24 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org A5D703858D34
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: sourceware.org;
 spf=pass smtp.mailfrom=arthur2e5@aosc.io
Received: from filter2.mymailcheap.com (filter2.mymailcheap.com
 [91.134.140.82])
 by relay1.mymailcheap.com (Postfix) with ESMTPS id 1A6423ECE3
 for <cygwin-patches@cygwin.com>; Thu, 25 Jun 2020 10:45:24 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by filter2.mymailcheap.com (Postfix) with ESMTP id 348EC2A514
 for <cygwin-patches@cygwin.com>; Thu, 25 Jun 2020 16:45:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
 s=default; t=1593096323;
 bh=VsA8yfcsURTD9zB3yx5UiiG/igbjBGmpV7AlMDXAjwk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=flrmmsqJGH9K6LcT78NJkL4GHYu46D4adLLxYz8A7PkHxsB2Oh99WvOjIlw8O88oS
 3CwvgQEQoEKRn5DUxvX86M6P3AELUZtZ/g3uOwxUJi3zb9J6pvlQa/V4tN0zf+EAtK
 hqJNlvOQ2hm+ICljPJwA3a9mKjdDasL+GrvntUjE=
X-Virus-Scanned: Debian amavisd-new at filter2.mymailcheap.com
Received: from filter2.mymailcheap.com ([127.0.0.1])
 by localhost (filter2.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zvqL-DyIuPjH for <cygwin-patches@cygwin.com>;
 Thu, 25 Jun 2020 16:45:21 +0200 (CEST)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by filter2.mymailcheap.com (Postfix) with ESMTPS
 for <cygwin-patches@cygwin.com>; Thu, 25 Jun 2020 16:45:21 +0200 (CEST)
Received: from [148.251.23.173] (ml.mymailcheap.com [148.251.23.173])
 by mail20.mymailcheap.com (Postfix) with ESMTP id E2F4D403ED;
 Thu, 25 Jun 2020 14:45:19 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com; dkim=pass (1024-bit key;
 unprotected) header.d=aosc.io header.i=@aosc.io header.b="aUcBsIBU"; 
 dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from localhost.localdomain (unknown [101.224.24.230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail20.mymailcheap.com (Postfix) with ESMTPSA id 0D4D6403ED;
 Thu, 25 Jun 2020 14:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
 t=1593096222; bh=VsA8yfcsURTD9zB3yx5UiiG/igbjBGmpV7AlMDXAjwk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=aUcBsIBUZLl9aEh+VPMnTrAPa5xS//xguyZaLYZjpD7bUfSrmQWklkTqBMrYKomIj
 VtKNMw6+rlU3s1DE48SdR9N5s11RrzU8JA9bHafHoOgE4KBr1TuDjZadYGHkbU4xRT
 0P0TVm5Q8LDdVRv2HjuIqU7iVCT53ac6znsMfQYE=
From: Mingye Wang <arthur2e5@aosc.io>
To: cygwin-patches@cygwin.com
Cc: Mingye Wang <arthur2e5@aosc.io>
Subject: [PATCH v2] Cygwin: rewrite cmdline parser
Date: Thu, 25 Jun 2020 22:43:15 +0800
Message-Id: <20200625144315.12388-1-arthur2e5@aosc.io>
X-Mailer: git-send-email 2.20.1.windows.1
In-Reply-To: <20200624223553.8892-1-arthur2e5@aosc.io>
References: <20200624223553.8892-1-arthur2e5@aosc.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E2F4D403ED
X-Spamd-Result: default: False [4.90 / 20.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; R_DKIM_ALLOW(0.00)[aosc.io:s=default];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; DMARC_NA(0.00)[aosc.io];
 BROKEN_CONTENT_TYPE(1.50)[]; R_SPF_SOFTFAIL(0.00)[~all];
 ML_SERVERS(-3.10)[148.251.23.173]; DKIM_TRACE(0.00)[aosc.io:+];
 RCPT_COUNT_TWO(0.00)[2]; MID_CONTAINS_FROM(1.00)[];
 RCVD_NO_TLS_LAST(0.10)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+];
 ASN(0.00)[asn:24940, ipnet:148.251.0.0/16, country:DE];
 RCVD_COUNT_TWO(0.00)[2];
 HFILTER_HELO_BAREIP(3.00)[148.251.23.173,1]
X-Rspamd-Server: mail20.mymailcheap.com
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Thu, 25 Jun 2020 14:45:27 -0000

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

Some clarifications are made in the documentation for when globs are not
expanded.  A minor change was made to insert_file to remove the memory
leak with multiple files.

The change fixes two complaints of mine:
* That cygwin is incompatible with its own escape.[1]
* That there is no way to echo `C:\"` from win32.[2]
  [1]: https://cygwin.com/pipermail/cygwin/2020-June/245162.html
  [2]: https://cygwin.com/pipermail/cygwin/2019-October/242790.html

(It's never the point to spawn cygwin32 from cygwin64. Consistency
matters: with yourself always, and with the outside world when you are
supposed to.)

---

This is the second version of the patch.  Changes include:
* Remove unnecessary allocations (do word in-place, realloc quotepos).
* Match MSVCRT backslash rules for unquoted.
* Make quotepos actually refer to out (smoke test).
* Pack up argument iteration a bit better.
* Edit documentation and insert_file.
---
 winsup/cygwin/dcrt0.cc   | 228 +++++++++++++++++++--------------------
 winsup/cygwin/winsup.h   |   4 +
 winsup/doc/cygwinenv.xml |   8 +-
 winsup/doc/faq-api.xml   |   2 +-
 4 files changed, 121 insertions(+), 121 deletions(-)

diff --git a/winsup/cygwin/dcrt0.cc b/winsup/cygwin/dcrt0.cc
index 5d8b4b74e..d16a24dd9 100644
--- a/winsup/cygwin/dcrt0.cc
+++ b/winsup/cygwin/dcrt0.cc
@@ -84,7 +84,7 @@ do_global_ctors (void (**in_pfunc)(), int force)
  * @foo and not the contents of foo.
  */
 static bool __stdcall
-insert_file (char *name, char *&cmd)
+insert_file (const char *name, char *&cmd, int free_old)
 {
   HANDLE f;
   DWORD size;
@@ -140,6 +140,8 @@ insert_file (char *name, char *&cmd)
 
   tmp[size++] = ' ';
   strcpy (tmp + size, cmd);
+  if (free_old)
+    free (cmd);
   cmd = tmp;
   return true;
 }
@@ -151,44 +153,68 @@ isquote (char c)
   return ch == '"' || ch == '\'';
 }
 
-/* Step over a run of characters delimited by quotes */
-static /*__inline*/ char *
-quoted (char *cmd, int winshell)
+/* MSVCRT-like argument parsing.
+ * Parse a word in-place, consuming characters and marking where quoting state is changed. */
+static /*__inline*/ bool
+next_arg (char *&cmd, char *&arg, size_t* quotepos, size_t &quotesize)
 {
-  char *p;
-  char quote = *cmd;
+  bool inquote = false;
+  size_t nbs = 0;
+  char quote = '\0';
+  quotepos[0] = SIZE_MAX;
+  size_t nquotes = 0;
+
+  while (*cmd && issep (*cmd))
+    cmd++;
 
-  if (!winshell)
+  arg = cmd;
+  char *out = arg;
+
+  for (;*cmd && (inquote || !issep (*cmd)); cmd++)
     {
-      char *p;
-      strcpy (cmd, cmd + 1);
-      if (*(p = strchrnul (cmd, quote)))
-	strcpy (p, p + 1);
-      return p;
+      if (*cmd == '\\')
+	{
+	  nbs += 1;
+	  continue;
+	}
+
+      // For anything else, sort out backslashes first.
+      memset (out, '\\', inquote ? nbs / 2 : nbs);
+      out += inquote ? nbs / 2 : nbs;
+
+      // Single-quote is our addition.  Would love to remove it.
+      if (nbs % 2 == 0 && (inquote ? *cmd == quote : isquote (*cmd)))
+	{
+	  /* The infamous "" special case: emit literal '"', no change.
+	   *
+	   * Makes quotepos tracking easier, so applies to single quote too:
+	   * without this handling, an out pos can contain many state changes,
+	   * so a check must be done before appending. */
+	  if (inquote && *cmd == quote && cmd[1] == quote)
+	    *out++ = *cmd++;
+	  else
+	    {
+	      if (!inquote)
+		quote = *cmd;
+	      if (++nquotes >= quotesize)
+		quotepos = realloc_type(quotepos, quotesize *= 2, size_t);
+	      quotepos[nquotes] = out - arg + inquote;
+	      inquote = !inquote;
+	    }
+	}
+      else
+	{
+	  *out++ = *cmd;
+	}
+
+      nbs = 0;
     }
 
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
-  return cmd;
+  if (*cmd)
+    cmd++;
+
+  *out = '\0';
+  return arg != cmd;
 }
 
 /* Perform a glob on word if it contains wildcard characters.
@@ -202,67 +228,62 @@ quoted (char *cmd, int winshell)
 			    && isalpha ((s)[2]) \
 			    && strchr ((s) + 3, '\\')))
 
+/* Call glob(3) on the word, and fill argv accordingly.
+ * If the input looks like a DOS path, double up backslashes.
+ */
 static int __stdcall
-globify (char *word, char **&argv, int &argc, int &argvlen)
+globify (const char *word, size_t *quotepos, size_t quotesize, char **&argv, int &argc, int &argvlen)
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
+  size_t n = quotepos[0] == SIZE_MAX ? 0 : strlen (word);
+  char *p;
+  const char *s;
+  int dos_spec = is_dos_path (word);
   char pattern[strlen (word) + ((dos_spec + 1) * n) + 1];
+  bool inquote = false;
+  size_t nquotes = 0;
 
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
+      if (nquotes < quotesize && quotepos[nquotes] == s - word)
+	{
+	  inquote = !inquote;
+	  nquotes++;
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
+	      memcpy (p, s, cnt);
+	      p += cnt - 1;
+	      s += cnt - 1;
+	    }
+	}
+    }
   *p = '\0';
 
   glob_t gl;
   gl.gl_offs = 0;
 
-  /* Attempt to match the argument.  Return just word (minus quoting) if no match. */
-  if (glob (pattern, GLOB_TILDE | GLOB_NOCHECK | GLOB_BRACE | GLOB_QUOTE, NULL, &gl) || !gl.gl_pathc)
+  /* Attempt to match the argument.  Bail if no match. */
+  if (glob (pattern, GLOB_TILDE | GLOB_BRACE, NULL, &gl) || !gl.gl_pathc)
     return 0;
 
   /* Allocate enough space in argv for the matched filenames. */
@@ -278,7 +299,7 @@ globify (char *word, char **&argv, int &argc, int &argvlen)
   char **av = argv + n;
   while (*gv)
     {
-      debug_printf ("argv[%d] = '%s'", n++, *gv);
+      debug_printf ("argv[%zu] = '%s'", n++, *gv);
       *av++ = *gv++;
     }
 
@@ -288,58 +309,31 @@ globify (char *word, char **&argv, int &argc, int &argvlen)
 }
 
 /* Build argv, argc from string passed from Windows.  */
-
 static void __stdcall
-build_argv (char *cmd, char **&argv, int &argc, int winshell)
+build_argv (char *cmd, char **&argv, int &argc, int doglob)
 {
   int argvlen = 0;
   int nesting = 0;		// monitor "nesting" from insert_file
 
+  // Would be a bad idea to use alloca due to insert_file.
+  size_t quotesize = 32;
+  size_t *quotepos = malloc_type(quotesize, size_t);
+
   argc = 0;
   argvlen = 0;
   argv = NULL;
 
   /* Scan command line until there is nothing left. */
-  while (*cmd)
+  while (next_arg (cmd, word, quotepos, quotesize))
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
-      if (argc && sawquote != word && *word == '@')
+      if (argc && quotepos[0] > 1 && *word == '@')
 	{
 	  if (++nesting > MAX_AT_FILE_LEVEL)
 	    api_fatal ("Too many levels of nesting for %s", word);
-	  if (insert_file (word, cmd))
-	      continue;			// There's new stuff in cmd now
+	  if (insert_file (word, cmd, nesting - 1))
+	    continue;  // There's new stuff in cmd now
 	}
 
       /* See if we need to allocate more space for argv */
@@ -350,16 +344,18 @@ build_argv (char *cmd, char **&argv, int &argc, int winshell)
 	}
 
       /* Add word to argv file after (optional) wildcard expansion. */
-      if (!winshell || !argc || !globify (word, argv, argc, argvlen))
+      if (!doglob || !argc || !globify (word, quotepos, quotesize, argv, argc, argvlen))
 	{
 	  debug_printf ("argv[%d] = '%s'", argc, word);
-	  argv[argc++] = word;
+	  argv[argc++] = strdup (word);
 	}
     }
 
   if (argv)
     argv[argc] = NULL;
 
+  free (word);
+  free (quotepos);
   debug_printf ("argc %d", argc);
 }
 
@@ -1064,7 +1060,7 @@ _dll_crt0 ()
 	  if (stackaddr)
 	    {
 	      /* Set stack pointer to new address.  Set frame pointer to
-	         stack pointer and subtract 32 bytes for shadow space. */
+		 stack pointer and subtract 32 bytes for shadow space. */
 	      __asm__ ("\n\
 		       movq %[ADDR], %%rsp \n\
 		       movq  %%rsp, %%rbp  \n\
diff --git a/winsup/cygwin/winsup.h b/winsup/cygwin/winsup.h
index fff7d18f3..f09d6d89e 100644
--- a/winsup/cygwin/winsup.h
+++ b/winsup/cygwin/winsup.h
@@ -151,6 +151,10 @@ extern int cygserver_running;
 #define isabspath(p) \
   (isdirsep (*(p)) || (isalpha (*(p)) && (p)[1] == ':' && (!(p)[2] || isdirsep ((p)[2]))))
 
+/* Shortcut.  See also std::add_pointer. */
+#define malloc_type(n, type) ((type *) malloc ((n) * sizeof (type)))
+#define realloc_type(b, n, type) ((type *) realloc (b, (n) * sizeof (type)))
+
 /******************** Initialization/Termination **********************/
 
 class per_process;
diff --git a/winsup/doc/cygwinenv.xml b/winsup/doc/cygwinenv.xml
index f549fee0d..54ee93443 100644
--- a/winsup/doc/cygwinenv.xml
+++ b/winsup/doc/cygwinenv.xml
@@ -34,10 +34,10 @@ There is no default set.
 </listitem>
 
 <listitem>
-<para><envar>(no)glob[:ignorecase]</envar> - if set, command line arguments
-containing UNIX-style file wildcard characters (brackets, braces, question mark,
-asterisk, escaped with \) are expanded into lists of files that match 
-those wildcards.
+<para><envar>(no)glob[:ignorecase]</envar> - if set, unquoted
+command line arguments containing UNIX-style file wildcard characters (brackets,
+braces, question mark, asterisk, escaped with \) are expanded into lists of
+files that match those wildcards.  Leading tildes are expanded.
 This is applicable only to programs run from non-Cygwin programs such as a CMD prompt.
 That means that this setting does not affect globbing operations for shells such as
 bash, sh, tcsh, zsh, etc.
diff --git a/winsup/doc/faq-api.xml b/winsup/doc/faq-api.xml
index 313f15d37..f09dd0b11 100644
--- a/winsup/doc/faq-api.xml
+++ b/winsup/doc/faq-api.xml
@@ -169,7 +169,7 @@ for the old executable and any dll into per-user subdirectories in the
 <para>If the DLL thinks it was invoked from a DOS style prompt, it runs a
 `globber' over the arguments provided on the command line.  This means
 that if you type <literal>LS *.EXE</literal> from DOS, it will do what you might
-expect.
+expect.  This only happens to the unquoted parts.
 </para>
 <para>Beware: globbing uses <literal>malloc</literal>.  If your application defines
 <literal>malloc</literal>, that will get used.  This may do horrible things to you.
-- 
2.20.1.windows.1
