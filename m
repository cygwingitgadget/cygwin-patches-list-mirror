Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com
 [210.131.2.83])
 by sourceware.org (Postfix) with ESMTPS id CA3333851C25
 for <cygwin-patches@cygwin.com>; Mon,  7 Sep 2020 04:46:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org CA3333851C25
Received: from Express5800-S70 (v038192.dynamic.ppp.asahi-net.or.jp
 [124.155.38.192]) (authenticated)
 by conssluserg-04.nifty.com with ESMTP id 0874jl6a021852
 for <cygwin-patches@cygwin.com>; Mon, 7 Sep 2020 13:45:47 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 0874jl6a021852
X-Nifty-SrcIP: [124.155.38.192]
Date: Mon, 7 Sep 2020 13:45:58 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/3] fhandler_pty_slave::setup_locale: respect charset
 == "UTF-8"
Message-Id: <20200907134558.3e1cd8bd4070991b856f58bb@nifty.ne.jp>
In-Reply-To: <20200907010413.53ef9a9b727e8f971ca6b2ea@nifty.ne.jp>
References: <20200902083014.GH4127@calimero.vinschen.de>
 <20200902083818.GI4127@calimero.vinschen.de>
 <20200902195412.aa7f233231d893a7a065b691@nifty.ne.jp>
 <20200902152450.GJ4127@calimero.vinschen.de>
 <20200903012500.640e36573c67328fc3e1bc70@nifty.ne.jp>
 <20200902163836.GL4127@calimero.vinschen.de>
 <20200903175912.GP4127@calimero.vinschen.de>
 <20200904182149.18cd752eef58c67ee8d39135@nifty.ne.jp>
 <20200904124400.GQ4127@calimero.vinschen.de>
 <20200904235016.9c34d04e809b5ad9f2bdfdf3@nifty.ne.jp>
 <20200904192235.GW4127@calimero.vinschen.de>
 <20200905174301.adbb3c147122fbe0636a0d56@nifty.ne.jp>
 <20200905201506.8bbca09f51a2b2b06135affa@nifty.ne.jp>
 <20200905231516.c799225e61b2b96bf05f65a6@nifty.ne.jp>
 <20200906175703.5875d4dd6140d9f6812cf2a9@nifty.ne.jp>
 <20200906191530.32230a99bf23d3c6f21beb41@nifty.ne.jp>
 <20200907010413.53ef9a9b727e8f971ca6b2ea@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Mon__7_Sep_2020_13_45_58_+0900_b/luYFFkr7w0hkqv"
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, NICE_REPLY_A,
 RCVD_IN_BARRACUDACENTRAL, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H4,
 RCVD_IN_MSPIKE_WL, SPF_HELO_NONE, SPF_PASS,
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
X-List-Received-Date: Mon, 07 Sep 2020 04:46:24 -0000

This is a multi-part message in MIME format.

