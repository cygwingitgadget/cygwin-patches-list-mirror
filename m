Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 by sourceware.org (Postfix) with ESMTPS id 03FEE3987C28
 for <cygwin-patches@cygwin.com>; Fri,  4 Sep 2020 19:22:39 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 03FEE3987C28
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MiJhQ-1kjTNC1i3q-00fTqo for <cygwin-patches@cygwin.com>; Fri, 04 Sep 2020
 21:22:36 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id C8975A83A87; Fri,  4 Sep 2020 21:22:35 +0200 (CEST)
Date: Fri, 4 Sep 2020 21:22:35 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/3] fhandler_pty_slave::setup_locale: respect charset ==
 "UTF-8"
Message-ID: <20200904192235.GW4127@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
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
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="H1spWtNR+x+ondvy"
Content-Disposition: inline
In-Reply-To: <20200904235016.9c34d04e809b5ad9f2bdfdf3@nifty.ne.jp>
X-Provags-ID: V03:K1:T9yQDUeg6ApTW0fRGRJjo55G85Ol9Jd8hB9N/1g+IHXVqlJz6qf
 gtknq0oW0fkUk4swXz2rfBc9qOlmZCT1mRYrzRVUe/W90s0INbKNjul79fTpORFjnRrutUN
 zoWSnt4Ef3IQdZLLRggazkuVmPP4Jmxl2sNbfKUnDjBP/hVc4zbVxJn8ToV6r442mHJJYfy
 UP4sDrCXlSx+VGX2B3Y6A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9crvi8Qsdrk=:LcuIUbyE1ZHDlNSMvLOZQ4
 edm9S8VW8XeSEBjRt0zDcJiI+u/C95ppr3s9Nc1tx5pTAOhNnCMQOGmO/daQelu53FIPj/Vzq
 9RBAwixhbziKH+SubmHF2mLukP8YkUMulPw8NEcqA/Ikh4nPVV2xAkBMKneznJqfBCqjtL6vs
 DRxr/OIQZWsNufavh6/ipPv69Mfj9qcodjpOjd6rZQIVviC/CKsNhiVztL2iRKzEYb1CzMRUj
 KU6chdddry7kGoiCPO/qE4sSTUEb17tOw1zvzcxVzJFCO2WQYLSd4GA09scZEZRE4EK8kCSVf
 kA1sOYagCAi812NwnqbtOyFFPSqgIVTH6Io1YSyNpispxpOHy1ztJFqXYbqUD5wjGUpqZ0ecD
 TuSxufDxP+ON7S5XbN4NVX8Ez7TnDG9MMTytoj9v2gvFW/jEZtJGdw8s5bZfP26DNDRfcbbjO
 79qD1a0yIXb6KHmVjF2h+MkXtEKTuMlGiPjEX7yBBOnyJFDISgcknuj3vlvTgdUgDF77YZmUA
 N9X46xfcSjAotA3HKhnhTSwcKM/LfKu/OzKvYeS8ksUVZS6CskVU97tpi3Hyd0fp4FqcoBKmc
 bsjAz3XkggltLiAK8w9vwIfwwwjxRJXrXUMbM+iCno5cTDJrazZgdzEVjHU8HtgCIGHPNp/uU
 pwaAJhetJDzSaLjbcU6RPbYQgN1MBZU5wwzr5Mo3EhX0Ci0xqhfb0LvYKyF4lMEm8eU3qjpZT
 s9cJDXdc1PqLQHEpQzE5/gjy8YtDBFPkcj1w2xTMZuGdsZiuNPOpKYqEnfg0xll+j4cmQJCql
 y3RHUPLxWaajzxQ9mfKbAoeNOPuU1IRG2q2MDLIYJF2xMXTRjmtQKW49Rz0nKqzp1fj+rxC3s
 o2Kouq1mGI+JtSAuDJ2Q==
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
X-List-Received-Date: Fri, 04 Sep 2020 19:22:42 -0000


--H1spWtNR+x+ondvy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Takashi,

