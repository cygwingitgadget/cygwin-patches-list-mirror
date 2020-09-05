Return-Path: <arthur2e5@aosc.io>
Received: from relay4.mymailcheap.com (relay4.mymailcheap.com [137.74.80.154])
 by sourceware.org (Postfix) with ESMTPS id BAC2E3857C5B
 for <cygwin-patches@cygwin.com>; Sat,  5 Sep 2020 05:27:55 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org BAC2E3857C5B
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: sourceware.org;
 spf=pass smtp.mailfrom=arthur2e5@aosc.io
Received: from filter1.mymailcheap.com (filter1.mymailcheap.com
 [149.56.130.247])
 by relay4.mymailcheap.com (Postfix) with ESMTPS id 33EBE3F1CF
 for <cygwin-patches@cygwin.com>; Sat,  5 Sep 2020 07:27:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by filter1.mymailcheap.com (Postfix) with ESMTP id 47AC62A0F4
 for <cygwin-patches@cygwin.com>; Sat,  5 Sep 2020 01:27:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
 s=default; t=1599283673;
 bh=eloW65T9kOywEXCgvJ84C+BVxkUZas4tdlbW4mIGa50=;
 h=From:To:Cc:Subject:Date:From;
 b=Z9X9mmnOej+0pb3m49wQkpiEkeaCOn0L6WWT5RHkqoazWJhLbpqYUgtjzqFFIqqJy
 OmvbeTlGTNBNyw79b6+khPo7lCAgq9cJdNxIDAnGMG1FL5in9Vw84ykoZ4WnMoqNp/
 FXM8d6A6xfryyd+f+06iShk4sUYVqaLd3FQ6aGwI=
