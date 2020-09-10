Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com
 [210.131.2.80])
 by sourceware.org (Postfix) with ESMTPS id D63DB3861038
 for <cygwin-patches@cygwin.com>; Thu, 10 Sep 2020 14:16:29 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org D63DB3861038
Received: from Express5800-S70 (v038192.dynamic.ppp.asahi-net.or.jp
 [124.155.38.192]) (authenticated)
 by conssluserg-01.nifty.com with ESMTP id 08AEG7bE018915
 for <cygwin-patches@cygwin.com>; Thu, 10 Sep 2020 23:16:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 08AEG7bE018915
X-Nifty-SrcIP: [124.155.38.192]
Date: Thu, 10 Sep 2020 23:16:10 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/3] fhandler_pty_slave::setup_locale: respect charset
 == "UTF-8"
Message-Id: <20200910231610.18a2871e38406e5c96cd2fc3@nifty.ne.jp>
In-Reply-To: <20200910140407.GB4127@calimero.vinschen.de>
References: <nycvar.QRO.7.76.6.2009011818560.56@tvgsbejvaqbjf.bet>
 <20200904190337.cde290e4b690793ef6a0f496@nifty.ne.jp>
 <nycvar.QRO.7.76.6.2009040822000.56@tvgsbejvaqbjf.bet>
 <20200905000302.9c777e3d2df4f49f3a641e42@nifty.ne.jp>
 <nycvar.QRO.7.76.6.2009072309070.56@tvgsbejvaqbjf.bet>
 <20200908171648.e65665caebb643ce99910fa3@nifty.ne.jp>
 <20200909072123.GX4127@calimero.vinschen.de>
 <20200910091500.388ab2f6796a4abce57a3cd2@nifty.ne.jp>
 <20200910140407.GB4127@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, NICE_REPLY_A,
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
X-List-Received-Date: Thu, 10 Sep 2020 14:16:33 -0000

On Thu, 10 Sep 2020 16:04:07 +0200
Corinna Vinschen wrote:

> Hi Takashi,
> 
> On Sep 10 09:15, Takashi Yano via Cygwin-patches wrote:
> > On Wed, 9 Sep 2020 09:21:23 +0200
> > Corinna Vinschen wrote:
> > > Takashi, does the patch from
> > > https://cygwin.com/pipermail/cygwin-developers/2020-August/011951.html
> > > still apply to the latest from master?  Question is, shouldn't the
> > > Windows calls setting the codepage be only called if started from
> > > child_info_spawn::worker for non-Cygwin executables?
> > 
> > I'd propose the patch:
> > 
> > diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
> > index 37d033bbe..95b28c3da 100644
> > --- a/winsup/cygwin/fhandler_tty.cc
> > +++ b/winsup/cygwin/fhandler_tty.cc
> > @@ -1830,7 +1830,11 @@ fhandler_pty_slave::setup_locale (void)
> >    extern UINT __eval_codepage_from_internal_charset ();
> > 
> >    if (!get_ttyp ()->term_code_page)
> > -    get_ttyp ()->term_code_page = __eval_codepage_from_internal_charset ();
> > +    {
> > +      get_ttyp ()->term_code_page = __eval_codepage_from_internal_charset ();
> > +      SetConsoleCP (get_ttyp ()->term_code_page);
> > +      SetConsoleOutputCP (get_ttyp ()->term_code_page);
> > +    }
> >  }
> > 
> >  void
> > 
> > However, Johannes insists setting codepage for non-cygwin apps
> > even when pseudo console is enabled, which I cannot agree.
> > 
> > Actually, I hesitate even the patch above, however, it seems to
> > be necessary for msys apps in terms of backward compatibility.
> 
> If we do as above, doesn't that mean the invocation of convert_mb_str in
> fhandler_pty_master::accept_input, as well as the second invocation of
> convert_mb_str in fhandler_pty_master::pty_master_fwd_thread are
> redundant?  Both are only called if get_ttyp ()->term_code_page differs
> from the input or output console codepage.  Given the above setting of
> the console CP to term_code_page, this would never be the case, right?

You are right by default. However, if user change the code page using
chcp.com, conversion does work.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
