Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
 by sourceware.org (Postfix) with ESMTPS id 8E4113860C3B
 for <cygwin-patches@cygwin.com>; Mon,  8 Mar 2021 20:52:39 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 8E4113860C3B
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MqbI0-1m5g7J39m4-00mbss for <cygwin-patches@cygwin.com>; Mon, 08 Mar 2021
 21:52:37 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 40F42A8266C; Mon,  8 Mar 2021 21:52:37 +0100 (CET)
Date: Mon, 8 Mar 2021 21:52:37 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Transfer input for native app only if the
 stdin is pcon.
Message-ID: <YEaOlWwJDe/3R7m/@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210308145510.1164-1-takashi.yano@nifty.ne.jp>
 <YEZDgPyUTu18fFD5@calimero.vinschen.de>
 <20210309004818.0e6973cfde7a563ab293e1ac@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210309004818.0e6973cfde7a563ab293e1ac@nifty.ne.jp>
X-Provags-ID: V03:K1:ivkqSVBSnX4qPoYImPusWKsVwjGrdyQpnjJNd2aYMZNVUm8s0AY
 Sl+GWrRIGBr6P8YtrARhxviMrF3zfQC141oZeN8ALza0X8ErMTk/c1arFAhpk5z/3EVuJSw
 s2Ao+tCM2H15yeC4n9dXAMowdNZOzUPl8h2PDdMs+/kWdjtAA2BpPfQ35eseFbzV9+9kXDa
 5IukAWaD/T+dRs7aFQGYw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cL22RManlWE=:BMeFQO7UlhIAyL1geW5C6e
 acZne9QAjZJ/TZsPz8VxJMKE26GsadFFb0rtQ9yRxAk+a/fF92YVmUBYTauI/o7ab1yGBcdvk
 PpJ2o/HZK+oTBOwyUz0UvSUb092KvxLo5+UJrsr+1ibTSY3Weh+4uMsfagneodGCRfN4Mmeik
 poAJuAknavLPiFMmDfsRww9xDRhxFvcwFHCWD8zhePvzS/G06iVtD2ecBdcqGitl5zEdxnJsX
 qlfbRVFDQwT8ELlP48UF9ZSqLLLoQ20mGKz0R6UUK9tLtpZ4q3OAgRP8zV7xsRtWgECXihbck
 Utmui3mFcy8LqfmqN/+gKUPLsIndjyhh/C0TipySIYr0cgW8ez4pGq9FghILxOr2xkHGfADQG
 ADzucpld6wcm81cv207PeJRm7jWG/YB3oUbNy4GkMHa9ML2Sr8PUjNcHFjajx+YarOBZ0oD4U
 DJJG0KGqjQ==
X-Spam-Status: No, score=-101.3 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Mon, 08 Mar 2021 20:52:41 -0000

On Mar  9 00:48, Takashi Yano via Cygwin-patches wrote:
> On Mon, 8 Mar 2021 16:32:16 +0100
> Corinna Vinschen wrote:
> > Hi Takashi,
> > 
> > On Mar  8 23:55, Takashi Yano via Cygwin-patches wrote:
> > > - Currently, transfer input is triggered even if the stdin of native
> > >   app is not a pseudo console. With this patch it is triggered only
> > >   if the stdin is a pseudo console.
> > 
> > do you have more patches in the loop?  I wonder if I should really start
> > the test release cycle for 3.2.0 or if I should wait a bit...?
> 
> I'm sorry to submit patches one after another. However,
> I think this should be the last one. Please go ahead.

Great, thanks!


Corinna
