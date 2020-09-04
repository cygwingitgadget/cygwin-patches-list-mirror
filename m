Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
 by sourceware.org (Postfix) with ESMTPS id 308A0386F461
 for <cygwin-patches@cygwin.com>; Fri,  4 Sep 2020 12:44:03 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 308A0386F461
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mc02Z-1kqXZ01zZf-00dWEN for <cygwin-patches@cygwin.com>; Fri, 04 Sep 2020
 14:44:01 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id A37D9A83A7A; Fri,  4 Sep 2020 14:44:00 +0200 (CEST)
Date: Fri, 4 Sep 2020 14:44:00 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/3] fhandler_pty_slave::setup_locale: respect charset ==
 "UTF-8"
Message-ID: <20200904124400.GQ4127@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <nycvar.QRO.7.76.6.2009011818560.56@tvgsbejvaqbjf.bet>
 <20200902083014.GH4127@calimero.vinschen.de>
 <20200902083818.GI4127@calimero.vinschen.de>
 <20200902195412.aa7f233231d893a7a065b691@nifty.ne.jp>
 <20200902152450.GJ4127@calimero.vinschen.de>
 <20200903012500.640e36573c67328fc3e1bc70@nifty.ne.jp>
 <20200902163836.GL4127@calimero.vinschen.de>
 <20200903175912.GP4127@calimero.vinschen.de>
 <20200904182149.18cd752eef58c67ee8d39135@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
In-Reply-To: <20200904182149.18cd752eef58c67ee8d39135@nifty.ne.jp>
X-Provags-ID: V03:K1:YBFBwX1wE03AC0/ypoA+iGV2euK+9bR5IP/57VBkMgJ8lLdyW5n
 i9EI6KzHgQFWjb1Pkl+KLKzbziwljGn3qAN0ru0hNVtKKmX7RRtLmArndhOEQjyogmbN7j+
 mupgiiCPTrYR0sOghexYf42O/nCPeqHSTSQGdE+RsFzs6L6MAaUMwRmak3KHbE47dahajPA
 8YGCdOUSg4Hxz/0SoWDpQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Rn++cUpH43c=:rSLaimMWHE/N19zuoTIsk2
 pckzrNBXPVLf34IuGkgbobLVWzGQ5SqqCVHG17oWaojIuusJnvRugGwqr0MQPTYBa0G3lxIvF
 97/VuqGSeDiy9gk9kBT+tU3SVYapa3XHNG6UfEJG+14eSWflcNWSIcFWOEOSn82zVnhyq6ruO
 WbaPKG5Lxfwfwf/C5+LQQlK6A+F3mx/XMVQLe9NbnD8WsEj2GFF/rzUeuPNupsQw3HFFicPI6
 aXabRO5xZFMhdi7s5LWyNWbXXSB4HbjfGlVKWVZpf6Y/Dz7CFcxinKlCiSxopHG32M6hCtalV
 vKNtudw4MTzlT4UmmA33fF5dtZc2imtUnxdWNeBWlzmuIaIQ8K//n/eVR2ATri86nxf9UDEa7
 DdBbJp3NhAj17y1S6Qxar0cMHUliknrn1fk7kX4HLQ2HI7Ean5v5Gb+ce3maJB21H5HiBpZeO
 VsQsp5kEw2zUBFxAu6OYXciD7dCcrKfunBF90wIxcZppx6TUGaYtfeSX+iFZp0aUDpD0JFaDz
 SyfZvkVPWb7eixuM003j9mtKdkDgMlw+7DFofYq1yiJIzTv3r1Vcv+3nc4LBao9NOAT3LWaEe
 vniSF/OzPFqQ4h9CfV5TUkUJ0IDjgoBC2GKbx41RH8ioqTlTGZg8pcND8k8yDYpLR3FdY4570
 SK7NUZUYAaf1IHYpwdtPLGs3bLrE0wCdUKINC7VDENd0KFtSk0DPOknsBePZFrcXuS1BAzwgt
 otbm+W0s2ZV83SB06h9f4SzVCjtc/y5ec8MIEOy4BqtG4uZjxVzCYp8XB9b3sH21lUfu9VQ9w
 I39suYwa5oKs1T8/03CjYCXHEFuG098Uzwml4aQCKjtIG0/mz5rI9tyH7LOhwfEnHHY1N1sJr
 VnT6RufmgBPk+XSS4gGQ==
