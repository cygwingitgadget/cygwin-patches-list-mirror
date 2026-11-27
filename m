Return-Path: <SRS0=8Yr5=JQ=aosc.io=arthur2e5@sourceware.org>
Received: from relay1.mymailcheap.com (relay1.mymailcheap.com [144.217.248.102])
	by sourceware.org (Postfix) with ESMTPS id 2F89642F9C1E
	for <cygwin-patches@cygwin.com>; Fri, 27 Nov 2026 12:56:55 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 2F89642F9C1E
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=aosc.io
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=aosc.io
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 2F89642F9C1E
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=144.217.248.102
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1795784215; cv=none;
	b=uiBEBFJ070WeSCIg2JLqqN22of6dbGE+WUfl0+Tx5xYKQFalc8EhkduV7RNhV89J6kPlAtiTy67DZw1klfQh8bRPGbpeFLZ5Ub80U29sm/2oPofr68C48f+bMnrRvm8NI3kMwosQwEhiEYLDExnsNLBl4Tt+1dkVsX0yMqzpR/0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1795784215; c=relaxed/simple;
	bh=MaHIP8J0I5GXmGLjQRjPb0rshmGg9I6LYcOJQ3NlF5s=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=jk7RTgEe/5E2KWd5U6egKkEyVHmokv/Dy0lq8e8H47TXP56+TgjNoCvq6GOUrdms3qJQyz0jO46g7b+hvba5tXTiNpBXZiPWmEsAj8lq2glhPvUVkvThLer9cOH13ACNtD/PcVrT0ipYYf3wn/nzKHHWJCrN9oCsIpkIQEafkMI=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (1024-bit key, unprotected) header.d=aosc.io header.i=@aosc.io header.a=rsa-sha256 header.s=default header.b=pKCY5qWN
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2F89642F9C1E
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=aosc.io header.i=@aosc.io header.a=rsa-sha256 header.s=default header.b=pKCY5qWN
Received: from nf2.mymailcheap.com (nf2.mymailcheap.com [54.39.180.165])
	by relay1.mymailcheap.com (Postfix) with ESMTPS id CFC583EADF
	for <cygwin-patches@cygwin.com>; Fri, 27 Nov 2026 12:56:54 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.38.223.107])
	by nf2.mymailcheap.com (Postfix) with ESMTPSA id 64E4D40080
	for <cygwin-patches@cygwin.com>; Fri, 27 Nov 2026 12:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aosc.io; s=default;
	t=1795784209; bh=D+YVrTi9Rw9hzh2balOBC0/K4xV07BEYPxp8u7qdR8k=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=pKCY5qWNiOWJDlwNRdiL5vZkDHyiU+LSupnnRnza8G20LQAGDb0aMWRr1DNU8TW3k
	 8nBmgyovrIE2wR4Bibi7self9MRnEEq4gCccabwYo5Xf9Y2IAn7A6EYQOP6lBh7IRy
	 +hwwLfjaer11ERPLEVmyqh18fJLnqkSww49YqdxM=
