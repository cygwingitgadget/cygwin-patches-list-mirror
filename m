Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com
 [210.131.2.91])
 by sourceware.org (Postfix) with ESMTPS id 2C82B385828E
 for <cygwin-patches@cygwin.com>; Tue,  5 Jul 2022 04:55:11 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 2C82B385828E
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from HP-Z230 (ak044095.dynamic.ppp.asahi-net.or.jp [119.150.44.95])
 (authenticated)
 by conssluserg-06.nifty.com with ESMTP id 2654sZMC031997
 for <cygwin-patches@cygwin.com>; Tue, 5 Jul 2022 13:54:36 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 2654sZMC031997
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1656996876;
 bh=bI9A3a6NmXPpsgxECaD0EDLdI7ZPhUpHDsOJBqHHHGw=;
 h=Date:From:To:Subject:In-Reply-To:References:From;
 b=wve9wm1+MwOGD1oNimvxTA2pWFUB97aAYBKRpyld6xhweoMg1zGpMV0/CXdLQa0xB
 ruUyWz3WP13PT3ZlJRC+5x/p9w4zsFLfL3UhbY6eKEgfIQLmZFAJCXP19MErneNCU8
 V+7xxl21bb9ZScLYCUsyCT+dp1J1Ycy17LsKZN6SxjNDb9stCETvGf6XV3d00t4yNE
 fp7CZjRwfGpSX1+KtS8kMEY0QPTutSKArnTTCipt1jmowpyRU4jxV9V9xJM+g8I+RB
 Tkh+HU6WugUB8qynInGpFo9cOrlQOhV+FXpw+J32OZ2SQJsiK6YosB418ZO9Mdrrs4
 hfJE0aBUc34NQ==
X-Nifty-SrcIP: [119.150.44.95]
Date: Tue, 5 Jul 2022 13:54:36 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: spawn: Treat empty path as the current directory.
Message-Id: <20220705135436.1d91baa3426e31114938f51d@nifty.ne.jp>
In-Reply-To: <4ba56b80-8faa-de1b-f3c4-f64106797106@cornell.edu>
References: <20220627124427.184-1-takashi.yano@nifty.ne.jp>
 <c4a8d150-4d16-2af5-a7ac-26e42f9befb8@cornell.edu>
 <376762b9-6ef2-4415-b3e6-fbc9be48f183@cornell.edu>
 <20220702083107.8aa64b1046484ab41911d8dc@nifty.ne.jp>
 <ab1226ff-1236-67a0-a140-0f6826fd1778@cornell.edu>
 <YsKm4GDa5Zi3VHjK@calimero.vinschen.de>
 <4ba56b80-8faa-de1b-f3c4-f64106797106@cornell.edu>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Tue, 05 Jul 2022 04:55:14 -0000

On Mon, 4 Jul 2022 19:05:19 -0400
Ken Brown wrote:
> On 7/4/2022 4:37 AM, Corinna Vinschen wrote:
> > On Jul  1 21:32, Ken Brown wrote:
> >> I interpreted the existing comment as meaning that a decision was already
> >> made at some point to align with Linux.  But it can't hurt to wait for
> >> Corinna to weigh in.
> > 
> > Personally I don't like this old crufty feature and I would rather keep
> > this POSIX compatible, but in fact it was meant to work as on Linux, so,
> > please go ahead, Takashi.
> > 
> > However, maybe this should go into the master branch only? WDYT?
> 
> I think so.  The bug has been around for a long time, and the code is tricky. 
> So we probably shouldn't take a chance on de-stabilizing the 3.3 branch.

Thanks! I have pushed the patch to master branch.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
