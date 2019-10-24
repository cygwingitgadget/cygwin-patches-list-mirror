Return-Path: <cygwin-patches-return-9792-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 67801 invoked by alias); 24 Oct 2019 01:01:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 67792 invoked by uid 89); 24 Oct 2019 01:01:31 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-1.9 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=Administrators, cygwin-patches, cygwinpatches, H*r:authenticated
X-HELO: conssluserg-02.nifty.com
Received: from conssluserg-02.nifty.com (HELO conssluserg-02.nifty.com) (210.131.2.81) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 24 Oct 2019 01:01:29 +0000
Received: from Express5800-S70 (ntsitm355024.sitm.nt.ngn.ppp.infoweb.ne.jp [175.184.70.24]) (authenticated)	by conssluserg-02.nifty.com with ESMTP id x9O11HAL024130	for <cygwin-patches@cygwin.com>; Thu, 24 Oct 2019 10:01:17 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x9O11HAL024130
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1571878877;	bh=oEYuTQ3mUohkCOym8KzaRWXVuy1xFafSUWw73JPiyUQ=;	h=Date:From:To:Subject:In-Reply-To:References:From;	b=VeL0cBhQlllIw7bNXr3ca6epjk+z9bT3CCM2HHw3IXMxyABUJruQGvV5jz35oZi5Q	 xCeKo3BPBctP4VeegtbVbjGPaE9HcOjOfswJzkBwlapZckXXf0Mj3sL7KbZPWKmm9/	 ng9BH740BnS157sz5OkmUYrPUkC11xOPgE+AsA1Zgjf4Q/SgAbti2lhK5HJVF4bF84	 LGxldSeNJF+xkSx4ze1yf1XyY0N0mYj8DLKqmE0y0wvzGUSE0fozZBqhVUSSocwQf5	 yTPw8tvruAZJT2T2RMoGMLz6piJlNSlyaCJtIgBn3K4ZjXWcXcXTL61xcyrql/G7QR	 qCH6Di1U5pG8Q==
Date: Thu, 24 Oct 2019 01:01:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Disable clear screen for ssh sessions with -t option.
Message-Id: <20191024100130.4c7f6e4ac55c10143e3c86f6@nifty.ne.jp>
In-Reply-To: <20191023120542.GA16240@calimero.vinschen.de>
References: <20191018143306.GG16240@calimero.vinschen.de>	<20191019085051.4d2cc80811854d21b193fed6@nifty.ne.jp>	<20191021094356.GI16240@calimero.vinschen.de>	<20191022090930.b312514dcf8495c1db4bb461@nifty.ne.jp>	<20191022065506.GL16240@calimero.vinschen.de>	<20191022162316.54c3bc2ff19dbc7ae1bdedf2@nifty.ne.jp>	<20191022080242.GN16240@calimero.vinschen.de>	<20191022182405.0ce3d7c17b0e7d924430b89c@nifty.ne.jp>	<20191022134048.GP16240@calimero.vinschen.de>	<20191023122717.66d241bd0a7814b7216d78f5@nifty.ne.jp>	<20191023120542.GA16240@calimero.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00063.txt.bz2

Hi Corinna,

On Wed, 23 Oct 2019 14:05:42 +0200
Corinna Vinschen wrote:
> In my limited testing it seems to work nicely.

Isn't the screen contents before opening pty cleared when cmd.exe is
executed?

Also Michael's test case probably does not work.
https://www.cygwin.com/ml/cygwin-patches/2019-q4/msg00054.html

> > +static bool
> > +is_running_as_service (void)
> 
> This function should probably use check_token_membership(PSID).
> I'm also not quite sure if checking for mandatory_system_integrity_sid
> makes sense.  Are there examples where the service SID is missing
> but the integrity is set to system integrity level?

If sshd or inetd is executed as cyg_server, S-1-5-6 (Service) is set.
However, when they are executed as Local System Account, only SIDs
set are as follows.

S-1-5-32-544 (Administrators)
S-1-1-0 (Everyone)
S-1-5-11 (Authenticated Users)
S-1-16-16384 (Mandatory System Integrity)

In this case, S-1-16-16384 does not have SE_GROUP_ENABLED flag, so
check_token_membership() can not be used.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
