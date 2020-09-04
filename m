Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com
 [210.131.2.81])
 by sourceware.org (Postfix) with ESMTPS id 409AA385141D
 for <cygwin-patches@cygwin.com>; Fri,  4 Sep 2020 14:50:23 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 409AA385141D
Received: from Express5800-S70 (v038192.dynamic.ppp.asahi-net.or.jp
 [124.155.38.192]) (authenticated)
 by conssluserg-02.nifty.com with ESMTP id 084Eo9Sp025523
 for <cygwin-patches@cygwin.com>; Fri, 4 Sep 2020 23:50:09 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 084Eo9Sp025523
X-Nifty-SrcIP: [124.155.38.192]
Date: Fri, 4 Sep 2020 23:50:16 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/3] fhandler_pty_slave::setup_locale: respect charset
 == "UTF-8"
Message-Id: <20200904235016.9c34d04e809b5ad9f2bdfdf3@nifty.ne.jp>
In-Reply-To: <20200904124400.GQ4127@calimero.vinschen.de>
References: <nycvar.QRO.7.76.6.2009011818560.56@tvgsbejvaqbjf.bet>
 <20200902083014.GH4127@calimero.vinschen.de>
 <20200902083818.GI4127@calimero.vinschen.de>
 <20200902195412.aa7f233231d893a7a065b691@nifty.ne.jp>
 <20200902152450.GJ4127@calimero.vinschen.de>
 <20200903012500.640e36573c67328fc3e1bc70@nifty.ne.jp>
 <20200902163836.GL4127@calimero.vinschen.de>
 <20200903175912.GP4127@calimero.vinschen.de>
 <20200904182149.18cd752eef58c67ee8d39135@nifty.ne.jp>
 <20200904124400.GQ4127@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, NICE_REPLY_A,
 RCVD_IN_BARRACUDACENTRAL, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE,
 SPF_PASS, TXREP autolearn=no autolearn_force=no version=3.4.2
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
X-List-Received-Date: Fri, 04 Sep 2020 14:50:26 -0000

Hi Corinna,

On Fri, 4 Sep 2020 14:44:00 +0200
Corinna Vinschen wrote:
> Hi Takashi,
> 
> On Sep  4 18:21, Takashi Yano via Cygwin-patches wrote:
> > Hi Corinna,
> > 
> > On Thu, 3 Sep 2020 19:59:12 +0200
> > Corinna Vinschen wrote:
> > > The only idea I had so far was, changing the way __set_charset_from_locale
> > > works from within _setlocale_r:
> > > 
> > > We could add a Cygwin-specific function only fetching the codepage and
> > > call it unconditionally from _setlocale_r.  __set_charset_from_locale is
> > > called with a new parameter "codepage", so it doesn't have to fetch the
> > > CP by itself, but it's still only called from _setlocale_r if necessary.
> > > 
> > > Would that be sufficient?  The CP conversion from 20127/ASCII to 65001/UTF8
> > > could be done at the point the codepage is actually required.
> > 
> > I think I have found the answer to your request.
> > Patch attached. What do you think of this patch?
> > 
> > Calling initial_setlocale() is necessary because
> > nl_langinfo() always returns "ANSI_X3.4-1968"
> > regardless locale setting if this is not called.
> 
> Well, this is correct.  Per POSIX, a standard-conformant application is
> running in the "C" locale unless it calls setlocale() explicitely.
> That's one reason Cygwin defaults to UTF-8 internally.  Everything,
> including the terminal, is supposed to default to UTF-8.  That's the
> most sane default, even if an application is not locale-aware.
> 
> So, to follow POSIX, initial_setlocale() is used to set up the
> environment and command line stuff and then, before calling the
> application's main, Cygwin calls _setlocale_r (_REENT, LC_CTYPE, "C");
> to reset the apps default locale to "C".  That's why nl_langinfo()
> returns "ANSI_X3.4-1968".
> 
> However, the initial_setlocale() call in dll_crt0_1 calls
> internal_setlocale(), and *that* function sets the conversion functions
> for the internal conversions.  What it *doesn't* do yet at the moment is
> to store the charset name itself or, better, the equivalent codepage.
> 
> If we change that, setup_locale can simply go away.  Below is a patch
> doing just that.  Can you please check if that works in your test
> scenarios?

I tried your patch, but unfortunately it does not work.
cygheap->locale.term_code_page is 0 in pty master.

If the following lines are moved in internal_setlocale(),

  const char *charset = __locale_charset (__get_global_locale ());
  debug_printf ("Global charset set to %s", charset);
  /* Store codepage to be utilized by pseudo console code. */
  cygheap->locale.term_code_page =
            __eval_codepage_from_internal_charset (charset);

in internal_setlocale() before

  /* Don't do anything if the charset hasn't actually changed. */
  if (cygheap->locale.mbtowc == __get_global_locale ()->mbtowc)
    return;

cygheap->locale.term_code_page is always 65001 even if mintty is
startted by
mintty -o locale=ja_JP -o charset=CP932
or
mintty -o locale=ja_JP -o charset=EUCJP

Perhaps, this is because LANG is not set properly yet when mintty
is started.

> However, there's something which worries me.  Why do we need or set the
> pseudo terminal codepage at all?  I see that you convert from MB charset
> to MB charset and then use the result in WriteFile to the connecting
> pipes.  Question is this: Why not just converting the strings via
> sys_mbstowcs to a UTF-16 string and then send that over the line, using
> WriteConsoleW for the final output to the console?  That would simplify
> this stuff quite a bit, wouldn't it?  After all, for writing UTF-16 to
> the console, we simply don't need to know or care for the console CP.

WriteConsoleW() cannot be used because the handle to_master_cyg is
not a console handle.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
