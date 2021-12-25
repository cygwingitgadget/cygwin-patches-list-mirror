Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com
 [210.131.2.81])
 by sourceware.org (Postfix) with ESMTPS id C2FE73858406
 for <cygwin-patches@cygwin.com>; Sat, 25 Dec 2021 04:13:00 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org C2FE73858406
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from Express5800-S70 (ae233132.dynamic.ppp.asahi-net.or.jp
 [14.3.233.132]) (authenticated)
 by conssluserg-02.nifty.com with ESMTP id 1BP4CV0h009326;
 Sat, 25 Dec 2021 13:12:31 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 1BP4CV0h009326
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1640405551;
 bh=m7lear+2Dv+ulLsLrbndoqJVTl0DSFXcUSUjsCnIPT4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=zVW2sHlEXb1AnlnJaOQUxw8mV6IhIAXGrAQO2mhDdjsoIg06qnua7PLETRXpS1XT5
 Hm7jm2JzpLeCM9VX4fYk4l8wVFFvfLRPu6+KQk5SrWoFMvZI4y+PQ2QDAj0g5Oe0BV
 pM0kHL4wvzhZrkIymy+wikMZZcOZ6MpOKHfENOQBQ+Z59/cIIInp7FKAavTCF6ECT9
 7AOyvmpeZHPBJTi+Gb6K1wt4+gr9BBgaYiSdR/X11wk0krAxsamBAMTy2gaezhy5pm
 Y75+3otvCGY0/RHkLaWQm1z2FmNh1Cm1mqpneIls5L/dv09aprsdq5Qg+ZiJhYCnqV
 plVmh4geoFraA==
X-Nifty-SrcIP: [14.3.233.132]
Date: Sat, 25 Dec 2021 13:12:42 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] fhandler_pipe: add sanity limit to handle loops
Message-Id: <20211225131242.adef568db53d561a6b134612@nifty.ne.jp>
In-Reply-To: <alpine.BSO.2.21.2112241945060.11760@resin.csoft.net>
References: <alpine.BSO.2.21.2112231503400.11760@resin.csoft.net>
 <f97bba17-16ab-d7be-01f6-1c057fb5f1a5@cornell.edu>
 <alpine.BSO.2.21.2112231623490.11760@resin.csoft.net>
 <c5115e9b-6475-d30e-04d3-cb84cfa92b3a@cornell.edu>
 <alpine.BSO.2.21.2112241136160.11760@resin.csoft.net>
 <622d3ac6-fa5d-965c-52da-db7a4463fffd@cornell.edu>
 <alpine.BSO.2.21.2112241638280.11760@resin.csoft.net>
 <20211225121902.54b82f1bb0d4f958d34a8bb7@nifty.ne.jp>
 <alpine.BSO.2.21.2112241945060.11760@resin.csoft.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, NICE_REPLY_A, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Sat, 25 Dec 2021 04:13:02 -0000

On Fri, 24 Dec 2021 19:47:46 -0800 (PST)
Jeremy Drake wrote:
> phi->NumberOfHandles = 7999168, n_handle = 256
> assertion "phi->NumberOfHandles <= n_handle" failed: file
> "../../.././winsup/cygwin/fhandler_pipe.cc", line 1280, function: void*
> fhandler_pipe::get_query_hdl_per_process(WCHAR*, OBJECT_NAME_INFORMATION*)
> Aborted

What!? Could you please check value of the "status" ?

What version of windows do you use?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
