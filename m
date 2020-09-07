Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com
 [210.131.2.83])
 by sourceware.org (Postfix) with ESMTPS id 8361A38708DB
 for <cygwin-patches@cygwin.com>; Mon,  7 Sep 2020 13:41:25 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 8361A38708DB
Received: from Express5800-S70 (v038192.dynamic.ppp.asahi-net.or.jp
 [124.155.38.192]) (authenticated)
 by conssluserg-04.nifty.com with ESMTP id 087DerKh019362
 for <cygwin-patches@cygwin.com>; Mon, 7 Sep 2020 22:40:53 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 087DerKh019362
X-Nifty-SrcIP: [124.155.38.192]
Date: Mon, 7 Sep 2020 22:40:56 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/3] fhandler_pty_slave::setup_locale: respect charset
 == "UTF-8"
Message-Id: <20200907224056.bdd8818cd7013248b41871a4@nifty.ne.jp>
In-Reply-To: <20200907192713.54ca04cdc8264c6a03ce6f59@nifty.ne.jp>
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
 <20200907192713.54ca04cdc8264c6a03ce6f59@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Mon, 07 Sep 2020 13:41:28 -0000

Here is a summary of my points:

[Senario 1]
1) Start mintty (UTF-8).
2) Start another mintty by 
     mintty -o charset=SJIS
   from the first mintty.

[Senario 2]
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


Q1) cygheap or tty shared memory?

Consider senario 1. If the term_code_page is in cygheap,
it is inherited to child process. Therefore, the second
mintty cannot update term_code_page while locale is changed.

Consider senario 2. Since only the child process knows the
locale, master (parent process) cannot get term_code_page
if it is in cygheap.

Q2) Is checking environment necessary?

As for senario 2, setlocale() is not called. So it is
necessary to check environment to know locale.

Q3) Where and when should term_code_page be set?

In senario 2, LANG is set just before exec() in the CHILD
process. Therefore, term_code_page should be determined
in the child_info_spawn:worker or in the execed process.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
