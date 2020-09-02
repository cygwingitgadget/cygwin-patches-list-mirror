Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com
 [210.131.2.90])
 by sourceware.org (Postfix) with ESMTPS id B9FB63857C48
 for <cygwin-patches@cygwin.com>; Wed,  2 Sep 2020 10:54:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org B9FB63857C48
Received: from Express5800-S70 (v038192.dynamic.ppp.asahi-net.or.jp
 [124.155.38.192]) (authenticated)
 by conssluserg-05.nifty.com with ESMTP id 082As5Xu019466
 for <cygwin-patches@cygwin.com>; Wed, 2 Sep 2020 19:54:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 082As5Xu019466
X-Nifty-SrcIP: [124.155.38.192]
Date: Wed, 2 Sep 2020 19:54:12 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/3] fhandler_pty_slave::setup_locale: respect charset
 == "UTF-8"
Message-Id: <20200902195412.aa7f233231d893a7a065b691@nifty.ne.jp>
In-Reply-To: <20200902083818.GI4127@calimero.vinschen.de>
References: <nycvar.QRO.7.76.6.2009011818560.56@tvgsbejvaqbjf.bet>
 <20200902083014.GH4127@calimero.vinschen.de>
 <20200902083818.GI4127@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, NICE_REPLY_A,
 RCVD_IN_BARRACUDACENTRAL, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H4,
 RCVD_IN_MSPIKE_WL, SPF_HELO_NONE, SPF_PASS,
 TXREP autolearn=no autolearn_force=no version=3.4.2
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
X-List-Received-Date: Wed, 02 Sep 2020 10:54:23 -0000

Hi Corinna,

On Wed, 2 Sep 2020 10:38:18 +0200
Corinna Vinschen wrote:
> On Sep  2 10:30, Corinna Vinschen wrote:
> > Ok guys, I'm not opposed to this change in terms of its result,
> > but I'm starting to wonder why all this locale code in fhandler_tty
> > is necessary at all.
> > 
> > I see that get_langinfo() calls __loadlocale and performs a lot of stuff
> > on the charsets which looks like duplicates of the initial_setlocale()
> > call performed at DLL startup.
> > 
> > If there's anything missing in the initial_setlocale() call which would
> > be required by the pseudo tty code?  What exactly is it?  The codepage?
> > And why can't we just add the info to cygheap->locale at initial_setlocale()
> > time so it's available at exec time without going through all this hassle
> > every time?
> > 
> > Apart from that, all this locale/charset/lcid stuff should be concentrated
> > in nlsfunc.cc ideally.
> 
> get_locale_from_env() and get_langinfo() should go away.  If we just
> need a codepage for get_ttyp ()->term_code_page, we should really find a
> way to do this from within internal_setlocale().

I looked into internal_setlocale() code, but I could not found
the code which handles thecode page. I found the code handling
the code page in __set_charset_from_locale() function in nlsfuncs.cc,
but it does not return code page itself. Could you please explain
more detail of your idea?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
