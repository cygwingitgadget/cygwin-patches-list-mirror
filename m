Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com
 [210.131.2.80])
 by sourceware.org (Postfix) with ESMTPS id 5B5A33858406
 for <cygwin-patches@cygwin.com>; Sat, 25 Dec 2021 03:19:16 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 5B5A33858406
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from Express5800-S70 (ae233132.dynamic.ppp.asahi-net.or.jp
 [14.3.233.132]) (authenticated)
 by conssluserg-01.nifty.com with ESMTP id 1BP3IpJU030905;
 Sat, 25 Dec 2021 12:18:51 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 1BP3IpJU030905
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1640402332;
 bh=q+0f8KB8iEodtejUcAfKdF/nTZl49eaSPVBlC/jz8Oc=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=dUZdFkDt4rdAPZCaIq77HEGy4dPJ8VH5RKycntMKJei2A882D3DUvUCmMo3BVTUJx
 JKfqljGXBZLSwKLq8490c29jGjWtSnECGIPs7fbtowC9faV5g5kFA4ZNcBtF/IkcP7
 z1XpkHmaKJ0UjwRf+azaQ6PwYLUelXsItpndbC/c8ruzKHjwN9TP2HLagu8FK8Nil6
 ecg6OhB9LsaPO5jRrs6quP/kNqkDhpqSwDKZrA/axodUG88z3aXN8gzutFqTxcQhT1
 9WtLO/jcb5KwIPT/+tFy2WbFa2tu8teN/yWJcMIW4zFbG1sI18QAqOX6OOTOs5g95r
 oTmGJwtMuM5eA==
X-Nifty-SrcIP: [14.3.233.132]
Date: Sat, 25 Dec 2021 12:19:02 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] fhandler_pipe: add sanity limit to handle loops
Message-Id: <20211225121902.54b82f1bb0d4f958d34a8bb7@nifty.ne.jp>
In-Reply-To: <alpine.BSO.2.21.2112241638280.11760@resin.csoft.net>
References: <alpine.BSO.2.21.2112231503400.11760@resin.csoft.net>
 <f97bba17-16ab-d7be-01f6-1c057fb5f1a5@cornell.edu>
 <alpine.BSO.2.21.2112231623490.11760@resin.csoft.net>
 <c5115e9b-6475-d30e-04d3-cb84cfa92b3a@cornell.edu>
 <alpine.BSO.2.21.2112241136160.11760@resin.csoft.net>
 <622d3ac6-fa5d-965c-52da-db7a4463fffd@cornell.edu>
 <alpine.BSO.2.21.2112241638280.11760@resin.csoft.net>
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
X-List-Received-Date: Sat, 25 Dec 2021 03:19:19 -0000

On Fri, 24 Dec 2021 16:39:13 -0800 (PST)
Jeremy Drake wrote:
> On Fri, 24 Dec 2021, Ken Brown wrote:
> 
> > On 12/24/2021 2:42 PM, Jeremy Drake wrote:
> > > It does seem to happen much more often on Windows on ARM64 (so much so
> > > that at first I thought it was an issue with their emulation).  With this
> > > patch I have not seen the issue again.
> >
> > So can you test your diagnosis by removing your patch and adding an assertion?
> 
> Done:
> :: Starting core system upgrade...
>  there is nothing to do
> :: Starting full system upgrade...
>  there is nothing to do
> assertion "phi->NumberOfHandles < n_handle" failed: file
> "../../.././winsup/cygwin/fhandler_pipe.cc", line 1275, function: void*
> fhandler_pipe::get_query_hdl_per_process(WCHAR*, OBJECT_NAME_INFORMATION*)
> Aborted

Could you please try
assert(phi->NumberOfHandles <= n_handle)
rather than
assert(phi->NumberOfHandles < n_handle)
?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
