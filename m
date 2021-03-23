Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 by sourceware.org (Postfix) with ESMTPS id 59BD1385BF9E
 for <cygwin-patches@cygwin.com>; Tue, 23 Mar 2021 09:32:36 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 59BD1385BF9E
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Myb8N-1laNME0K2H-00yvgR for <cygwin-patches@cygwin.com>; Tue, 23 Mar 2021
 10:32:35 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 2583CA80DBA; Tue, 23 Mar 2021 10:32:34 +0100 (CET)
Date: Tue, 23 Mar 2021 10:32:34 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Rename input named pipes.
Message-ID: <YFm1suUDnvW/HOEY@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210321035953.1671-1-takashi.yano@nifty.ne.jp>
 <YFiEQJf6ZDivGbPH@calimero.vinschen.de>
 <20210323093808.0e0b4114dc72ca5e9ddaabc3@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210323093808.0e0b4114dc72ca5e9ddaabc3@nifty.ne.jp>
X-Provags-ID: V03:K1:1hD1/H4XX/j3iDn4E1TsB+Z10d2dcF2HvQYV+TJp217w87g6IsF
 AVWQC/ZM3FzKYHaya7OWHbq4Ml/PcAinSX2JJQ2BlYXDEKPO9rDwXZiI+lFDhf9VMOVJLL2
 4CwLuP15N/Mv08B6kMaJYvbuuoXOIRhaamnVQcXpfTQPYj3kwjA2gAnSNDjTlOq27OnJpRf
 DYc3QHieA24Q0ToAIQUkA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WkzG8lUvVf0=:NtFh/JDvmoC43EpPC+cXCn
 H4nWwBfUF3mi7vbyxqeZSsm1iPkGP1201qP6KFCOmbiCPMWQqXp2pRSSsuLstr0Rl9wWNG8n4
 7C3Et5fvu0xhNrTvVh9HYg+kWdQZkvatMP68JNbESb7eDnAN212vqlJeQE762prJoZkrKMQaT
 DPWvBosDy9uL2Ab4C9G92SxkWk6e0tJlZjZHGdWm2uVl7rPONzJiLxxCzv0aq2LODccwa+3/y
 3fyQx+fpmdu7woyTCiA5JLAxZJ+fxNg+Ftng6eslvK/ss49OmrPGOoz9SQPisYdC9EryhQInt
 D8lzin+ugjc5rIxxv0F0uJDmLxk01lSm+sPW41iwNjeLldI0pZuieGJ3DfTS7wK0kXEuFacaY
 GYZHifR9KFzEt5cCJOZRDJo15QjX8JpbBxq0PDdsAqOxEP0TRXRK9RjgSVAP+J48JU/ys6RXJ
 2srzaiOj2g==
X-Spam-Status: No, score=-101.0 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_NONE, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Tue, 23 Mar 2021 09:32:37 -0000

On Mar 23 09:38, Takashi Yano via Cygwin-patches wrote:
> On Mon, 22 Mar 2021 12:49:20 +0100
> Corinna Vinschen wrote:
> > Hi Takashi,
> > 
> > On Mar 21 12:59, Takashi Yano via Cygwin-patches wrote:
> > > - Currently, the name of input pipe is "ptyNNNN-from-master" for
> > >   cygwin process, and "ptyNNNN-to-slave" for non-cygwin process.
> > >   These are not only inconsistent with output pipes but also very
> > >   confusing.
> > >   With this patch, these are renamed to "ptyNNNN-from-master-cyg"
> > >   and "ptyNNNN-from-master" respectively.
> > > ---
> > >  winsup/cygwin/fhandler_tty.cc | 2 +-
> > >  winsup/cygwin/tty.cc          | 4 ++--
> > >  2 files changed, 3 insertions(+), 3 deletions(-)
> > 
> > Actually... wouldn't it make more sense to call the Cygwin pipe
> > 
> >   pty%d-from-master / pty%d-to-slave
> > 
> > and the non-Cygwin one something like
> > 
> >   pty%d-from-master-nat / pty%d-to-slave-nat
> > 
> > ?
> > 
> > After all, Cygwin is the norm, and non-Cygwin is the exception.
> > 
> > On second thought, this would also make sense for thr fhandler methods,
> > i. e.
> > 
> >   get_output_handle / get_output_handle_cyg
> > 
> > vs.
> > 
> >   get_output_handle_nat / get_output_handle
> > 
> > Probably the fhandler stuff is too much renaming for this release,
> > but we should do this for the next one, I think.
> 
> I basically agree. However, renaming them consistently is
> too much for 3.2.0 release as you mentioned. So, IMHO, it
> is better to apply this patch once for 3.2.0 release and
> then fully rename them for the next one.
> 
> What do you think?

I thought of renaming the pipes in this release, since you're already
renaimg it anyway.  Renaming the fhandler members and methods could
take place in the next release.

Do you prefer to rename pipes and fhandler methods in a single release?


Thanks,
Corinna
