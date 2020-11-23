Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com
 [210.131.2.80])
 by sourceware.org (Postfix) with ESMTPS id E3F76385800D
 for <cygwin-patches@cygwin.com>; Mon, 23 Nov 2020 11:02:48 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org E3F76385800D
Received: from Express5800-S70 (v038192.dynamic.ppp.asahi-net.or.jp
 [124.155.38.192]) (authenticated)
 by conssluserg-01.nifty.com with ESMTP id 0ANB2Hu4031490
 for <cygwin-patches@cygwin.com>; Mon, 23 Nov 2020 20:02:17 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 0ANB2Hu4031490
X-Nifty-SrcIP: [124.155.38.192]
Date: Mon, 23 Nov 2020 20:02:18 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 2/2] Cygwin: pty: Discard "OSC Ps; ? BEL/ST" in pseudo
 console output.
Message-Id: <20201123200218.8d410bb095cedd6ee7f10b12@nifty.ne.jp>
In-Reply-To: <20201123085859.GN303847@calimero.vinschen.de>
References: <20201123052815.761-1-takashi.yano@nifty.ne.jp>
 <20201123052815.761-3-takashi.yano@nifty.ne.jp>
 <20201123085859.GN303847@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Mon, 23 Nov 2020 11:02:52 -0000

On Mon, 23 Nov 2020 09:58:59 +0100
Corinna Vinschen wrote:

> Hi Takashi,
> 
> just a small style nit:
> 
> On Nov 23 14:28, Takashi Yano via Cygwin-patches wrote:
> > - If vim is executed in WSL in mintty, some garbage string caused
> >   by "OSC Ps;? BEL/ST" will be shown in some situations. This patch
> >   fixes the issue by removing "OSC Ps;? BEL/ST" from pseudo console
> >   output.
> > ---
> >  winsup/cygwin/fhandler_tty.cc | 30 ++++++++++++++++++++++++++++++
> >  1 file changed, 30 insertions(+)
> > 
> > diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
> > index 911945675..38285c7f4 100644
> > --- a/winsup/cygwin/fhandler_tty.cc
> > +++ b/winsup/cygwin/fhandler_tty.cc
> > @@ -2069,6 +2069,36 @@ fhandler_pty_master::pty_master_fwd_thread ()
> >  	    else
> >  	      state = 0;
> >  
> > +	  /* Remove OSC Ps ; ? BEL/ST */
> > +	  for (DWORD i=0; i<rlen; i++)
>                      ^^^  ^^^^^^
>                      spaces

I will submit v2 patch. Thanks.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
