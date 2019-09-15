Return-Path: <cygwin-patches-return-9680-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2087 invoked by alias); 15 Sep 2019 04:06:20 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 2029 invoked by uid 89); 15 Sep 2019 04:06:19 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-19.6 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=L, strip, iso88591, iso-8859-1
X-HELO: conuserg-01.nifty.com
Received: from conuserg-01.nifty.com (HELO conuserg-01.nifty.com) (210.131.2.68) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 15 Sep 2019 04:06:16 +0000
Received: from localhost.localdomain (ntsitm283243.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.151.243]) (authenticated)	by conuserg-01.nifty.com with ESMTP id x8F45sLr026084;	Sun, 15 Sep 2019 13:06:04 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-01.nifty.com x8F45sLr026084
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1568520364;	bh=vV2TNvQi65P5TKoBNIIRdNFspJufp3R826mVZZTsGUY=;	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;	b=q3JCkAhyGRMnWUICVCWdxAsJNu5Ga2YY8U8rOa3nruGgC3wHtAnNaAtgp7IE2Ef04	 ZjdHXThKDvAWDhJ/9vxuP73iepmuu/mlsnI/ONeI22Q7xagvLPErt8CSTohevVswGP	 2tMDTMp3xtaRBBdvPgSvxeWT2uPcUkI6/6KQvZRFpo1E063jM/M9Bhkex39t1YKrVn	 0G/Vu0DxZ1LqPboKquRL6KsD/glGwoEOis6e1KfjpAu/s7RI3M9nrhySoDfbzPXqmv	 rQC8tTZf0LYOOaleIlk9DlHHnVOkT82QKoLA03UaqmgLwYpey1v7fbEGgB+yWDo0jN	 edeuvFIlQ+sQw==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 2/3] Cygwin: pty: Use system NLS function instead of PTY's own one.
Date: Sun, 15 Sep 2019 04:06:00 -0000
Message-Id: <20190915040553.849-3-takashi.yano@nifty.ne.jp>
In-Reply-To: <20190915040553.849-1-takashi.yano@nifty.ne.jp>
References: <20190915040553.849-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00201.txt.bz2

- Since calling system __loadlocale() caused execution error,
  PTY used its own NLS function. The cause of the error has been
  found, the corresponding code has been rewritten using system
  function.
---
 winsup/cygwin/fhandler.h      |   1 +
 winsup/cygwin/fhandler_tty.cc | 499 +++++++---------------------------
 winsup/cygwin/tty.cc          |   2 +-
 winsup/cygwin/tty.h           |   2 +-
 4 files changed, 107 insertions(+), 397 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index 1bf5dfb09..4efb6a4f2 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -2192,6 +2192,7 @@ class fhandler_pty_slave: public fhandler_pty_common
   {
     return get_ttyp ()->ti.c_lflag & ICANON;
   }
+  void setup_locale (void);
 };
 
 #define __ptsname(buf, unit) __small_sprintf ((buf), "/dev/pty%d", (unit))
diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 1b1d54447..3bf8d0b75 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -29,11 +29,6 @@ details. */
 
 #define ALWAYS_USE_PCON false
 #define USE_API_HOOK true
-#define USE_OWN_NLS_FUNC true
-
-#if !USE_OWN_NLS_FUNC
-#include "langinfo.h"
-#endif
 
 /* Not yet defined in Mingw-w64 */
 #ifndef ENABLE_VIRTUAL_TERMINAL_PROCESSING
@@ -1129,7 +1124,7 @@ fhandler_pty_slave::push_to_pcon_screenbuffer (const char *ptr, size_t len)
   size_t nlen;
   DWORD origCP;
   origCP = GetConsoleOutputCP ();
-  SetConsoleOutputCP (get_ttyp ()->TermCodePage);
+  SetConsoleOutputCP (get_ttyp ()->term_code_page);
   /* Just copy */
   buf = (char *) HeapAlloc (GetProcessHeap (), 0, len);
   memcpy (buf, (char *)ptr, len);
