Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com
 [210.131.2.83])
 by sourceware.org (Postfix) with ESMTPS id C5D49385483C
 for <cygwin-patches@cygwin.com>; Tue, 23 Mar 2021 11:57:43 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org C5D49385483C
Received: from Express5800-S70 (ae236159.dynamic.ppp.asahi-net.or.jp
 [14.3.236.159]) (authenticated)
 by conssluserg-04.nifty.com with ESMTP id 12NBvGRo032278
 for <cygwin-patches@cygwin.com>; Tue, 23 Mar 2021 20:57:16 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 12NBvGRo032278
X-Nifty-SrcIP: [14.3.236.159]
Date: Tue, 23 Mar 2021 20:57:17 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/2] Return appropriate handle by _get_osfhandle() and
 GetStdHandle().
Message-Id: <20210323205717.bf5c3a41695871ec70bf1229@nifty.ne.jp>
In-Reply-To: <YFm+fEONY3wLq3Sp@calimero.vinschen.de>
References: <20210321040126.1720-1-takashi.yano@nifty.ne.jp>
 <20210321174427.cf79e39deeea896583caa48c@nifty.ne.jp>
 <20210322080738.6841d7f2a1e09290a929ad90@nifty.ne.jp>
 <YFiC6FXrnGeW8v1M@calimero.vinschen.de>
 <58c7be6c-42db-cc09-9f89-461ac7c87747@cornell.edu>
 <YFm+fEONY3wLq3Sp@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, NICE_REPLY_A, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Tue, 23 Mar 2021 11:57:45 -0000

On Tue, 23 Mar 2021 11:10:04 +0100
Corinna Vinschen wrote:
> [CC Marco, CC Jan]
> 
> On Mar 22 13:02, Ken Brown via Cygwin-patches wrote:
> > [Still CC Marco]
> > 
> > On 3/22/2021 7:43 AM, Corinna Vinschen via Cygwin-patches wrote:
> > > [CC Marco]
> > > 
> > > On Mar 22 08:07, Takashi Yano via Cygwin-patches wrote:
> > > > On Sun, 21 Mar 2021 17:44:27 +0900
> > > > Takashi Yano wrote:
> > > > > [...]
> > > > > However, following cygwin apps/dlls call _get_osfhandle():
> > > > > ccmake.exe
> > > > > cmake.exe
> > > > > cpack.exe
> > > > > ctest.exe
> > > > > ddrescue.exe
> 
> I'm pretty sure ddrescue needs the osfhandle just to access raw block
> devices.
> 
> > > > > And also, following cygwin apps/dlls call GetStdHandle():
> > > > > ccmake.exe
> > > > > cmake.exe
> > > > > cpack.exe
> > > > > ctest.exe
> > > > > run.exe
> 
> run creates its own conin/conout handles to create a hidden console.
> The code calling GetStdHandle() is only for debug purposes and never
> built into the executable.
> 
> > > > > cygusb0.dll
> 
> This lib tries to access USB devices only.
> 
> > > > > tk86.dll
> 
> Not sure about this one.  In theory this shouldn't happen, given our
> tk is built against X11, not against the Windows GUI.
> 
> Jan, can you please check where and why tk86.dll calls GetStdHandle.
> I found a few places in the source where GetStdHandle is called, but
> it's not clear to me which one is called.

Thanks for checking obove.

> > Out of curiosity, I took a quick glance at the cmake code.  It appears that
> > this code is designed to support running cmake in a Console.  I don't think
> > that should be needed any more, if it ever was.
> > [...]
> > I think the following might suffice (untested):
> > 
> > --- a/Source/kwsys/Terminal.c
> > +++ b/Source/kwsys/Terminal.c
> > @@ -10,7 +10,7 @@
> >  #endif
> > 
> >  /* Configure support for this platform.  */
> > -#if defined(_WIN32) || defined(__CYGWIN__)
> > +#if defined(_WIN32)
> >  #  define KWSYS_TERMINAL_SUPPORT_CONSOLE
> >  #endif
> >  #if !defined(_WIN32)
> 
> Looks right to me.  If we patch cmake to do the right thing, do we still
> need this patch, Takashi?

I don't think so. If all is well with current code, nothing to be fixed.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
