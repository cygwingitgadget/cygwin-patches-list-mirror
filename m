Return-Path: <cygwin-patches-return-9872-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 46950 invoked by alias); 21 Dec 2019 02:42:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 46938 invoked by uid 89); 21 Dec 2019 02:42:32 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-6.0 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=cygwin-patches, cygwinpatches, H*r:authenticated
X-HELO: conssluserg-02.nifty.com
Received: from conssluserg-02.nifty.com (HELO conssluserg-02.nifty.com) (210.131.2.81) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 21 Dec 2019 02:42:29 +0000
Received: from Express5800-S70 (ntsitm247158.sitm.nt.ngn.ppp.infoweb.ne.jp [124.27.253.158]) (authenticated)	by conssluserg-02.nifty.com with ESMTP id xBL2ffiv007206;	Sat, 21 Dec 2019 11:41:41 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com xBL2ffiv007206
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1576896101;	bh=Un+F5vCs1ekdbT3fQSvQP1HUG5QYfFKvMIN5xCVaq/U=;	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;	b=Qz3ULtLfo6+7iFibSNaMnZAFR6lpi3KagxRIJAAaGyQ9rPx8RRJnNBxP/b6WYPT+N	 JUaTVgIk9XRrcJSHCUbvBoN4gt0V6wNdVF3fzC2kO6h/qrejuU+6Zr2mDef9g6ZmTM	 2yLjvJ2ZRUmVe9ulX1ohCrhMiOSGfPi8gb6rv7zQMbwVZymOjWtsP24UYzAMazKUVb	 L7I2qhrLy+/dPb+3H3bXF0fBU4iGLHVpQt2vqLcRowtlIR5Qt/0okdCeUaKDeFVuf5	 +nT4KR99C49usyI30gUESIUSPp1Ga03l0JzTYR8p6hTAXtggsyZBpw27g15mc8TI4U	 Q8/p7C7ud3bqA==
Date: Sat, 21 Dec 2019 02:42:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: "Lavrentiev, Anton (NIH/NLM/NCBI) [C]" <lavr@ncbi.nlm.nih.gov>
Subject: Re: [PATCH] Cygwin: pty: Fix ESC[?3h and ESC[?3l handling again.
Message-Id: <20191221114151.d5e541a478606e7ef9b05d78@nifty.ne.jp>
In-Reply-To: <BN7PR09MB2739C6A79C748A5FD044D69EA5520@BN7PR09MB2739.namprd09.prod.outlook.com>
References: <20191219110330.1902-1-takashi.yano@nifty.ne.jp>	<20191219112924.GT10310@calimero.vinschen.de>	<BN7PR09MB2739C6A79C748A5FD044D69EA5520@BN7PR09MB2739.namprd09.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00143.txt.bz2

On Thu, 19 Dec 2019 15:50:07 +0000
"Lavrentiev, Anton (NIH/NLM/NCBI) [C] via cygwin-patches" wrote:
> Just noticed that in the patch below and couldn't help it, sorry..
> 
> Things like
> 
> char* p0;
> 
> and later:
> 
> isdigit(*p0))  or  isalpha(*p0)
> 
> are usually not a good (correct) way of coding, because of possible sign extension of *p0
> which you normally wouldn't want to have (remember the ctype calls/macros actually expect
> an "int", not a character, input).  So it should be either "unsigned char* p0" or
> "isdigit((unsigned char)(*p0))", generally.

Thanks for the advice. In general, you are right.

However, in cygwin, ALLOW_NEGATIVE_CTYPE_INDEX is defined
in ctype library in newlib, and the lookup table is extended
in the negative direction.

So, in terms of results, the code works as expected. 

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
