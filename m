Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 by sourceware.org (Postfix) with ESMTPS id 04B343858036
 for <cygwin-patches@cygwin.com>; Fri, 23 Oct 2020 09:21:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 04B343858036
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MHG4W-1kaGzO0R7I-00DJgx for <cygwin-patches@cygwin.com>; Fri, 23 Oct 2020
 11:21:18 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id F18C3A81039; Fri, 23 Oct 2020 11:21:16 +0200 (CEST)
Date: Fri, 23 Oct 2020 11:21:16 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/1] Fix MSG_WAITALL support
Message-ID: <20201023092116.GT5492@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20201012180213.21748-1-kbrown@cornell.edu>
 <48028fa7-5bcd-2c37-f535-87ad622840ba@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <48028fa7-5bcd-2c37-f535-87ad622840ba@cornell.edu>
X-Provags-ID: V03:K1:kvnSvWLlMd1tqonWMASwWgTOWmS5NwOgpyAbJnZFzQLzydzMtxm
 SdRiMk9dnOO91aNx8w0RRLdvrtUnex5apEJJo99mFmB8jGibsDbOow1pAHhWdxYLADJMfuC
 elfn7Js2Qa4GwvyVmH31Om8F99MD9NWD3nikXpq/I3QeA2apSNSkZRnLoGhLd8Cw4+LMVVz
 tWWqkyY6qEhs+eV08+akg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Nzy9gSI2RQc=:4HaJADQHveaJMfkEQb5Pzz
 lO/i+lvDCvi6JeH/na6WHjSVq8y4L2CD3rR72Q5ksf0fi/Q6j5v3bbsrelt3niYMZhvCuSNnf
 eUoiCCXBKl1p2V3I3P8qriRn5NXHYfwLxS2Cd6RzlBznbr3niIzKJDiqf3uQcOqw1RMnQSU00
 kapDHHg8yFIsyiZZqSUzJ4Y7JRYzhxjqzKgpzYkiSnTNjIaUR60h7thOMvPD7r50Cu0HyY70t
 5/BifJG014eBsGTFv7CFLeXbA137ePJG/lZ6sAcLmOcA+h5VguRNiiO3LqhLeuKnZ9MGoFOaf
 rqMz38KCB/GC2u4H1ATUAXnRcuWzp+Kh5NfZRKc13owP6f/3kDDDq+sDAjDQ7ZuRzj1+sxNKD
 D5jkyQmenkk8HZwu7NiQsJLDtDjP2/P425F5xbvA2oenhC1CVbSQpO/JUinb7/qHgTuthQL3C
 l2M2fPCEHg==
X-Spam-Status: No, score=-100.7 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Fri, 23 Oct 2020 09:21:21 -0000

On Oct 22 15:26, Ken Brown via Cygwin-patches wrote:
> On 10/12/2020 2:02 PM, Ken Brown via Cygwin-patches wrote:
> > It looks to me like there's been a bug in the MSG_WAITALL support for
> > AF_INET and AF_LOCAL sockets ever since that support was first
> > introduced 13 years ago in commit 023a2fa7.  If I'm right, MSG_WAITALL
> > has never worked.
> > 
> > This patch fixes it.  I'll push it in a few days if no one sees
> > anything wrong with it.
> > 
> > In a followup email I'll show how I tested it.
> 
> Hi Corinna,
> 
> I know I said I'd push this in a few days, but that was when I thought you'd
> be gone for a while longer.
> 
> Does the patch look OK?

Sure!  I mean, you tested it and it fixing a problem, right?


Thanks,
Corinna
