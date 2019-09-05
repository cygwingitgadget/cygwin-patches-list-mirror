Return-Path: <cygwin-patches-return-9635-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15364 invoked by alias); 5 Sep 2019 10:13:16 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 15345 invoked by uid 89); 5 Sep 2019 10:13:16 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-6.8 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*f:sk:596d7a1, H*i:sk:596d7a1, screen
X-HELO: conssluserg-06.nifty.com
Received: from conssluserg-06.nifty.com (HELO conssluserg-06.nifty.com) (210.131.2.91) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 05 Sep 2019 10:13:14 +0000
Received: from Express5800-S70 (ntsitm268057.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.110.57]) (authenticated)	by conssluserg-06.nifty.com with ESMTP id x85ACv8J014551;	Thu, 5 Sep 2019 19:12:57 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x85ACv8J014551
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1567678378;	bh=IE1pt21xbf73tkt2OixdfUPpt9385VloU+Y3KpS+UM8=;	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;	b=p+SbOO2VNqjpX6k1PLhH1D6nfbliYVKOENFPuyvRJ+2brJ1+c3FcKBPVWWR1zdUuN	 HVIW+UlweBUxzl99OS4/XUgl8kAtCxzwUpUHc+ZPM1TiTAazwVsTMOTDukCIjMMSrQ	 QTaBB5AjzlsQcrS+vm/NrCmKf2jtUX7Ft2yIacE7R8FT2dFNgs3bcTLg9Ktx98YFUU	 jKyw95lqREkVDTD5gKn8PmVURUHTB8/MTXEg7ECPyD3lCzeOWpz7VRrh1Z+e4fcqM+	 tP3QEERGQJvOvz4W0l9YZrfrGkM4qDzehKD9NM7Y0/zHlvJyAUCwU9U4CDmkYmy5M0	 S1dPn7odjlXbw==
Date: Thu, 05 Sep 2019 10:13:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Brian.Inglis@SystematicSw.ab.ca
Subject: Re: [PATCH 2/2] Cygwin: pty: Disable clear screen on new pty if TERM=dumb or emacs*.
Message-Id: <20190905191304.348eedbec3fcd540486a4bc6@nifty.ne.jp>
In-Reply-To: <596d7a19-020d-3055-45e9-eba604b809ba@SystematicSw.ab.ca>
References: <20190904014618.1372-1-takashi.yano@nifty.ne.jp>	<20190904014618.1372-3-takashi.yano@nifty.ne.jp>	<e8c3b43a-7988-bb2c-a52b-dc792677dd96@SystematicSw.ab.ca>	<20190904123431.59ac7a667f91e3cb65f2a9a9@nifty.ne.jp>	<20190904124551.c1aa5b7a15689d384d95356a@nifty.ne.jp>	<73eb5cad-600d-8191-0d8b-241b3e47bd56@SystematicSw.ab.ca>	<20190905101333.c5cc6920cc3f67d7c625df31@nifty.ne.jp>	<596d7a19-020d-3055-45e9-eba604b809ba@SystematicSw.ab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00155.txt.bz2

On Wed, 4 Sep 2019 21:36:28 -0600
Brian Inglis wrote:
> So how do you tell the pseudo-console to generate only text not escape sequences
> the recipient may not be prepared to deal with?

Unfortunately, no idea.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
