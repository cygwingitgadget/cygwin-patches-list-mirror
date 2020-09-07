Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com
 [210.131.2.90])
 by sourceware.org (Postfix) with ESMTPS id 010D4386EC25
 for <cygwin-patches@cygwin.com>; Mon,  7 Sep 2020 09:37:10 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 010D4386EC25
Received: from Express5800-S70 (v038192.dynamic.ppp.asahi-net.or.jp
 [124.155.38.192]) (authenticated)
 by conssluserg-05.nifty.com with ESMTP id 0879awTV016677
 for <cygwin-patches@cygwin.com>; Mon, 7 Sep 2020 18:36:58 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 0879awTV016677
X-Nifty-SrcIP: [124.155.38.192]
Date: Mon, 7 Sep 2020 18:36:59 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/3] fhandler_pty_slave::setup_locale: respect charset
 == "UTF-8"
Message-Id: <20200907183659.5150b2a8f296e4df13b1df1c@nifty.ne.jp>
In-Reply-To: <20200907082633.GC4127@calimero.vinschen.de>
References: <20200902195412.aa7f233231d893a7a065b691@nifty.ne.jp>
 <20200902152450.GJ4127@calimero.vinschen.de>
 <20200903012500.640e36573c67328fc3e1bc70@nifty.ne.jp>
 <20200902163836.GL4127@calimero.vinschen.de>
 <20200903175912.GP4127@calimero.vinschen.de>
 <20200904182149.18cd752eef58c67ee8d39135@nifty.ne.jp>
 <20200904124400.GQ4127@calimero.vinschen.de>
 <20200904235016.9c34d04e809b5ad9f2bdfdf3@nifty.ne.jp>
 <20200904192235.GW4127@calimero.vinschen.de>
 <20200905174301.adbb3c147122fbe0636a0d56@nifty.ne.jp>
 <20200907082633.GC4127@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
X-List-Received-Date: Mon, 07 Sep 2020 09:37:13 -0000