--Multipart=_Mon__7_Sep_2020_13_45_58_+0900_b/luYFFkr7w0hkqv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 7 Sep 2020 01:04:13 +0900
Takashi Yano via Cygwin-patches <cygwin-patches@cygwin.com> wrote:
> On Sun, 6 Sep 2020 19:15:30 +0900
> Takashi Yano via Cygwin-patches <cygwin-patches@cygwin.com> wrote:
> > On Sun, 6 Sep 2020 17:57:03 +0900
> > Takashi Yano via Cygwin-patches <cygwin-patches@cygwin.com> wrote:
> > > On Sat, 5 Sep 2020 23:15:16 +0900
> > > Takashi Yano via Cygwin-patches <cygwin-patches@cygwin.com> wrote:
> > > > Hi Corinna,
> > > > 
> > > > On Sat, 5 Sep 2020 20:15:06 +0900
> > > > Takashi Yano via Cygwin-patches <cygwin-patches@cygwin.com> wrote:
> > > > > On Sat, 5 Sep 2020 17:43:01 +0900
> > > > > Takashi Yano via Cygwin-patches <cygwin-patches@cygwin.com> wrote:
> > > > > > Hi Corinna,
> > > > > > 
> > > > > > On Fri, 4 Sep 2020 21:22:35 +0200
> > > > > > Corinna Vinschen wrote:
> > > > > > > Hi Takashi,
> > > > > > > 
> > > > > > > On Sep  4 23:50, Takashi Yano via Cygwin-patches wrote:
> > > > > > > > Hi Corinna,
> > > > > > > > 
> > > > > > > > On Fri, 4 Sep 2020 14:44:00 +0200
> > > > > > > > Corinna Vinschen wrote:
> > > > > > > > > On Sep  4 18:21, Takashi Yano via Cygwin-patches wrote:
> > > > > > > > > > I think I have found the answer to your request.
> > > > > > > > > > Patch attached. What do you think of this patch?
> > > > > > > > > > 
> > > > > > > > > > Calling initial_setlocale() is necessary because
> > > > > > > > > > nl_langinfo() always returns "ANSI_X3.4-1968"
> > > > > > > > > > regardless locale setting if this is not called.
> > > > > > > > > [...]
> > > > > > > > > However, the initial_setlocale() call in dll_crt0_1 calls
> > > > > > > > > internal_setlocale(), and *that* function sets the conversion functions
> > > > > > > > > for the internal conversions.  What it *doesn't* do yet at the moment is
> > > > > > > > > to store the charset name itself or, better, the equivalent codepage.
> > > > > > > > > 
> > > > > > > > > If we change that, setup_locale can simply go away.  Below is a patch
> > > > > > > > > doing just that.  Can you please check if that works in your test
> > > > > > > > > scenarios?
> > > > > > > > 
> > > > > > > > I tried your patch, but unfortunately it does not work.
> > > > > > > > cygheap->locale.term_code_page is 0 in pty master.
> > > > > > > > 
> > > > > > > > If the following lines are moved in internal_setlocale(),
> > > > > > > > 
> > > > > > > >   const char *charset = __locale_charset (__get_global_locale ());
> > > > > > > >   debug_printf ("Global charset set to %s", charset);
> > > > > > > >   /* Store codepage to be utilized by pseudo console code. */
> > > > > > > >   cygheap->locale.term_code_page =
> > > > > > > >             __eval_codepage_from_internal_charset (charset);
> > > > > > > > 
> > > > > > > > in internal_setlocale() before
> > > > > > > > 
> > > > > > > >   /* Don't do anything if the charset hasn't actually changed. */
> > > > > > > >   if (cygheap->locale.mbtowc == __get_global_locale ()->mbtowc)
> > > > > > > >     return;
> > > > > > > 
> > > > > > > Uh, that makes sense.
> > > > > > > 
> > > > > > > > cygheap->locale.term_code_page is always 65001 even if mintty is
> > > > > > > > startted by
> > > > > > > > mintty -o locale=ja_JP -o charset=CP932
> > > > > > > > or
> > > > > > > > mintty -o locale=ja_JP -o charset=EUCJP
> > > > > > > > 
> > > > > > > > Perhaps, this is because LANG is not set properly yet when mintty
> > > > > > > > is started.
> > > > > > > 
> > > > > > > Yeah, that's the reason.  The above settings of locale and charset on
> > > > > > > the CLI should only take over when mintty calls setlocale() with a
> > > > > > > matching string.  The fact that it sets the matching value in the
> > > > > > > environment, too, should only affect child processes, not mintty itself.
> > > > > > > 
> > > > > > > But it's incorrect to call initial_setlocale() from setup_locale()
> > > > > > > without resetting it to its original value.
> > > > > > > 
> > > > > > > Unfortunately that doesn't solve any problem with the pseudo console
> > > > > > > codepage.  Drat.  It sounds like you need the terminal's charset,
> > > > > > > rather than the one set in the environment.
> > > > > > > 
> > > > > > > So this boils down to the fact that term_code_page must be set
> > > > > > > after the application is already running and as soo as it creates
> > > > > > > the pty, me thinks.  What if __eval_codepage_from_internal_charset()
> > > > > > > is called at pty creation?  Or even on reading from /writing to
> > > > > > > the pty the first time?  That should always be late enough to fetch
> > > > > > > the correct codepage.
> > > > > > > 
> > > > > > > Patch attached.  Does that work as expected?
> > > > > > 
> > > > > > Thank you very much for the patch.
> > > > > > 
> > > > > > Your new additional patch works well except the test case such as:
> > > > > > 
> > > > > >   int pm = getpt();
> > > > > >   if (fork()) {
> > > > > >     [do the master operations]
> > > > > >   } else {
> > > > > >     int ps = open(ptsname(pm), O_RDWR|O_NOCTTY);
> > > > > >     close(pm);
> > > > > >     setsid();
> > > > > >     ioctl(ps, TIOCSCTTY, 1);
> > > > > >     dup2(ps, 0);
> > > > > >     dup2(ps, 1);
> > > > > >     dup2(ps, 2);
> > > > > >     close(ps);
> > > > > >     [exec non-cygwin process]
> > > > > >   }
> > > > > > 
> > > > > > If this test case is run in cygwin console (command prompt),
> > > > > > it causes garbled output due to term_code_page == 0.
> > > > > > 
> > > > > > The second additional patch attached fixes the isseu.
> > > > > 
> > > > > No. This does not fix enough.
> > > > > 
> > > > > In the test case above, if it does not call setlocale(),
> > > > > __eval_codepage_from_internal_charset() always returns "ASCII"
> > > > > regardless of locale setting. Therefore, output is garbled if
> > > > > the terminal charset is not UTF-8.
> > > > 
> > > > New additional patch against your patches is attached.
> > > > In the end, essentially what was being done in the original
> > > > code has been restored.
> > > 
> > > The patch revised a little.
> > 
> > Chages:
> > - If global locale is set, it takes precedence.
> 
> Changes:
> - Use __get_current_locale() instead of __get_global_locale().
> - Fix a bug for ISO-8859-* charset.

