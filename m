Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com
 [210.131.2.91])
 by sourceware.org (Postfix) with ESMTPS id 838DA3857C42
 for <cygwin-patches@cygwin.com>; Sun,  6 Sep 2020 10:29:00 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 838DA3857C42
Received: from Express5800-S70 (v038192.dynamic.ppp.asahi-net.or.jp
 [124.155.38.192]) (authenticated)
 by conssluserg-06.nifty.com with ESMTP id 086ASkhV025324
 for <cygwin-patches@cygwin.com>; Sun, 6 Sep 2020 19:28:47 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 086ASkhV025324
X-Nifty-SrcIP: [124.155.38.192]
Date: Sun, 6 Sep 2020 19:28:48 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/3] fhandler_pty_slave::setup_locale: respect charset
 == "UTF-8"
Message-Id: <20200906192848.0394f5d208edda68a9fec991@nifty.ne.jp>
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
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, NICE_REPLY_A,
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
X-List-Received-Date: Sun, 06 Sep 2020 10:29:01 -0000

Hi Corinna,

On Fri, 4 Sep 2020 14:44:00 +0200
Corinna Vinschen <corinna-cygwin@cygwin.com> wrote:
> +    case 'I': /* ISO-8859-x */
> +      codepage = strtoul (charset + 9, NULL, 10);
> +      break;

This should be:
codepage = strtoul (charset + 9, NULL, 10) + 28590;
shouldn't it?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
