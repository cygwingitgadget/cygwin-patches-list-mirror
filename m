Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com
 [210.131.2.80])
 by sourceware.org (Postfix) with ESMTPS id DEB70393C87F
 for <cygwin-patches@cygwin.com>; Wed,  2 Sep 2020 14:52:18 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org DEB70393C87F
Received: from Express5800-S70 (v038192.dynamic.ppp.asahi-net.or.jp
 [124.155.38.192]) (authenticated)
 by conssluserg-01.nifty.com with ESMTP id 082Eq1oQ008147;
 Wed, 2 Sep 2020 23:52:01 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 082Eq1oQ008147
X-Nifty-SrcIP: [124.155.38.192]
Date: Wed, 2 Sep 2020 23:52:10 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/3] fhandler_pty_slave::setup_locale: respect charset
 == "UTF-8"
Message-Id: <20200902235210.0165c624688db6a90937753e@nifty.ne.jp>
In-Reply-To: <nycvar.QRO.7.76.6.2009021111190.56@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.2009011818560.56@tvgsbejvaqbjf.bet>
 <20200902083014.GH4127@calimero.vinschen.de>
 <20200902184104.a4a754ab3827352eab126e5c@nifty.ne.jp>
 <nycvar.QRO.7.76.6.2009020822590.56@tvgsbejvaqbjf.bet>
 <20200902220600.8e4e994b275545bcfafa1802@nifty.ne.jp>
 <nycvar.QRO.7.76.6.2009021111190.56@tvgsbejvaqbjf.bet>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, KAM_ASCII_DIVIDERS, NICE_REPLY_A,
 RCVD_IN_BARRACUDACENTRAL, RCVD_IN_DNSWL_NONE, SPF_HELO_NONE, SPF_PASS,
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
X-List-Received-Date: Wed, 02 Sep 2020 14:52:22 -0000

On Wed, 2 Sep 2020 11:12:53 +0200 (CEST)
Johannes Schindelin wrote:
> On Wed, 2 Sep 2020, Takashi Yano wrote:
> > OK, I will check Angular/CLI next. But I am not familier with
> > Agnular/CLI. Could you please provide simple steps to reproduce
> > the problem?
> 
> Here is a report: https://github.com/git-for-windows/git/issues/2793

I already read that thread, and I have try following step.

1) Install node.js
2) npm install --global @angular/cli
3) ng new test-app
4) cd test-app
5) ng test --code-coverage

However, the output is very differnt from the bug report,
and there seems to be no garbled output.

The output is something like:

Compiling @angular/core : es2015 as esm2015
Compiling @angular/animations : es2015 as esm2015
Compiling @angular/compiler/testing : es2015 as esm2015
Compiling @angular/common : es2015 as esm2015
Compiling @angular/animations/browser : es2015 as esm2015
Compiling @angular/core/testing : es2015 as esm2015
Compiling @angular/animations/browser/testing : es2015 as esm2015
Compiling @angular/platform-browser : es2015 as esm2015
Compiling @angular/common/http : es2015 as esm2015
Compiling @angular/common/testing : es2015 as esm2015
Compiling @angular/router : es2015 as esm2015
Compiling @angular/forms : es2015 as esm2015
Compiling @angular/platform-browser-dynamic : es2015 as esm2015
Compiling @angular/platform-browser/testing : es2015 as esm2015
Compiling @angular/platform-browser/animations : es2015 as esm2015
Compiling @angular/common/http/testing : es2015 as esm2015
Compiling @angular/platform-browser-dynamic/testing : es2015 as esm2015
Compiling @angular/router/testing : es2015 as esm2015
10% building 2/2 modules 0 active02 09 2020 23:49:25.110:WARN [karma]: No captur
ed browser, open http://localhost:9876/
02 09 2020 23:49:25.118:INFO [karma-server]: Karma v5.0.9 server started at http
://0.0.0.0:9876/
02 09 2020 23:49:25.119:INFO [launcher]: Launching browsers Chrome with concurre
ncy unlimited
02 09 2020 23:49:25.125:INFO [launcher]: Starting browser Chrome
92% additional asset processing copy-webpack-plugin02 09 2020 23:49:34.003:WARN
[karma]: No captured browser, open http://localhost:9876/
02 09 2020 23:49:34.907:INFO [Chrome 85.0.4183.83 (Windows 10)]: Connected on so
cket z7khH23JfW4v-_TtAAAA with id 59608191
Chrome 85.0.4183.83 (Windows 10): Executed 3 of 3 SUCCESS (0.62 secs / 0.273 sec
s)
TOTAL: 3 SUCCESS
TOTAL: 3 SUCCESS
TOTAL: 3 SUCCESS

=============================== Coverage summary ===============================
Statements   : 100% ( 6/6 )
Branches     : 100% ( 0/0 )
Functions    : 100% ( 0/0 )
Lines        : 100% ( 5/5 )
================================================================================

What's wrong?

> But why do you want to look into Angular/CLI? Do you really think that it
> makes sense to try to fix every console app out there? Really? Wouldn't it
> make more sense to just accept that there are many console applications
> that are broken by the recent change, and accommodate them in the Cygwin
> runtime? That would take substantially less time.

It is important to know what's happning actually to fix the issue.
Superficial patch makes the problem more complicated.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
