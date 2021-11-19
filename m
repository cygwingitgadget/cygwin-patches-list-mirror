Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 by sourceware.org (Postfix) with ESMTPS id 43BD9385800C
 for <cygwin-patches@cygwin.com>; Fri, 19 Nov 2021 15:53:59 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 43BD9385800C
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N8GEY-1makGE09aK-014GeN for <cygwin-patches@cygwin.com>; Fri, 19 Nov 2021
 16:53:58 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 997A9A80DA6; Fri, 19 Nov 2021 16:53:57 +0100 (CET)
Date: Fri, 19 Nov 2021 16:53:57 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: sigproc: Do not send signal to myself if exiting.
Message-ID: <YZfIlfu+1Lw3OZIl@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20211119115043.356-1-takashi.yano@nifty.ne.jp>
 <YZfH6jj7AqbpSTn2@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YZfH6jj7AqbpSTn2@calimero.vinschen.de>
X-Provags-ID: V03:K1:rZ8tVeeW8pJmQ+/eNUj63hnBAmEEq58C6PIx7zMBY/cJu90RpVS
 Lp53How3a12ZElwCSXN10xkhvjH3gDUJzxTVvQVZEW0F+CF/Crjn4GteUrnd2k8UbeRi5x2
 miORBezefxxkIVyEk24sulEBu3Q2Jpp6HOgJB0AUSkswYtxOaWj0SHTrfMNWC+Ve0RVWUXh
 DWsPj0M+ygWc1BgHwI1iQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:P50QOeA+qwQ=:CkkfgDkeAJtDoE5Ck/ZvW4
 kEzhQq3+22AFQ17UkUgiaK+HarQx0iQHbx+wrTWd7GBvRFBpD6VBmqORGFaZu++EvLDlZkLHM
 /EmB21ISYAB58B7QoI202+JKN35J7HSRra/RnLYCqy01n2b+4or9wB51tOwfDSfTz+y++mlRo
 HbnOU43ppkznlFVdsguxNQVTKE1vkQe83BlvC/JF4SXm7fbqs8nqPqy7PW5jb/dCuGS4f98Kt
 WdhjPA+t8QiCVcElvfkcVXhlD/7mFE2fa/979kl1cfukXPgROJPNWOWy9vMktqYO6TEbUqqa/
 A5cO7ZtXlnxL4OxZTFN3k6MLMSB4ijxgTTif0ijluphZ9ZhEvIsxDtjdlC2KTlwB4rJ7z2YXw
 MsH8esrHxEgqRzB/sWXV+VC5AWQg+XN7uuNEe+W3/zN0sghpBoErmF50RQ0Xj0oQsNeKy7zMa
 H9aTsg1idh2bkCi9jqBqwDTFWpxbLL8t8DC+XOKvS2n1dQ4pSzm4/MET4SnBO9aKWWMurywkg
 GM7rgKEcgd3XZDDPIy0jz3rxSLhA2V0hP8rXxXH9fWXEHPzxKeHtyYmcL9yphEygNBy+nPaRT
 TWF4YZtQSx7k4uKkMH3YY9XZH/sQffb2bN6NlLiqEjPcpTBKTZRs8qDdQiW1nisdGqIGmgucN
 kWXaLINkishfW4VsOzEn6QOxe/POPvzPDAB7bL3t4/AX73kxOda0kXrUNsFl0qrIn/HHQn99q
 5Q+Hz3EB7rWhoDEv
X-Spam-Status: No, score=-105.4 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H4, RCVD_IN_MSPIKE_WL, SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Fri, 19 Nov 2021 15:54:00 -0000

On Nov 19 16:51, Corinna Vinschen wrote:
> Hi Takashi,
> 
> On Nov 19 20:50, Takashi Yano wrote:
> > - This patch fixes the issue that process sometimes hangs for 60
> >   seconds with the following scenario.
> >     1) Open command prompt.
> >     2) Run "c:\cygwin64\bin\bash -l"
> >     3) Compipe the following source with mingw compiler.
> >        /*--- Begin ---*/
> >        #include <stdio.h>
> >        int main() {return getchar();}
> >        /*---- End ----*/
> >     3) Run "tcsh -c ./a.exe"
> >     4) Hit Ctrl-C.
> > ---
> >  winsup/cygwin/sigproc.cc | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
> > index 97211edcf..9160dd160 100644
> > --- a/winsup/cygwin/sigproc.cc
> > +++ b/winsup/cygwin/sigproc.cc
> > @@ -603,6 +603,10 @@ sig_send (_pinfo *p, siginfo_t& si, _cygtls *tls)
> >        its_me = false;
> >      }
> >  
> > +  /* Do not send signal to myself if exiting. */
> > +  if (its_me && exit_state > ES_EXIT_STARTING && si.si_signo > 0)
> > +    goto out;
> > +
> >    if (its_me)
> >      sendsig = my_sendsig;
> >    else
> > -- 
> > 2.33.0
> 
> Isn't that already handled in wait_sig?  What's the difference here?

...and where exactly is it waiting 60 secs?

> 
> 
> Thx,
> Corinna
