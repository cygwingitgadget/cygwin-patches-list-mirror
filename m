Return-Path: <SRS0=8Yr5=JQ=aosc.io=arthur2e5@sourceware.org>
Received: from relay3.mymailcheap.com (relay3.mymailcheap.com [217.182.119.157])
	by sourceware.org (Postfix) with ESMTPS id 66F2442F9C0A
	for <cygwin-patches@cygwin.com>; Fri, 27 Nov 2026 12:56:54 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 66F2442F9C0A
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=aosc.io
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=aosc.io
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 66F2442F9C0A
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=217.182.119.157
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1795784214; cv=none;
	b=K+dUmSQ97+lnOuNiIr8LoSRABr34MOizw1W9ZISk55jn9o/k2Fi5Fhpx+VJjd+DBEYlhTnTAzzuJ7UXyZS2k756zIMH9sko/pcZMGTxpmuiojxd33Ex4oWljICrSzchpkLPFlVhlN7MlIQPoVPpM5vec1gp4MDgDi1YZ1HAluLA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1795784214; c=relaxed/simple;
	bh=T0IAaI+HWPHzBwm6bS2cJQGkiJNdWEOy+ZHl8SZIJZw=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=KPXl/ck5auxJUlnfKJcix6g38NcpsPUKSrzz2H8XGjSNfeEkMT4JlKpgrjOZzyQ4zolsMsovN2eootI2oV5722D1OipSUX2/IUSttTiRDOxLQxWHjUPblRmjRZJW1hJZ92QxVik8x0p6ejD5dNr4D2GGZEccPzQMTUKXvJdcfFA=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (1024-bit key, unprotected) header.d=aosc.io header.i=@aosc.io header.a=rsa-sha256 header.s=default header.b=KBkG48jW
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 66F2442F9C0A
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=aosc.io header.i=@aosc.io header.a=rsa-sha256 header.s=default header.b=KBkG48jW
Received: from nf2.mymailcheap.com (nf2.mymailcheap.com [54.39.180.165])
	by relay3.mymailcheap.com (Postfix) with ESMTPS id C42A93EB6A
	for <cygwin-patches@cygwin.com>; Fri, 27 Nov 2026 12:56:52 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.38.223.107])
	by nf2.mymailcheap.com (Postfix) with ESMTPSA id C3C2B40085
	for <cygwin-patches@cygwin.com>; Fri, 27 Nov 2026 12:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aosc.io; s=default;
	t=1795784206; bh=KG+hMw9qjhyNUgDcC5zdbmVkvTJU44L/d2gVav2IzIM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=KBkG48jWUqxz6aaslWaxVzAPTRJ7soNGeieuSEynXOgjJXv9sHaXrkBfsOdovhvYN
	 uLRoNpwKUcSgRhiE34b37hvzQFagjOj8Ts4AtW4kzXxOiXJk57Wmo4/R/iV8gN0hEG
	 Xbe1cKid8/AAFS3fj5QPbjJP6awectMDHWV3naOM=