On Sep  4 23:50, Takashi Yano via Cygwin-patches wrote:
> Hi Corinna,
> 
> On Fri, 4 Sep 2020 14:44:00 +0200
> Corinna Vinschen wrote:
> > On Sep  4 18:21, Takashi Yano via Cygwin-patches wrote:
> > > I think I have found the answer to your request.
> > > Patch attached. What do you think of this patch?
> > > 
> > > Calling initial_setlocale() is necessary because
> > > nl_langinfo() always returns "ANSI_X3.4-1968"
> > > regardless locale setting if this is not called.
> > [...]
> > However, the initial_setlocale() call in dll_crt0_1 calls
> > internal_setlocale(), and *that* function sets the conversion functions
> > for the internal conversions.  What it *doesn't* do yet at the moment is
> > to store the charset name itself or, better, the equivalent codepage.
> > 
> > If we change that, setup_locale can simply go away.  Below is a patch
> > doing just that.  Can you please check if that works in your test
> > scenarios?
> 
> I tried your patch, but unfortunately it does not work.
> cygheap->locale.term_code_page is 0 in pty master.
> 
> If the following lines are moved in internal_setlocale(),
> 
>   const char *charset = __locale_charset (__get_global_locale ());
>   debug_printf ("Global charset set to %s", charset);
>   /* Store codepage to be utilized by pseudo console code. */
>   cygheap->locale.term_code_page =
>             __eval_codepage_from_internal_charset (charset);
> 
> in internal_setlocale() before
> 
>   /* Don't do anything if the charset hasn't actually changed. */
>   if (cygheap->locale.mbtowc == __get_global_locale ()->mbtowc)
>     return;

Uh, that makes sense.

> cygheap->locale.term_code_page is always 65001 even if mintty is
> startted by
> mintty -o locale=ja_JP -o charset=CP932
> or
> mintty -o locale=ja_JP -o charset=EUCJP
> 
> Perhaps, this is because LANG is not set properly yet when mintty
> is started.

Yeah, that's the reason.  The above settings of locale and charset on
the CLI should only take over when mintty calls setlocale() with a
matching string.  The fact that it sets the matching value in the
environment, too, should only affect child processes, not mintty itself.

But it's incorrect to call initial_setlocale() from setup_locale()
without resetting it to its original value.

Unfortunately that doesn't solve any problem with the pseudo console
codepage.  Drat.  It sounds like you need the terminal's charset,
rather than the one set in the environment.

So this boils down to the fact that term_code_page must be set
after the application is already running and as soo as it creates
the pty, me thinks.  What if __eval_codepage_from_internal_charset()
is called at pty creation?  Or even on reading from /writing to
the pty the first time?  That should always be late enough to fetch
the correct codepage.

Patch attached.  Does that work as expected?

> > However, there's something which worries me.  Why do we need or set the
> > pseudo terminal codepage at all?  I see that you convert from MB charset
> > to MB charset and then use the result in WriteFile to the connecting
> > pipes.  Question is this: Why not just converting the strings via
> > sys_mbstowcs to a UTF-16 string and then send that over the line, using
> > WriteConsoleW for the final output to the console?  That would simplify
> > this stuff quite a bit, wouldn't it?  After all, for writing UTF-16 to
> > the console, we simply don't need to know or care for the console CP.
> 
> WriteConsoleW() cannot be used because the handle to_master_cyg is
> not a console handle.

Sigh, of course.  It's all just pipes.  I forgot that, sorry.

