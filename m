Return-Path: <SRS0=bHOJ=4U=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com [210.131.2.91])
	by sourceware.org (Postfix) with ESMTPS id D79EB3858D1E
	for <cygwin-patches@cygwin.com>; Thu, 22 Dec 2022 13:13:11 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org D79EB3858D1E
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from HP-Z230 (aj135041.dynamic.ppp.asahi-net.or.jp [220.150.135.41]) (authenticated)
	by conssluserg-06.nifty.com with ESMTP id 2BMDCjkc018848
	for <cygwin-patches@cygwin.com>; Thu, 22 Dec 2022 22:12:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 2BMDCjkc018848
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
	s=dec2015msa; t=1671714765;
	bh=+q+M6tVPhFkyHT0y0yYDmQV7PAzt1VTszSW/n/MSkFk=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=RNqKgogQmjnHTszHhZ14Q8o+z7M7AQhW1puF3Qw6wTpZuSHfTqCUZulV63cUSv18Q
	 6S+oec+1OMQFC2e11OH2MbdA0sIdgLPklUbx+lvJaYXejqOj/tTsVS93HJs0ukHT6+
	 WXjFHv+cCWSimqWOyBokx8aSe1wdGUAQo+prIDZk/fx1LwYD/VAJVkgAhIrY9Md2W4
	 it/5rCmIVKPrYrqOXPCuTee2QMrolm3kLy7NHK7gn0IVMHgIvJcijibTLZ002dIRxP
	 X2z/M2gFd/vYLS/e7jEmSeRESDh3W4r3hJEsynNnUE63EL6x3/bM69JHAx27Va8Lbn
	 hupD/jA42aD/g==
X-Nifty-SrcIP: [220.150.135.41]
Date: Thu, 22 Dec 2022 22:12:45 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Make the console accessible from other
 terminals.
Message-Id: <20221222221245.25cac3bec4b6d36136c5abe6@nifty.ne.jp>
In-Reply-To: <Y6RSs9d1atkWcPiJ@calimero.vinschen.de>
References: <20221220124521.499-1-takashi.yano@nifty.ne.jp>
	<Y6ItllXJ8J20cEbp@calimero.vinschen.de>
	<20221221192343.32699d22e6d113ce9195de8f@nifty.ne.jp>
	<Y6MCeRdiRCJAQMbV@calimero.vinschen.de>
	<20221222180603.9a8dedadfee6c59cdf073e36@nifty.ne.jp>
	<Y6RSs9d1atkWcPiJ@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Thu, 22 Dec 2022 13:50:59 +0100
Corinna Vinschen wrote:
> On Dec 22 18:06, Takashi Yano wrote:
> > On Wed, 21 Dec 2022 13:56:25 +0100
> > Corinna Vinschen wrote:
> > > However, there's something broken with these patches in terms of
> > > debugging:
> > > 
> > > With current origin/master:
> > > 
> > >   $ ls -l  /dev/cons0
> > >   crw-rw-rw- 4 corinna vinschen 3, 0 Dec 21 13:46 /dev/cons0
> > >   $ strace -o xxx /bin/ls /dev/cons0
> > >   /dev/cons0
> > > 
> > > After applying "pinfo: Align CTTY behavior to the statement of POSIX."
> > > 
> > >   $ ls -l /dev/cons0
> > >   crw-rw-rw- 4 corinna vinschen 3, 0 Dec 21 13:51 /dev/cons0
> > >   $ strace -o xxx /bin/ls /dev/cons0
> > >   /usr/bin/ls: cannot access '/dev/cons0': No such device or address
> > > 
> > > "devices: Make generic console devices invisible from pty." doesn't
> > > change this, but after applying "console: Make the console accessible
> > > from other terminals.":
> > > 
> > >   $ ls -l /dev/cons0
> > >   crw------- 4 corinna vinschen 3, 0 Dec 21 13:55 /dev/cons0
> > >   $ strace -o xxx /bin/ls /dev/cons0
> > >    670400 [main] ls 1630 C:\cygwin64\bin\ls.exe: *** fatal error - MapViewOfFileEx '(null)'(0x54), Win32 error 487.  Terminating.
> > >    674526 [main] ls 1630 cygwin_exception::open_stackdumpfile: Dumping stack trace to ls.exe.stackdump
> > > 
> > > FWIW:
> > > 
> > >   $ strace -o xxx /bin/ls
> > >    673796 [main] ls 1633 C:\cygwin64\bin\ls.exe: *** fatal error - MapViewOfFileEx '(null)'(0x54), Win32 error 487.  Terminating.
> > >    676814 [main] ls 1633 cygwin_exception::open_stackdumpfile: Dumping stack trace to ls.exe.stackdump
> > 
> > Thank you for finding this. I think this can be easily fixed.
> > Please see v3 patch.
> > 
> > [PATCH v3] Cygwin: pinfo: Align CTTY behavior to the statement of POSIX.
> 
> LGTM.  Please push all three patches.
> 
> However, I'm not really sure we should merge "Align CTTY behavior to the
> statement of POSIX." to 3.4.  It's a behavioral change, and how sure are
> we that it has no side-effects?

Thanks for reviewing. OK, I will push tha patch: "Align CTTY behavior
to the statement of POSIX." only for master branch.

How about
 [PATCH] Cygwin: devices: Make generic console devices invisible from pty.
?

Do you think this also should be only for master?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
