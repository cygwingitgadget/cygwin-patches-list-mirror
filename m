Return-Path: <cygwin-patches-return-9624-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 112271 invoked by alias); 4 Sep 2019 14:42:29 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 112262 invoked by uid 89); 4 Sep 2019 14:42:29 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-6.8 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=my, screen
X-HELO: conssluserg-05.nifty.com
Received: from conssluserg-05.nifty.com (HELO conssluserg-05.nifty.com) (210.131.2.90) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 04 Sep 2019 14:42:27 +0000
Received: from Express5800-S70 (ntsitm268057.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.110.57]) (authenticated)	by conssluserg-05.nifty.com with ESMTP id x84EgC6N025211	for <cygwin-patches@cygwin.com>; Wed, 4 Sep 2019 23:42:12 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x84EgC6N025211
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1567608132;	bh=8puDhVBbDgYtyaE0PlXFP2G7fKOdipAsVjABJWZBu8k=;	h=Date:From:To:Subject:In-Reply-To:References:From;	b=KucKJ6DSw6nvLoNc82YWj2WIk6jQM09tFQPTPoDUtQAbOG4khZd/Hti8WYm92Wbqk	 UHU8JkkUlqPD4dJ5HBwkVuG0vxPIgf6PSwc8GrdeTllSyjOcEpKmuatwWHsA3AGr/b	 yoxjCksCaDEE14ilrkwMltowy4P8IFvQF8AULoJGtye10ADcNuRgYonWUqxOeU6spN	 O+CNnUtl7S4U9Ygc+Ou/S60T6uN63T/ZsGQPM1QC8uXI5/epmF6WqHbT7lJKUHPkoE	 7hCiyRpenIwo1LI92JGuutzkDDk5gCrrOgWBhbTc79SjLg3S7d9pvDnZxed6NJbbE0	 iiya1Pufaz63g==
Date: Wed, 04 Sep 2019 14:42:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 2/2] Cygwin: pty: Disable clear screen on new pty if TERM=dumb or emacs*.
Message-Id: <20190904234222.4c8bfbb31d9a899eb2670082@nifty.ne.jp>
In-Reply-To: <20190904135503.GS4164@calimero.vinschen.de>
References: <20190904014618.1372-1-takashi.yano@nifty.ne.jp>	<20190904014618.1372-3-takashi.yano@nifty.ne.jp>	<20190904104738.GP4164@calimero.vinschen.de>	<20190904214953.50fc84221ea7508475c80859@nifty.ne.jp>	<20190904135503.GS4164@calimero.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00144.txt.bz2

On Wed, 4 Sep 2019 15:55:03 +0200
Corinna Vinschen wrote:
> The code in fixup_after_attach() is the only code snippet setting
> need_clear_screen = true.  And that code also requires term != "dump" &&
> term == "*emacs*" to set need_clear_screen.

term != "*emacs*"

> The code in reset_switch_to_pcon() requires that the need_clear_screen
> flag is true regardless of checking TERM.  So this code depends on the
> successful TERM check from fixup_after_attach anyway.
> 
> What am I missing?

Two checking results may not be the same. Indeed, emacs changes
TERM between two checks.

fixup_after_attach() is called from fixup_after_exec(),
which is called before executing the program code.
reset_switch_to_pcon () is mainly called from PTY slave I/O functions.
This is usually from the program code.

The behaviour of the patch is as follows.

First check : True  True  False False
Second check: True  False True  False
Clear screen: Yes   No    No   No

# True: neither dumb nor emacs*
#  False: either dumb or emacs*


> +             if (get_ttyp ()->num_pcon_attached_slaves == 0 &&
> +                 term && strcmp (term, "dumb") &&
> +          	  term && !strstr (term, "emacs") &&
> +                 !ALWAYS_USE_PCON)
> 
> You're checking term for != NULL twice.

Oh my!

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
