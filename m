Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com
 [210.131.2.81])
 by sourceware.org (Postfix) with ESMTPS id 28B8F3857C5B
 for <cygwin-patches@cygwin.com>; Sat,  5 Sep 2020 08:43:11 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 28B8F3857C5B
Received: from Express5800-S70 (v038192.dynamic.ppp.asahi-net.or.jp
 [124.155.38.192]) (authenticated)
 by conssluserg-02.nifty.com with ESMTP id 0858gxje012184
 for <cygwin-patches@cygwin.com>; Sat, 5 Sep 2020 17:42:59 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 0858gxje012184
X-Nifty-SrcIP: [124.155.38.192]
Date: Sat, 5 Sep 2020 17:43:01 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/3] fhandler_pty_slave::setup_locale: respect charset
 == "UTF-8"
Message-Id: <20200905174301.adbb3c147122fbe0636a0d56@nifty.ne.jp>
In-Reply-To: <20200904192235.GW4127@calimero.vinschen.de>
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
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Sat__5_Sep_2020_17_43_01_+0900_Ll19BBP6T8DhVvXO"
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, NICE_REPLY_A,
 RCVD_IN_BARRACUDACENTRAL, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE,
 SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Sat, 05 Sep 2020 08:43:16 -0000

This is a multi-part message in MIME format.

--Multipart=_Sat__5_Sep_2020_17_43_01_+0900_Ll19BBP6T8DhVvXO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Corinna,

On Fri, 4 Sep 2020 21:22:35 +0200
Corinna Vinschen wrote:
> Hi Takashi,
> 
> On Sep  4 23:50, Takashi Yano via Cygwin-patches wrote:
> > Hi Corinna,
> > 
> > On Fri, 4 Sep 2020 14:44:00 +0200
> > Corinna Vinschen wrote:
> > > On Sep  4 18:21, Takashi Yano via Cygwin-patches wrote:
> > > > I think I have found the answer to your request.
> > > > Patch attached. What do you think of this patch?
> > > > 
> > > > Calling initial_setlocale() is necessary because
> > > > nl_langinfo() always returns "ANSI_X3.4-1968"
> > > > regardless locale setting if this is not called.
> > > [...]
> > > However, the initial_setlocale() call in dll_crt0_1 calls
> > > internal_setlocale(), and *that* function sets the conversion functions
> > > for the internal conversions.  What it *doesn't* do yet at the moment is
> > > to store the charset name itself or, better, the equivalent codepage.
> > > 
> > > If we change that, setup_locale can simply go away.  Below is a patch
> > > doing just that.  Can you please check if that works in your test
> > > scenarios?
> > 
> > I tried your patch, but unfortunately it does not work.
> > cygheap->locale.term_code_page is 0 in pty master.
> > 
> > If the following lines are moved in internal_setlocale(),
> > 
> >   const char *charset = __locale_charset (__get_global_locale ());
> >   debug_printf ("Global charset set to %s", charset);
> >   /* Store codepage to be utilized by pseudo console code. */
> >   cygheap->locale.term_code_page =
> >             __eval_codepage_from_internal_charset (charset);
> > 
> > in internal_setlocale() before
> > 
> >   /* Don't do anything if the charset hasn't actually changed. */
> >   if (cygheap->locale.mbtowc == __get_global_locale ()->mbtowc)
> >     return;
> 
> Uh, that makes sense.
> 
> > cygheap->locale.term_code_page is always 65001 even if mintty is
> > startted by
> > mintty -o locale=ja_JP -o charset=CP932
> > or
> > mintty -o locale=ja_JP -o charset=EUCJP
> > 
> > Perhaps, this is because LANG is not set properly yet when mintty
> > is started.
> 
> Yeah, that's the reason.  The above settings of locale and charset on
> the CLI should only take over when mintty calls setlocale() with a
> matching string.  The fact that it sets the matching value in the
> environment, too, should only affect child processes, not mintty itself.
> 
> But it's incorrect to call initial_setlocale() from setup_locale()
> without resetting it to its original value.
> 
> Unfortunately that doesn't solve any problem with the pseudo console
> codepage.  Drat.  It sounds like you need the terminal's charset,
> rather than the one set in the environment.
> 
> So this boils down to the fact that term_code_page must be set
> after the application is already running and as soo as it creates
> the pty, me thinks.  What if __eval_codepage_from_internal_charset()
> is called at pty creation?  Or even on reading from /writing to
> the pty the first time?  That should always be late enough to fetch
> the correct codepage.
> 
> Patch attached.  Does that work as expected?

Thank you very much for the patch.

