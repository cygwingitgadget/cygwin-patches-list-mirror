Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com
 [210.131.2.90])
 by sourceware.org (Postfix) with ESMTPS id E65393857806
 for <cygwin-patches@cygwin.com>; Thu, 10 Sep 2020 13:08:38 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org E65393857806
Received: from Express5800-S70 (v038192.dynamic.ppp.asahi-net.or.jp
 [124.155.38.192]) (authenticated)
 by conssluserg-05.nifty.com with ESMTP id 08AD872f029315
 for <cygwin-patches@cygwin.com>; Thu, 10 Sep 2020 22:08:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 08AD872f029315
X-Nifty-SrcIP: [124.155.38.192]
Date: Thu, 10 Sep 2020 22:08:10 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/3] fhandler_pty_slave::setup_locale: respect charset
 == "UTF-8"
Message-Id: <20200910220810.3f3910eb065dd3be0186b885@nifty.ne.jp>
In-Reply-To: <20200908184536.3670324a2026ef0394de3821@nifty.ne.jp>
References: <20200904124400.GQ4127@calimero.vinschen.de>
 <20200904235016.9c34d04e809b5ad9f2bdfdf3@nifty.ne.jp>
 <20200904192235.GW4127@calimero.vinschen.de>
 <20200905174301.adbb3c147122fbe0636a0d56@nifty.ne.jp>
 <20200905201506.8bbca09f51a2b2b06135affa@nifty.ne.jp>
 <20200905231516.c799225e61b2b96bf05f65a6@nifty.ne.jp>
 <20200906175703.5875d4dd6140d9f6812cf2a9@nifty.ne.jp>
 <20200906191530.32230a99bf23d3c6f21beb41@nifty.ne.jp>
 <20200907010413.53ef9a9b727e8f971ca6b2ea@nifty.ne.jp>
 <20200907134558.3e1cd8bd4070991b856f58bb@nifty.ne.jp>
 <20200908084034.GO4127@calimero.vinschen.de>
 <20200908184536.3670324a2026ef0394de3821@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, NICE_REPLY_A,
 RCVD_IN_BARRACUDACENTRAL, RCVD_IN_DNSWL_NONE, SPF_HELO_NONE, SPF_PASS,
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
X-List-Received-Date: Thu, 10 Sep 2020 13:08:41 -0000

On Tue, 8 Sep 2020 18:45:36 +0900
Takashi Yano via Cygwin-patches <cygwin-patches@cygwin.com> wrote:

> Hi Corinna,
> 
> On Tue, 8 Sep 2020 10:40:34 +0200
> Corinna Vinschen wrote:
> > On Sep  7 13:45, Takashi Yano via Cygwin-patches wrote:
> > > On Mon, 7 Sep 2020 01:04:13 +0900
> > > > > Chages:
> > > > > - If global locale is set, it takes precedence.
> > > > 
> > > > Changes:
> > > > - Use __get_current_locale() instead of __get_global_locale().
> > > > - Fix a bug for ISO-8859-* charset.
> > > 
> > > Changes:
> > > - Use envblock if it is passed to CreateProcess in spawn.cc.
> > 
> > For the time being and to make at least *some* progress and with my
> > upcoming "away from keyboard"-time , I pushed the gist of my patch,
> > replacing the locale evaluating code in fhandler_tty with the function
> > __eval_codepage_from_internal_charset in its most simple form.
> > I didn't touch anything else, given that this discussion is still
> > ongoing.
> 
> Your patch pushed does the magic!
> 
> Even cygterm works even though the code does not check environment.
> 
> The point is here.
> 
> @@ -1977,9 +1807,6 @@ fhandler_pty_slave::fixup_after_exec ()
>    if (!close_on_exec ())
>      fixup_after_fork (NULL);   /* No parent handle required. */
> 
> -  /* Set locale */
> -  setup_locale ();
> -
>    /* Hook Console API */
>  #define DO_HOOK(module, name) \
>    if (!name##_Orig) \
> 
> Without this deletion, term_code_page is determined when
> cygwin shell is executed. Since it is in fixup_after_exec(),
> setlocale() does not called yet in the shell. As a result,
> term_code_page cannot be determined correctly.
> 
> In your new patch, term_code_page is determined when the first
> non-cygwin program is execed in the shell. The shell process
> already calls setlocale(), so term_code_page can be determined
> using global locale.
> 
> Thanks for the excellent idea!
> 
> Only the problem I noticed is that cygterm does not work if the
> shell does not call setlocale(). This happens if the shell is
> non-cygwin program, for example, cmd.exe, however, it is unusual
> case.

I noticed this also happens when shell is /bin/ash (/bin/dash).
However, it's still acceptable for me.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