X-Virus-Scanned: Debian amavisd-new at filter1.mymailcheap.com
Received: from filter1.mymailcheap.com ([127.0.0.1])
 by localhost (filter1.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id URA2fviXNQwM for <cygwin-patches@cygwin.com>;
 Sat,  5 Sep 2020 01:27:50 -0400 (EDT)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by filter1.mymailcheap.com (Postfix) with ESMTPS
 for <cygwin-patches@cygwin.com>; Sat,  5 Sep 2020 01:27:50 -0400 (EDT)
Received: from [148.251.23.173] (ml.mymailcheap.com [148.251.23.173])
 by mail20.mymailcheap.com (Postfix) with ESMTP id DD3F44083E;
 Sat,  5 Sep 2020 05:27:49 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com; dkim=pass (1024-bit key;
 unprotected) header.d=aosc.io header.i=@aosc.io header.b="KnBIZBAZ"; 
 dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from localhost.localdomain (unknown [222.70.42.237])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail20.mymailcheap.com (Postfix) with ESMTPSA id 9AF2E4083E;
 Sat,  5 Sep 2020 05:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
 t=1599283648; bh=eloW65T9kOywEXCgvJ84C+BVxkUZas4tdlbW4mIGa50=;
 h=From:To:Cc:Subject:Date:From;
 b=KnBIZBAZESV9Cv5lT/cTWY7kJh42PO4EkqgJNXaviYfdhov0GGKWLllJy8XOKqzWO
 Q2a+ttAjYc1OSpPVoMxEWtGGEmorrn+dG30EbxdLleJnqs9ovLeJa/Sw/BJqGk8h+Q
 ex6zl3IRHgT8bb3BAYqbZjOOd7r0RzQ0GyL+sXlg=
From: Mingye Wang <arthur2e5@aosc.io>
To: cygwin-patches@cygwin.com
Cc: Mingye Wang <arthur2e5@aosc.io>
Subject: [PATCH v4 1/3] Cygwin: rewrite and make public cmdline parser
Date: Sat,  5 Sep 2020 13:27:09 +0800
Message-Id: <20200905052711.13008-1-arthur2e5@aosc.io>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DD3F44083E
X-Spamd-Result: default: False [4.90 / 20.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(0.00)[aosc.io:s=default];
 RECEIVED_SPAMHAUS_PBL(0.00)[222.70.42.237:received];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; DMARC_NA(0.00)[aosc.io];
 BROKEN_CONTENT_TYPE(1.50)[]; R_SPF_SOFTFAIL(0.00)[~all:c];
 ML_SERVERS(-3.10)[148.251.23.173]; DKIM_TRACE(0.00)[aosc.io:+];
 RCPT_COUNT_TWO(0.00)[2]; MID_CONTAINS_FROM(1.00)[];
 RCVD_NO_TLS_LAST(0.10)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+];
 ASN(0.00)[asn:24940, ipnet:148.251.0.0/16, country:DE];
 RCVD_COUNT_TWO(0.00)[2];
 HFILTER_HELO_BAREIP(3.00)[148.251.23.173,1]
X-Rspamd-Server: mail20.mymailcheap.com
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0,
 RCVD_IN_BARRACUDACENTRAL, SPF_HELO_NONE, SPF_PASS,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Sat, 05 Sep 2020 05:27:59 -0000

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
expanded.  The functions are made public for testing, but my tcl setup
is currently too messed up for running them!  I did test them as an
isolated program on WSL-Debian.

The change fixes two complaints of mine:
* That cygwin is incompatible with its own escape.[1]
* That there is no way to echo `C:\"` from win32.[2]
  [1]: https://cygwin.com/pipermail/cygwin/2020-June/245162.html
  [2]: https://cygwin.com/pipermail/cygwin/2019-October/242790.html

(It's never the point to spawn cygwin32 from cygwin64. Consistency
matters: with yourself always, and with the outside world when you are
supposed to.)

This is the fourth version of the patch. I provide all my patches to
Cygwin, including this one and all future ones, under the 2-clause BSD
license.
---
 winsup/cygwin/common.din              |   2 +
 winsup/cygwin/dcrt0.cc                | 297 +-------------------
 winsup/cygwin/include/sys/cygwin.h    |   2 +
 winsup/cygwin/winf.cc                 | 378 +++++++++++++++++++++++++-
 winsup/cygwin/winf.h                  |   8 +-
 winsup/cygwin/winsup.h                |   7 +-
 winsup/doc/cygwinenv.xml              |   8 +-
 winsup/doc/faq-api.xml                |   2 +-
 winsup/doc/misc-funcs.xml             |  71 +++++
 winsup/testsuite/Makefile.in          |   6 +-
 winsup/testsuite/winsup.api/cmdline.c | 102 +++++++
 11 files changed, 577 insertions(+), 306 deletions(-)
 create mode 100644 winsup/testsuite/winsup.api/cmdline.c

diff --git a/winsup/cygwin/common.din b/winsup/cygwin/common.din
index a7b4aa2b0..f15dc6a9e 100644
--- a/winsup/cygwin/common.din
+++ b/winsup/cygwin/common.din
@@ -393,6 +393,8 @@ cygwin_split_path NOSIGFE
 cygwin_stackdump SIGFE
 cygwin_umount SIGFE
 cygwin_winpid_to_pid SIGFE
+cygwin_cmdline_parse SIGFE
+cygwin_cmdline_build SIGFE
 daemon SIGFE
 dbm_clearerr SIGFE
 dbm_close SIGFE
diff --git a/winsup/cygwin/dcrt0.cc b/winsup/cygwin/dcrt0.cc
index 5d8b4b74e..6f906102d 100644
--- a/winsup/cygwin/dcrt0.cc
+++ b/winsup/cygwin/dcrt0.cc
@@ -10,7 +10,6 @@ details. */
 #include "miscfuncs.h"
 #include <unistd.h>
 #include <stdlib.h>
-#include "glob.h"
 #include <ctype.h>
 #include <locale.h>
 #include <sys/param.h>
@@ -35,6 +34,7 @@ details. */
 #include "cygxdr.h"
 #include "fenv.h"
 #include "ntdll.h"
+#include "winf.h"
 
 #define MAX_AT_FILE_LEVEL 10
 
@@ -77,292 +77,6 @@ do_global_ctors (void (**in_pfunc)(), int force)
     (*pfunc) ();
 }
 