Received: from Arisu (unknown [179.253.246.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id C3B15E1FD0
	for <cygwin-patches@cygwin.com>; Fri, 27 Nov 2026 12:56:45 +0000 (UTC)
From: Mingye Wang <arthur2e5@aosc.io>
To: cygwin-patches@cygwin.com
Subject: [PATCH v7 1/3] Cygwin: move cmdline parser from dcrt0.cc to winf.cc
Date: Fri, 27 Nov 2026 20:56:37 +0800
Message-ID: <20261127125639.2099-2-arthur2e5@aosc.io>
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
X-Rspamd-Queue-Id: C3C2B40085
X-Rspamd-Server: nf2.mymailcheap.com
X-Rspamd-Action: no action
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Move insert_file, isquote, quoted, is_dos_path, globify and build_argv
to winf.cc without changing them, and declare build_argv in winf.h.

No functional change.  This is an artificial commit, only here to make
the following rewrite's diff readable.

AI was used to perform the move mechanically.

Co-Authored-By: Skadi "Skadeep" Deepseek <noreply@deepseek.com>
---
 winsup/cygwin/dcrt0.cc              | 290 +--------------------------
 winsup/cygwin/local_includes/winf.h |   2 +
 winsup/cygwin/winf.cc               | 291 ++++++++++++++++++++++++++++
 3 files changed, 294 insertions(+), 289 deletions(-)

diff --git a/winsup/cygwin/dcrt0.cc b/winsup/cygwin/dcrt0.cc
index 1c5e4cce870..f41feb98ac4 100644
--- a/winsup/cygwin/dcrt0.cc
+++ b/winsup/cygwin/dcrt0.cc
@@ -10,7 +10,6 @@ details. */
 #include "create_posix_thread.h"
 #include <unistd.h>
 #include <stdlib.h>
-#include "glob.h"
 #include <ctype.h>
 #include <locale.h>
 #include <sys/param.h>
@@ -36,8 +35,7 @@ details. */
 #include "cygxdr.h"
 #include <fenv.h>
 #include "ntdll.h"
-
-#define MAX_AT_FILE_LEVEL 10
+#include "winf.h"
 
 #define PREMAIN_LEN (sizeof (user_data->premain) / sizeof (user_data->premain[0]))
 
@@ -78,292 +76,6 @@ do_global_ctors (void (**in_pfunc)(), int force)
     (*pfunc) ();
 }
 
-/*
- * Replaces @file in the command line with the contents of the file.
- * There may be multiple @file's in a single command line
- * A \@file is replaced with @file so that echo \@foo would print
- * @foo and not the contents of foo.
- */
-static bool
-insert_file (char *name, char *&cmd)
-{
-  HANDLE f;
-  DWORD size;
-  tmp_pathbuf tp;
-
-  PWCHAR wname = tp.w_get ();
-  sys_mbstowcs (wname, NT_MAX_PATH, name + 1);
-  f = CreateFileW (wname,
-		   GENERIC_READ,		/* open for reading	*/
-		   FILE_SHARE_VALID_FLAGS,      /* share for reading	*/
-		   &sec_none_nih,		/* default security	*/
-		   OPEN_EXISTING,		/* existing file only	*/
-		   FILE_ATTRIBUTE_NORMAL,	/* normal file		*/
-		   NULL);			/* no attr. template	*/
-
-  if (f == INVALID_HANDLE_VALUE)
-    {
-      debug_printf ("couldn't open file '%s', %E", name);
-      return false;
-    }
-
-  /* This only supports files up to about 4 billion bytes in
-     size.  I am making the bold assumption that this is big
-     enough for this feature */
-  size = GetFileSize (f, NULL);
-  if (size == 0xFFFFFFFF)
-    {
-      CloseHandle (f);
-      debug_printf ("couldn't get file size for '%s', %E", name);
-      return false;
-    }
-
-  int new_size = strlen (cmd) + size + 2;
-  char *tmp = (char *) malloc (new_size);
-  if (!tmp)
-    {
-      CloseHandle (f);
-      debug_printf ("malloc failed, %E");
-      return false;
-    }
-
-  /* realloc passed as it should */
-  DWORD rf_read;
-  BOOL rf_result;
-  rf_result = ReadFile (f, tmp, size, &rf_read, NULL);
-  CloseHandle (f);
-  if (!rf_result || (rf_read != size))
-    {
-      free (tmp);
-      debug_printf ("ReadFile failed, %E");
-      return false;
-    }
-
-  tmp[size++] = ' ';
-  strcpy (tmp + size, cmd);
-  cmd = tmp;
-  return true;
-}
-
-static inline int
-isquote (char c)
-{
-  char ch = c;
-  return ch == '"' || ch == '\'';
-}
-
-/* Step over a run of characters delimited by quotes */
-static /*__inline*/ char *
-quoted (char *cmd, int winshell)
-{
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
-}
-
-/* Perform a glob on word if it contains wildcard characters.
-   Also quote every character between quotes to force glob to
-   treat the characters literally. */
-
-/* Either X:[...] or \\server\[...] */
-#define is_dos_path(s) (isdrive(s) \
-			|| ((s)[0] == '\\' \
-			    && (s)[1] == '\\' \
-			    && isalpha ((s)[2]) \
-			    && strchr ((s) + 3, '\\')))
-
-static int
-globify (char *word, char **&argv, int &argc, int &argvlen)
-{
-  if (*word != '~' && strpbrk (word, "?*[\"\'(){}") == NULL)
-    return 0;
-
-  int n = 0;
-  char *p, *s;
-  int dos_spec = is_dos_path (word);
-  if (!dos_spec && isquote (*word) && word[1] && word[2])
-    dos_spec = is_dos_path (word + 1);
-
-  /* We'll need more space if there are quoting characters in
-     word.  If that is the case, doubling the size of the
-     string should provide more than enough space. */
-  if (strpbrk (word, "'\""))
-    n = strlen (word);
-  char pattern[strlen (word) + ((dos_spec + 1) * n) + 1];
-
-  /* Fill pattern with characters from word, quoting any
-     characters found within quotes. */
-  for (p = pattern, s = word; *s != '\000'; s++, p++)
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
-	    *p++ = '\\';
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
-  *p = '\0';
-
-  glob_t gl;
-  gl.gl_offs = 0;
-
-  /* Attempt to match the argument.  Return just word (minus quoting) if no match. */
-  if (glob (pattern, GLOB_TILDE | GLOB_NOCHECK | GLOB_BRACE | GLOB_QUOTE, NULL, &gl) || !gl.gl_pathc)
-    return 0;
-
-  /* Allocate enough space in argv for the matched filenames. */
-  n = argc;
-  if ((argc += gl.gl_pathc) > argvlen)
-    {
-      argvlen = argc + 10;
-      argv = (char **) realloc (argv, (1 + argvlen) * sizeof (argv[0]));
-    }
-
-  /* Copy the matched filenames to argv. */
-  char **gv = gl.gl_pathv;
-  char **av = argv + n;
-  while (*gv)
-    {
-      debug_printf ("argv[%d] = '%s'", n++, *gv);
-      *av++ = *gv++;
-    }
-
-  /* Clean up after glob. */
-  free (gl.gl_pathv);
-  return 1;
-}
-
-/* Build argv, argc from string passed from Windows.  */
-
-static void
-build_argv (char *cmd, char **&argv, int &argc, int winshell)
-{
-  int argvlen = 0;
-  int nesting = 0;		// monitor "nesting" from insert_file
-
-  argc = 0;
-  argvlen = 0;
-  argv = NULL;
-
-  /* Scan command line until there is nothing left. */
-  while (*cmd)
-    {
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
-      /* Possibly look for @file construction assuming that this isn't
-	 the very first argument and the @ wasn't quoted */
-      if (argc && sawquote != word && *word == '@')
-	{
-	  if (++nesting > MAX_AT_FILE_LEVEL)
-	    api_fatal ("Too many levels of nesting for %s", word);
-	  if (insert_file (word, cmd))
-	      continue;			// There's new stuff in cmd now
-	}
-
-      /* See if we need to allocate more space for argv */
-      if (argc >= argvlen)
-	{
-	  argvlen = argc + 10;
-	  argv = (char **) realloc (argv, (1 + argvlen) * sizeof (argv[0]));
-	}
-
-      /* Add word to argv file after (optional) wildcard expansion. */
-      if (!winshell || !argc || !globify (word, argv, argc, argvlen))
-	{
-	  debug_printf ("argv[%d] = '%s'", argc, word);
-	  argv[argc++] = word;
-	}
-    }
-
-  if (argv)
-    argv[argc] = NULL;
-
-  debug_printf ("argc %d", argc);
-}
 
 /* sanity and sync check */
 void
