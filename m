Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com
 [210.131.2.81])
 by sourceware.org (Postfix) with ESMTPS id 75FF83851C2A
 for <cygwin-patches@cygwin.com>; Mon,  7 Sep 2020 08:38:52 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 75FF83851C2A
Received: from Express5800-S70 (v038192.dynamic.ppp.asahi-net.or.jp
 [124.155.38.192]) (authenticated)
 by conssluserg-02.nifty.com with ESMTP id 0878cOoi020345
 for <cygwin-patches@cygwin.com>; Mon, 7 Sep 2020 17:38:24 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 0878cOoi020345
X-Nifty-SrcIP: [124.155.38.192]
Date: Mon, 7 Sep 2020 17:38:24 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/3] fhandler_pty_slave::setup_locale: respect charset
 == "UTF-8"
Message-Id: <20200907173824.3c382c6a5924b25d5563e5bf@nifty.ne.jp>
In-Reply-To: <20200907082738.GD4127@calimero.vinschen.de>
References: <20200902152450.GJ4127@calimero.vinschen.de>
 <20200903012500.640e36573c67328fc3e1bc70@nifty.ne.jp>
 <20200902163836.GL4127@calimero.vinschen.de>
 <20200903175912.GP4127@calimero.vinschen.de>
 <20200904182149.18cd752eef58c67ee8d39135@nifty.ne.jp>
 <20200904124400.GQ4127@calimero.vinschen.de>
 <20200904235016.9c34d04e809b5ad9f2bdfdf3@nifty.ne.jp>
 <20200904192235.GW4127@calimero.vinschen.de>
 <20200905174301.adbb3c147122fbe0636a0d56@nifty.ne.jp>
 <20200905201506.8bbca09f51a2b2b06135affa@nifty.ne.jp>
 <20200907082738.GD4127@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Mon, 07 Sep 2020 08:39:03 -0000

On Mon, 7 Sep 2020 10:27:38 +0200
Corinna Vinschen wrote:
> On Sep  5 20:15, Takashi Yano via Cygwin-patches wrote:
> > On Sat, 5 Sep 2020 17:43:01 +0900
> > Takashi Yano via Cygwin-patches <cygwin-patches@cygwin.com> wrote:
> > No. This does not fix enough.
> > 
> > In the test case above, if it does not call setlocale(),
> > __eval_codepage_from_internal_charset() always returns "ASCII"
> 
> ??? __eval_codepage_from_internal_charset() never returns ASCII.
> It returns UTF-8 by default.

Sorry, I meant __locale_charset (__get_global_locale ()) returns
"ASCII".

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