Btw., the main loop in fhandler_pty_master::pty_master_fwd_thread()
calls 

  char *buf = convert_mb_str (cygheap->locale.term_code_page,
                              &nlen, CP_UTF8, ptr, wlen);
                                     ^^^^^^^
  [...]
  WriteFile (to_master_cyg, ...

But then, after the code breaks from that loop, it calls

  char *buf = convert_mb_str (cygheap->locale.term_code_page, &nlen,
                              GetConsoleOutputCP (), ptr, wlen);
                              ^^^^^^^^^^^^^^^^^^^^^
  [...]
  process_opost_output (to_master_cyg, ...

process_opost_output then calls WriteFile on that to_master_cyg handle,
just like the WriteFile call above.

Is that really correct?  Shouldn't the second invocation use CP_UTF8 as
well?


Corinna

--H1spWtNR+x+ondvy
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment;
	filename="0001-Cygwin-try-calling-__eval_codepage_from_internal_cha.patch"

From 89acd62e88871a89b9bcb2964924f8960c7673ec Mon Sep 17 00:00:00 2001
From: Corinna Vinschen <corinna@vinschen.de>
Date: Fri, 4 Sep 2020 21:20:35 +0200
Subject: [PATCH] Cygwin: try calling __eval_codepage_from_internal_charset in
 pty code

the idea being, that we need the tty's locale and charset, not the
environment locale settings when starting the tty.
---
 winsup/cygwin/fhandler_tty.cc | 17 +++++++++++++++++
 winsup/cygwin/nlsfuncs.cc     | 12 +++++-------
 2 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index f207a0b27892..feb014175123 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -39,6 +39,8 @@ extern "C" {
   VOID WINAPI ClosePseudoConsole (HPCON);
 }
 
+extern UINT __eval_codepage_from_internal_charset ();
+
 #define close_maybe(h) \
   do { \
     if (h && h != INVALID_HANDLE_VALUE) \
@@ -633,6 +635,11 @@ fhandler_pty_slave::open (int flags, mode_t)
 
   fhandler_console::need_invisible ();
 
+#if 1 /* Let's try this first */
+  if (!cygheap->locale.term_code_page)
+    cygheap->locale.term_code_page = __eval_codepage_from_internal_charset ();
+#endif
+
   set_open_status ();
   return 1;
 
@@ -1607,6 +1614,11 @@ fhandler_pty_master::write (const void *ptr, size_t len)
   if (bg <= bg_eof)
     return (ssize_t) bg;
 
+#if 0 /* Let's try this if setting codepage at pty open time is not enough */
+  if (!cygheap->locale.term_code_page)
+    cygheap->locale.term_code_page = __eval_codepage_from_internal_charset ();
+#endif
+
   push_process_state process_state (PID_TTYOU);
 
   /* Write terminal input to to_slave pipe instead of output_handle
@@ -1969,6 +1981,11 @@ fhandler_pty_master::pty_master_fwd_thread ()
   DWORD rlen;
   char outbuf[65536];
 
+#if 0 /* Let's try this if setting codepage at pty open time is not enough */
+  if (!cygheap->locale.term_code_page)
+    cygheap->locale.term_code_page = __eval_codepage_from_internal_charset ();
+#endif
+
   termios_printf ("Started.");
   for (;;)
     {
diff --git a/winsup/cygwin/nlsfuncs.cc b/winsup/cygwin/nlsfuncs.cc
index 10a3a0705142..6bffc77c91eb 100644
--- a/winsup/cygwin/nlsfuncs.cc
+++ b/winsup/cygwin/nlsfuncs.cc
@@ -1452,9 +1452,10 @@ __set_charset_from_locale (const char *locale, char *charset)
    internal charset setting.  This is *not* necessarily the Windows
    codepage connected to a locale by default, so we have to set this
    up explicitely. */
-static UINT
-__eval_codepage_from_internal_charset (const char *charset)
+UINT
+__eval_codepage_from_internal_charset ()
 {
+  const char *charset = __locale_charset (__get_global_locale ());
   UINT codepage = CP_UTF8; /* Default UTF8 */
 
   /* The internal charset names are well defined, so we can use shortcuts. */
@@ -1582,11 +1583,8 @@ internal_setlocale ()
   if (cygheap->locale.mbtowc == __get_global_locale ()->mbtowc)
     return;
 
-  const char *charset = __locale_charset (__get_global_locale ());
-  debug_printf ("Global charset set to %s", charset);
-  /* Store codepage to be utilized by pseudo console code. */
-  cygheap->locale.term_code_page =
-			__eval_codepage_from_internal_charset (charset);
+  debug_printf ("Global charset set to %s",
+		__locale_charset (__get_global_locale ()));
   /* Fetch PATH and CWD and convert to wchar_t in previous charset. */
   path = getenv ("PATH");
   if (path && *path)	/* $PATH can be potentially unset. */
-- 
2.26.2


--H1spWtNR+x+ondvy--
