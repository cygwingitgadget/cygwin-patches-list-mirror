Return-Path: <cygwin-patches-return-9653-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 130419 invoked by alias); 6 Sep 2019 14:53:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 130085 invoked by uid 89); 6 Sep 2019 14:53:16 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-9.5 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: conssluserg-01.nifty.com
Received: from conssluserg-01.nifty.com (HELO conssluserg-01.nifty.com) (210.131.2.80) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 06 Sep 2019 14:53:15 +0000
Received: from Express5800-S70 (ntsitm268057.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.110.57]) (authenticated)	by conssluserg-01.nifty.com with ESMTP id x86EqnEG022945	for <cygwin-patches@cygwin.com>; Fri, 6 Sep 2019 23:52:49 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x86EqnEG022945
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1567781569;	bh=ZP+cqsVMNc/XZDpdlr3EEKpjnggbJ+pXoetdmZmGwnw=;	h=Date:From:To:Subject:In-Reply-To:References:From;	b=kFhS4PR0KJrFFWICqVu2yrDvaQ3tLheJwtBFR8waN+GpyfAnVN/vHTjLEYFOtnamF	 /08eeC7fTB3RYdFnoYdYk9Hgwnl5fVWaLTBMTJUOAUueT5Dx0MfF6KcrpYyD0zo83e	 xCVzKYCuLy6q7Ha7wwNa4lt4zawTlOf47JZxXs9kVou7k0W84rG4R24K9G9T2hJMmY	 bIaeYk0iQi5p99umwGAeuEOA/hSVO44KZs6hjYyaE+MHs+wJCTxLT8TfvNV07UJZvl	 mj2ttmC97GvDBOZgMEw8qNVYk20CDCxiOkzwMdUdPZr3mSWFUP/+zR/pgbYUiXU+Ml	 MEEMjDHuhIABA==
Date: Fri, 06 Sep 2019 14:53:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 0/1] Cygwin: pty: Fix the behaviour of Ctrl-C in the pseudo console mode.
Message-Id: <20190906235258.7256226da5d5e79db51eb83c@nifty.ne.jp>
In-Reply-To: <20190906144239.671-1-takashi.yano@nifty.ne.jp>
References: <20190906144239.671-1-takashi.yano@nifty.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00173.txt.bz2

Sorry again. Please apply v3.

On Fri,  6 Sep 2019 23:42:38 +0900
Takashi Yano <takashi.yano@nifty.ne.jp> wrote:

> - When the I/O pipe is switched to the pseudo console side, the
>   behaviour of Ctrl-C is unstable. This rarely happens, however,
>   for example, shell sometimes crashes by Ctrl-C in that situation.
>   This patch fixes that issue.
> 
> v2:
> Remove the code which accidentally clears ENABLE_ECHO_INPUT flag.
> 
> Takashi Yano (1):
>   Cygwin: pty: Fix the behaviour of Ctrl-C in the pseudo console mode.
> 
>  winsup/cygwin/fhandler.h      |   4 +-
>  winsup/cygwin/fhandler_tty.cc |  32 +++++----
>  winsup/cygwin/select.cc       |   2 +-
>  winsup/cygwin/spawn.cc        | 128 +++++++++++++++++-----------------
>  4 files changed, 88 insertions(+), 78 deletions(-)
> 
> -- 
> 2.21.0
> 


-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
