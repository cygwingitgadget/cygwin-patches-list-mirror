Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com
 [210.131.2.83])
 by sourceware.org (Postfix) with ESMTPS id 154A4386F440
 for <cygwin-patches@cygwin.com>; Thu, 27 Aug 2020 08:59:57 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 154A4386F440
Received: from Express5800-S70 (v038192.dynamic.ppp.asahi-net.or.jp
 [124.155.38.192]) (authenticated)
 by conssluserg-04.nifty.com with ESMTP id 07R8xhw7030377
 for <cygwin-patches@cygwin.com>; Thu, 27 Aug 2020 17:59:44 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 07R8xhw7030377
X-Nifty-SrcIP: [124.155.38.192]
Date: Thu, 27 Aug 2020 17:59:48 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Disable pseudo console if TERM is dumb or
 not set.
Message-Id: <20200827175948.e814342d1dd56e69e3c77c58@nifty.ne.jp>
In-Reply-To: <20200827084756.GU3272@calimero.vinschen.de>
References: <20200826120015.1188-1-takashi.yano@nifty.ne.jp>
 <20200826173606.GP3272@calimero.vinschen.de>
 <20200827130720.f9f618c1313e18848a995f8c@nifty.ne.jp>
 <20200827084756.GU3272@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, NICE_REPLY_A,
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
X-List-Received-Date: Thu, 27 Aug 2020 09:00:02 -0000

On Thu, 27 Aug 2020 10:47:56 +0200
Corinna Vinschen wrote:
> On Aug 27 13:07, Takashi Yano via Cygwin-patches wrote:
> > On Wed, 26 Aug 2020 19:36:06 +0200
> > Corinna Vinschen wrote:
> > > On Aug 26 21:00, Takashi Yano via Cygwin-patches wrote:
> > > > Pseudo console generates escape sequences on execution of non-cygwin
> > > > apps.  If the terminal does not support escape sequence, output will
> > > > be garbled. This patch prevents garbled output in dumb terminal by
> > > > disabling pseudo console.
> > > 
> > > I'm a bit puzzled by this patch.  We had code handling emacs and dumb
> > > terminals explicitely in the early forms of the first incarnation of
> > > the pseudo tty code, but fortunately you found a way to handle this
> > > without hardcoding terminal types into Cygwin.  Why do you think we
> > > have to do this now?
> > 
> > What previously disccussed was the problem that the clearing
> > screen at pty startup displays garbage (^[[H^[[2J) in emacs.
> > Finally, this was settled by eliminating clear-screen and
> > triggering redraw-screen instead at the first execution of
> > non-cygwin app.
> > 
> > However, the problem reported in
> > https://cygwin.com/pipermail/cygwin/2020-August/245983.html
> > still remains. 
> > 
> > What's worse in the new implementation, pseudo console sends
> > ESC[6n (querying cursor position) internally on startup and
> > waits for a response. This causes hang if pseudo console is
> > started in dumb terminal.
> > 
> > This patch is for fixing this issue.
> 
> Would it be feasible to implement this using a timeout instead?
> If the response isn't sent within, say, 100ms, just skip it?

Hang is caused at CreateProcessW() call, so there is no way to
use time out. It is possible to send ESC[6n before creating
pseudo console for a test and wait for responce with timeout,
however, if the terminal is dumb, garbage ^[[6n will be displayed.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