@@ -1246,16 +1241,16 @@ fhandler_pty_slave::write (const void *ptr, size_t len)
   char *buf;
   ssize_t nlen;
   UINT targetCodePage = get_ttyp ()->switch_to_pcon_out ?
-    GetConsoleOutputCP () : get_ttyp ()->TermCodePage;
-  if (targetCodePage != get_ttyp ()->TermCodePage)
+    GetConsoleOutputCP () : get_ttyp ()->term_code_page;
+  if (targetCodePage != get_ttyp ()->term_code_page)
     {
       size_t wlen =
-	MultiByteToWideChar (get_ttyp ()->TermCodePage, 0,
+	MultiByteToWideChar (get_ttyp ()->term_code_page, 0,
 			     (char *)ptr, len, NULL, 0);
       wchar_t *wbuf = (wchar_t *)
 	HeapAlloc (GetProcessHeap (), 0, wlen * sizeof (wchar_t));
       wlen =
-	MultiByteToWideChar (get_ttyp ()->TermCodePage, 0,
+	MultiByteToWideChar (get_ttyp ()->term_code_page, 0,
 			     (char *)ptr, len, wbuf, wlen);
       nlen = WideCharToMultiByte (targetCodePage, 0,
 				  wbuf, wlen, NULL, 0, NULL, NULL);
@@ -2242,15 +2237,15 @@ fhandler_pty_master::write (const void *ptr, size_t len)
       char *buf;
       size_t nlen;
 
-      if (get_ttyp ()->TermCodePage != CP_UTF8)
+      if (get_ttyp ()->term_code_page != CP_UTF8)
 	{
 	  size_t wlen =
-	    MultiByteToWideChar (get_ttyp ()->TermCodePage, 0,
+	    MultiByteToWideChar (get_ttyp ()->term_code_page, 0,
 				 (char *)ptr, len, NULL, 0);
 	  wchar_t *wbuf = (wchar_t *)
 	    HeapAlloc (GetProcessHeap (), 0, wlen * sizeof (wchar_t));
 	  wlen =
-	    MultiByteToWideChar (get_ttyp ()->TermCodePage, 0,
+	    MultiByteToWideChar (get_ttyp ()->term_code_page, 0,
 				 (char *)ptr, len, wbuf, wlen);
 	  nlen = WideCharToMultiByte (CP_UTF8, 0,
 				      wbuf, wlen, NULL, 0, NULL, NULL);
@@ -2502,7 +2497,6 @@ get_locale_from_env (char *locale)
   strcpy (locale, env);
 }
 
-#if USE_OWN_NLS_FUNC
 static LCID
 get_langinfo (char *locale_out, char *charset_out)
 {
@@ -2510,318 +2504,52 @@ get_langinfo (char *locale_out, char *charset_out)
   char new_locale[ENCODING_LEN + 1];
   get_locale_from_env (new_locale);
 
-  /* The following code is borrowed from __loadlocale() in
-     newlib/libc/locale/locale.c */
-
-  /* At this point a full-featured system would just load the locale
-     specific data from the locale files.
-     What we do here for now is to check the incoming string for correctness.
-     The string must be in one of the allowed locale strings, either
-     one in POSIX-style, or one in the old newlib style to maintain
-     backward compatibility.  If the local string is correct, the charset
-     is extracted and stored in ctype_codeset or message_charset
-     dependent on the cateogry. */
-  char *locale = NULL;
-  char charset[ENCODING_LEN + 1];
-  long val = 0;
-  char *end, *c = NULL;
-
-  /* This additional code handles the case that the incoming locale string
-     is not valid.  If so, it calls the function __set_locale_from_locale_alias,
-     which is only available on Cygwin right now.  The function reads the
-     file /usr/share/locale/locale.alias.  The file contains locale aliases
-     and their replacement locale.  For instance, the alias "french" is
-     translated to "fr_FR.ISO-8859-1", the alias "thai" is translated to
-     "th_TH.TIS-620".  If successful, the function returns with LCID
-     correspoding to the locale. */
-  char tmp_locale[ENCODING_LEN + 1];
-
-restart:
+  __locale_t loc;
+  memset(&loc, 0, sizeof (loc));
+  const char *locale = __loadlocale (&loc, LC_CTYPE, new_locale);
   if (!locale)
-    locale = new_locale;
-  else if (locale != tmp_locale)
-    {
-      locale = __set_locale_from_locale_alias (locale, tmp_locale);
-      if (!locale)
-	return 0;
-    }
-# define FAIL	goto restart
-
-  /* "POSIX" is translated to "C", as on Linux. */
-  if (!strcmp (locale, "POSIX"))
-    strcpy (locale, "C");
-  if (!strcmp (locale, "C"))				/* Default "C" locale */
-    strcpy (charset, "ASCII");
-  else if (locale[0] == 'C'
-	   && (locale[1] == '-'		/* Old newlib style */
-	       || locale[1] == '.'))	/* Extension for the C locale to allow
-					   specifying different charsets while
-					   sticking to the C locale in terms
-					   of sort order, etc.  Proposed in
-					   the Debian project. */
-    {
-      char *chp;
-
-      c = locale + 2;
-      strcpy (charset, c);
-      if ((chp = strchr (charset, '@')))
-        /* Strip off modifier */
-        *chp = '\0';
-      c += strlen (charset);
-    }
-  else							/* POSIX style */
-    {
-      c = locale;
-
-      /* Don't use ctype macros here, they might be localized. */
-      /* Language */
-      if (c[0] < 'a' || c[0] > 'z'
-	  || c[1] < 'a' || c[1] > 'z')
-	FAIL;
-      c += 2;
-      /* Allow three character Language per ISO 639-3 */
-      if (c[0] >= 'a' && c[0] <= 'z')
-	++c;
-      if (c[0] == '_')
-        {
-	  /* Territory */
-	  ++c;
-	  if (c[0] < 'A' || c[0] > 'Z'
-	      || c[1] < 'A' || c[1] > 'Z')
-	    FAIL;
-	  c += 2;
-	}
-      if (c[0] == '.')
-	{
-	  /* Charset */
-	  char *chp;
-
-	  ++c;
-	  strcpy (charset, c);
-	  if ((chp = strchr (charset, '@')))
-	    /* Strip off modifier */
-	    *chp = '\0';
-	  c += strlen (charset);
-	}
-      else if (c[0] == '\0' || c[0] == '@')
-	/* End of string or just a modifier */
-
-	/* The Cygwin-only function __set_charset_from_locale checks
-	   for the default charset which is connected to the given locale.
-	   The function uses Windows functions in turn so it can't be easily
-	   adapted to other targets.  However, if any other target provides
-	   equivalent functionality, preferrably using the same function name
-	   it would be sufficient to change the guarding #ifdef. */
-	__set_charset_from_locale (locale, charset);
-      else
-	/* Invalid string */
-	FAIL;
-    }
-  /* We only support this subset of charsets. */
-  switch (charset[0])
-    {
-    case 'U':
-    case 'u':
-      if (strcasecmp (charset, "UTF-8") && strcasecmp (charset, "UTF8"))
-	FAIL;
-      strcpy (charset, "UTF-8");
-      break;
-    case 'E':
-    case 'e':
-      if (strncasecmp (charset, "EUC", 3))
-	FAIL;
-      c = charset + 3;
-      if (*c == '-')
-	++c;
-      if (!strcasecmp (c, "JP"))
-	strcpy (charset, "EUCJP");
-      /* Newlib does neither provide EUC-KR nor EUC-CN, and Cygwin's
-	 implementation requires Windows support. */
-      else if (!strcasecmp (c, "KR"))
-	strcpy (charset, "EUCKR");
-      else if (!strcasecmp (c, "CN"))
-	strcpy (charset, "EUCCN");
-      else
-	FAIL;
-      break;
-    case 'S':
-    case 's':
-      if (strcasecmp (charset, "SJIS"))
-	FAIL;
-      strcpy (charset, "SJIS");
-      break;
-    case 'I':
-    case 'i':
-      /* Must be exactly one of ISO-8859-1, [...] ISO-8859-16, except for
-         ISO-8859-12.  This code also recognizes the aliases without dashes. */
-      if (strncasecmp (charset, "ISO", 3))
-	FAIL;
-      c = charset + 3;
-      if (*c == '-')
-	++c;
-      if (strncasecmp (c, "8859", 4))
-	FAIL;
-      c += 4;
-      if (*c == '-')
-	++c;
-      val = strtol (c, &end, 10);
-      if (val < 1 || val > 16 || val == 12 || *end)
-	FAIL;
-      strcpy (charset, "ISO-8859-");
-      c = charset + 9;
-      if (val > 10)
-	*c++ = '1';
-      *c++ = val % 10 + '0';
-      *c = '\0';
-      break;
-    case 'C':
-    case 'c':
-      if (charset[1] != 'P' && charset[1] != 'p')
-	FAIL;
-      strncpy (charset, "CP", 2);
-      val = strtol (charset + 2, &end, 10);
-      if (*end)
-	FAIL;
-      switch (val)
-	{
-	case 437:
-	case 720:
-	case 737:
-	case 775:
-	case 850:
-	case 852:
-	case 855:
-	case 857:
-	case 858:
-	case 862:
-	case 866:
-	case 874:
-	case 1125:
-	case 1250:
-	case 1251:
-	case 1252:
-	case 1253:
-	case 1254:
-	case 1255:
-	case 1256:
-	case 1257:
-	case 1258:
-	case 932:
-	  break;
-	default:
-	  FAIL;
-	}
-      break;
-    case 'K':
-    case 'k':
-      /* KOI8-R, KOI8-U and the aliases without dash */
-      if (strncasecmp (charset, "KOI8", 4))
-	FAIL;
-      c = charset + 4;
-      if (*c == '-')
-	++c;
-      if (*c == 'R' || *c == 'r')
-	{
-	  val = 20866;
-	  strcpy (charset, "CP20866");
-	}
-      else if (*c == 'U' || *c == 'u')
-	{
-	  val = 21866;
-	  strcpy (charset, "CP21866");
-	}
-      else
-	FAIL;
-      break;
-    case 'A':
-    case 'a':
-      if (strcasecmp (charset, "ASCII"))
-	FAIL;
-      strcpy (charset, "ASCII");
-      break;
-    case 'G':
-    case 'g':
-      /* Newlib does not provide GBK/GB2312 and Cygwin's implementation
-	 requires Windows support. */
-      if (!strcasecmp (charset, "GBK")
-	  || !strcasecmp (charset, "GB2312"))
-	strcpy (charset, charset[2] == '2' ? "GB2312" : "GBK");
-      else
-      /* GEORGIAN-PS and the alias without dash */
-      if (!strncasecmp (charset, "GEORGIAN", 8))
-	{
-	  c = charset + 8;
-	  if (*c == '-')
-	    ++c;
-	  if (strcasecmp (c, "PS"))
-	    FAIL;
-	  val = 101;
-	  strcpy (charset, "CP101");
-	}
-      else
-	FAIL;
-      break;
-    case 'P':
-    case 'p':
-      /* PT154 */
-      if (strcasecmp (charset, "PT154"))
-	FAIL;
-      val = 102;
-      strcpy (charset, "CP102");
-      break;
-    case 'T':
-    case 't':
-      if (strncasecmp (charset, "TIS", 3))
-	FAIL;
-      c = charset + 3;
-      if (*c == '-')
-	++c;
-      if (strcasecmp (c, "620"))
-	FAIL;
-      val = 874;
-      strcpy (charset, "CP874");
-      break;
-    /* Newlib does not provide Big5 and Cygwin's implementation
-       requires Windows support. */
-    case 'B':
-    case 'b':
-      if (strcasecmp (charset, "BIG5"))
-	FAIL;
-      strcpy (charset, "BIG5");
-      break;
-    default:
-      FAIL;
-    }
+    locale = "C";
+
+  char tmp_locale[ENCODING_LEN + 1];
+  char *ret = __set_locale_from_locale_alias (locale, tmp_locale);
+  if (ret)
+    locale = tmp_locale;
+
+  const char *charset;
+  struct lc_ctype_T *lc_ctype = (struct lc_ctype_T *) loc.lc_cat[LC_CTYPE].ptr;
+  if (!lc_ctype)
+    charset = "ASCII";
+  else
+    charset = lc_ctype->codeset;
 
   /* The following code is borrowed from nl_langinfo()
      in newlib/libc/locale/nl_langinfo.c */
   /* Convert charset to Linux compatible codeset string. */
-  const char *ret = charset;
-  if (ret[0] == 'A'/*SCII*/)
-    ret = "ANSI_X3.4-1968";
-  else if (ret[0] == 'E')
-    {
-      if (strcmp (ret, "EUCJP") == 0)
-	ret = "EUC-JP";
-      else if (strcmp (ret, "EUCKR") == 0)
-	ret = "EUC-KR";
-      else if (strcmp (ret, "EUCCN") == 0)
-	ret = "GB2312";
-    }
-  else if (ret[0] == 'C'/*Pxxxx*/)
-    {
-      if (strcmp (ret + 2, "874") == 0)
-	ret = "TIS-620";
-      else if (strcmp (ret + 2, "20866") == 0)
-	ret = "KOI8-R";
-      else if (strcmp (ret + 2, "21866") == 0)
-	ret = "KOI8-U";
-      else if (strcmp (ret + 2, "101") == 0)
-	ret = "GEORGIAN-PS";
-      else if (strcmp (ret + 2, "102") == 0)
-	ret = "PT154";
-    }
-  else if (ret[0] == 'S'/*JIS*/)
+  if (charset[0] == 'A'/*SCII*/)
+    charset = "ANSI_X3.4-1968";
+  else if (charset[0] == 'E')
+    {
+      if (strcmp (charset, "EUCJP") == 0)
+	charset = "EUC-JP";
+      else if (strcmp (charset, "EUCKR") == 0)
+	charset = "EUC-KR";
+      else if (strcmp (charset, "EUCCN") == 0)
+	charset = "GB2312";
+    }
+  else if (charset[0] == 'C'/*Pxxxx*/)
+    {
+      if (strcmp (charset + 2, "874") == 0)
+	charset = "TIS-620";
+      else if (strcmp (charset + 2, "20866") == 0)
+	charset = "KOI8-R";
+      else if (strcmp (charset + 2, "21866") == 0)
+	charset = "KOI8-U";
+      else if (strcmp (charset + 2, "101") == 0)
+	charset = "GEORGIAN-PS";
+      else if (strcmp (charset + 2, "102") == 0)
+	charset = "PT154";
+    }
+  else if (charset[0] == 'S'/*JIS*/)
     {
       /* Cygwin uses MSFT's implementation of SJIS, which differs
 	 in some codepoints from the real thing, especially
@@ -2833,7 +2561,7 @@ restart:
 	 differently to our internal functions.  Therefore we
 	 return what we really implement, CP932.  This is handled
 	 fine by libiconv. */
-      ret = "CP932";
+      charset = "CP932";
     }
 
   wchar_t lc[ENCODING_LEN + 1];
@@ -2851,10 +2579,56 @@ restart:
 
   /* Set results */
   strcpy(locale_out, new_locale);
-  strcpy(charset_out, ret);
+  strcpy(charset_out, charset);
   return lcid;
 }
-#endif /* USE_OWN_NLS_FUNC */
+
+void
+fhandler_pty_slave::setup_locale (void)
+{
+  char locale[ENCODING_LEN + 1] = "C";
+  char charset[ENCODING_LEN + 1] = "ASCII";
+  LCID lcid = get_langinfo (locale, charset);
+
+  /* Set console code page form locale */
+  UINT code_page;
+  if (lcid == 0 || lcid == (LCID) -1)
+    code_page = 20127; /* ASCII */
+  else if (!GetLocaleInfo (lcid,
+			   LOCALE_IDEFAULTANSICODEPAGE | LOCALE_RETURN_NUMBER,
+			   (char *) &code_page, sizeof (code_page)))
+    code_page = 20127; /* ASCII */
+  SetConsoleCP (code_page);
+  SetConsoleOutputCP (code_page);
+
+  if (get_ttyp ()->term_code_page == 0)
+    {
+      /* Set terminal code page from locale */
+      /* This code is borrowed from mintty: charset.c */
+      get_ttyp ()->term_code_page = 20127; /* Default ASCII */
+      char charset_u[ENCODING_LEN + 1] = {0, };
+      for (int i=0; charset[i] && i<ENCODING_LEN; i++)
+	charset_u[i] = toupper (charset[i]);
+      unsigned int iso;
+      UINT cp = 20127; /* Default for fallback */
+      if (sscanf (charset_u, "ISO-8859-%u", &iso) == 1 ||
+	  sscanf (charset_u, "ISO8859-%u", &iso) == 1 ||
+	  sscanf (charset_u, "ISO8859%u", &iso) == 1)
+	{
+	  if (iso && iso <= 16 && iso !=12)
+	    get_ttyp ()->term_code_page = 28590 + iso;
+	}
+      else if (sscanf (charset_u, "CP%u", &cp) == 1)
+	get_ttyp ()->term_code_page = cp;
+      else
+	for (int i=0; cs_names[i].cp; i++)
+	  if (strcasecmp (charset_u, cs_names[i].name) == 0)
+	    {
+	      get_ttyp ()->term_code_page = cs_names[i].cp;
+	      break;
+	    }
+    }
+}
 
 void
 fhandler_pty_slave::fixup_after_attach (bool native_maybe, int fd_set)
@@ -2870,74 +2644,6 @@ fhandler_pty_slave::fixup_after_attach (bool native_maybe, int fd_set)
 	    {
 	      pcon_attached_to = get_minor ();
 	      init_console_handler (true);
-#if USE_OWN_NLS_FUNC
-	      char locale[ENCODING_LEN + 1] = "C";
-	      char charset[ENCODING_LEN + 1] = "ASCII";
-	      LCID lcid = get_langinfo (locale, charset);
-#else /* USE_OWN_NLS_FUNC */
-	      char env[ENCODING_LEN + 1];
-	      get_locale_from_env (env);
-	      setlocale (LC_CTYPE, env);
-	      const char *locale = setlocale (LC_CTYPE, NULL);
-#if 0
-	      char tmp_locale[ENCODING_LEN + 1];
-	      char *ret = __set_locale_from_locale_alias (locale, tmp_locale);
-	      if (ret)
-		locale = tmp_locale;
-#endif
-	      wchar_t lc[ENCODING_LEN + 1];
-	      wchar_t *p;
-	      mbstowcs (lc, locale, ENCODING_LEN);
-	      p = wcschr (lc, L'.');
-	      if (p)
-		*p = L'\0';
-	      p = wcschr (lc, L'@');
-	      if (p)
-		*p = L'\0';
-	      p = wcschr (lc, L'_');
-	      if (p)
-		*p = L'-';
-	      LCID lcid = LocaleNameToLCID (lc, 0);
-	      const char *charset = nl_langinfo (CODESET);
-#endif /* USE_OWN_NLS_FUNC */
-
-	      /* Set console code page form locale */
-	      UINT CodePage;
-	      if (lcid == 0 || lcid == (LCID) -1)
-		CodePage = 20127; /* ASCII */
-	      else if (!GetLocaleInfo (lcid,
-		       LOCALE_IDEFAULTANSICODEPAGE | LOCALE_RETURN_NUMBER,
-		       (char *) &CodePage, sizeof (CodePage)))
-		CodePage = 20127; /* ASCII */
-	      SetConsoleCP (CodePage);
-	      SetConsoleOutputCP (CodePage);
-
-	      if (get_ttyp ()->num_pcon_attached_slaves == 0)
-		{
-		  /* Set terminal code page from locale */
-		  /* This code is borrowed from mintty: charset.c */
-		  char charset_u[ENCODING_LEN + 1] = {0, };
-		  for (int i=0; charset[i] && i<ENCODING_LEN; i++)
-		    charset_u[i] = toupper (charset[i]);
-		  unsigned int iso;
-		  UINT cp = 20127; /* Default for fallback */
-		  if (sscanf (charset_u, "ISO-8859-%u", &iso) == 1 ||
-		      sscanf (charset_u, "ISO8859-%u", &iso) == 1 ||
-		      sscanf (charset_u, "ISO8859%u", &iso) == 1)
-		    {
-		      if (iso && iso <= 16 && iso !=12)
-			get_ttyp ()->TermCodePage = 28590 + iso;
-		    }
-		  else if (sscanf (charset_u, "CP%u", &cp) == 1)
-		    get_ttyp ()->TermCodePage = cp;
-		  else
-		    for (int i=0; cs_names[i].cp; i++)
-		      if (strcasecmp (charset_u, cs_names[i].name) == 0)
-			{
-			  get_ttyp ()->TermCodePage = cs_names[i].cp;
-			  break;
-			}
-		}
 	    }
 	  /* Clear screen to synchronize pseudo console screen buffer
 	     with real terminal. This is necessary because pseudo
@@ -3036,6 +2742,9 @@ fhandler_pty_slave::fixup_after_exec ()
 	}
     }
 
+  /* Set locale */
+  setup_locale ();
+
 #if USE_API_HOOK
   /* Hook Console API */
   if (getPseudoConsole ())
@@ -3294,7 +3003,7 @@ fhandler_pty_master::pty_master_fwd_thread ()
 
 	  char *buf;
 	  size_t nlen;
-	  if (get_ttyp ()->TermCodePage != CP_UTF8)
+	  if (get_ttyp ()->term_code_page != CP_UTF8)
 	    {
 	      size_t wlen2 =
 		MultiByteToWideChar (CP_UTF8, 0,
@@ -3304,10 +3013,10 @@ fhandler_pty_master::pty_master_fwd_thread ()
 	      wlen2 =
 		MultiByteToWideChar (CP_UTF8, 0,
 				     (char *)ptr, wlen, wbuf, wlen2);
-	      nlen = WideCharToMultiByte (get_ttyp ()->TermCodePage, 0,
+	      nlen = WideCharToMultiByte (get_ttyp ()->term_code_page, 0,
 					  wbuf, wlen2, NULL, 0, NULL, NULL);
 	      buf = (char *) HeapAlloc (GetProcessHeap (), 0, nlen);
-	      nlen = WideCharToMultiByte (get_ttyp ()->TermCodePage, 0,
+	      nlen = WideCharToMultiByte (get_ttyp ()->term_code_page, 0,
 					  wbuf, wlen2, buf, nlen, NULL, NULL);
 	      HeapFree (GetProcessHeap (), 0, wbuf);
 	    }
diff --git a/winsup/cygwin/tty.cc b/winsup/cygwin/tty.cc
index 54c25d997..460153cdb 100644
--- a/winsup/cygwin/tty.cc
+++ b/winsup/cygwin/tty.cc
@@ -243,7 +243,7 @@ tty::init ()
   mask_switch_to_pcon_in = false;
   pcon_pid = 0;
   num_pcon_attached_slaves = 0;
-  TermCodePage = 20127; /* ASCII */
+  term_code_page = 0;
   need_clear_screen = false;
 }
 
diff --git a/winsup/cygwin/tty.h b/winsup/cygwin/tty.h
index b7d1e23ad..927d7afd9 100644
--- a/winsup/cygwin/tty.h
+++ b/winsup/cygwin/tty.h
@@ -104,7 +104,7 @@ private:
   bool mask_switch_to_pcon_in;
   pid_t pcon_pid;
   int num_pcon_attached_slaves;
-  UINT TermCodePage;
+  UINT term_code_page;
   bool need_clear_screen;
 
 public:
-- 
2.21.0