-/*
- * Replaces @file in the command line with the contents of the file.
- * There may be multiple @file's in a single command line
- * A \@file is replaced with @file so that echo \@foo would print
- * @foo and not the contents of foo.
- */
-static bool __stdcall
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
-      strcpy (cmd, cmd + 1);
-      if (*(p = strchrnul (cmd, quote)))
-	strcpy (p, p + 1);
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
-static int __stdcall
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
-	    if (dos_spec || *s != '\\')
-	      /* nothing */;
-	    else if (s[1] == quote || s[1] == '\\')
-	      s++;
-	    *p++ = '\\';
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
-static void __stdcall
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
-
 /* sanity and sync check */
 void __stdcall
 check_sanity_and_sync (per_process *p)
@@ -939,8 +653,11 @@ dll_crt0_1 (void *)
 
       /* Scan the command line and build argv.  Expand wildcards if not
 	 called from another cygwin process. */
-      build_argv (line, __argv, __argc,
-		  NOTSTATE (myself, PID_CYGPARENT) && allow_glob);
+      __argc = cygwin_cmdline_parse (line, &__argv, NULL,
+		NOTSTATE (myself, PID_CYGPARENT) && allow_glob, MAX_AT_FILE_LEVEL);
+
+      if (__argc < 0)
+	api_fatal ("Too many levels of nesting for %s", line);
 
       /* Convert argv[0] to posix rules if it's currently blatantly
 	 win32 style. */
