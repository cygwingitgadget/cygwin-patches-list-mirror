Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 by sourceware.org (Postfix) with ESMTPS id BC4F73857C5F
 for <cygwin-patches@cygwin.com>; Wed, 24 Mar 2021 10:52:31 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org BC4F73857C5F
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MybbH-1lb1ZA0xvZ-00yxfW; Wed, 24 Mar 2021 11:52:29 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 79479A80D4B; Wed, 24 Mar 2021 11:52:28 +0100 (CET)
Date: Wed, 24 Mar 2021 11:52:28 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Marco Atzeri <marco.atzeri@gmail.com>
Cc: cygwin-patches@cygwin.com, Jan Nijtmans <jan.nijtmans@gmail.com>
Subject: Re: [PATCH 0/2] Return appropriate handle by _get_osfhandle() and
 GetStdHandle().
Message-ID: <YFsZ7AwlJQUnWGTG@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Marco Atzeri <marco.atzeri@gmail.com>,
 cygwin-patches@cygwin.com, Jan Nijtmans <jan.nijtmans@gmail.com>
References: <20210321040126.1720-1-takashi.yano@nifty.ne.jp>
 <20210321174427.cf79e39deeea896583caa48c@nifty.ne.jp>
 <20210322080738.6841d7f2a1e09290a929ad90@nifty.ne.jp>
 <YFiC6FXrnGeW8v1M@calimero.vinschen.de>
 <58c7be6c-42db-cc09-9f89-461ac7c87747@cornell.edu>
 <YFm+fEONY3wLq3Sp@calimero.vinschen.de>
 <78ac1b6e-c933-8b3a-9603-14d031f38b64@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <78ac1b6e-c933-8b3a-9603-14d031f38b64@gmail.com>
X-Provags-ID: V03:K1:JOlwYtUG0C3Nt00IPuOBQ7mtV6mjk/kmxMCAzHEWlhblPXCEwkZ
 5oXbgM0CY9ht5uk1hUEezg/meKKPfo4HVbvbmjMxmsVM3hQ7X1LlmxjjQ89Lk2xr6zy0wi/
 Ocs7XyLLJ0OOrMEaKWMdj4MU6Q7pRVmXoFWcRANzjcmeXFc4osUGNtJumhlOly9h5YABBW2
 iDaurE/CUYgwVYK4sk7oA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:216uAbW8MBc=:+C64B2HI/elBiJgiogVHjL
 ++hPV/9fWqS/fgc7AtdGJBqtdmXT7tL8gJsKhEK1GWOCG0oXccXbhIFfjCK7hidj2QSLQKBJD
 /KBbPjrYpHcHX/CD5QURzYH4Tg+U/3gqZmfToJF5fVikXDjTVFoG7Mnym9252yKHyrWMu9lhI
 8IwZJDSl8yWuk+BxCgWK4T1Sxm09T/FN9XbpCoaUuWKTam3JboCzW7nmtv1YInUw2HZ04hXoi
 S7Qpc4JD287tgMNo82s+GfEaRGeMVZxjBfLPOVpX7bzm6XxUG7BeGSPb+xLuaFLbDfv4eb9zy
 9ZsApYne4Q3BvvMqxXUEr4A5cOxfvjkzy1O7BXIh2zwW9Pb6gmyw/nESk3DMZNrjgriDxEwAZ
 I9Xi/o1l3yQD1Yd0UqFfyfMbFzGG/lAgKRMmKYhYmF4AUo8qsymR/xwZxBGj9R5f6TSwDPUfI
 sDslWKlxeNF2ujpP6fqI6x/7QXV7hwsTu4p7hB0HhsZW+rcIRrgu
X-Spam-Status: No, score=-101.2 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Wed, 24 Mar 2021 10:52:33 -0000

On Mar 24 11:43, Marco Atzeri wrote:
> On 23.03.2021 11:10, Corinna Vinschen wrote:
> > [CC Marco, CC Jan]
> > 
> > 
> > > Out of curiosity, I took a quick glance at the cmake code.  It appears that
> > > this code is designed to support running cmake in a Console.  I don't think
> > > that should be needed any more, if it ever was.
> > > [...]
> > > I think the following might suffice (untested):
> > > 
> > > --- a/Source/kwsys/Terminal.c
> > > +++ b/Source/kwsys/Terminal.c
> > > @@ -10,7 +10,7 @@
> > >   #endif
> > > 
> > >   /* Configure support for this platform.  */
> > > -#if defined(_WIN32) || defined(__CYGWIN__)
> > > +#if defined(_WIN32)
> > >   #  define KWSYS_TERMINAL_SUPPORT_CONSOLE
> > >   #endif
> > >   #if !defined(_WIN32)
> 
> noted.
> cmake was always annoying, we remove this type of define and they add
> somewhere else
> 
> 
> > Looks right to me.  If we patch cmake to do the right thing, do we still
> > need this patch, Takashi?
> > 
> > 
> > Thanks,
> > Corinna
> 
> Regards
> Marco

Thanks, Marco!


Corinna
