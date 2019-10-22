Return-Path: <cygwin-patches-return-9778-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8962 invoked by alias); 22 Oct 2019 07:23:21 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 8947 invoked by uid 89); 22 Oct 2019 07:23:21 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-1.9 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=screen
X-HELO: conssluserg-01.nifty.com
Received: from conssluserg-01.nifty.com (HELO conssluserg-01.nifty.com) (210.131.2.80) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 22 Oct 2019 07:23:19 +0000
Received: from Express5800-S70 (ntsitm355024.sitm.nt.ngn.ppp.infoweb.ne.jp [175.184.70.24]) (authenticated)	by conssluserg-01.nifty.com with ESMTP id x9M7NBqI030788	for <cygwin-patches@cygwin.com>; Tue, 22 Oct 2019 16:23:11 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x9M7NBqI030788
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1571728991;	bh=bol76GXJJNiMtQFfae9JbvMM0eHbKuMfM3G1SfmRBYw=;	h=Date:From:To:Subject:In-Reply-To:References:From;	b=NCFTyS8QennP/lPhtVCtw09POjTBXDK8iuGoDoG92HxSB17hN9O02cYBl/GVM2j1u	 VeDZ0p+7N/C3gDff8XfjLV3iag0y6Sy1IYQnpYp+dBWZimZ8RBYcL+JnndUxuIVIkx	 X2PJFUoNog86J6EtgIXpqKGl3c3b6UGmKIzi8+wpCc/l47rrkP65hXUTyJ/nDHEPfk	 PTyZQHdiz23zuLs3Ec1OA3ImOChQYNFucqfcGYUACQc8aQDA6nPM6CjtV9JvyjQPAz	 IJnOXUlkyR8tVbHmQn5LrncgHWIDl3iUQUZADVE9w5vxoNg9+znvBAMSBGq5AGGJwt	 wZCQqis3SRG3g==
Date: Tue, 22 Oct 2019 07:23:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Disable clear screen for ssh sessions with -t option.
Message-Id: <20191022162316.54c3bc2ff19dbc7ae1bdedf2@nifty.ne.jp>
In-Reply-To: <20191022065506.GL16240@calimero.vinschen.de>
References: <20191018113721.2486-1-takashi.yano@nifty.ne.jp>	<20191018143306.GG16240@calimero.vinschen.de>	<20191019085051.4d2cc80811854d21b193fed6@nifty.ne.jp>	<20191021094356.GI16240@calimero.vinschen.de>	<20191022090930.b312514dcf8495c1db4bb461@nifty.ne.jp>	<20191022065506.GL16240@calimero.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00049.txt.bz2

On Tue, 22 Oct 2019 08:55:06 +0200
Corinna Vinschen wrote:
> On Oct 22 09:09, Takashi Yano wrote:
> > I confirmed the dwSize has right screen size and dwCursorPosition
> > is (0,0) just after creating pty even though the cursor position
> > in real screen is not at top left.
> > 
> > Clearing screen fixes this mismatch.
> 
> And calling SetConsoleCursorPosition instead does not?

For SetConsoleCursorPosition, it is necessary to know the cursor
position of course. I cannot come up with any other way than
using ANSI escape sequence "ESC[6n". Do you think this is
feasible?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
