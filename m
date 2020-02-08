Return-Path: <cygwin-patches-return-10044-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 113153 invoked by alias); 8 Feb 2020 14:53:22 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 113128 invoked by uid 89); 8 Feb 2020 14:53:22 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-5.1 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: conssluserg-04.nifty.com
Received: from conssluserg-04.nifty.com (HELO conssluserg-04.nifty.com) (210.131.2.83) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 08 Feb 2020 14:53:20 +0000
Received: from Express5800-S70 (ntsitm196171.sitm.nt.ngn.ppp.infoweb.ne.jp [125.0.207.171]) (authenticated)	by conssluserg-04.nifty.com with ESMTP id 018Er0g9006580	for <cygwin-patches@cygwin.com>; Sat, 8 Feb 2020 23:53:01 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 018Er0g9006580
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1581173581;	bh=m7Z5J2XeDUXBVh+NMmhsVR/UGnpM5yb9vjX/oATQF/U=;	h=Date:From:To:Subject:In-Reply-To:References:From;	b=UHNH4lNm9v6kFR7Op3erpxkYtiQBhklg0vs8YIxFOlp3oNhft5PlXYwo4FY2iFoGE	 VMHrlFwHL3C+9n+M4LLDu4hr7ZbvMhupgvnYytZ9jHTuPxzvNrxedIjz3irYFclnHI	 NFzWLv5qQmhguUEEx+hKcHw2J3fNCGDV1X76LSXj/8yQaAd0puGej+X0ZvjPHjYwkH	 fL91fEc4uy7Mqorn7T1xv5O9vGFH2xccxdSlxB8QyQ/tHILgAacYpYSkLcx4enlmx4	 3tFjUK2Dm2XROhyravWaqDRbpQlQYWup6ibw08bP+ojoUTCgAGs4QAqUa3lVSm5kLb	 2HmS1I1xg27+w==
Date: Sat, 08 Feb 2020 14:53:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Use pinfo() rather than kill() with signal 0.
Message-Id: <20200208235311.bda313987c047dc8bf69ed2e@nifty.ne.jp>
In-Reply-To: <20200206190330.GT3403@calimero.vinschen.de>
References: <20200206104817.1116-1-takashi.yano@nifty.ne.jp>	<20200206190330.GT3403@calimero.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00150.txt

On Thu, 6 Feb 2020 20:03:30 +0100
Corinna Vinschen wrote:
> I'm inclined to release 3.1.3 next week.  Is that ok with you or
> do you anticipate more patches which should go into 3.1.3?

Currently, I have two patches which are under test. I would be
happy if these could be included in 3.1.3. I am planning to
divide one of them into several patches. I will submit these
patches in a few days.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
