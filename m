Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com
 [210.131.2.81])
 by sourceware.org (Postfix) with ESMTPS id 09A6B38387D5
 for <cygwin-patches@cygwin.com>; Mon,  6 Jun 2022 23:22:02 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 09A6B38387D5
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from HP-Z230 (ak044095.dynamic.ppp.asahi-net.or.jp [119.150.44.95])
 (authenticated)
 by conssluserg-02.nifty.com with ESMTP id 256NLeLH018369
 for <cygwin-patches@cygwin.com>; Tue, 7 Jun 2022 08:21:40 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 256NLeLH018369
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1654557700;
 bh=AdNOm+2B7Cl2vYMbu8tlAoMAYtNCe+oWP2sw8k3DiKw=;
 h=Date:From:To:Subject:In-Reply-To:References:From;
 b=gN9zFjQucp5g7DK+TIm9i0MRbC0xQbD9oUrnwxPfCTy38T7SsJzVMzK7ykDC0nWlH
 GrgS94iGbzmWUhBWZOaPAVGmNJGlE803qqyQKnNaP8zt4odlxViEXPuCc7Rsy0Phnf
 uunOy656WUOdShI0ooqDjb5ZVNIX/c7n+GGLy9AaJwqU1MuwWlnCMZ9Q8d7i0TD8n4
 3msRaADEZS3/aFFa+jg6qv4r3AIlMaNSh/kuA6tMPkjuuTkzveNCEPebWea87+6Dsh
 PxumwbWJ3CWXfiyO9WxekdBB/LNjb3k5xAsY8QfYIeREqXmC/vJP17hIv4I5xf08hE
 5zw39luwrNtng==
X-Nifty-SrcIP: [119.150.44.95]
Date: Tue, 7 Jun 2022 08:21:40 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: remove most occurrences of __stdcall, WINAPI,
 and, __cdecl
Message-Id: <20220607082140.65c6d89ead72e9806ea24ff8@nifty.ne.jp>
In-Reply-To: <b5f56fb5-48eb-8596-5855-35a35dcb8a55@cornell.edu>
References: <2d54f846-365f-848f-4fdb-1c22d4c1bfa0@cornell.edu>
 <c9c7e7fe-adc6-c845-2720-06bc40591255@dronecode.org.uk>
 <b5f56fb5-48eb-8596-5855-35a35dcb8a55@cornell.edu>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, NICE_REPLY_A, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
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
X-List-Received-Date: Mon, 06 Jun 2022 23:22:06 -0000

On Mon, 6 Jun 2022 12:24:15 -0400
Ken Brown wrote:
> On 6/5/2022 4:24 PM, Jon Turney wrote:
> > On 03/06/2022 15:00, Ken Brown wrote:
> >> remove most occurrences of __stdcall, WINAPI, and __cdecl
> >>
> >> These have no effect on x86_64.  Retain only a few occurrences of
> >> __cdecl in files imported from other sources.
> > 
> > While you are correct that it has no effect on x86_64, I'd incline towards 
> > retaining WINAPI on Windows API functions, because it's part of the function 
> > signature.  But other people might have other opinions on that...
> 
> I ended up retaining all occurrences of WINAPI.  Those that don't directly occur 
> in Windows API functions are mostly used for thread functions passed to 
> CreateThread, and the latter expects a WINAPI function.

That sounds good to me.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
