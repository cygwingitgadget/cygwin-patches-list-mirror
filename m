Return-Path: <cygwin-patches-return-10137-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 114524 invoked by alias); 28 Feb 2020 02:14:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 114515 invoked by uid 89); 28 Feb 2020 02:14:22 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-6.4 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: conssluserg-04.nifty.com
Received: from conssluserg-04.nifty.com (HELO conssluserg-04.nifty.com) (210.131.2.83) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 28 Feb 2020 02:14:18 +0000
Received: from Express5800-S70 (ntsitm196171.sitm.nt.ngn.ppp.infoweb.ne.jp [125.0.207.171]) (authenticated)	by conssluserg-04.nifty.com with ESMTP id 01S2E4L1016405	for <cygwin-patches@cygwin.com>; Fri, 28 Feb 2020 11:14:04 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 01S2E4L1016405
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1582856044;	bh=ReBHmsqHbkAWBi3hymRcEtE/qnIpwb39BRpXYq+jLGM=;	h=Date:From:To:Subject:In-Reply-To:References:From;	b=XaYG7rfgU4RCMs+ir84ZqU9UBosOVu3IpLow6AcY9MR9YLW0QylfxHokK2d+cdMWv	 110FZdFDtv1sMGue4oi1F42aQnsddaIIjSUbkoxedaqOePI1aiPqgq1CaADldV4CmZ	 J2eRQulBGAKwnrd/K1hvsPqzEOPwQYavMKKdVkWq1R7KF8G2VJ30aualM0bozpP2MD	 KE6EHh70Z4UCA6JYkQVBIkJUxl2xmuAR+Ogv6X3F7Uk/Y6sGr1viVvUhWoXjzEGx23	 7Z0J+7s3KURung98ud7g1QtRFgXN+LqsWm2KlHvYy1aKlAa+rgjYmFxipKkTpW9/Ci	 MjupdseoBp8zA==
Date: Fri, 28 Feb 2020 02:14:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 1/4] Cygwin: console: Add workaround for broken IL/DL in xterm mode.
Message-Id: <20200228111409.149929dcf710cabf99a879b3@nifty.ne.jp>
In-Reply-To: <05cca441-eb83-4600-90f3-bf82ec7a0190@dronecode.org.uk>
References: <20200226153302.584-1-takashi.yano@nifty.ne.jp>	<20200226153302.584-2-takashi.yano@nifty.ne.jp>	<05cca441-eb83-4600-90f3-bf82ec7a0190@dronecode.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00243.txt

On Thu, 27 Feb 2020 18:03:47 +0000
Jon Turney wrote:
> > +#define wpbuf_put(x) \
> > +  wpbuf[wpixput++] = x; \
> > +  if (wpixput > WPBUF_LEN) \
> > +    wpixput--;
> > +
> 
> So I think either the macro need it contents contained by a 'do { ... } 
> while(0)',  or that instance of it needs to be surrounded by braces, to 
> do what you intend.

Thanks for the advice. Fortunately, "if" statement does not
cause a problem even if it is accidentally executed outside
"else" block in this case.

Hans,
as for making a patch for this issue, may I leave it to you
because you are already working on it? 

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