@@ -1064,7 +781,7 @@ _dll_crt0 ()
 	  if (stackaddr)
 	    {
 	      /* Set stack pointer to new address.  Set frame pointer to
-	         stack pointer and subtract 32 bytes for shadow space. */
+		 stack pointer and subtract 32 bytes for shadow space. */
 	      __asm__ ("\n\
 		       movq %[ADDR], %%rsp \n\
 		       movq  %%rsp, %%rbp  \n\
diff --git a/winsup/cygwin/include/sys/cygwin.h b/winsup/cygwin/include/sys/cygwin.h
index 805671ef9..e19ac0cd2 100644
--- a/winsup/cygwin/include/sys/cygwin.h
+++ b/winsup/cygwin/include/sys/cygwin.h
@@ -86,6 +86,8 @@ extern void *cygwin_create_path (cygwin_conv_path_t what, const void *from);
 extern pid_t cygwin_winpid_to_pid (int);
 extern int cygwin_posix_path_list_p (const char *);
 extern void cygwin_split_path (const char *, char *, char *);
+extern int cygwin_cmdline_parse (char *, char ***, char **, int, int);
+extern char *cygwin_cmdline_build (const char * const *, int, int);
 
 struct __cygwin_perfile
 {
diff --git a/winsup/cygwin/winf.cc b/winsup/cygwin/winf.cc
index d0c5c440f..15b8076ad 100644
--- a/winsup/cygwin/winf.cc
+++ b/winsup/cygwin/winf.cc
@@ -15,15 +15,16 @@ details. */
 #include "tls_pbuf.h"
 #include "winf.h"
 #include "sys/cygwin.h"
+#include "glob.h"
 
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
@@ -63,7 +64,7 @@ linebuf::prepend (const char *what, int len)
 }
 
 bool
-linebuf::fromargv (av& newargv, const char *real_path, bool cmdlenoverflow_ok)
+linebuf::fromargv (av& newargv, const char *real_path, bool trunc_for_cygwin, bool forcequote)
 {
   bool success = true;
   for (int i = 0; i < newargv.argc; i++)
@@ -73,7 +74,7 @@ linebuf::fromargv (av& newargv, const char *real_path, bool cmdlenoverflow_ok)
 
       a = i ? newargv[i] : (char *) real_path;
       int len = strlen (a);
-      if (len != 0 && !strpbrk (a, " \t\n\r\""))
+      if (len != 0 && !forcequote && !strpbrk (a, " \t\n\r\""))
 	add (a, len);
       else
 	{
@@ -111,7 +112,7 @@ linebuf::fromargv (av& newargv, const char *real_path, bool cmdlenoverflow_ok)
       add (" ", 1);
     }
 
-  finish (cmdlenoverflow_ok);
+  finish (trunc_for_cygwin);
 
   if (ix >= MAXWINCMDLEN)
     {
@@ -138,3 +139,370 @@ av::unshift (const char *what)
   argc++;
   return 1;
 }
+
+/*
+ * Read a file into a newly-allocated buffer.
+ */
+static char* __reg1
+read_file (const char *name)
+{
+#ifndef WINF_STDIO_TEST
+  HANDLE f;
+  DWORD size;
+  tmp_pathbuf tp;
+
+  PWCHAR wname = tp.w_get ();
+  sys_mbstowcs (wname, NT_MAX_PATH, name);	/* FIXME: Do we need \\?\ ? */
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
+      return NULL;
+    }
+
+  /* This only supports files up to about 4 billion bytes in
+     size.  I am making the bold assumption that this is big
+     enough for this feature */
+  size = GetFileSize (f, NULL);
+  if (size == 0xFFFFFFFF)
+    {
+      debug_printf ("couldn't get file size for '%s', %E", name);
+      CloseHandle (f);
+      return NULL;
+    }
+
+  char *string = (char *) malloc (size + 1);
+  if (!string)
+    {
+      CloseHandle (f);
+      return NULL;
+    }
+
+  /* malloc passed as it should */
+  DWORD rf_read;
+  BOOL rf_result;
+  rf_result = ReadFile (f, string, size, &rf_read, NULL);
+  if (!rf_result || (rf_read != size))
+    {
+      CloseHandle (f);
+      return NULL;
+    }
+#else
+  /* Test code for fiddling on WSL. */
+  FILE *f = fopen (name, "rb");
+  if (!f)
+    return NULL;
+
+  fseek (f, 0, SEEK_END);
+  long size = ftell (f);
+  rewind (f);
+
+  char *string = (char *) malloc (size + 1);
+  if (!string)
+    {
+      fclose (f);
+      return NULL;
+    }
+  fread ((void *) string, 1, size, f);
+  fclose (f);
+#endif
+  string[size] = '\0';
+  return string;
+}
+
+static inline int
+isquote (char c)
+{
+  char ch = c;
+  return ch == '"' || ch == '\'';
+}
+
+static inline int
+issep (char c)
+{
+  return c && (strchr (" \t\n\r", c) != NULL);
+}
+
+/* MSVCRT-like argument parsing.
+ * Parse a word in-place, consuming characters and marking where quoting state is changed. */
+static bool __reg3
+next_arg (char *&cmd, char *&arg, size_t* quotepos, size_t &quotesize)
+{
+  bool inquote = false;
+  size_t nbs = 0;
+  char quote = '\0';
+  size_t nquotes = 0;
+
+  while (*cmd && issep (*cmd))
+    cmd++;
+
+  arg = cmd;
+  char *out = arg;
+
+  for (;*cmd && (inquote || !issep (*cmd)); cmd++)
+    {
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
+      else
+	{
+	  *out++ = *cmd;
+	}
+
+      nbs = 0;
+    }
+
+  if (*cmd)
+    cmd++;
+
+  *out = '\0';
+  quotepos[nquotes++] = SIZE_MAX;
+  return arg != cmd;
+}
+
+
+/* Either X:[...] or \\server\[...] */
+#define is_dos_path(s) (isdrive(s) \
+			|| ((s)[0] == '\\' \
+			    && (s)[1] == '\\' \
+			    && isalpha ((s)[2]) \
+			    && strchr ((s) + 3, '\\')))
+
+
+/* Perform a glob on word if it contains wildcard characters.
+   Also quote every character between quotes to force glob to
+   treat the characters literally.
+
+   Call glob(3) on the word, and fill argv accordingly.
+   If the input looks like a DOS path, double up backslashes.
+ */
+static int __reg3
+globify (const char *word, size_t *quotepos, size_t quotesize, char **&argv, int &argc, int &argvlen)
+{
+  if (*word != '~' && strpbrk (word, "?*[\"\'(){}") == NULL)
+    return 0;
+
+  /* We'll need more space if there are quoting characters in
+     word.  If that is the case, doubling the size of the
+     string should provide more than enough space. */
+  size_t n = quotepos[0] == SIZE_MAX ? 0 : strlen (word);
+  char *p;
+  const char *s;
+  int dos_spec = is_dos_path (word);
+  char pattern[strlen (word) + ((dos_spec + 1) * n) + 1];
+  bool inquote = false;
+  size_t nquotes = 0;
+
+  /* Fill pattern with characters from word, quoting any
+     characters found within quotes. */
+  for (p = pattern, s = word; *s != '\000'; s++, p++)
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
+	    *p++ = '\\';
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
+  *p = '\0';
+
+  glob_t gl;
+  gl.gl_offs = 0;
+
+  /* Attempt to match the argument.  Bail if no match. */
+  if (glob (pattern, GLOB_TILDE | GLOB_BRACE, NULL, &gl) || !gl.gl_pathc)
+    return 0;
+
+  /* Allocate enough space in argv for the matched filenames. */
+  n = argc;
+  if ((argc += gl.gl_pathc) > argvlen)
+    {
+      argvlen = argc + 10;
+      char **old_argv = argv;
+      argv = (char **) realloc (argv, (1 + argvlen) * sizeof (argv[0]));
+      if (!argv)
+	{
+	  free (gl.gl_pathv);
+	  argv = old_argv;
+	  return -ENOMEM;
+	}
+    }
+
+  /* Copy the matched filenames to argv. */
+  char **gv = gl.gl_pathv;
+  char **av = argv + n;
+  while (*gv)
+    {
+      debug_printf ("argv[%zu] = '%s'", n++, *gv);
+      *av++ = *gv++;
+    }
+
+  /* Clean up after glob. */
+  free (gl.gl_pathv);
+  return 1;
+}
+
+/* Build argv, argc from string passed from Windows.  */
+extern "C" int
+cygwin_cmdline_parse (char *cmd, char ***pargv, char **allocs, int doglob, int maxfile)
+{
+  int argvlen = 0;
+  int nesting = 0;	      // nesting depth for @file (file_stack index)
+  int inserts = 0;	      // total @file encountered (allocs index)
+
+  // Would be a bad idea to use alloca due to unbounded file size.
+  size_t quotesize = 32;
+  size_t *quotepos = malloc_type (quotesize, size_t);
+
+  int argc = 0;
+  int error = 0;
+  char **argv = NULL;
+  char *word;
+
+  bool bail_on_file = maxfile > 0;
+  maxfile = bail_on_file ? maxfile : -maxfile;
+  char *file_stack[maxfile];
+  bool has_next;
+
+  /* Scan command line until there is nothing left. */
+  while ((has_next = next_arg (cmd, word, quotepos, quotesize)) || nesting)
+    {
+      /* Catch when "nothing" is reached but we can pop the stack. */
+      if (! has_next)
+	{
+	  cmd = file_stack[--nesting];
+	  continue;
+	}
+
+      /* Possibly look for @file construction assuming that this isn't
+	 the very first argument and the @ wasn't quoted */
+      if (argc && quotepos[0] > 0 && *word == '@')
+	{
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
+	}
+
+      /* See if we need to allocate more space for argv */
+      if (argc >= argvlen)
+	{
+	  argvlen = argc + 10;
+	  char **old_argv = argv;
+	  argv = (char **) realloc (old_argv, (1 + argvlen) * sizeof (argv[0]));
+	  if (!argv)
+	    {
+	      argv = old_argv;
+	      error = -ENOMEM;
+	      goto exit;
+	    }
+	}
+
+      /* Add word to argv file after (optional) wildcard expansion. */
+      if (!doglob || !argc || (error = globify (word, quotepos, quotesize, argv, argc, argvlen)) > 0)
+	{
+	  debug_printf ("argv[%d] = '%s'", argc, word);
+	  argv[argc++] = word;
+	}
+      else if (error)
+	{
+	  goto exit;
+	}
+    }
+
+exit:
+  if (argv)
+    argv[argc] = NULL;
+  if (allocs != NULL)
+    allocs[inserts] = NULL;
+
+  free (quotepos);
+  debug_printf ("argc %d", argc);
+
+  *pargv = argv;
+  return error ? error : argc;
+}
+
+extern "C" char *
+cygwin_cmdline_build(const char * const *argv, int allow_of, int forcequote) {
+  int ac;
+  for (ac = 0; argv[ac]; ac++);
+  av av (ac, argv);
+  linebuf ret;
+  if (ret.fromargv (av, av[0], false, !!forcequote) || allow_of)
+    return strdup ((const char *) ret);
+  return NULL;
+}
diff --git a/winsup/cygwin/winf.h b/winsup/cygwin/winf.h
index e3a65f8cc..b0b4a30ea 100644
--- a/winsup/cygwin/winf.h
+++ b/winsup/cygwin/winf.h
@@ -73,7 +73,7 @@ class linebuf
   void add (const char *what) {add (what, strlen (what));}
   void prepend (const char *, int);
   void __reg2 finish (bool);
-  bool __reg3 fromargv(av&, const char *, bool);;
+  bool __reg3 fromargv(av&, const char *, bool, bool fq = false);;
   operator size_t () const { return ix + 1; }
   operator const char * () const { return buf; }
   operator wchar_t * ()
@@ -94,3 +94,9 @@ class linebuf
     return wbuf;
   }
 };