X-Spam-Status: No, score=-105.3 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Fri, 04 Sep 2020 12:44:05 -0000


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Takashi,

On Sep  4 18:21, Takashi Yano via Cygwin-patches wrote:
> Hi Corinna,
> 
> On Thu, 3 Sep 2020 19:59:12 +0200
> Corinna Vinschen wrote:
> > The only idea I had so far was, changing the way __set_charset_from_locale
> > works from within _setlocale_r:
> > 
> > We could add a Cygwin-specific function only fetching the codepage and
> > call it unconditionally from _setlocale_r.  __set_charset_from_locale is
> > called with a new parameter "codepage", so it doesn't have to fetch the
> > CP by itself, but it's still only called from _setlocale_r if necessary.
> > 
> > Would that be sufficient?  The CP conversion from 20127/ASCII to 65001/UTF8
> > could be done at the point the codepage is actually required.
> 
> I think I have found the answer to your request.
> Patch attached. What do you think of this patch?
> 
> Calling initial_setlocale() is necessary because
> nl_langinfo() always returns "ANSI_X3.4-1968"
> regardless locale setting if this is not called.

Well, this is correct.  Per POSIX, a standard-conformant application is
running in the "C" locale unless it calls setlocale() explicitely.
That's one reason Cygwin defaults to UTF-8 internally.  Everything,
including the terminal, is supposed to default to UTF-8.  That's the
most sane default, even if an application is not locale-aware.

So, to follow POSIX, initial_setlocale() is used to set up the
environment and command line stuff and then, before calling the
application's main, Cygwin calls _setlocale_r (_REENT, LC_CTYPE, "C");
to reset the apps default locale to "C".  That's why nl_langinfo()
returns "ANSI_X3.4-1968".

However, the initial_setlocale() call in dll_crt0_1 calls
internal_setlocale(), and *that* function sets the conversion functions
for the internal conversions.  What it *doesn't* do yet at the moment is
to store the charset name itself or, better, the equivalent codepage.

If we change that, setup_locale can simply go away.  Below is a patch
doing just that.  Can you please check if that works in your test
scenarios?

However, there's something which worries me.  Why do we need or set the
pseudo terminal codepage at all?  I see that you convert from MB charset
to MB charset and then use the result in WriteFile to the connecting
pipes.  Question is this: Why not just converting the strings via
sys_mbstowcs to a UTF-16 string and then send that over the line, using
WriteConsoleW for the final output to the console?  That would simplify
this stuff quite a bit, wouldn't it?  After all, for writing UTF-16 to
the console, we simply don't need to know or care for the console CP.


Thanks,
Corinna

--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment;
	filename="0001-Cygwin-fetch-codepage-for-pseudo-console-at-initial_.patch"

From d5dff1690d1a228579eef472441d67fb6ef20b5e Mon Sep 17 00:00:00 2001
From: Corinna Vinschen <corinna@vinschen.de>
Date: Fri, 4 Sep 2020 14:39:58 +0200
Subject: [PATCH] Cygwin: fetch codepage for pseudo console at
 initial_setlocale time

drop locale checking in fhandler_tty code. Create function
__eval_codepage_from_internal_charset called from
internal_setlocale to store term_code_page in cygheap,
rather than in tty.  Drop now unneeded setup_locale calls
during fork and execve.

Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
---
 winsup/cygwin/cygheap.h       |   1 +
 winsup/cygwin/fhandler.h      |   1 -
 winsup/cygwin/fhandler_tty.cc | 195 ++--------------------------------
 winsup/cygwin/nlsfuncs.cc     |  54 +++++++++-
 winsup/cygwin/spawn.cc        |  12 ---
 5 files changed, 60 insertions(+), 203 deletions(-)

diff --git a/winsup/cygwin/cygheap.h b/winsup/cygwin/cygheap.h
index 8877cc358c39..2b84f4252071 100644
--- a/winsup/cygwin/cygheap.h
+++ b/winsup/cygwin/cygheap.h
@@ -341,6 +341,7 @@ struct cygheap_debug
 struct cygheap_locale
 {
   mbtowc_p mbtowc;
+  UINT term_code_page;
 };
 
 struct user_heap_info
diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index b4ba9428aa90..af619df5f9b1 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -2336,7 +2336,6 @@ class fhandler_pty_slave: public fhandler_pty_common
   void set_switch_to_pcon (void);
   void reset_switch_to_pcon (void);
   void mask_switch_to_pcon_in (bool mask);
