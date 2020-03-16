Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com
 [210.131.2.83])
 by sourceware.org (Postfix) with ESMTPS id AC5953953C07
 for <cygwin-patches@cygwin.com>; Mon, 16 Mar 2020 02:04:17 +0000 (GMT)
Received: from Express5800-S70 (ntsitm194054.sitm.nt.ngn.ppp.infoweb.ne.jp
 [125.0.205.54]) (authenticated)
 by conssluserg-04.nifty.com with ESMTP id 02G23nkb004648
 for <cygwin-patches@cygwin.com>; Mon, 16 Mar 2020 11:03:49 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 02G23nkb004648
X-Nifty-SrcIP: [125.0.205.54]
Date: Mon, 16 Mar 2020 11:03:54 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Add FreeConsole to destructor of pty slave.
Message-Id: <20200316110354.8482779ab59324921498a2f6@nifty.ne.jp>
In-Reply-To: <20200313095825.GB512788@calimero.vinschen.de>
References: <20200313030649.874-1-takashi.yano@nifty.ne.jp>
 <20200313095825.GB512788@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED, DKIM_VALID,
 DKIM_VALID_AU, DKIM_VALID_EF, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2,
 SPF_HELO_NONE, SPF_PASS autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin-patches mailing list <cygwin-patches.cygwin.com>
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <http://cygwin.com/pipermail/cygwin-patches/>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Mon, 16 Mar 2020 02:04:20 -0000

On Fri, 13 Mar 2020 10:58:25 +0100
Corinna Vinschen wrote:
> Pushed.  However, the comment in that snippet (Why comes...) puzzles
> me a bit.  Can you clarify this a bit?

_tc is set in fhandler_pty_master::setup() in very early stage.
So I thought it should have valid value in destructor of pty
slave. However, in practice, _tc may be NULL in some unclear
situation.

I wonder why _tc can be NULL in the destructor of pty slave.
I must have overlooked something...

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
