Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com
 [210.131.2.81])
 by sourceware.org (Postfix) with ESMTPS id AE01938618AA
 for <cygwin-patches@cygwin.com>; Fri, 11 Sep 2020 19:11:35 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org AE01938618AA
Received: from Express5800-S70 (v038192.dynamic.ppp.asahi-net.or.jp
 [124.155.38.192]) (authenticated)
 by conssluserg-02.nifty.com with ESMTP id 08BJBEmr025111
 for <cygwin-patches@cygwin.com>; Sat, 12 Sep 2020 04:11:14 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 08BJBEmr025111
X-Nifty-SrcIP: [124.155.38.192]
Date: Sat, 12 Sep 2020 04:11:16 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Add workaround for ISO-2022 and ISCII in
 convert_mb_str().
Message-Id: <20200912041116.71e276467eaa4040c329547d@nifty.ne.jp>
In-Reply-To: <20200911185706.GO4127@calimero.vinschen.de>
References: <20200911105401.153-1-takashi.yano@nifty.ne.jp>
 <20200911120840.GH4127@calimero.vinschen.de>
 <20200911213515.98a88ca7f186ede9bf8fc106@nifty.ne.jp>
 <20200911140601.GK4127@calimero.vinschen.de>
 <20200912010504.586a156f1712f61c3c696d40@nifty.ne.jp>
 <20200912023843.58ef0f3134d6aea5359c27c0@nifty.ne.jp>
 <20200912033758.d3e898332cb37f8b69f43bd4@nifty.ne.jp>
 <20200911185706.GO4127@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Fri, 11 Sep 2020 19:11:39 -0000

On Fri, 11 Sep 2020 20:57:06 +0200
Corinna Vinschen wrote:
> On Sep 12 03:37, Takashi Yano via Cygwin-patches wrote:
> > On Sat, 12 Sep 2020 02:38:43 +0900
> > Takashi Yano via Cygwin-patches <cygwin-patches@cygwin.com> wrote:
> > > How about the patch attached?
> > > I think this is safer than previous patch.
> > 
> > I have revised this patch to fit current git head, and submit
> > to cygwin-patches@cygwin.com.
> 
> Thanks, but I didn't apply this one because it doesn't really make sense
> to go to the extra effort to support outdated and incompatible codepages
> we don't handle as Cygwin codeset at all.  IMHO it's not worth to call
> another MBTWC just to check if a codepage supports the MB_ERR_INVALID_CHARS
> flag.

I have checked which codepage does not support MB_ERR_INVALID_CHARS.
The result is as follows.

42
50220
50221
50222
50225
50227
50229
52936
57002
57003
57004
57005
57006
57007
57008
57009
57010
57011
65000

If all of these are not worth for everyone, I agree with you.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
