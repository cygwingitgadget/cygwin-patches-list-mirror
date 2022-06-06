Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com
 [210.131.2.91])
 by sourceware.org (Postfix) with ESMTPS id 4882E385828F
 for <cygwin-patches@cygwin.com>; Mon,  6 Jun 2022 00:02:41 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 4882E385828F
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from HP-Z230 (ak044095.dynamic.ppp.asahi-net.or.jp [119.150.44.95])
 (authenticated)
 by conssluserg-06.nifty.com with ESMTP id 256028F8007451
 for <cygwin-patches@cygwin.com>; Mon, 6 Jun 2022 09:02:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 256028F8007451
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1654473728;
 bh=7GgrrpNABiTUGNQH9fw34r5KzbPoIDQfsMo+SORoTmM=;
 h=Date:From:To:Subject:In-Reply-To:References:From;
 b=1epcvjBwYg/9GsCqwauKmdvqg5r5D2QM/S+qnD1YkMSNa+0Os12aWaYamnCNq8q0r
 cFW/P1iwjE8fLfpuVDPQarEgy3vTJeuf3XplWHwRELX6gQURQmIOclrVU0oZLyaL14
 Z3ZH3OwJsSPf4miSJn8FWJ3nLbprAWetM0hQXb0OAcLz39oWPj8nLy/1LA+fFFPfZL
 +HzYrSz1K23/zEPjRFYZFuspGDXhGBVIXhXgOrwtk99enF9YjxK1A1CRwdrOBYSooo
 8yp+C0L4LPoAuDhOYSKUMHtbu0vXuxvkTX736Cww0UkFReM2MkenuTpY/ZroHVEKrP
 hr8j1vqa8y9/Q==
X-Nifty-SrcIP: [119.150.44.95]
Date: Mon, 6 Jun 2022 09:02:08 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: remove most occurrences of __stdcall, WINAPI,
 and, __cdecl
Message-Id: <20220606090208.04c671c35d529bef308c9425@nifty.ne.jp>
In-Reply-To: <c9c7e7fe-adc6-c845-2720-06bc40591255@dronecode.org.uk>
References: <2d54f846-365f-848f-4fdb-1c22d4c1bfa0@cornell.edu>
 <c9c7e7fe-adc6-c845-2720-06bc40591255@dronecode.org.uk>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Mon, 06 Jun 2022 00:02:46 -0000

On Sun, 5 Jun 2022 21:24:15 +0100
Jon Turney wrote:
> On 03/06/2022 15:00, Ken Brown wrote:
> > remove most occurrences of __stdcall, WINAPI, and __cdecl
> > 
> > These have no effect on x86_64.  Retain only a few occurrences of
> > __cdecl in files imported from other sources.
> 
> While you are correct that it has no effect on x86_64, I'd incline 
> towards retaining WINAPI on Windows API functions, because it's part of 
> the function signature.  But other people might have other opinions on 
> that...

I rather incline to Jon's opinion.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