On Mon, 7 Sep 2020 10:26:33 +0200
Corinna Vinschen wrote:
> Hi Takashi,
> 
> On Sep  5 17:43, Takashi Yano via Cygwin-patches wrote:
> > On Fri, 4 Sep 2020 21:22:35 +0200
> > Corinna Vinschen wrote:
> > > So this boils down to the fact that term_code_page must be set
> > > after the application is already running and as soo as it creates
> > > the pty, me thinks.  What if __eval_codepage_from_internal_charset()
> > > is called at pty creation?  Or even on reading from /writing to
> > > the pty the first time?  That should always be late enough to fetch
> > > the correct codepage.
> > > 
> > > Patch attached.  Does that work as expected?
> > 
> > Thank you very much for the patch.
> > 
> > Your new additional patch works well except the test case such as:
> > 
> >   int pm = getpt();
> >   if (fork()) {
> >     [do the master operations]
> >   } else {
> >     int ps = open(ptsname(pm), O_RDWR|O_NOCTTY);
> >     close(pm);
> >     setsid();
> >     ioctl(ps, TIOCSCTTY, 1);
> >     dup2(ps, 0);
> >     dup2(ps, 1);
> >     dup2(ps, 2);
> >     close(ps);
> >     [exec non-cygwin process]
> >   }
> > 
> > If this test case is run in cygwin console (command prompt),
> > it causes garbled output due to term_code_page == 0.
> 
> term_code_page is set on fhandler_pty_slave::open, which is what
> you call above.  How can term_code_page be 0 after that?  Are you
> talking about the forking parent process being master?  If so, either
> switching `#if 1/#if 0' blocks in the patch might fix this (by setting
> term_code_page on first read/write), or alternatively adding an
> __eval_codepage_from_internal_charset() call to the master creation
> as well.  Did you try enabling the #if 0'd blocks?

IIUC, it is not shared with its parent process (master) if the pty
slave is opned in the child slave process.

When #if 0 block in master::write is enabled the problem is avoidable
only if master calls write. If the slave process is a output-only
process, master::write is never called.

> Either way, the call to __eval_codepage_from_internal_charset() should
> take place as soon as the first pty gets created or on first pty
> read/write.

Hmm, this sounds reasonable...

> __eval_codepage_from_internal_charset() could also simply be called
> on *every* invocation of pty read/write, given how low profile it is.

If the slave process execed is non-cygwin process in above test case,
slave::read and slave::write are not called, so this also cannot solve
the problem.

> Apart from that, I don't see anything wrong with the above scenario.
> If the application creating the pty does *not* switch locale, we're
> in "C" locale territory, and we should default to UTF-8.  That's
> what a call to __eval_codepage_from_internal_charset() would do,
> because it defaults to UTF-8 and never returns the ASCII codepage.

The above test case is simplifed version of the code of cygterm.
It is a part of teraterm https://ttssh2.osdn.jp/index.html.en.
Cygterm does not call setlocale() even with LANG=ja_JP.CP932.
So I think environment should be checked if setlocale() is not
called. In cygterm, environment LANG is set only in slave side.
Therefore, term_code_page should be determine in slave side.

> > > Btw., the main loop in fhandler_pty_master::pty_master_fwd_thread()
> > > calls 
> > > 
> > >   char *buf = convert_mb_str (cygheap->locale.term_code_page,
> > >                               &nlen, CP_UTF8, ptr, wlen);
> > >                                      ^^^^^^^
> > >   [...]
> > >   WriteFile (to_master_cyg, ...
> > > 
> > > But then, after the code breaks from that loop, it calls
> > > 
> > >   char *buf = convert_mb_str (cygheap->locale.term_code_page, &nlen,
> > >                               GetConsoleOutputCP (), ptr, wlen);
> > >                               ^^^^^^^^^^^^^^^^^^^^^
> > >   [...]
> > >   process_opost_output (to_master_cyg, ...
> > > 
> > > process_opost_output then calls WriteFile on that to_master_cyg handle,
> > > just like the WriteFile call above.
> > > 
> > > Is that really correct?  Shouldn't the second invocation use CP_UTF8 as
> > > well?
> > 
> > That is correct. The first conversion is for the case that pseudo
> > console is enabled, and the second one is for the case that pseudo
> > console is disabled.
> > 
> > Pseudo console converts charset from console code page to UTF-8.
> > Therefore, data read from from_slave is always UTF-8 when pseudo
> > console is enabled. Moreover, OPOST processing is done in pseudo
> > console, so write data simply by WriteFile() is enough.
> > 
> > If pseudo console is disabled, cmd.exe and so on uses console
> > code page, so the code page of data read from from_slave is
> > GetConsoleOutputCP(). In this case, OPOST processing is necessary.
> 
> This is really confusing me.  We never set the console codepage in the
> old pty code before, it was just pipes transmitting bytes.  Why do we
> suddenly have to handle native apps running in a console in this case?!?

This is actually not related to pseudo console. In Japanese environment,
cmd.exe output CP932 string by default. This caused gabled output in old
cygwin such as 3.0.7. The code for the case that pseudo console is
disabled is to fix this.

> > diff --git a/winsup/cygwin/cygheap.h b/winsup/cygwin/cygheap.h
> > index 2b84f4252..8877cc358 100644
> > --- a/winsup/cygwin/cygheap.h
> > +++ b/winsup/cygwin/cygheap.h
> > @@ -341,7 +341,6 @@ struct cygheap_debug
> >  struct cygheap_locale
> >  {
> >    mbtowc_p mbtowc;
> > -  UINT term_code_page;
> 
> No, wait.  Just reverting this change without checking the alternatives
> doesn't make sense.
> 
> Why would we want to store the codepage in every single tty, given
> term_code_page is set to the same value in every one of them?  AFAICS
> it's sufficient to have a single term_code_page shared with the child
> processes via cygheap.  The idea is to get rid of the complex
> setup_locale code in every execve call and just set it once in a process
> tree starting at the process creating the ptys.

You are right if term_code_page can be determined in master process.
However, as for the above test case, I cannot imagine the solution.
What cygterm essentially does is as follows. It does not call setlocale()
and not set LANG in master process.

  int pm = getpt();
  if (fork()) {
    [do the master operations]
  } else {
    setsid();
    ps = open(ptsname(pm), O_RDWR);
    close(pm);
    dup2(ps, 0);
    dup2(ps, 1);
    dup2(ps, 2);
    close(ps);
    setenv("LANG", "ja_JP.SJIS", 1);
    [exec shell]
  }

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
