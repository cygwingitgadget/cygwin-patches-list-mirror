Return-Path: <cygwin-patches-return-9933-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3023 invoked by alias); 14 Jan 2020 04:10:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 3007 invoked by uid 89); 14 Jan 2020 04:10:04 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-7.5 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: conssluserg-02.nifty.com
Received: from conssluserg-02.nifty.com (HELO conssluserg-02.nifty.com) (210.131.2.81) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 14 Jan 2020 04:10:02 +0000
Received: from Express5800-S70 (ntsitm247158.sitm.nt.ngn.ppp.infoweb.ne.jp [124.27.253.158]) (authenticated)	by conssluserg-02.nifty.com with ESMTP id 00E49hgq024028	for <cygwin-patches@cygwin.com>; Tue, 14 Jan 2020 13:09:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 00E49hgq024028
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1578974983;	bh=pgnuAKdMyiK7WiM+FdPL7Eka9gP6ZmskFBTz/sM247c=;	h=Date:From:To:Subject:In-Reply-To:References:From;	b=E9l81hPLI1OwtqTSevUDlzF0wEC6kEsd0nz9i9Ty2MvotOQ5+kUzJKNEbAOfas8FI	 4q5VjAz0WH4ydRWn7LsIE9G4GIeMMHLU8TkiVRqgCL1LLQEL4tZMyQTJ0i8lbmvq1T	 MgXlVxTv9soCzNO6pTbaXiRFNWBIfr/AmjSIYLlyXlQqY3buJr9CtFnyePDsMnUuLr	 J04LaYYSPhLzFmKkGniZGlfViy6h3xMEx02CeVhxq6hDQiM+Gh1AjB6TUm+nw6icEp	 Aefw35M5GjPn33aq0RI7i2xCys9MgmZhG9RU5BgX3nv/Leeya8VTXGRy9XksQ2dAuJ	 t1MYqvpT6BOMQ==
Date: Tue, 14 Jan 2020 04:10:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Fix the issue regarding open and close multiple PTYs.
Message-Id: <20200114130945.61a8cde5ff6abfbba0c24d93@nifty.ne.jp>
In-Reply-To: <20200113154952.GI5858@calimero.vinschen.de>
References: <20200101064748.8709-1-takashi.yano@nifty.ne.jp>	<20200113154952.GI5858@calimero.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00039.txt

Hi Corinna,

On Mon, 13 Jan 2020 16:49:52 +0100
Corinna Vinschen wrote:
> But then again, given that Cygwin uses EXTENDED_STARTUPINFO_PRESENT
> anyway, wouldn't it makes sense to pass the required handles with
> PROC_THREAD_ATTRIBUTE_HANDLE_LIST to avoid having to open the
> parent with PROCESS_DUP_HANDLE?

Thanks for the advice. I didn't know PROC_THREAD_ATTRIBUTE_HANDLE_LIST.
It is very good idea to use PROC_THREAD_ATTRIBUTE_HANDLE_LIST.

I will submit a revised patch.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