Received: from Arisu (unknown [179.253.246.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id D9FA1E1FD5
	for <cygwin-patches@cygwin.com>; Fri, 27 Nov 2026 12:56:48 +0000 (UTC)
From: Mingye Wang <arthur2e5@aosc.io>
To: cygwin-patches@cygwin.com
Subject: [PATCH v7 3/3] Cygwin: rewrite cmdline parser
Date: Fri, 27 Nov 2026 20:56:39 +0800
Message-ID: <20261127125639.2099-4-arthur2e5@aosc.io>
X-Mailer: git-send-email 2.56.0.windows.4.niugit
In-Reply-To: <20261127125639.2099-1-arthur2e5@aosc.io>
References: <20261127125639.2099-1-arthur2e5@aosc.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[aosc.io:+];
	PREVIOUSLY_DELIVERED(0.00)[cygwin-patches@cygwin.com];
	TO_DN_NONE(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[aosc.io,quarantine];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	R_DKIM_ALIGNED(0.00)[strict];
	FROM_EQ_ENVFROM(0.00)[];
	TEXT_WORDS_TRUNCATED(0.00)[sampled=1]
X-Rspamd-Queue-Id: 64E4D40080
X-Rspamd-Server: nf2.mymailcheap.com
X-Rspamd-Action: no action
X-Spam-Status: No, score=-11.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

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
* A memory leak in the @file expansion is removed by rewriting it to use
  a stack of buffers. This also simplifies the code since we no longer
  have to move stuff. The "downside" is that tokens can no longer cross
  file boundaries.

Some clarifications are made in the documentation for when globs are not
expanded.

The change fixes two complaints of mine:
* That cygwin is incompatible with its own escape.[1]
* That there is no way to echo `C:\"` from win32.[2]
  [1]: https://cygwin.com/pipermail/cygwin/2020-June/245162.html
  [2]: https://cygwin.com/pipermail/cygwin/2019-October/242790.html

(It's never the point to spawn cygwin32 from cygwin64. Consistency
matters: with yourself always, and with the outside world when you are
supposed to.)

This is the seventh version of the patch, having fixed issues with
compilation, rebased to the latest version, and tested by replacing
cygwin1.dll.

AI was used to automate patch-rebasing and testing.
It did not write any non-trivial new code.
It did find a bug related to trailing backslash recovery!

Co-Authored-By: Skadi "Skadeep" Deepseek <noreply@deepseek.com>
---
 winsup/cygwin/dcrt0.cc                |  11 +-
 winsup/cygwin/local_includes/winf.h   |   4 +-
 winsup/cygwin/local_includes/winsup.h |   7 +-
 winsup/cygwin/winf.cc                 | 374 +++++++++++++++-----------
 winsup/doc/cygwinenv.xml              |   8 +-
 winsup/doc/faq-api.xml                |   2 +-
 6 files changed, 231 insertions(+), 175 deletions(-)

diff --git a/winsup/cygwin/dcrt0.cc b/winsup/cygwin/dcrt0.cc
index f41feb98ac4..d652fb30f21 100644
--- a/winsup/cygwin/dcrt0.cc
+++ b/winsup/cygwin/dcrt0.cc
@@ -37,6 +37,8 @@ details. */
 #include "ntdll.h"
 #include "winf.h"
 
+#define MAX_AT_FILE_LEVEL 10
+
 #define PREMAIN_LEN (sizeof (user_data->premain) / sizeof (user_data->premain[0]))
 
 extern "C" void cygwin_exit (int) __attribute__ ((noreturn));
@@ -622,8 +624,13 @@ dll_crt0_1 (void *)
 
       /* Scan the command line and build argv.  Expand wildcards if not
 	 called from another cygwin process. */
-      build_argv (line, __argv, __argc,
-		  NOTSTATE (myself, PID_CYGPARENT) && allow_glob);
+      __argc = cygwin_cmdline_parse (line, &__argv, NULL,
+		NOTSTATE (myself, PID_CYGPARENT) && allow_glob, MAX_AT_FILE_LEVEL);
+
+      if (__argc == -EMLINK)
+	api_fatal ("Too many levels of nesting for %s", line);
+      else if (__argc < 0)
+	api_fatal ("%s for parsing cmdline %s", strerror(-__argc), line);
 
       /* Convert argv[0] to posix rules if it's currently blatantly
 	 win32 style. */
diff --git a/winsup/cygwin/local_includes/winf.h b/winsup/cygwin/local_includes/winf.h
index c5a8050f9c6..13aacd5c556 100644
--- a/winsup/cygwin/local_includes/winf.h
+++ b/winsup/cygwin/local_includes/winf.h
@@ -78,7 +78,7 @@ class linebuf
   void add (const char *what) {add (what, strlen (what));}
   void prepend (const char *, int);
   void finish (bool);
-  bool fromargv(av&, const char *, bool);;
+  bool fromargv(av&, const char *, bool, bool fq = false);;
   operator size_t () const { return ix + 1; }
   operator const char * () const { return buf; }
   operator wchar_t * ()
@@ -100,4 +100,4 @@ class linebuf
   }
 };
 
-void build_argv (char *cmd, char **&argv, int &argc, int winshell);
+extern "C" int cygwin_cmdline_parse (char *cmd, char ***pargv, char **allocs, int doglob, int maxfile);
diff --git a/winsup/cygwin/local_includes/winsup.h b/winsup/cygwin/local_includes/winsup.h
index 6841d4a59fb..f5daf780d3d 100644
--- a/winsup/cygwin/local_includes/winsup.h
+++ b/winsup/cygwin/local_includes/winsup.h
@@ -133,9 +133,6 @@ extern int cygserver_running;
 
 #define set_api_fatal_return(n) do {extern int __api_fatal_exit_val; __api_fatal_exit_val = (n);} while (0)
 
-#undef issep
-#define issep(ch) (strchr (" \t\n\r", (ch)) != NULL)
-
 /* Treats "X:" as absolute path.
    FIXME: We should drop the notion that "X:" is a valid absolute path.
    Only "X:/" and "X:\\" should be (see isabspath_strict below).  The
@@ -147,6 +144,10 @@ extern int cygserver_running;
 #define isabspath_strict(p) \
   (isdirsep (*(p)) || (isalpha (*(p)) && (p)[1] == ':' && isdirsep ((p)[2])))
 
+/* Shortcut.  See also std::add_pointer. */
+#define malloc_type(n, type) ((type *) malloc ((n) * sizeof (type)))
+#define realloc_type(b, n, type) ((type *) realloc ((b), (n) * sizeof (type)))
+
 /******************** Initialization/Termination **********************/
 
 class per_process;
diff --git a/winsup/cygwin/winf.cc b/winsup/cygwin/winf.cc
index a4b2d87d312..532e071de35 100644
--- a/winsup/cygwin/winf.cc
+++ b/winsup/cygwin/winf.cc
@@ -15,17 +15,17 @@ details. */
 #include "tls_pbuf.h"
 #include "winf.h"
 #include "sys/cygwin.h"
-#include <ctype.h>
 #include "glob.h"
+#include <stdio.h>
 
 void
-linebuf::finish (bool cmdlenoverflow_ok)
+linebuf::finish (bool trunc_for_cygwin)
 {
   if (!ix)
     add ("", 1);
   else
     {
-      if (ix-- > MAXCYGWINCMDLEN && cmdlenoverflow_ok)
+      if (ix-- > MAXCYGWINCMDLEN && trunc_for_cygwin)
 	ix = MAXCYGWINCMDLEN - 1;
       buf[ix] = '\0';
     }
@@ -65,7 +65,7 @@ linebuf::prepend (const char *what, int len)
 }
 
 bool
-linebuf::fromargv (av& newargv, const char *real_path, bool cmdlenoverflow_ok)
+linebuf::fromargv (av& newargv, const char *real_path, bool trunc_for_cygwin, bool forcequote)
 {
   bool success = true;
   for (int i = 0; i < newargv.argc; i++)
@@ -75,7 +75,7 @@ linebuf::fromargv (av& newargv, const char *real_path, bool cmdlenoverflow_ok)
 
       a = i ? newargv[i] : (char *) real_path;
       int len = strlen (a);
-      if (len != 0 && !strpbrk (a, " \t\n\r\""))
+      if (len != 0 && !forcequote && !strpbrk (a, " \t\n\r\""))
 	add (a, len);
       else
 	{
@@ -113,7 +113,7 @@ linebuf::fromargv (av& newargv, const char *real_path, bool cmdlenoverflow_ok)
       add (" ", 1);
     }
 
-  finish (cmdlenoverflow_ok);
+  finish (trunc_for_cygwin);
 
   if (ix >= MAXWINCMDLEN)
     {
@@ -141,23 +141,18 @@ av::unshift (const char *what)
   return 1;
 }
 
-#define MAX_AT_FILE_LEVEL 10
-
 /*
- * Replaces @file in the command line with the contents of the file.
- * There may be multiple @file's in a single command line
- * A \@file is replaced with @file so that echo \@foo would print
- * @foo and not the contents of foo.
+ * Read a file into a newly-allocated buffer.
  */
-static bool
-insert_file (char *name, char *&cmd)
+static char *
+read_file (const char *name)
 {
   HANDLE f;
   DWORD size;
   tmp_pathbuf tp;
 
   PWCHAR wname = tp.w_get ();
-  sys_mbstowcs (wname, NT_MAX_PATH, name + 1);
+  sys_mbstowcs (wname, NT_MAX_PATH, name);	/* FIXME: Do we need \\?\ ? */
   f = CreateFileW (wname,
 		   GENERIC_READ,		/* open for reading	*/
 		   FILE_SHARE_VALID_FLAGS,      /* share for reading	*/
@@ -169,7 +164,7 @@ insert_file (char *name, char *&cmd)
   if (f == INVALID_HANDLE_VALUE)
     {
       debug_printf ("couldn't open file '%s', %E", name);
-      return false;
+      return NULL;
     }
 
   /* This only supports files up to about 4 billion bytes in
@@ -180,34 +175,29 @@ insert_file (char *name, char *&cmd)
     {
       CloseHandle (f);
       debug_printf ("couldn't get file size for '%s', %E", name);
-      return false;
+      return NULL;
     }
 
-  int new_size = strlen (cmd) + size + 2;
-  char *tmp = (char *) malloc (new_size);
-  if (!tmp)
+  char *string = (char *) malloc (size + 1);
+  if (!string)
     {
       CloseHandle (f);
-      debug_printf ("malloc failed, %E");
-      return false;
+      return NULL;
     }
 
-  /* realloc passed as it should */
+  /* malloc passed as it should */
   DWORD rf_read;
   BOOL rf_result;
-  rf_result = ReadFile (f, tmp, size, &rf_read, NULL);
+  rf_result = ReadFile (f, string, size, &rf_read, NULL);
   CloseHandle (f);
   if (!rf_result || (rf_read != size))
     {
-      free (tmp);
+      free (string);
       debug_printf ("ReadFile failed, %E");
-      return false;
+      return NULL;
     }
-
-  tmp[size++] = ' ';
-  strcpy (tmp + size, cmd);
-  cmd = tmp;
-  return true;
+  string[size] = '\0';
+  return string;
 }
 
 static inline int
@@ -217,85 +207,94 @@ isquote (char c)
   return ch == '"' || ch == '\'';
 }
 
-/* Step over a run of characters delimited by quotes */
-static /*__inline*/ char *
-quoted (char *cmd, int winshell)
+static inline int
+issep (char c)
 {
-  char *p;
-  char quote = *cmd;
-
-  if (!winshell)
-    {
-      char *p;
-      memmove (cmd, cmd + 1, strlen (cmd));
-      if (*(p = strchrnul (cmd, quote)))
-	memmove (p, p + 1, strlen (p));
-      return p;
-    }
-
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
+  return c && (strchr (" \t\n\r", c) != NULL);
 }
 
-/* Grab the next argument from the command line, terminating it in place.
-   Return false when the command line is exhausted.  */
+/* MSVCRT-like argument parsing.
+ * Parse a word in-place, consuming characters and marking where quoting state is changed. */
 static bool
-next_arg (char *&cmd, char *&word, char *&sawquote, bool winshell, bool first)
+next_arg (char *&cmd, char *&arg, size_t* quotepos, size_t &quotesize)
 {
-  while (issep (*cmd))
+  bool inquote = false;
+  size_t nbs = 0;
+  char quote = '\0';
+  size_t nquotes = 0;
+
+  while (*cmd && issep (*cmd))
     cmd++;
 
-  if (!*cmd)
-    return false;
+  arg = cmd;
+  char *out = arg;
 
-  word = cmd;
-  sawquote = NULL;
-  while (*cmd)
+  for (;*cmd && (inquote || !issep (*cmd)); cmd++)
     {
-      if (*cmd != '"' && (!winshell || *cmd != '\''))
-	cmd++;			// Skip over this character
+      if (*cmd == '\\')
+	{
+	  nbs += 1;
+	  continue;
+	}
+
+      // For anything else, sort out backslashes first.
+      // All backslashes are literal, except these before a quote.
+      // Single-quote is our addition.  Would love to remove it.
+      bool atquote = inquote ? *cmd == quote : isquote (*cmd);
+      size_t n = atquote ? nbs / 2 : nbs;
+      memset (out, '\\', n);
+      out += n;
+
+      if (nbs % 2 == 0 && atquote)
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
+	      if (nquotes > quotesize - 1)
+		quotepos = realloc_type(quotepos, quotesize *= 2, size_t);
+	      quotepos[nquotes++] = out - arg + inquote;
+	      inquote = !inquote;
+	    }
+	}
       else
-	/* Skip over characters until the closing quote */
 	{
-	  sawquote = cmd;
-	  /* Handle quoting.  Only strip off quotes if the parent is
-	     a Cygwin process, or if the word starts with a '@'.
-	     In this case, the insert_file function needs an unquoted
-	     DOS filename and globbing isn't performed anyway. */
-	  cmd = quoted (cmd, winshell && !first && *word != '@');
+	  *out++ = *cmd;
 	}
-      if (issep (*cmd))		// End of argument if space
-	break;
+
+      nbs = 0;
     }
+
+  /* Flush backslashes that end the word: they are literal. */
+  if (nbs)
+    {
+      memset (out, '\\', nbs);
+      out += nbs;
+    }
+
   if (*cmd)
-    *cmd++ = '\0';		// Terminate `word'
+    cmd++;
 
-  return true;
+  *out = '\0';
+  quotepos[nquotes++] = SIZE_MAX;
+  return arg != cmd;
 }
 