-  void setup_locale (void);
 };
 
 #define __ptsname(buf, unit) __small_sprintf ((buf), "/dev/pty%d", (unit))
diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 8bf39c3e6cf2..f207a0b27892 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -1614,8 +1614,9 @@ fhandler_pty_master::write (const void *ptr, size_t len)
   if (to_be_read_from_pcon () && get_ttyp ()->h_pseudo_console)
     {
       size_t nlen;
-      char *buf = convert_mb_str
-	(CP_UTF8, &nlen, get_ttyp ()->term_code_page, (const char *) ptr, len);
+      char *buf = convert_mb_str (CP_UTF8, &nlen,
+				  cygheap->locale.term_code_page,
+				  (const char *) ptr, len);
 
       WaitForSingleObject (input_mutex, INFINITE);
 
@@ -1782,185 +1783,6 @@ fhandler_pty_common::set_close_on_exec (bool val)
   close_on_exec (val);
 }
 
-/* This table is borrowed from mintty: charset.c */
-static const struct {
-  UINT cp;
-  const char *name;
-}
-cs_names[] = {
-  { CP_UTF8, "UTF-8"},
-  { CP_UTF8, "UTF8"},
-  {   20127, "ASCII"},
-  {   20127, "US-ASCII"},
-  {   20127, "ANSI_X3.4-1968"},
-  {   20866, "KOI8-R"},
-  {   20866, "KOI8R"},
-  {   20866, "KOI8"},
-  {   21866, "KOI8-U"},
-  {   21866, "KOI8U"},
-  {   20932, "EUCJP"},
-  {   20932, "EUC-JP"},
-  {     874, "TIS620"},
-  {     874, "TIS-620"},
-  {     932, "SJIS"},
-  {     936, "GBK"},
-  {     936, "GB2312"},
-  {     936, "EUCCN"},
-  {     936, "EUC-CN"},
-  {     949, "EUCKR"},
-  {     949, "EUC-KR"},
-  {     950, "BIG5"},
-  {       0, "NULL"}
-};
-
-static void
-get_locale_from_env (char *locale)
-{
-  const char *env = NULL;
-  char lang[ENCODING_LEN + 1] = {0, }, country[ENCODING_LEN + 1] = {0, };
-  env = getenv ("LC_ALL");
-  if (env == NULL || !*env)
-    env = getenv ("LC_CTYPE");
-  if (env == NULL || !*env)
-    env = getenv ("LANG");
-  if (env == NULL || !*env)
-    {
-      if (GetLocaleInfo (LOCALE_CUSTOM_UI_DEFAULT,
-			  LOCALE_SISO639LANGNAME,
-			  lang, sizeof (lang)))
-	GetLocaleInfo (LOCALE_CUSTOM_UI_DEFAULT,
-		       LOCALE_SISO3166CTRYNAME,
-		       country, sizeof (country));
-      else if (GetLocaleInfo (LOCALE_CUSTOM_DEFAULT,
-			      LOCALE_SISO639LANGNAME,
-			      lang, sizeof (lang)))
-	  GetLocaleInfo (LOCALE_CUSTOM_DEFAULT,
-			 LOCALE_SISO3166CTRYNAME,
-			 country, sizeof (country));
-      else if (GetLocaleInfo (LOCALE_USER_DEFAULT,
-			      LOCALE_SISO639LANGNAME,
-			      lang, sizeof (lang)))
-	  GetLocaleInfo (LOCALE_USER_DEFAULT,
-			 LOCALE_SISO3166CTRYNAME,
-			 country, sizeof (country));
-      else if (GetLocaleInfo (LOCALE_SYSTEM_DEFAULT,
-			      LOCALE_SISO639LANGNAME,
-			      lang, sizeof (lang)))
-	  GetLocaleInfo (LOCALE_SYSTEM_DEFAULT,
-			 LOCALE_SISO3166CTRYNAME,
-			 country, sizeof (country));
-      if (strlen (lang) && strlen (country))
-	__small_sprintf (lang + strlen (lang), "_%s.UTF-8", country);
-      else
-	strcpy (lang , "C.UTF-8");
-      env = lang;
-    }
-  strcpy (locale, env);
-}
-
-static void
-get_langinfo (char *locale_out, char *charset_out)
-{
-  /* Get locale from environment */
-  char new_locale[ENCODING_LEN + 1];
-  get_locale_from_env (new_locale);
-
-  __locale_t loc;
-  memset (&loc, 0, sizeof (loc));
-  const char *locale = __loadlocale (&loc, LC_CTYPE, new_locale);
-  if (!locale)
-    locale = "C";
-
-  const char *charset;
-  struct lc_ctype_T *lc_ctype = (struct lc_ctype_T *) loc.lc_cat[LC_CTYPE].ptr;
-  if (!lc_ctype)
-    charset = "ASCII";
-  else
-    charset = lc_ctype->codeset;
-
-  /* The following code is borrowed from nl_langinfo()
-     in newlib/libc/locale/nl_langinfo.c */
-  /* Convert charset to Linux compatible codeset string. */
-  if (charset[0] == 'A'/*SCII*/)
-    charset = "ANSI_X3.4-1968";
-  else if (charset[0] == 'E')
-    {
-      if (strcmp (charset, "EUCJP") == 0)
-	charset = "EUC-JP";
-      else if (strcmp (charset, "EUCKR") == 0)
-	charset = "EUC-KR";
-      else if (strcmp (charset, "EUCCN") == 0)
-	charset = "GB2312";
-    }
-  else if (charset[0] == 'C'/*Pxxxx*/)
-    {
-      if (strcmp (charset + 2, "874") == 0)
-	charset = "TIS-620";
-      else if (strcmp (charset + 2, "20866") == 0)
-	charset = "KOI8-R";
-      else if (strcmp (charset + 2, "21866") == 0)
-	charset = "KOI8-U";
-      else if (strcmp (charset + 2, "101") == 0)
-	charset = "GEORGIAN-PS";
-      else if (strcmp (charset + 2, "102") == 0)
-	charset = "PT154";
-    }
-  else if (charset[0] == 'S'/*JIS*/)
-    {
-      /* Cygwin uses MSFT's implementation of SJIS, which differs
-	 in some codepoints from the real thing, especially
-	 0x5c: yen sign instead of backslash,
-	 0x7e: overline instead of tilde.
-	 We can't use the real SJIS since otherwise Win32
-	 pathnames would become invalid.  OTOH, if we return
-	 "SJIS" here, then libiconv will do mb<->wc conversion
-	 differently to our internal functions.  Therefore we
-	 return what we really implement, CP932.  This is handled
-	 fine by libiconv. */
-      charset = "CP932";
-    }
-
-  /* Set results */
-  strcpy (locale_out, new_locale);
-  strcpy (charset_out, charset);
-}
-
-void
-fhandler_pty_slave::setup_locale (void)
-{
-  if (get_ttyp ()->term_code_page != 0)
-    return;
-
-  char locale[ENCODING_LEN + 1] = "C";
-  char charset[ENCODING_LEN + 1] = "ASCII";
-  get_langinfo (locale, charset);
-
-  /* Set terminal code page from locale */
-  /* This code is borrowed from mintty: charset.c */
-  get_ttyp ()->term_code_page = 20127; /* Default ASCII */
-  char charset_u[ENCODING_LEN + 1] = {0, };
-  for (int i=0; charset[i] && i<ENCODING_LEN; i++)
-    charset_u[i] = toupper (charset[i]);
-  unsigned int iso;
-  UINT cp = 20127; /* Default for fallback */
-  if (sscanf (charset_u, "ISO-8859-%u", &iso) == 1
-      || sscanf (charset_u, "ISO8859-%u", &iso) == 1
-      || sscanf (charset_u, "ISO8859%u", &iso) == 1)
-    {
-      if (iso && iso <= 16 && iso !=12)
-	get_ttyp ()->term_code_page = 28590 + iso;
-    }
-  else if (sscanf (charset_u, "CP%u", &cp) == 1)
-    get_ttyp ()->term_code_page = cp;
-  else
-    for (int i=0; cs_names[i].cp; i++)
-      if (strcasecmp (charset_u, cs_names[i].name) == 0)
-	{
-	  get_ttyp ()->term_code_page = cs_names[i].cp;
-	  break;
-	}
-}
-
 void
 fhandler_pty_slave::fixup_after_fork (HANDLE parent)
 {
@@ -1977,9 +1799,6 @@ fhandler_pty_slave::fixup_after_exec ()
   if (!close_on_exec ())
     fixup_after_fork (NULL);	/* No parent handle required. */
 
-  /* Set locale */
-  setup_locale ();
-
   /* Hook Console API */
 #define DO_HOOK(module, name) \
   if (!name##_Orig) \
@@ -2205,8 +2024,8 @@ fhandler_pty_master::pty_master_fwd_thread ()
 	      state = 0;
 
 	  size_t nlen;
-	  char *buf = convert_mb_str
-	    (get_ttyp ()->term_code_page, &nlen, CP_UTF8, ptr, wlen);
+	  char *buf = convert_mb_str (cygheap->locale.term_code_page,
+				      &nlen, CP_UTF8, ptr, wlen);
 
 	  ptr = buf;
 	  wlen = rlen = nlen;
@@ -2228,8 +2047,8 @@ fhandler_pty_master::pty_master_fwd_thread ()
 	  continue;
 	}
       size_t nlen;
-      char *buf = convert_mb_str
-	(get_ttyp ()->term_code_page, &nlen, GetConsoleOutputCP (), ptr, wlen);
+      char *buf = convert_mb_str (cygheap->locale.term_code_page, &nlen,
+				  GetConsoleOutputCP (), ptr, wlen);
 
       ptr = buf;
       wlen = rlen = nlen;
diff --git a/winsup/cygwin/nlsfuncs.cc b/winsup/cygwin/nlsfuncs.cc
index 668d7eb9e778..10a3a0705142 100644
--- a/winsup/cygwin/nlsfuncs.cc
+++ b/winsup/cygwin/nlsfuncs.cc
@@ -1448,6 +1448,53 @@ __set_charset_from_locale (const char *locale, char *charset)
   stpcpy (charset, cs);
 }
 