Changes:
- Use envblock if it is passed to CreateProcess in spawn.cc.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>

--Multipart=_Mon__7_Sep_2020_13_45_58_+0900_b/luYFFkr7w0hkqv
Content-Type: text/plain;
 name="set-term-code-page.diff"
Content-Disposition: attachment;
 filename="set-term-code-page.diff"
Content-Transfer-Encoding: 7bit

diff --git a/winsup/cygwin/cygheap.h b/winsup/cygwin/cygheap.h
index 2b84f4252..8877cc358 100644
--- a/winsup/cygwin/cygheap.h
+++ b/winsup/cygwin/cygheap.h
@@ -341,7 +341,6 @@ struct cygheap_debug
 struct cygheap_locale
 {
   mbtowc_p mbtowc;
-  UINT term_code_page;
 };
 
 struct user_heap_info
diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index af619df5f..17e03785f 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -2336,6 +2336,7 @@ class fhandler_pty_slave: public fhandler_pty_common
   void set_switch_to_pcon (void);
   void reset_switch_to_pcon (void);
   void mask_switch_to_pcon_in (bool mask);
+  void setup_locale (const WCHAR *env);
 };
 
 #define __ptsname(buf, unit) __small_sprintf ((buf), "/dev/pty%d", (unit))
diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index feb014175..fc9f4c44d 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -39,7 +39,7 @@ extern "C" {
   VOID WINAPI ClosePseudoConsole (HPCON);
 }
 