Your new additional patch works well except the test case such as:

  int pm = getpt();
  if (fork()) {
    [do the master operations]
  } else {
    int ps = open(ptsname(pm), O_RDWR|O_NOCTTY);
    close(pm);
    setsid();
    ioctl(ps, TIOCSCTTY, 1);
    dup2(ps, 0);
    dup2(ps, 1);
    dup2(ps, 2);
    close(ps);
    [exec non-cygwin process]
  }

If this test case is run in cygwin console (command prompt),
it causes garbled output due to term_code_page == 0.

The second additional patch attached fixes the isseu.

> Btw., the main loop in fhandler_pty_master::pty_master_fwd_thread()
> calls 
> 
>   char *buf = convert_mb_str (cygheap->locale.term_code_page,
>                               &nlen, CP_UTF8, ptr, wlen);
>                                      ^^^^^^^
>   [...]
>   WriteFile (to_master_cyg, ...
> 
> But then, after the code breaks from that loop, it calls
> 
>   char *buf = convert_mb_str (cygheap->locale.term_code_page, &nlen,
>                               GetConsoleOutputCP (), ptr, wlen);
>                               ^^^^^^^^^^^^^^^^^^^^^
>   [...]
>   process_opost_output (to_master_cyg, ...
> 
> process_opost_output then calls WriteFile on that to_master_cyg handle,
> just like the WriteFile call above.
> 
> Is that really correct?  Shouldn't the second invocation use CP_UTF8 as
> well?

That is correct. The first conversion is for the case that pseudo
console is enabled, and the second one is for the case that pseudo
console is disabled.

Pseudo console converts charset from console code page to UTF-8.
Therefore, data read from from_slave is always UTF-8 when pseudo
console is enabled. Moreover, OPOST processing is done in pseudo
console, so write data simply by WriteFile() is enough.

If pseudo console is disabled, cmd.exe and so on uses console
code page, so the code page of data read from from_slave is
GetConsoleOutputCP(). In this case, OPOST processing is necessary.

If the second conversion and process_opost_output() are in the
"else {}" block for "if (get_ttyp ()->h_pseudo_console) {}",
the intent whould be clearer.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>

--Multipart=_Sat__5_Sep_2020_17_43_01_+0900_Ll19BBP6T8DhVvXO
Content-Type: text/plain;
 name="set-term-code-page-in-_ti.diff"
Content-Disposition: attachment;
 filename="set-term-code-page-in-_ti.diff"
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
diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index feb014175..8dc9d3df9 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -636,8 +636,8 @@ fhandler_pty_slave::open (int flags, mode_t)
   fhandler_console::need_invisible ();
 
 #if 1 /* Let's try this first */
-  if (!cygheap->locale.term_code_page)
-    cygheap->locale.term_code_page = __eval_codepage_from_internal_charset ();
+  if (!get_ttyp ()->term_code_page)
+    get_ttyp ()->term_code_page = __eval_codepage_from_internal_charset ();
 #endif
 
   set_open_status ();
@@ -1615,8 +1615,8 @@ fhandler_pty_master::write (const void *ptr, size_t len)
     return (ssize_t) bg;
 
 #if 0 /* Let's try this if setting codepage at pty open time is not enough */
-  if (!cygheap->locale.term_code_page)
-    cygheap->locale.term_code_page = __eval_codepage_from_internal_charset ();
+  if (!get_ttyp ()->term_code_page)
+    get_ttyp ()->term_code_page = __eval_codepage_from_internal_charset ();
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
@@ -1982,8 +1982,8 @@ fhandler_pty_master::pty_master_fwd_thread ()
   char outbuf[65536];
 
 #if 0 /* Let's try this if setting codepage at pty open time is not enough */
-  if (!cygheap->locale.term_code_page)
-    cygheap->locale.term_code_page = __eval_codepage_from_internal_charset ();
+  if (!get_ttyp ()->term_code_page)
+    get_tty ()->term_code_page = __eval_codepage_from_internal_charset ();
 #endif
 
   termios_printf ("Started.");
@@ -2041,7 +2041,7 @@ fhandler_pty_master::pty_master_fwd_thread ()
 	      state = 0;
 
 	  size_t nlen;
-	  char *buf = convert_mb_str (cygheap->locale.term_code_page,
+	  char *buf = convert_mb_str (get_ttyp ()->term_code_page,
 				      &nlen, CP_UTF8, ptr, wlen);
 
 	  ptr = buf;
@@ -2064,7 +2064,7 @@ fhandler_pty_master::pty_master_fwd_thread ()
 	  continue;
 	}
       size_t nlen;
-      char *buf = convert_mb_str (cygheap->locale.term_code_page, &nlen,
+      char *buf = convert_mb_str (get_ttyp ()->term_code_page, &nlen,
 				  GetConsoleOutputCP (), ptr, wlen);
 
       ptr = buf;

--Multipart=_Sat__5_Sep_2020_17_43_01_+0900_Ll19BBP6T8DhVvXO--
