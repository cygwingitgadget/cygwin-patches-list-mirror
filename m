Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com
 [210.131.2.80])
 by sourceware.org (Postfix) with ESMTPS id B3190385840C
 for <cygwin-patches@cygwin.com>; Thu, 28 Apr 2022 00:29:16 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org B3190385840C
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from Express5800-S70 (ak044095.dynamic.ppp.asahi-net.or.jp
 [119.150.44.95]) (authenticated)
 by conssluserg-01.nifty.com with ESMTP id 23S0Sreb017802
 for <cygwin-patches@cygwin.com>; Thu, 28 Apr 2022 09:28:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 23S0Sreb017802
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1651105734;
 bh=PRK8tXONi0r6Km36jaEI95pesd//WbTLM1ShMoEbuF8=;
 h=Date:From:To:Subject:In-Reply-To:References:From;
 b=LOYh81aNbo3yqBM0ieWOctUjoLkcR1Jnv6pQOF7pMJwGpv+p3XIn/ZV+yS0D+CD0i
 mUB7UQpYtqJxbAealjZ0Ck/DyD60pxQ1FnxWabKYQPDxiT23GeRbZJ68Uzjd9Zl+hP
 A0czAkhru4YV7dDMZ8hXEuVaFaU7BrQhIDKskj5NeRhBKWYotRlW+ratmYd3A6OkJ1
 +tiQgTWW2UvfNsk4wKz1cg28Y7DrbEihCk2gYEtk4mXA8a4Ru8KPYIzJ4ArMsfwroz
 8Z3pjajBnz2FHkaGjt7TeisTogkWXBYry57q1Z9SAIH8XFTCUFSBth1Ff+kPjPCFtD
 8K5LggsFAGtnA==
X-Nifty-SrcIP: [119.150.44.95]
Date: Thu, 28 Apr 2022 09:29:02 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/2] Fix build with w32api 10.0.0
Message-Id: <20220428092902.d7cb9331078f1e97f9fee144@nifty.ne.jp>
In-Reply-To: <YmkNRCnQq7pR00Ee@calimero.vinschen.de>
References: <20220412173210.50882-1-jon.turney@dronecode.org.uk>
 <YmkNRCnQq7pR00Ee@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, KAM_NUMSUBJECT, NICE_REPLY_A,
 RCVD_IN_DNSWL_NONE, SPF_HELO_NONE, SPF_PASS,
 TXREP autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
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
X-List-Received-Date: Thu, 28 Apr 2022 00:29:20 -0000

On Wed, 27 Apr 2022 11:30:44 +0200
Corinna Vinschen wrote:
> On Apr 12 18:32, Jon Turney via Cygwin-patches wrote:
> > Jon Turney (2):
> >   Cygwin: Fix build with w32api 10.0.0
> >   Cygwin: Fix typo KERB_S4U_LOGON_FLAG_IDENTITY -> IDENTIFY
>                                          ^^^^^^^^^^^^^^^^^^^^
>                                          Ooooops
> 
> LGTM, thanks,
> Corinna

Shouldn't these patches be applied also to cygwin-3_3-branch?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
