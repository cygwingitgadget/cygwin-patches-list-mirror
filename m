Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
 by sourceware.org (Postfix) with ESMTPS id 9924B3858D28
 for <cygwin-patches@cygwin.com>; Sat,  5 Feb 2022 10:22:45 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 9924B3858D28
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MAfpQ-1n5Jqm11bs-00B32T for <cygwin-patches@cygwin.com>; Sat, 05 Feb 2022
 11:22:44 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id C758DA80D8B; Sat,  5 Feb 2022 11:22:43 +0100 (CET)
Date: Sat, 5 Feb 2022 11:22:43 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: wincap: Add capabilities for Windows 10 2004 and
 newer.
Message-ID: <Yf5P80AMY1rRQpuK@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20220205080719.928-1-takashi.yano@nifty.ne.jp>
 <Yf5H+DgpvRIGa9ys@calimero.vinschen.de>
 <20220205185519.ee6239a14697d360a902e666@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220205185519.ee6239a14697d360a902e666@nifty.ne.jp>
X-Provags-ID: V03:K1:mi14ztxKG/GKg1Pcoqn72ykH4+L7jDhqkzqrJwWtdnCRLUN/uZN
 UJRp8RsjxZrA3EA0nUKjiM/p+sbKGTxuoW2givYvo+cYg2NCkETpTG1BuGruOby0Qw95oCo
 WoUR/7VjY4fsNayiaz20jnVKe9pAWaAP7C2sYyNokw1g6Z26h2Kq0JUq6qVqjCi0zHg0oUa
 7HVWddTbSQLZhKd6xHtFA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AD75tFuLlNY=:lDGDXSWT79kOvD3nq3zkxu
 yE84ojaBk7k6b3idRYdm3f7frxP9j1qtCLFDTGTgZJyzz5TL5a4t2HzGgEiN/GbIc9htFJeGF
 WhyiXSPtFuVses1bZuhbaZ6WgJ3YpPGMXqyLS/T2ohR/X3RfdRjujO0b1p2tn7270NYfAPOgZ
 w+KQZfR3XBSxoiqA12AiTWfFOqyM4eLpkewjf8/OW+V8P35t26/lS3zk5sdnRkkLJZjlWenFJ
 MuKE1JGOP+Ty73hXIG7POdkpa82hhuMEPuJCm+rFXtpzA52nopAlAeiEz7yeYdBt48prvxk77
 RRqI7yyx+mxwBQADH046wdtH+Qc+8kXn6M8Q2cGa6SFxd0Y5D0JP5l0/Us9jKLNzSL2Ei1i1l
 60+4Zb0Q9+uvNX4ss5kvdKNRQ+yZKO1UwGFHKbuUFEUKSL+00usVCRQIINeVZekLAQjPs40mK
 RQbQO+toRTxQEsnc9kZ2b7lQnDdivWO6SYgup+KW+vjn8OwNyFRffFjDhv5DabwDVRozu5QYr
 98Z9H3sShu3DkrZE4ggUntWkg+fjH94hU/i2LTgcBcuXUVz5mgC0zOpK8+YOLBkk60v6GStQI
 bDxZWimRYAIlrF7103MdlsRvRbqQqOJDMgu24W928oDZPoTXwBG0ykTbIN7ri+mbRY/JQ2FuV
 Oob0YJb52B5NYJc7+bTmYThaQInFgv6IV/PpnuCZwg1LW/EYh05Z3FD0pQ0GMseUJqoJZVM03
 lSQDXJU0JS2A0coH
X-Spam-Status: No, score=-97.9 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H5, RCVD_IN_MSPIKE_WL, SPF_FAIL, SPF_HELO_NONE, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Sat, 05 Feb 2022 10:22:47 -0000

On Feb  5 18:55, Takashi Yano wrote:
> On Sat, 5 Feb 2022 10:48:40 +0100
> Corinna Vinschen wrote:
> > On Feb  5 17:07, Takashi Yano wrote:
> > > - The capability changes since Windows 10 2004 have been reflected
> > >   in wincap.cc. (has_con_broken_il_dl has been changed to false.)
> > > ---
> > >  winsup/cygwin/wincap.cc | 35 ++++++++++++++++++++++++++++++++++-
> > >  1 file changed, 34 insertions(+), 1 deletion(-)
> > 
> > Sure thing, please push.
> 
> Is this should be for both master and cygwin-3_3-branch?
> Or only for master?

Not sure... master-only, I think.


Corinna