diff --git a/winsup/cygwin/local_includes/winf.h b/winsup/cygwin/local_includes/winf.h
index b5869344109..c5a8050f9c6 100644
--- a/winsup/cygwin/local_includes/winf.h
+++ b/winsup/cygwin/local_includes/winf.h
@@ -99,3 +99,5 @@ class linebuf
     return wbuf;
   }
 };
+
+void build_argv (char *cmd, char **&argv, int &argc, int winshell);
diff --git a/winsup/cygwin/winf.cc b/winsup/cygwin/winf.cc
index d0c5c440fbe..881438fa42e 100644
--- a/winsup/cygwin/winf.cc
+++ b/winsup/cygwin/winf.cc
@@ -15,6 +15,8 @@ details. */
 #include "tls_pbuf.h"
 #include "winf.h"
 #include "sys/cygwin.h"
+#include <ctype.h>
+#include "glob.h"
 
 void
 linebuf::finish (bool cmdlenoverflow_ok)
@@ -138,3 +140,292 @@ av::unshift (const char *what)
   argc++;
   return 1;
 }
+
+#define MAX_AT_FILE_LEVEL 10
+
+/*
+ * Replaces @file in the command line with the contents of the file.
+ * There may be multiple @file's in a single command line
+ * A \@file is replaced with @file so that echo \@foo would print
+ * @foo and not the contents of foo.
+ */
+static bool
+insert_file (char *name, char *&cmd)
+{
+  HANDLE f;
+  DWORD size;
+  tmp_pathbuf tp;
+
+  PWCHAR wname = tp.w_get ();
+  sys_mbstowcs (wname, NT_MAX_PATH, name + 1);
+  f = CreateFileW (wname,
+		   GENERIC_READ,		/* open for reading	*/
+		   FILE_SHARE_VALID_FLAGS,      /* share for reading	*/
+		   &sec_none_nih,		/* default security	*/
+		   OPEN_EXISTING,		/* existing file only	*/
+		   FILE_ATTRIBUTE_NORMAL,	/* normal file		*/
+		   NULL);			/* no attr. template	*/
+
+  if (f == INVALID_HANDLE_VALUE)
+    {
+      debug_printf ("couldn't open file '%s', %E", name);
+      return false;
+    }
+
+  /* This only supports files up to about 4 billion bytes in
+     size.  I am making the bold assumption that this is big
+     enough for this feature */
+  size = GetFileSize (f, NULL);
+  if (size == 0xFFFFFFFF)
+    {
+      CloseHandle (f);
+      debug_printf ("couldn't get file size for '%s', %E", name);
+      return false;
+    }
+
+  int new_size = strlen (cmd) + size + 2;
+  char *tmp = (char *) malloc (new_size);
+  if (!tmp)
+    {
+      CloseHandle (f);
+      debug_printf ("malloc failed, %E");
+      return false;
+    }
+
+  /* realloc passed as it should */
+  DWORD rf_read;
+  BOOL rf_result;
+  rf_result = ReadFile (f, tmp, size, &rf_read, NULL);
+  CloseHandle (f);
+  if (!rf_result || (rf_read != size))
+    {
+      free (tmp);
+      debug_printf ("ReadFile failed, %E");
+      return false;
+    }
+
+  tmp[size++] = ' ';
+  strcpy (tmp + size, cmd);
+  cmd = tmp;
+  return true;
+}
+
+static inline int
+isquote (char c)
+{
+  char ch = c;
+  return ch == '"' || ch == '\'';
+}
+
+/* Step over a run of characters delimited by quotes */
+static /*__inline*/ char *
+quoted (char *cmd, int winshell)
+{
+  char *p;
+  char quote = *cmd;
+
+  if (!winshell)
+    {
+      char *p;
+      memmove (cmd, cmd + 1, strlen (cmd));
+      if (*(p = strchrnul (cmd, quote)))
+	memmove (p, p + 1, strlen (p));
+      return p;
+    }
+
+  const char *s = quote == '\'' ? "'" : "\\\"";
+  /* This must have been run from a Windows shell, so preserve
+     quotes for globify to play with later. */
+  while (*cmd && *++cmd)
+    if ((p = strpbrk (cmd, s)) == NULL)
+      {
+	cmd = strchr (cmd, '\0');	// no closing quote
+	break;
+      }
+    else if (*p == '\\')
+      cmd = ++p;
+    else if (quote == '"' && p[1] == '"')
+      {
+	*p = '\\';
+	cmd = ++p;			// a quoted quote
+      }
+    else
+      {
+	cmd = p + 1;		// point to after end
+	break;
+      }
+  return cmd;
+}
+
+/* Perform a glob on word if it contains wildcard characters.
+   Also quote every character between quotes to force glob to
+   treat the characters literally. */
+
+/* Either X:[...] or \\server\[...] */
+#define is_dos_path(s) (isdrive(s) \
+			|| ((s)[0] == '\\' \
+			    && (s)[1] == '\\' \
+			    && isalpha ((s)[2]) \
+			    && strchr ((s) + 3, '\\')))
+
+static int
+globify (char *word, char **&argv, int &argc, int &argvlen)
+{
+  if (*word != '~' && strpbrk (word, "?*[\"\'(){}") == NULL)
+    return 0;
+
+  int n = 0;
+  char *p, *s;
+  int dos_spec = is_dos_path (word);
+  if (!dos_spec && isquote (*word) && word[1] && word[2])
+    dos_spec = is_dos_path (word + 1);
+
+  /* We'll need more space if there are quoting characters in
+     word.  If that is the case, doubling the size of the
+     string should provide more than enough space. */
+  if (strpbrk (word, "'\""))
+    n = strlen (word);
+  char pattern[strlen (word) + ((dos_spec + 1) * n) + 1];
+
+  /* Fill pattern with characters from word, quoting any
+     characters found within quotes. */
+  for (p = pattern, s = word; *s != '\000'; s++, p++)
+    if (!isquote (*s))
+      {
+	if (dos_spec && *s == '\\')
+	  *p++ = '\\';
+	*p = *s;
+      }
+    else
+      {
+	char quote = *s;
+	while (*++s && *s != quote)
+	  {
+	    mbstate_t mbs = { 0 };
+	    if (dos_spec || *s != '\\')
+	      /* nothing */;
+	    else if (s[1] == quote || s[1] == '\\')
+	      s++;
+	    *p++ = '\\';
+	    size_t cnt = isascii (*s) ? 1 : mbrtowi (NULL, s, MB_CUR_MAX, &mbs);
+	    if (cnt <= 1 || cnt == (size_t)-1)
+	      *p++ = *s;
+	    else
+	      {
+		--s;
+		while (cnt-- > 0)
+		  *p++ = *++s;
+	      }
+	  }
+	if (*s == quote)
+	  p--;
+	if (*s == '\0')
+	    break;
+      }
+
+  *p = '\0';
+
+  glob_t gl;
+  gl.gl_offs = 0;
+
+  /* Attempt to match the argument.  Return just word (minus quoting) if no match. */
+  if (glob (pattern, GLOB_TILDE | GLOB_NOCHECK | GLOB_BRACE | GLOB_QUOTE, NULL, &gl) || !gl.gl_pathc)
+    return 0;
+
+  /* Allocate enough space in argv for the matched filenames. */
+  n = argc;
+  if ((argc += gl.gl_pathc) > argvlen)
+    {
+      argvlen = argc + 10;
+      argv = (char **) realloc (argv, (1 + argvlen) * sizeof (argv[0]));
+    }
+
+  /* Copy the matched filenames to argv. */
+  char **gv = gl.gl_pathv;
+  char **av = argv + n;
+  while (*gv)
+    {
+      debug_printf ("argv[%d] = '%s'", n++, *gv);
+      *av++ = *gv++;
+    }
+
+  /* Clean up after glob. */
+  free (gl.gl_pathv);
+  return 1;
+}
+
+/* Build argv, argc from string passed from Windows.  */
+
+static void
+build_argv (char *cmd, char **&argv, int &argc, int winshell)
+{
+  int argvlen = 0;
+  int nesting = 0;		// monitor "nesting" from insert_file
+
+  argc = 0;
+  argvlen = 0;
+  argv = NULL;
+
+  /* Scan command line until there is nothing left. */
+  while (*cmd)
+    {
+      /* Ignore spaces */
+      if (issep (*cmd))
+	{
+	  cmd++;
+	  continue;
+	}
+
+      /* Found the beginning of an argument. */
+      char *word = cmd;
+      char *sawquote = NULL;
+      while (*cmd)
+	{
+	  if (*cmd != '"' && (!winshell || *cmd != '\''))
+	    cmd++;		// Skip over this character
+	  else
+	    /* Skip over characters until the closing quote */
+	    {
+	      sawquote = cmd;
+	      /* Handle quoting.  Only strip off quotes if the parent is
+		 a Cygwin process, or if the word starts with a '@'.
+		 In this case, the insert_file function needs an unquoted
+		 DOS filename and globbing isn't performed anyway. */
+	      cmd = quoted (cmd, winshell && argc > 0 && *word != '@');
+	    }
+	  if (issep (*cmd))	// End of argument if space
+	    break;
+	}
+      if (*cmd)
+	*cmd++ = '\0';		// Terminate `word'
+
+      /* Possibly look for @file construction assuming that this isn't
+	 the very first argument and the @ wasn't quoted */
+      if (argc && sawquote != word && *word == '@')
+	{
+	  if (++nesting > MAX_AT_FILE_LEVEL)
+	    api_fatal ("Too many levels of nesting for %s", word);
+	  if (insert_file (word, cmd))
+	      continue;			// There's new stuff in cmd now
+	}
+
+      /* See if we need to allocate more space for argv */
+      if (argc >= argvlen)
+	{
+	  argvlen = argc + 10;
+	  argv = (char **) realloc (argv, (1 + argvlen) * sizeof (argv[0]));
+	}
+
+      /* Add word to argv file after (optional) wildcard expansion. */
+      if (!winshell || !argc || !globify (word, argv, argc, argvlen))
+	{
+	  debug_printf ("argv[%d] = '%s'", argc, word);
+	  argv[argc++] = word;
+	}
+    }
+
+  if (argv)
+    argv[argc] = NULL;
+
+  debug_printf ("argc %d", argc);
+}
-- 
2.56.0.windows.4.niugit