+
+extern "C"
+{
+  int cygwin_cmdline_parse (char *, char ***, char **, int, int);
+  char *cygwin_cmdline_build (const char * const *, int, int);
+}
diff --git a/winsup/cygwin/winsup.h b/winsup/cygwin/winsup.h
index fff7d18f3..3d779c742 100644
--- a/winsup/cygwin/winsup.h
+++ b/winsup/cygwin/winsup.h
@@ -133,9 +133,6 @@ extern int cygserver_running;
 
 #define set_api_fatal_return(n) do {extern int __api_fatal_exit_val; __api_fatal_exit_val = (n);} while (0)
 
-#undef issep
-#define issep(ch) (strchr (" \t\n\r", (ch)) != NULL)
-
 /* Every path beginning with / or \, as well as every path being X:
    or starting with X:/ or X:\ */
 #define isabspath_u(p) \
@@ -151,6 +148,10 @@ extern int cygserver_running;
 #define isabspath(p) \
   (isdirsep (*(p)) || (isalpha (*(p)) && (p)[1] == ':' && (!(p)[2] || isdirsep ((p)[2]))))
 
+/* Shortcut.  See also std::add_pointer. */
+#define malloc_type(n, type) ((type *) malloc ((n) * sizeof (type)))
+#define realloc_type(b, n, type) ((type *) realloc ((b), (n) * sizeof (type)))
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
diff --git a/winsup/doc/misc-funcs.xml b/winsup/doc/misc-funcs.xml
index 7463942e6..760167048 100644
--- a/winsup/doc/misc-funcs.xml
+++ b/winsup/doc/misc-funcs.xml
@@ -110,4 +110,75 @@ enum.  The second is an optional pointer.</para>
   </refsect1>
 </refentry>
 
