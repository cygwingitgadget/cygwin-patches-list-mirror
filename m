Return-Path: <SRS0=bHOJ=4U=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
	by sourceware.org (Postfix) with ESMTPS id 7493A3858281
	for <cygwin-patches@cygwin.com>; Thu, 22 Dec 2022 09:06:16 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 7493A3858281
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from HP-Z230 (aj135041.dynamic.ppp.asahi-net.or.jp [220.150.135.41]) (authenticated)
	by conssluserg-01.nifty.com with ESMTP id 2BM963Vs020999
	for <cygwin-patches@cygwin.com>; Thu, 22 Dec 2022 18:06:03 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 2BM963Vs020999
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
	s=dec2015msa; t=1671699963;
	bh=lxj8P6qQuJiRTZHr+t6myz5H9pflXiNzsdo5AswnkwY=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=b1h9PBgWnvfvlnpbz/0K/h7fEU1roWqZ13/Xd8jv0nYh+LOxsBk9cewxnBipW4ehL
	 cB9N6xDb4iIqbkBR1XUpgZYmL0liZH2fG0eF842QTxbemZPfhRVlbr8WKZYR2nZP5e
	 xmZuo/zWzUlSQJgrZyvOQJPcGpMPGrhpvFXM8y7V5O+MDLzDLIt3KA0F0aksRNN5mT
	 EN3b/X97VEEP1QkBIaZCZfLlID7xqj8Z326tisURXUAYgxzBJQbgUKc0nUcXwh6efA
	 AoCokUVxVyWiyHGXtQ6ADwi27R+cojEiJ72RpA5dIdSbdVl1lbQZUyO+i0GeogRMCw
	 8xDjFuvBn0PYw==
X-Nifty-SrcIP: [220.150.135.41]
Date: Thu, 22 Dec 2022 18:06:03 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Make the console accessible from other
 terminals.
Message-Id: <20221222180603.9a8dedadfee6c59cdf073e36@nifty.ne.jp>
In-Reply-To: <Y6MCeRdiRCJAQMbV@calimero.vinschen.de>
References: <20221220124521.499-1-takashi.yano@nifty.ne.jp>
	<Y6ItllXJ8J20cEbp@calimero.vinschen.de>
	<20221221192343.32699d22e6d113ce9195de8f@nifty.ne.jp>
	<Y6MCeRdiRCJAQMbV@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Wed, 21 Dec 2022 13:56:25 +0100
Corinna Vinschen wrote:
> However, there's something broken with these patches in terms of
> debugging:
> 
> With current origin/master:
> 
>   $ ls -l  /dev/cons0
>   crw-rw-rw- 4 corinna vinschen 3, 0 Dec 21 13:46 /dev/cons0
>   $ strace -o xxx /bin/ls /dev/cons0
>   /dev/cons0
> 
> After applying "pinfo: Align CTTY behavior to the statement of POSIX."
> 
>   $ ls -l /dev/cons0
>   crw-rw-rw- 4 corinna vinschen 3, 0 Dec 21 13:51 /dev/cons0
>   $ strace -o xxx /bin/ls /dev/cons0
>   /usr/bin/ls: cannot access '/dev/cons0': No such device or address
> 
> "devices: Make generic console devices invisible from pty." doesn't
> change this, but after applying "console: Make the console accessible
> from other terminals.":
> 
>   $ ls -l /dev/cons0
>   crw------- 4 corinna vinschen 3, 0 Dec 21 13:55 /dev/cons0
>   $ strace -o xxx /bin/ls /dev/cons0
>    670400 [main] ls 1630 C:\cygwin64\bin\ls.exe: *** fatal error - MapViewOfFileEx '(null)'(0x54), Win32 error 487.  Terminating.
>    674526 [main] ls 1630 cygwin_exception::open_stackdumpfile: Dumping stack trace to ls.exe.stackdump
> 
> FWIW:
> 
>   $ strace -o xxx /bin/ls
>    673796 [main] ls 1633 C:\cygwin64\bin\ls.exe: *** fatal error - MapViewOfFileEx '(null)'(0x54), Win32 error 487.  Terminating.
>    676814 [main] ls 1633 cygwin_exception::open_stackdumpfile: Dumping stack trace to ls.exe.stackdump

Thank you for finding this. I think this can be easily fixed.
Please see v3 patch.

[PATCH v3] Cygwin: pinfo: Align CTTY behavior to the statement of POSIX.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
