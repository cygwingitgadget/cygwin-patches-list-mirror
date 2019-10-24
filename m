Return-Path: <cygwin-patches-return-9794-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 66437 invoked by alias); 24 Oct 2019 10:17:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 66142 invoked by uid 89); 24 Oct 2019 10:17:35 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-1.9 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=disappears, screen
X-HELO: conssluserg-05.nifty.com
Received: from conssluserg-05.nifty.com (HELO conssluserg-05.nifty.com) (210.131.2.90) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 24 Oct 2019 10:17:34 +0000
Received: from Express5800-S70 (ntsitm355024.sitm.nt.ngn.ppp.infoweb.ne.jp [175.184.70.24]) (authenticated)	by conssluserg-05.nifty.com with ESMTP id x9OAHLc4024585	for <cygwin-patches@cygwin.com>; Thu, 24 Oct 2019 19:17:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x9OAHLc4024585
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1571912242;	bh=fnKKK5eS8TwU/nZ6RtpBpRxlU9HOGjfi3yn3yHNV3K4=;	h=Date:From:To:Subject:In-Reply-To:References:From;	b=tuVF241S01NO8u58qaVpEnkRrUGqiPy+Qhkn/IRdcrdjGKltxma9jvrUoayBQOqDH	 j9SPRfUk66WTEa9/+tsrF2CFBZvbfsiRLsEc+BFMXVpCIHYqR7SQgmzuh2PFMW+++I	 NjjHPO3j0NSf2dvETShB5QJl0e5mObYK0fNw8TzVbJPCIRkZByOGiujBb4kpL8vaEt	 TbXdREQyLQdAdFehtouq4zag4A57her4QL2SSU08x60Qif2ny3qzvFUp3LAyEmnvA2	 ImxxAZPwcW9KFmCUxd8NBXkkh3A+FYivtzpeEwZbTWXQbwSphBYjPS1/YUw0z7cUXt	 Fu+Se3jR19cwA==
Date: Thu, 24 Oct 2019 10:17:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Disable clear screen for ssh sessions with -t option.
Message-Id: <20191024191724.f44a44745f16f78595ae1b43@nifty.ne.jp>
In-Reply-To: <20191024093817.GD16240@calimero.vinschen.de>
References: <20191021094356.GI16240@calimero.vinschen.de>	<20191022090930.b312514dcf8495c1db4bb461@nifty.ne.jp>	<20191022065506.GL16240@calimero.vinschen.de>	<20191022162316.54c3bc2ff19dbc7ae1bdedf2@nifty.ne.jp>	<20191022080242.GN16240@calimero.vinschen.de>	<20191022182405.0ce3d7c17b0e7d924430b89c@nifty.ne.jp>	<20191022134048.GP16240@calimero.vinschen.de>	<20191023122717.66d241bd0a7814b7216d78f5@nifty.ne.jp>	<20191023120542.GA16240@calimero.vinschen.de>	<20191024100130.4c7f6e4ac55c10143e3c86f6@nifty.ne.jp>	<20191024093817.GD16240@calimero.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00065.txt.bz2

On Thu, 24 Oct 2019 11:38:17 +0200
Corinna Vinschen wrote:
> Well, what I see when starting cmd.exe with this patch is a short
> flicker in the existing output in mintty, but the cursor position
> stays the same. and cmd.exe output is where you'd expect it.

I mean:
1) start mintty
2) ps
3) script
4) cmd

In my environment, output of ps command disappears.

> If it's running as Local System (actually SYSTEM), it should have
> the user SID S-1-5-18.  You can just check this with
> 
>   cygheap->user.saved_sid () == well_known_system_sid

Thanks for the advice. Now I have confirmed the following code
works as expected.

inline static bool
is_running_as_service (void)
{
  return check_token_membership (well_known_service_sid)
    || RtlEqualSid (well_known_system_sid, cygheap->user.saved_sid ());
}

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
