Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com
 [210.131.2.91])
 by sourceware.org (Postfix) with ESMTPS id 300D9385800C
 for <cygwin-patches@cygwin.com>; Fri, 19 Nov 2021 17:15:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 300D9385800C
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from Express5800-S70 (z221123.dynamic.ppp.asahi-net.or.jp
 [110.4.221.123]) (authenticated)
 by conssluserg-06.nifty.com with ESMTP id 1AJHEl4F025063
 for <cygwin-patches@cygwin.com>; Sat, 20 Nov 2021 02:14:47 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 1AJHEl4F025063
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1637342087;
 bh=xXhe5nmfn73UyXSyo95ZqFKMrEyPe53hIL0784v3rNw=;
 h=Date:From:To:Subject:In-Reply-To:References:From;
 b=ax+iCuHPmpDQrrm4ZL9h98mZIszwMGFspPZyzg9n8ehxdJ/XGjfj9t3fX4yNhjgT7
 2KLLrOImk6I5sICC7OmEGInL3vdqM1/LKYmRXDPriVrwZtZxCFlylbsN+nnkbv4jT9
 AxJhvZGZD8gjR3WZeovXmkZztwlqjAwjU1dUPl00dxDISh+nVNm9vrFKvx86xIWFH6
 8NKH3G4IRxvRlAtd10+dedLEs4Q3Q7jyEmKqMcOD3gwNgWY5KSMVg61UDg1/Mp/1Dv
 wU7n/NTuEnOPHzl8WKvsc25p+gCZH2WB0pa2BQQvXcpnKMzL6MFcQZMxe7yAPyMtX3
 r26L8q08dtt/g==
X-Nifty-SrcIP: [110.4.221.123]
Date: Sat, 20 Nov 2021 02:14:52 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: sigproc: Do not send signal to myself if exiting.
Message-Id: <20211120021452.c72956bba50a03d33c43d454@nifty.ne.jp>
In-Reply-To: <YZfIlfu+1Lw3OZIl@calimero.vinschen.de>
References: <20211119115043.356-1-takashi.yano@nifty.ne.jp>
 <YZfH6jj7AqbpSTn2@calimero.vinschen.de>
 <YZfIlfu+1Lw3OZIl@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.2 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, NICE_REPLY_A,
 RCVD_IN_DNSWL_NONE, SPF_HELO_NONE, SPF_PASS,
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
X-List-Received-Date: Fri, 19 Nov 2021 17:15:24 -0000

On Fri, 19 Nov 2021 16:53:57 +0100
Corinna Vinschen wrote:
> On Nov 19 16:51, Corinna Vinschen wrote:
> > Hi Takashi,
> > 
> > On Nov 19 20:50, Takashi Yano wrote:
> > > - This patch fixes the issue that process sometimes hangs for 60
> > >   seconds with the following scenario.
> > >     1) Open command prompt.
> > >     2) Run "c:\cygwin64\bin\bash -l"
> > >     3) Compipe the following source with mingw compiler.
> > >        /*--- Begin ---*/
> > >        #include <stdio.h>
> > >        int main() {return getchar();}
> > >        /*---- End ----*/
> > >     3) Run "tcsh -c ./a.exe"
> > >     4) Hit Ctrl-C.
> > > ---
> > >  winsup/cygwin/sigproc.cc | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
> > > index 97211edcf..9160dd160 100644
> > > --- a/winsup/cygwin/sigproc.cc
> > > +++ b/winsup/cygwin/sigproc.cc
> > > @@ -603,6 +603,10 @@ sig_send (_pinfo *p, siginfo_t& si, _cygtls *tls)
> > >        its_me = false;
> > >      }
> > >  
> > > +  /* Do not send signal to myself if exiting. */
> > > +  if (its_me && exit_state > ES_EXIT_STARTING && si.si_signo > 0)
> > > +    goto out;
> > > +
> > >    if (its_me)
> > >      sendsig = my_sendsig;
> > >    else
> > > -- 
> > > 2.33.0
> > 
> > Isn't that already handled in wait_sig?  What's the difference here?
> 
> ...and where exactly is it waiting 60 secs?

If sending signal to myself with exit_state > ES_EXIT_STARGING,
wait_for_completion in sig_send() is set to true. Therefore,
sig_send() waits for pack.wakeup event for WSSC (60000 msec) here:

  /* No need to wait for signal completion unless this was a signal to
     this process.

     If it was a signal to this process, wait for a dispatched signal.
     Otherwise just wait for the wait_sig to signal that it has finished
     processing the signal.  */
  if (wait_for_completion)
    {
      sigproc_printf ("Waiting for pack.wakeup %p", pack.wakeup);
      rc = WaitForSingleObject (pack.wakeup, WSSC);
      ForceCloseHandle (pack.wakeup);
    }

However, thread wait_sig ignores the signal here:
      /* Don't process signals when we start exiting */
      if (exit_state > ES_EXIT_STARTING && pack.si.si_signo > 0)
        continue;
and does not call SetEvent (pack.wakeup).

As a result, sig_send() hangs for 60 secs.

With this patch, sig_send() does not send signal which will
be ignored in wait_sig().

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
