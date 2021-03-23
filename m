Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com
 [210.131.2.83])
 by sourceware.org (Postfix) with ESMTPS id 79EB6385701F
 for <cygwin-patches@cygwin.com>; Tue, 23 Mar 2021 11:50:14 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 79EB6385701F
Received: from Express5800-S70 (ae236159.dynamic.ppp.asahi-net.or.jp
 [14.3.236.159]) (authenticated)
 by conssluserg-04.nifty.com with ESMTP id 12NBnucN027728
 for <cygwin-patches@cygwin.com>; Tue, 23 Mar 2021 20:49:56 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 12NBnucN027728
X-Nifty-SrcIP: [14.3.236.159]
Date: Tue, 23 Mar 2021 20:49:57 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Rename input named pipes.
Message-Id: <20210323204957.9f311383716eeb3dafbdcbf2@nifty.ne.jp>
In-Reply-To: <YFm1suUDnvW/HOEY@calimero.vinschen.de>
References: <20210321035953.1671-1-takashi.yano@nifty.ne.jp>
 <YFiEQJf6ZDivGbPH@calimero.vinschen.de>
 <20210323093808.0e0b4114dc72ca5e9ddaabc3@nifty.ne.jp>
 <YFm1suUDnvW/HOEY@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Tue, 23 Mar 2021 11:50:18 -0000

On Tue, 23 Mar 2021 10:32:34 +0100
Corinna Vinschen wrote:
> On Mar 23 09:38, Takashi Yano via Cygwin-patches wrote:
> > On Mon, 22 Mar 2021 12:49:20 +0100
> > Corinna Vinschen wrote:
> > > Hi Takashi,
> > > 
> > > On Mar 21 12:59, Takashi Yano via Cygwin-patches wrote:
> > > > - Currently, the name of input pipe is "ptyNNNN-from-master" for
> > > >   cygwin process, and "ptyNNNN-to-slave" for non-cygwin process.
> > > >   These are not only inconsistent with output pipes but also very
> > > >   confusing.
> > > >   With this patch, these are renamed to "ptyNNNN-from-master-cyg"
> > > >   and "ptyNNNN-from-master" respectively.
> > > > ---
> > > >  winsup/cygwin/fhandler_tty.cc | 2 +-
> > > >  winsup/cygwin/tty.cc          | 4 ++--
> > > >  2 files changed, 3 insertions(+), 3 deletions(-)
> > > 
> > > Actually... wouldn't it make more sense to call the Cygwin pipe
> > > 
> > >   pty%d-from-master / pty%d-to-slave
> > > 
> > > and the non-Cygwin one something like
> > > 
> > >   pty%d-from-master-nat / pty%d-to-slave-nat
> > > 
> > > ?
> > > 
> > > After all, Cygwin is the norm, and non-Cygwin is the exception.
> > > 
> > > On second thought, this would also make sense for thr fhandler methods,
> > > i. e.
> > > 
> > >   get_output_handle / get_output_handle_cyg
> > > 
> > > vs.
> > > 
> > >   get_output_handle_nat / get_output_handle
> > > 
> > > Probably the fhandler stuff is too much renaming for this release,
> > > but we should do this for the next one, I think.
> > 
> > I basically agree. However, renaming them consistently is
> > too much for 3.2.0 release as you mentioned. So, IMHO, it
> > is better to apply this patch once for 3.2.0 release and
> > then fully rename them for the next one.
> > 
> > What do you think?
> 
> I thought of renaming the pipes in this release, since you're already
> renaimg it anyway.  Renaming the fhandler members and methods could
> take place in the next release.

OK. I will submit the rename patch.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