+
 /* Perform a glob on word if it contains wildcard characters.
    Also quote every character between quotes to force glob to
-   treat the characters literally. */
+   treat the characters literally.
+
+   Call glob(3) on the word, and fill argv accordingly.
+   If the input looks like a DOS path, double up backslashes.
+ */
 
 /* Either X:[...] or \\server\[...] */
 #define is_dos_path(s) (isdrive(s) \
@@ -305,137 +304,186 @@ next_arg (char *&cmd, char *&word, char *&sawquote, bool winshell, bool first)
 			    && strchr ((s) + 3, '\\')))
 
 static int
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
+  int argcwant;
 
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
-	    mbstate_t mbs = { 0 };
-	    if (dos_spec || *s != '\\')
-	      /* nothing */;
-	    else if (s[1] == quote || s[1] == '\\')
-	      s++;
+    {
+      if (nquotes < quotesize)
+	{
+	  if (quotepos[nquotes] == SIZE_MAX)
+	    quotesize = nquotes;
+	  else if (quotepos[nquotes] == size_t (s - word))
+	    {
+	      inquote = !inquote;
+	      nquotes++;
+	    }
+	}
+      if (!inquote)
+	{
+	  if (dos_spec && *s == '\\')
 	    *p++ = '\\';
-	    size_t cnt = isascii (*s) ? 1 : mbrtowi (NULL, s, MB_CUR_MAX, &mbs);
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
+	  mbstate_t mbs = { 0 };
+	  size_t cnt = isascii (*s) ? 1 : mbrtowi (NULL, s, MB_CUR_MAX, &mbs);
+	  if (cnt <= 1 || cnt == (size_t)-1)
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
-  n = argc;
-  if ((argc += gl.gl_pathc) > argvlen)
+  if ((argcwant = argc + gl.gl_pathc) > argvlen)
     {
-      argvlen = argc + 10;
-      argv = (char **) realloc (argv, (1 + argvlen) * sizeof (argv[0]));
+      argvlen = argcwant + 10;
+      char **new_argv = (char **) realloc (argv, (1 + argvlen) * sizeof (argv[0]));
+      if (!new_argv)
+	{
+	  free (gl.gl_pathv);
+	  return -ENOMEM;
+	}
+      argv = new_argv;
     }
 
   /* Copy the matched filenames to argv. */
-  char **gv = gl.gl_pathv;
-  char **av = argv + n;
-  while (*gv)
+  for (char **gv = gl.gl_pathv; *gv; gv++)
     {
-      debug_printf ("argv[%d] = '%s'", n++, *gv);
-      *av++ = *gv++;
+      debug_printf ("argv[%zu] = '%s'", argc, *gv);
+      argv[argc++] = *gv;
     }
 
-  /* Clean up after glob. */
+  /* Clean up after glob.  Not using globfree() because the matches are retained. */
   free (gl.gl_pathv);
   return 1;
 }
 
-
 /* Build argv, argc from string passed from Windows.  */
-
-static void
-build_argv (char *cmd, char **&argv, int &argc, int winshell)
+extern "C" int
+cygwin_cmdline_parse (char *cmd, char ***pargv, char **allocs, int doglob, int maxfile)
 {
   int argvlen = 0;
-  int nesting = 0;		// monitor "nesting" from insert_file
+  int nesting = 0;	      // nesting depth for @file (file_stack index)
+  int inserts = 0;	      // total @file encountered (allocs index)
 
-  argc = 0;
-  argvlen = 0;
-  argv = NULL;
+  // Would be a bad idea to use alloca due to unbounded file size.
+  size_t quotesize = 32;
+  size_t *quotepos = malloc_type (quotesize, size_t);
 
+  int argc = 0;
+  int error = 0;
+  char **argv = NULL;
   char *word;
-  char *sawquote;
+
+  bool bail_on_file = maxfile > 0;
+  maxfile = bail_on_file ? maxfile : -maxfile;
+  char *file_stack[maxfile];
+  bool has_next;
 
   /* Scan command line until there is nothing left. */
-  while (next_arg (cmd, word, sawquote, winshell, argc == 0))
+  while ((has_next = next_arg (cmd, word, quotepos, quotesize)) || nesting)
     {
+      /* Catch when "nothing" is reached but we can pop the stack. */
+      if (! has_next)
+	{
+	  cmd = file_stack[--nesting];
+	  continue;
+	}
+
       /* Possibly look for @file construction assuming that this isn't
 	 the very first argument and the @ wasn't quoted */
-      if (argc && sawquote != word && *word == '@')
+      if (argc && quotepos[0] > 0 && *word == '@')
 	{
-	  if (++nesting > MAX_AT_FILE_LEVEL)
-	    api_fatal ("Too many levels of nesting for %s", word);
-	  if (insert_file (word, cmd))
-	      continue;			// There's new stuff in cmd now
+	  bool do_include = inserts < maxfile;
+	  char *fbuf;
+	  if (!do_include && bail_on_file)
+	    {
+	      error = -EMLINK;
+	      goto exit;
+	    }
+	  if (do_include && (fbuf = read_file (word + 1)))
+	    {
+	      file_stack[nesting++] = cmd;
+	      if (allocs != NULL)
+		allocs[inserts] = fbuf;
+
+	      inserts += 1;
+	      cmd = fbuf;
+	      continue;
+	    }
 	}
 
       /* See if we need to allocate more space for argv */
       if (argc >= argvlen)
 	{
 	  argvlen = argc + 10;
-	  argv = (char **) realloc (argv, (1 + argvlen) * sizeof (argv[0]));
+	  char **new_argv = (char **) realloc (argv, (1 + argvlen) * sizeof (argv[0]));
+	  if (!new_argv)
+	    {
+	      error = -ENOMEM;
+	      goto exit;
+	    }
+	  argv = new_argv;
 	}
 
       /* Add word to argv file after (optional) wildcard expansion. */
-      if (!winshell || !argc || !globify (word, argv, argc, argvlen))
+      if (doglob && argc != 0)
 	{
-	  debug_printf ("argv[%d] = '%s'", argc, word);
-	  argv[argc++] = word;
+	  error = globify (word, quotepos, quotesize, argv, argc, argvlen);
+	  if (error < 0)
+	    goto exit;
+	  else if (error > 0)
+	    {
+              error = 0;
+	      continue;
+	    }
 	}
+
+      debug_printf ("argv[%d] = '%s'", argc, word);
+      argv[argc++] = word;
     }
 
+exit:
   if (argv)
     argv[argc] = NULL;
+  if (allocs != NULL)
+    allocs[inserts] = NULL;
 
+  free (quotepos);
   debug_printf ("argc %d", argc);
+
+  *pargv = argv;
+  return error ? error : argc;
 }
diff --git a/winsup/doc/cygwinenv.xml b/winsup/doc/cygwinenv.xml
index fcb6e22485b..6d4c2e368a1 100644
--- a/winsup/doc/cygwinenv.xml
+++ b/winsup/doc/cygwinenv.xml
@@ -55,10 +55,10 @@ to the command as arguments.
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
index c9b35f6b04d..0a59c889505 100644
--- a/winsup/doc/faq-api.xml
+++ b/winsup/doc/faq-api.xml
@@ -179,7 +179,7 @@ for the old executable and any dll into per-user subdirectories in the
 <para>If the DLL thinks it was invoked from a DOS style prompt, it runs a
 `globber' over the arguments provided on the command line.  This means
 that if you type <literal>LS *.EXE</literal> from DOS, it will do what you might
-expect.
+expect.  This only happens to the unquoted parts.
 </para>
 <para>Beware: globbing uses <literal>malloc</literal>.  If your application defines
 <literal>malloc</literal>, that will get used.  This may do horrible things to you.
-- 
2.56.0.windows.4.niugit

