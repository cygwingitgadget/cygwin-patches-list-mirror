Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com
 [210.131.2.80])
 by sourceware.org (Postfix) with ESMTPS id 262FB386184F
 for <cygwin-patches@cygwin.com>; Mon, 18 Jan 2021 15:41:18 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 262FB386184F
Received: from Express5800-S70 (x067108.dynamic.ppp.asahi-net.or.jp
 [122.249.67.108]) (authenticated)
 by conssluserg-01.nifty.com with ESMTP id 10IFevIM009393
 for <cygwin-patches@cygwin.com>; Tue, 19 Jan 2021 00:40:57 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 10IFevIM009393
X-Nifty-SrcIP: [122.249.67.108]
Date: Tue, 19 Jan 2021 00:41:01 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Set input_available_event only for cygwin
 pipe.
Message-Id: <20210119004101.482327ca82eef5461b6b3e3c@nifty.ne.jp>
In-Reply-To: <20210118152700.GJ59030@calimero.vinschen.de>
References: <20210115092631.748-1-takashi.yano@nifty.ne.jp>
 <20210119000031.4eab2786d24768f405b6bfdf@nifty.ne.jp>
 <20210118152700.GJ59030@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, NICE_REPLY_A,
 RCVD_IN_DNSWL_NONE, SPF_HELO_NONE, SPF_PASS,
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
X-List-Received-Date: Mon, 18 Jan 2021 15:41:21 -0000

On Mon, 18 Jan 2021 16:27:00 +0100
Corinna Vinschen wrote:
> On Jan 19 00:00, Takashi Yano via Cygwin-patches wrote:
> > Hi Corinna,
> > 
> > On Fri, 15 Jan 2021 18:26:31 +0900
> > Takashi Yano wrote:
> > > - cat exits immediately in the following senario.
> > >     1) Execute env CYGWIN=disable_pcon script
> > >     2) Execute cmd.exe
> > >     3) Execute cat in cmd.exe.
> > >   This is caused by setting input_available_event for the pipe for
> > >   non-cygwin app. This patch fixes the issue.
> > > ---
> > >  winsup/cygwin/fhandler_tty.cc | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
> > > index e4993bf31..0b9901974 100644
> > > --- a/winsup/cygwin/fhandler_tty.cc
> > > +++ b/winsup/cygwin/fhandler_tty.cc
> > > @@ -394,7 +394,8 @@ fhandler_pty_master::accept_input ()
> > >  	}
> > >      }
> > >  
> > > -  SetEvent (input_available_event);
> > > +  if (write_to == get_output_handle ())
> > > +    SetEvent (input_available_event);
> > >    ReleaseMutex (input_mutex);
> > >    return ret;
> > >  }
> > > -- 
> > > 2.30.0
> > > 
> > 
> > I would be happy if you could review this patch as well.
> 
> Sorry, I missed that one!  Pushed.

Thanks!

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