-extern UINT __eval_codepage_from_internal_charset ();
+extern UINT __eval_codepage_from_internal_charset (const WCHAR *env);
 
 #define close_maybe(h) \
   do { \
@@ -635,9 +635,9 @@ fhandler_pty_slave::open (int flags, mode_t)
 
   fhandler_console::need_invisible ();
 
-#if 1 /* Let's try this first */
-  if (!cygheap->locale.term_code_page)
-    cygheap->locale.term_code_page = __eval_codepage_from_internal_charset ();
+#if 0 /* Let's try this first */
+  if (!get_ttyp ()->term_code_page)
+    get_ttyp ()->term_code_page = __eval_codepage_from_internal_charset (NULL);
 #endif
 
   set_open_status ();
@@ -1615,8 +1615,8 @@ fhandler_pty_master::write (const void *ptr, size_t len)
     return (ssize_t) bg;
 
 #if 0 /* Let's try this if setting codepage at pty open time is not enough */
-  if (!cygheap->locale.term_code_page)
-    cygheap->locale.term_code_page = __eval_codepage_from_internal_charset ();
+  if (!get_ttyp ()->term_code_page)
+    get_ttyp ()->term_code_page = __eval_codepage_from_internal_charset (NULL);
 #endif
 
   push_process_state process_state (PID_TTYOU);
@@ -1627,7 +1627,7 @@ fhandler_pty_master::write (const void *ptr, size_t len)
     {
       size_t nlen;
       char *buf = convert_mb_str (CP_UTF8, &nlen,
-				  cygheap->locale.term_code_page,
+				  get_ttyp ()->term_code_page,
 				  (const char *) ptr, len);
 
       WaitForSingleObject (input_mutex, INFINITE);
@@ -1795,6 +1795,13 @@ fhandler_pty_common::set_close_on_exec (bool val)
   close_on_exec (val);
 }
 
+void
+fhandler_pty_slave::setup_locale (const WCHAR *env)
+{
+  if (!get_ttyp ()->term_code_page)
+    get_ttyp ()->term_code_page = __eval_codepage_from_internal_charset (env);
+}
+
 void
 fhandler_pty_slave::fixup_after_fork (HANDLE parent)
 {
@@ -1811,6 +1818,9 @@ fhandler_pty_slave::fixup_after_exec ()
   if (!close_on_exec ())
     fixup_after_fork (NULL);	/* No parent handle required. */
 
+  /* Set locale */
+  setup_locale (NULL);
+
   /* Hook Console API */
 #define DO_HOOK(module, name) \
   if (!name##_Orig) \
@@ -1982,8 +1992,8 @@ fhandler_pty_master::pty_master_fwd_thread ()
   char outbuf[65536];
 
 #if 0 /* Let's try this if setting codepage at pty open time is not enough */
-  if (!cygheap->locale.term_code_page)
-    cygheap->locale.term_code_page = __eval_codepage_from_internal_charset ();
+  if (!get_ttyp ()->term_code_page)
+    get_ttyp ()->term_code_page = __eval_codepage_from_internal_charset (NULL);
 #endif
 
   termios_printf ("Started.");
@@ -2041,7 +2051,7 @@ fhandler_pty_master::pty_master_fwd_thread ()
 	      state = 0;
 
 	  size_t nlen;
-	  char *buf = convert_mb_str (cygheap->locale.term_code_page,
+	  char *buf = convert_mb_str (get_ttyp ()->term_code_page,
 				      &nlen, CP_UTF8, ptr, wlen);
 
 	  ptr = buf;
@@ -2064,7 +2074,7 @@ fhandler_pty_master::pty_master_fwd_thread ()
 	  continue;
 	}
       size_t nlen;
-      char *buf = convert_mb_str (cygheap->locale.term_code_page, &nlen,
+      char *buf = convert_mb_str (get_ttyp ()->term_code_page, &nlen,
 				  GetConsoleOutputCP (), ptr, wlen);
 
       ptr = buf;
diff --git a/winsup/cygwin/nlsfuncs.cc b/winsup/cygwin/nlsfuncs.cc
index 6bffc77c9..120b55c24 100644
--- a/winsup/cygwin/nlsfuncs.cc
+++ b/winsup/cygwin/nlsfuncs.cc
@@ -1453,9 +1453,42 @@ __set_charset_from_locale (const char *locale, char *charset)
    codepage connected to a locale by default, so we have to set this
    up explicitely. */
 UINT
-__eval_codepage_from_internal_charset ()
+__eval_codepage_from_internal_charset (const WCHAR *envblock)
 {
-  const char *charset = __locale_charset (__get_global_locale ());
+  const char *charset;
+  __locale_t *loc = NULL;
+  if (__get_current_locale ()->lc_cat[LC_CTYPE].buf)
+    charset = __locale_charset (__get_current_locale ());
+  else
+    {
+      char locale[ENCODING_LEN + 1] = {0, };
+      if (envblock)
+	{
+	  const WCHAR *lc_all = NULL, *lc_ctype = NULL, *lang = NULL;
+	  for (const WCHAR *p = envblock; *p != L'\0'; p += wcslen (p) + 1)
+	    if (wcsncmp (p, L"LC_ALL=", 7) == 0)
+	      lc_all = p + 7;
+	    else if (wcsncmp (p, L"LC_CTYPE=", 9) == 0)
+	      lc_ctype = p + 9;
+	    else if (wcsncmp (p, L"LANG=", 5) == 0)
+	      lang = p + 5;
+	  if (lc_all && *lc_all)
+	    snprintf (locale, ENCODING_LEN + 1, "%ls", lc_all);
+	  else if (lc_ctype && *lc_ctype)
+	    snprintf (locale, ENCODING_LEN + 1, "%ls", lc_ctype);
+	  else if (lang && *lang)
+	    snprintf (locale, ENCODING_LEN + 1, "%ls", lang);
+	}
+      if (!*locale)
+	{
+	  const char *env = __get_locale_env (_REENT, LC_CTYPE);
+	  strncpy (locale, env, ENCODING_LEN);
+	  locale[ENCODING_LEN] = '\0';
+	}
+      loc = duplocale (__get_current_locale ());
+      __loadlocale (loc, LC_CTYPE, locale);
+      charset = __locale_charset (loc);
+    }
   UINT codepage = CP_UTF8; /* Default UTF8 */
 
   /* The internal charset names are well defined, so we can use shortcuts. */
@@ -1485,7 +1518,7 @@ __eval_codepage_from_internal_charset ()
       codepage = 936;
       break;
     case 'I': /* ISO-8859-x */
-      codepage = strtoul (charset + 9, NULL, 10);
+      codepage = strtoul (charset + 9, NULL, 10) + 28590;
       break;
     case 'S': /* SJIS */
       codepage = 932;
@@ -1493,6 +1526,8 @@ __eval_codepage_from_internal_charset ()
     default: /* All set to UTF8 already */
       break;
     }
+  if (loc)
+    freelocale (loc);
   return codepage;
 }
 
diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index 02c4207ab..e9b808688 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -619,6 +619,18 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	    }
 	}
 
+      if (!iscygwin ())
+	{
+	  cfd.rewind ();
+	  while (cfd.next () >= 0)
+	    if (cfd->get_major () == DEV_PTYS_MAJOR)
+	      {
+		fhandler_pty_slave *ptys =
+		  (fhandler_pty_slave *)(fhandler_base *) cfd;
+		ptys->setup_locale (envblock);
+	      }
+	}
+
       /* Set up needed handles for stdio */
       si.dwFlags = STARTF_USESTDHANDLES;
       si.hStdInput = handle ((in__stdin < 0 ? 0 : in__stdin), false);

--Multipart=_Mon__7_Sep_2020_13_45_58_+0900_b/luYFFkr7w0hkqv--