+<refentry id="func-cygwin-cmdline-parse">
+  <refmeta>
+    <refentrytitle>cygwin_cmdline_parse</refentrytitle>
+    <manvolnum>3</manvolnum>
+    <refmiscinfo class="manual">Cygwin API Reference</refmiscinfo>
+  </refmeta>
+
+  <refnamediv>
+    <refname>cygwin_cmdline_parse</refname>
+  </refnamediv>
+
+  <refsynopsisdiv>
+<funcsynopsis>
+<funcsynopsisinfo>
+#include &lt;sys/cygwin.h&gt;
+</funcsynopsisinfo>
+<funcprototype>
+<funcdef>int
+<function>cygwin_cmdline_parse</function></funcdef>
+<paramdef>char *<parameter>cmd</parameter></paramdef>
+<paramdef>char ***<parameter>pargv</parameter></paramdef>
+<paramdef>char **<parameter>allocs</parameter></paramdef>
+<paramdef>int <parameter>doglob</parameter></paramdef>
+<paramdef>int <parameter>maxfile</parameter></paramdef>
+</funcprototype></funcsynopsis>
+  </refsynopsisdiv>
+
+  <refsect1 id="func-cygwin-internal-desc">
+    <title>Description</title>
+<para>This function parses a Windows command line in the buffer in-place pointed to by <parameter>cmd</parameter> to the argv pointed to by <parameter>pargv</parameter>. Globbing is performed on non-quoted components if <parameter>doglob</parameter> is 1. Expansion of <ulink url="../cygwin-ug-net/using-specialnames.html#pathnames-at">@pathnames</ulink> is performed if <parameter>maxfile</parameter> is non-zero.</para>
+<para><parameter>maxfile</parameter> specifies the maximum number of @pathname expansions to perform. If the value is positive, -EMLINK is returned when the limit is exceeded. Othewise the parser quietly keeps the value.</para>
+<para>If <parameter>allocs</parameter> is non-NULL, any allocations due to @pathname expansions
+are stored inside. The new buffers should be released using free().</para>
+<para>The return value is the argument count, or a negative errno value on error. When an error occurs, <parameter>pargv</parameter> will reflect the extent of parsed arguments.</para>
+<para>Parsing is generally done according to the rules found in the 2008 Microsoft C++ Runtime. Extentions to the rule include @pathname support, globbing via glob(3), and acceptance of single quotes for quoting.</para>
+  </refsect1>
+</refentry>
+
+<refentry id="func-cygwin-cmdline-build">
+  <refmeta>
+    <refentrytitle>cygwin_cmdline_build</refentrytitle>
+    <manvolnum>3</manvolnum>
+    <refmiscinfo class="manual">Cygwin API Reference</refmiscinfo>
+  </refmeta>
+
+  <refnamediv>
+    <refname>cygwin_cmdline_build</refname>
+  </refnamediv>
+
+  <refsynopsisdiv>
+<funcsynopsis>
+<funcsynopsisinfo>
+#include &lt;sys/cygwin.h&gt;
+</funcsynopsisinfo>
+<funcprototype>
+<funcdef>char *
+<function>cygwin_cmdline_build</function></funcdef>
+<paramdef>const char * const *<parameter>argv</parameter></paramdef>
+<paramdef>int <parameter>allow_overflow</parameter></paramdef>
+<paramdef>int <parameter>forcequote</parameter></paramdef>
+</funcprototype></funcsynopsis>
+  </refsynopsisdiv>
+
+  <refsect1 id="func-cygwin-internal-desc">
+    <title>Description</title>
+<para>This function builds a quoted Windows command line from the <parameter>argv</parameter> given. If <parameter>allow_overflow</parameter> is zero, a check is performed to prevent the cmdline from exceeding 32 KiB. If <parameter>forcequote</parameter> is true, all arguments will be quoted.</para>
+<para>The return value is a pointer to a newly-built string or NULL on error. This buffer should be released using free().</para>
+<para>This function is not a strict inversion of cygwin_cmdline_parse unless <parameter>forcequote</parameter> is on, due to the extensions provided by the parser.</para>
+  </refsect1>
+</refentry>
+
 </sect1>
