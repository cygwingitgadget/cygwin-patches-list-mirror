Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com
 [210.131.2.91])
 by sourceware.org (Postfix) with ESMTPS id 731633858C51
 for <cygwin-patches@cygwin.com>; Fri,  1 Jul 2022 23:31:27 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 731633858C51
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from HP-Z230 (ak044095.dynamic.ppp.asahi-net.or.jp [119.150.44.95])
 (authenticated)
 by conssluserg-06.nifty.com with ESMTP id 261NV7LC030511
 for <cygwin-patches@cygwin.com>; Sat, 2 Jul 2022 08:31:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 261NV7LC030511
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1656718267;
 bh=11SbZSzFk2NMr/fjbLfvOnlh2q8p+JfcOH+XOG8hKrQ=;
 h=Date:From:To:Subject:In-Reply-To:References:From;
 b=rI7w2wNvvmlFWyoCBL002T7phnpTv1Ln8GRIi42DQOzWuqwFMOw5DCeS2DCQLQw6+
 r8hiOUT+e03BB8P/uc01zpq+jKLeoVzGeitdRF02FB/CbNrm9nP2Yobu45gUESN6vG
 0jPx7ukVuTIeG/b0TZDPQI/p1HPMgQA2rmQ095aGvAIwmpWKrVnHKxXfPsIxPNbERf
 Hun8GeKycXn61dtisfPDarpDonGDv7t303Ak474cZ3Ca+iZUEbS/V97MrvMP+Q1bLU
 njpStMKHZjY6Eb2AKxgqkovYsTZKTDVCfnK7qGKhFdvs2IedQzW4JxHM/91w7OnHOq
 grQLR8JQj1ftw==
X-Nifty-SrcIP: [119.150.44.95]
Date: Sat, 2 Jul 2022 08:31:07 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: spawn: Treat empty path as the current directory.
Message-Id: <20220702083107.8aa64b1046484ab41911d8dc@nifty.ne.jp>
In-Reply-To: <376762b9-6ef2-4415-b3e6-fbc9be48f183@cornell.edu>
References: <20220627124427.184-1-takashi.yano@nifty.ne.jp>
 <c4a8d150-4d16-2af5-a7ac-26e42f9befb8@cornell.edu>
 <376762b9-6ef2-4415-b3e6-fbc9be48f183@cornell.edu>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00, BODY_8BITS,
 DKIM_SIGNED, DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, KAM_SHORT, NICE_REPLY_A,
 RCVD_IN_DNSWL_NONE, SPF_HELO_NONE, SPF_PASS, TXREP,
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
X-List-Received-Date: Fri, 01 Jul 2022 23:31:30 -0000

On Thu, 30 Jun 2022 21:16:35 -0400
Ken Brown wrote:
> On 6/30/2022 11:45 AM, Ken Brown wrote:
> > On 6/27/2022 8:44 AM, Takashi Yano wrote:
> >> - With this patch, the empty path (empty element in PATH or PATH is
> >>    absent) is treated as the current directory as Linux does.
> >> Addresses: https://cygwin.com/pipermail/cygwin/2022-June/251730.html
> > 
> > It might be a good idea to include a comment in the code and the commit message 
> > that this feature is being added for Linux compatibility but that it is 
> > deprecated.  According to https://man7.org/linux/man-pages/man7/environ.7.html,
> > 
> >                As a legacy feature, a zero-length prefix (specified as
> >                two adjacent colons, or an initial or terminating colon)
> >                is interpreted to mean the current working directory.
> >                However, use of this feature is deprecated, and POSIX
> >                notes that a conforming application shall use an explicit
> >                pathname (e.g., .)  to specify the current working
> >                directory.
> > 
> > Alternatively, maybe this is a case where we should prefer POSIX compliance to 
> > Linux compatibility.  Corinna, WDYT?
> 
> I withdraw my suggestion.  There's already a comment in the code saying, "An 
> empty path or '.' means the current directory", so it's clear that the intention 
> was to support that feature, and the code was simply buggy.
> 
> I've now read through the patch, and it looks good to me.  This was pretty 
> tricky to get right.

We still need to discuss whether it is better to align Linux
behavior or just keeping POSIX compliance, don't we?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
