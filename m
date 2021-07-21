Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 by sourceware.org (Postfix) with ESMTPS id EF7063896817
 for <cygwin-patches@cygwin.com>; Wed, 21 Jul 2021 09:30:52 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org EF7063896817
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MmlGg-1lMKEP0dbK-00juWj for <cygwin-patches@cygwin.com>; Wed, 21 Jul 2021
 11:30:51 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 7C9CAA831C3; Wed, 21 Jul 2021 11:30:50 +0200 (CEST)
Date: Wed, 21 Jul 2021 11:30:50 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Fix nanosleep returning negative rem
Message-ID: <YPfpSgbZbr+bnOWE@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <000201d77d7a$2faae510$8f00af30$@cl.cam.ac.uk>
 <YPfdSyPTCdSWhRv/@calimero.vinschen.de>
 <0189b5495b2149c5a690de0431b7695c@metastack.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0189b5495b2149c5a690de0431b7695c@metastack.com>
X-Provags-ID: V03:K1:v2T4N1ADgH9NzEOYq3Cr+g8Af4FsV0BtZUdIhpB5RH+ssT4WU02
 st/LNp3+pPn0K5oeSSnRNm6rin8uUjLbsYE1IdzCYjox9ckcTA54JtxGT0pa4DEurywpoiT
 FwmqJqb0vEZV9yjwosVOIe1TTv8lrajs1jusFDwLSo5ET5Gte6BAWDX0UJP8A3Ox+I0HW2r
 IgDCCzvtp/09jAV/A3D7w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:i1qQKgTOHz4=:7UB8di+GKTtG7sBz+/E7GG
 NvbWd04csw4m30GxdLdE7Vcz7kHbQ+M1m3ejnsQswXNBZs25bijlaijsRJSaTn8Swt+fwYNlq
 QbwaSNzC9RN+usP0RSPM0s54auVKafwcBmbZkD7Arz1SaodKaSXtAE0+dpPaZgYHxAkvK4f68
 rORTIbq8WjXr963qWkh/EXtOFeeG9WdQB0EOFaag3mgS6w/jGwAv1UnDh+Scd3O1HpekGIp+q
 venNkFJPDkWbgfzZcqzwJGvoITyKnRCc/kOZ1juY4LoR1eo+RswWa8/nHQe3Kj3gfbDmDjhYa
 tRwFoqc1ahEKK1ajGeT3Ff/AGyFUd8Vvm1gTGo2udB1mNs+/EmlEKnpbKGZwWt+OUS1sqO9cu
 3oJSOsQqyP2W/z/GrRkRLg997zm7fq6EtTDySuoE7+McTBfR2QBMzipUqvAH9sqkxcGfLdMlz
 m5ahWJiAuBREpWsCm1Iil5dsmTgmDSDSdpdAokaf7EAqZSYN+0Kj2E+dxIZKGnHZRpRpB26QY
 iTiOL4fcrVGIPF0jj1+tu8dHlj5Yl/4lGjcV4SaFcgIvxkWzE6/e0Pxaon4lPqA8STgaAGSCq
 lFN6QbiV2Zcs3VTIOFCuTxTv5hIoKZtfYPKMbL0m46O2CUeaK7Vq2v0eDFDVE1mlS0nps3rhf
 gtCCyWLxpIq3oWtkAVJBr9hAifde8jw/CUchPJsOc9r9fl9Hmvkcz5Q7ZT+nM1DfH6kkA2mhg
 uK7UiANFDktBw9q25utqRNR6soaKAC0+ivceFHxECe6JQVCYggUdOqAhcAnzmrptCQK3rPnm+
 Bw6KfXxQdpJIrkKFFAQhghl+nAKVPqUhNZq1/dxGZlPA60wCWWHh5dMNgqMcMDzVIgRnwEyhZ
 8AN4lBp86Fz0hdAh0wRA==
X-Spam-Status: No, score=-100.3 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL, SPF_HELO_NONE, SPF_NEUTRAL,
 TXREP autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
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
X-List-Received-Date: Wed, 21 Jul 2021 09:30:54 -0000

On Jul 21 09:07, David Allsopp wrote:
> > On Jul 20 16:16, David Allsopp wrote:
> > > I've pushed a repro case for this to
> > > https://github.com/dra27/cygwin-nanosleep-bug.git
> > >
> > > Originally noticed as the main CI system for OCaml has been failing
> > > sporadically for the signal.ml test mentioned in that repo. This
> > > morning I tried hammering that test on my dev machine and discovered
> > > that it fails very frequently. No idea if that's drivers, Windows 10
> > > updates, number of cores or what, but it was definitely happening, and
> > > easily.
> > >
> > > Drilling further, it appears that NtQueryTimer is able to return a
> > > negative value in the TimeRemaining field even when SignalState is
> > > false. The values I've seen have always been < 15ms - i.e. less than
> > > the timer resolution, so I wonder if there is a point at which the
> > > timer has elapsed but has not been signalled, but WaitForMultipleObjects
> > returns because of the EINTR signal.
> > > Mildly surprising that it seems to be so reproducible.
> > >
> > > Anyway, a patch is attached which simply guards a negative return
> > > value. The test on tbi.SignalState is in theory unnecessary.
> > 
> > Thanks for the patch, I think your patch is fine.  However, I'd like to
> > dig a bit into this to see what exactly happens.  Do you have a very
> > simple testcase in plain C, by any chance?
> 
> https://github.com/dra27/cygwin-nanosleep-bug/blob/main/signal.c was
> as simple as I'd gone at this stage (eliminating OCaml from the
> equation!). It might be possible to get it to happen without all the
> pthreads stuff: having confirmed it definitely wasn't OCaml and been
> able to put the appropriate system_printf's into cygwait to see that
> NtQueryTimer really was returning this small negative value, I stopped
> simplifying.
> 
> Does that repro case trigger on your system too?

I'm not sure.  Would the output " - nanosleep failed: ..." indicate the
bug has been triggered?  If so, no, I can't reproduce this on my system.

I wrote a quick STC using the NT API calls and I can't reproduce the
problem with this code either.  The output is either

  SignalState: 1 TimeRemaining: -5354077459183

or

  SignalState: 0 TimeRemaining: 653

I never get a small negative value in the latter case.  Can you
reproduce your problem with this testcase or tweak it to reproduce it?

Either way, your patch as safe guard should be ok.


Thanks,
Corinna