diff --git a/winsup/testsuite/Makefile.in b/winsup/testsuite/Makefile.in
index a86a35b88..bdc116d12 100644
--- a/winsup/testsuite/Makefile.in
+++ b/winsup/testsuite/Makefile.in
@@ -96,6 +96,7 @@ install:
 install_host:
 
 clean:
+	-rm -f */*/*.d
 	-rm -f *.o *.dll *.a *.exp junk *.bak *.base *.exe testsuite/* *.d *.dat
 
 maintainer-clean realclean: clean
@@ -162,8 +163,9 @@ testsuite/site.exp: site.exp
 check: $(TESTSUP_LIB_NAME) $(RUNTIME) cygrun.exe testsuite/site.exp
 	cd testsuite; runtest --tool winsup $(RUNTESTFLAGS)
 
+# FIXME: I can't find where the MINGW_FE is, so...
 cygrun.o: cygrun.c
-	${MINGW_FE} $(CC) $(MINGW_CFLAGS) -o $@ -c $<
+	x86_64-w64-mingw32-gcc $(MINGW_CFLAGS) -o $@ -c $<
 
 cygrun.exe : cygrun.o
-	${MINGW_FE} $(CC) ${MINGW_LDFLAGS} -o $@ $<
+	x86_64-w64-mingw32-gcc ${MINGW_LDFLAGS} -o $@ $<
diff --git a/winsup/testsuite/winsup.api/cmdline.c b/winsup/testsuite/winsup.api/cmdline.c
new file mode 100644
index 000000000..86c6ba94d
--- /dev/null
+++ b/winsup/testsuite/winsup.api/cmdline.c
@@ -0,0 +1,102 @@
+/* This file is part of Cygwin.
+ *
+ * Tests for cygwin_cmdline_() APIs.
+ */
+
+#include "../libltp/include/test.h"
+#include <sys/cygwin.h>
+
+const char *TCID = "cmdline";    	/* Test program identifier. */
+int TST_TOTAL = 1;              /* Total number of test cases. */
+extern int Tst_count;           /* Test Case counter for tst_* routines */
+
+int
+argvcmp (char *a[], char *b[])
+{
+  size_t i = 0;
+  int res = 0;
+
+  // content same?
+  for (; a[i] && b[i]; i++)
+    if (res = strcmp (a[i], b[i]))
+      return res;
+
+  // length same?
+  return a[i] || b[i];
+}
+
+char *
+stringify_argv (char *a[])
+{
+  size_t retsize = 1024;
+  char *ret = malloc (retsize);
+  size_t retpos = 0;
+
+  for (size_t i = 0; a[i]; i++)
+    {
+      size_t len = strlen (a[i]);
+      while (retsize < retpos + len)
+        {
+          retsize *= 2;
+          ret = realloc (ret, retsize);
+        }
+      strcpy (ret + retpos, a[i]);
+      retpos += len;
+      ret[retpos++] = ',';
+    }
+
+  ret[retpos] = '\0';
+  return ret;
+}
+
+#define PASS(...) tst_resm (TPASS, name, ## __VA_ARGS__)
+#define FAIL(...) tst_resm (TFAIL, name_bad, ## __VA_ARGS__)
+
+void
+assert_argv_eq (const char* name, char *a[], char *b[])
+{
+  if (!argvcmp (a, b))
+    {
+      PASS (name);
+      return;
+    }
+
+  const char *fault = " (expected [%s], got [%s])";
+  char *name_bad = malloc (strlen (name) + strlen (fault) + 1);
+  strcpy (name_bad, name);
+  strcat (name_bad, fault);
+  char *sa = stringify_argv (a), *sb = stringify_argv (b);
+  FAIL (sa, sb);
+  free (sa);
+  free (sb);
+}
+
+int
+parse_test (void)
+{
+  char *subject;
+  char **av;
+
+  tst_resm (TINFO, "Running %s", __FUNCTION__);
+
+  subject = strdup ("a \\\\\\ \"\\a\\\\\"");
+  char *av_exp1[4] = {"a", "\\\\\\", "\\a\\", NULL};
+  cygwin_cmdline_parse (subject, &av, NULL, 0, 0);
+  assert_argv_eq ("Backslashes rules", av_exp1, av);
+  free (subject);
+
+  subject = strdup ("a\"b\"c d\"\"e @\"f h \"\" i j\"");
+  char *av_exp2[4] = {"abc", "d\"e", "@f h \" i j", NULL};
+  cygwin_cmdline_parse (subject, &av, NULL, 0, 0);
+  assert_argv_eq ("Mixed quoting environment", av_exp2, av);
+  free (subject);
+}
+
+int
+main (int argc, char *argv[])
+{
+  parse_test ();
+  tst_exit ();
+  /* NOTREACHED */
+  return 0;
+}
-- 
2.20.1.windows.1
