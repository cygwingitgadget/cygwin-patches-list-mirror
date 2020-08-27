Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com
 [210.131.2.81])
 by sourceware.org (Postfix) with ESMTPS id ECAFF3857C47
 for <cygwin-patches@cygwin.com>; Thu, 27 Aug 2020 03:34:40 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org ECAFF3857C47
Received: from Express5800-S70 (v038192.dynamic.ppp.asahi-net.or.jp
 [124.155.38.192]) (authenticated)
 by conssluserg-02.nifty.com with ESMTP id 07R3YG2W017782
 for <cygwin-patches@cygwin.com>; Thu, 27 Aug 2020 12:34:16 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 07R3YG2W017782
X-Nifty-SrcIP: [124.155.38.192]
Date: Thu, 27 Aug 2020 12:34:18 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Fix incorrect code page when setting console title on
 Win10
Message-Id: <20200827123418.ab6d9a9a6157daa43aef1e5f@nifty.ne.jp>
In-Reply-To: <20200826173345.GO3272@calimero.vinschen.de>
References: <tencent_DEAF96B572731C3B3E524F22CCAC86D3AD07@qq.com>
 <20200826090625.GN3272@calimero.vinschen.de>
 <nycvar.QRO.7.76.6.2008260919460.56@tvgsbejvaqbjf.bet>
 <20200826173345.GO3272@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00, BODY_8BITS,
 DKIM_SIGNED, DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, KAM_NUMSUBJECT,
 NICE_REPLY_A, RCVD_IN_BARRACUDACENTRAL, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2,
 SPF_HELO_NONE, SPF_PASS, TXREP autolearn=no autolearn_force=no version=3.4.2
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
X-List-Received-Date: Thu, 27 Aug 2020 03:34:44 -0000

On Wed, 26 Aug 2020 19:33:45 +0200
Corinna Vinschen wrote:
> On Aug 26 09:30, Johannes Schindelin wrote:
> > Hi Corinna,
> > 
> > On Wed, 26 Aug 2020, Corinna Vinschen wrote:
> > 
> > > On Aug 26 16:43, 宫大汉 via Cygwin-patches wrote:
> > > > When Cygwin sets console titles on Win10 (has_con_24bit_colors &amp;&amp; !con_is_legacy),
> > > > `WriteConsoleA` is used and causes an error if:
> > > > 1. the environment variable of `LANG` is `***.UTF-8`
> > > > 2. and the code page of console.exe is not UTF-8
> > > > &nbsp; 1. e.g. on my Computer, it's GB2312, for Chinese text
> > > >
> > > >
> > > > I've done some tests on msys2 and details are on https://github.com/git-for-windows/git/issues/2738,
> > > > and I filed a PR of https://github.com/git-for-windows/msys2-runtime/pull/25.
> > 
> > Just in case you want to have a look at it, you can download the patch via
> > https://github.com/git-for-windows/msys2-runtime/commit/334f52a53a2e6b7f560b0e8810b9f672ebb3ad24.patch
> > 
> > FWIW my original reviewer comment was: "why not fix wpbuf.send() in the
> > first place?" but after having a good look around, that method seemed to
> > be called from so many places that I "got cold feet" of that approach.
> > 
> > For one, I saw at least one caller that wants to send Escape sequences,
> > and I have no idea whether it is a good idea to do that in the `*W()`
> > version of the `WriteConsole()` function.
> 
> Yes, it is.  There's no good reason to use the A functions, actually.
> They are just wrappers calling the W functions and WriteConsoleW
> evaluates ESC sequences just fine (just given as UTF-16 chars).
> 
> > So the real question from my side is: how to address properly the many
> > uses of `WriteConsoleA()` (which breaks all kinds of encodings in many
> > situations because Windows' idea of the current code page and Cygwin's
> > idea of the current locale are pretty often at odds).
> > 
> > The patch discussed here circumvents one of those call sites.
> > 
> > However, even though there have not been any callers of `WriteConsoleA()`
> > in Cygwin v3.0.7 (but four callers of `WriteConsoleW()` which I suspect
> > were converted to `*A()` calls in v3.1.0 by the Pseudo Console patches),
> > there are now a whopping 15 callers of that `*A()` function in Cygwin
> > v3.1.7. See here:
> > [...]
> > That cannot be intentional, can it? We should always thrive to use the
> > `*W()` functions so that we can be sure that the expected encoding is
> > used, right?
> 
> Takashi?  Any reason to use WriteConsoleA rather than WriteConsoleW?  If
> at all, WriteConsoleA should only be used if it's 100% safe to assume
> that the buffer only contains ASCII chars < 127.

No. I just did not realize that the escapce sequence cound contain
non-ASCII chars. I am sorry.

I will submit a patch for that issue.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
