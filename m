Return-Path: <cygwin-patches-return-9806-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 113012 invoked by alias); 6 Nov 2019 15:13:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 113000 invoked by uid 89); 6 Nov 2019 15:13:53 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-3.6 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=D*jp
X-HELO: conssluserg-01.nifty.com
Received: from conssluserg-01.nifty.com (HELO conssluserg-01.nifty.com) (210.131.2.80) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 06 Nov 2019 15:13:50 +0000
Received: from Express5800-S70 (ntsitm355024.sitm.nt.ngn.ppp.infoweb.ne.jp [175.184.70.24]) (authenticated)	by conssluserg-01.nifty.com with ESMTP id xA6FDd3t026441	for <cygwin-patches@cygwin.com>; Thu, 7 Nov 2019 00:13:39 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com xA6FDd3t026441
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1573053219;	bh=/Xtt1UIUA7AuFHzScFXZVA1b+Cxuj1RrALCvUKbPqQo=;	h=Date:From:To:Subject:In-Reply-To:References:From;	b=aw8y3/cdSDI1KCXJ6kohHuMV50YMubWHmXVFVKB8CUJ6yoHGFssphRzjoDU7cTGa6	 wnR4cRe0VJHF9GL5otmiBDkZ04kXzZ9maie/qWESDsPA7IXgBtvalcoeThrSSA2Nbv	 jZGmXegIR1pLP6YU8F7KqvGg2JHLsMqnfxjcK0E+AmYvW4hEgimVSMXxGH0ckFePXJ	 wl35BKR/XbdDuYdj0b0HZGhyJLuYmc2gO86ON3dqzfT3S0LJ14ypvUfl5VW1Wpj+uB	 IjsOaCiFoApWsjglQOMUIxozLHdQTapebBFfdZ8qA19Nl2NlvOKi89RYlQFdpexuly	 M2S88Z+41xaxw==
Date: Wed, 06 Nov 2019 15:13:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console, pty: Prevent error in legacy console mode.
Message-Id: <20191107001340.dafd73695159626807f51cfe@nifty.ne.jp>
In-Reply-To: <20191106140547.GU3372@calimero.vinschen.de>
References: <20191106115909.429-1-takashi.yano@nifty.ne.jp>	<20191106140547.GU3372@calimero.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00077.txt.bz2

Hi Corinna,

On Wed, 6 Nov 2019 15:05:47 +0100
Corinna Vinschen wrote:
> the patch is fine in general.  Still, what I really like to see is a
> descriptive log message, as well as a matching comment...
> 
> On Nov  6 20:59, Takashi Yano wrote:
> > @@ -3131,6 +3134,16 @@ fhandler_pty_master::setup_pseudoconsole ()
> >        if (res != S_OK)
> >  	system_printf ("CreatePseudoConsole() failed. %08x\n",
> >  		       GetLastError ());
> > +      error = true;
> > +    }
> > +
> 
> ...here, to explain briefly why this check is done.
> 
> > +  reg_key reg (HKEY_CURRENT_USER, KEY_READ, L"Console", NULL);
> > +  if (reg.error ())
> > +    error = true;
> > +  if (reg.get_dword (L"ForceV2", 1) == 0)
> > +    error = true;
> > +  if (error)
> > +    {
> >        CloseHandle (from_master);
> >        CloseHandle (to_slave);
> >        from_master = from_master_cyg;

I will submit revised version as v2 patch.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