+/* Called from internal_setlocale.  Set a codepage which reflects the
+   internal charset setting.  This is *not* necessarily the Windows
+   codepage connected to a locale by default, so we have to set this
+   up explicitely. */
+static UINT
+__eval_codepage_from_internal_charset (const char *charset)
+{
+  UINT codepage = CP_UTF8; /* Default UTF8 */
+
+  /* The internal charset names are well defined, so we can use shortcuts. */
+  switch (charset[0])
+    {
+    case 'B': /* BIG5 */
+      codepage = 950;
+      break;
+    case 'C': /* CPxxx */
+      codepage = strtoul (charset + 2, NULL, 10);
+      break;
+    case 'E': /* EUCxx */
+      switch (charset[3])
+	{
+	case 'J': /* EUCJP */
+	  codepage = 20932;
+	  break;
+	case 'K': /* EUCKR */
+	  codepage = 949;
+	  break;
+	case 'C': /* EUCCN */
+	  codepage = 936;
+	  break;
+	}
+      break;
+    case 'G': /* GBK/GB2312 */
+      codepage = 936;
+      break;
+    case 'I': /* ISO-8859-x */
+      codepage = strtoul (charset + 9, NULL, 10);
+      break;
+    case 'S': /* SJIS */
+      codepage = 932;
+      break;
+    default: /* All set to UTF8 already */
+      break;
+    }
+  return codepage;
+}
+
 /* This function is called from newlib's loadlocale if the locale identifier
    was invalid, one way or the other.  It looks for the file
 
@@ -1535,8 +1582,11 @@ internal_setlocale ()
   if (cygheap->locale.mbtowc == __get_global_locale ()->mbtowc)
     return;
 
-  debug_printf ("Global charset set to %s",
-		__locale_charset (__get_global_locale ()));
+  const char *charset = __locale_charset (__get_global_locale ());
+  debug_printf ("Global charset set to %s", charset);
+  /* Store codepage to be utilized by pseudo console code. */
+  cygheap->locale.term_code_page =
+			__eval_codepage_from_internal_charset (charset);
   /* Fetch PATH and CWD and convert to wchar_t in previous charset. */
   path = getenv ("PATH");
   if (path && *path)	/* $PATH can be potentially unset. */
diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index 92d190d1a764..02c4207abae9 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -619,18 +619,6 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	    }
 	}
 
-      if (!iscygwin ())
-	{
-	  cfd.rewind ();
-	  while (cfd.next () >= 0)
-	    if (cfd->get_major () == DEV_PTYS_MAJOR)
-	      {
-		fhandler_pty_slave *ptys =
-		  (fhandler_pty_slave *)(fhandler_base *) cfd;
-		ptys->setup_locale ();
-	      }
-	}
-
       /* Set up needed handles for stdio */
       si.dwFlags = STARTF_USESTDHANDLES;
       si.hStdInput = handle ((in__stdin < 0 ? 0 : in__stdin), false);
-- 
2.26.2


--y0ulUmNC+osPPQO6--
